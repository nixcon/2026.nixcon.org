module Main where

import Control.Lens.Operators ((%~), (&), (^.), (.~))
import Control.Monad ((>=>))
import Control.Monad.Extra (whileM)
import Data.Default (def)
import Data.Generics.Labels ()
import Data.HashSet (HashSet)
import Data.HashSet qualified as HashSet
import Data.Sequence (Seq)
import Data.Sequence qualified as Seq
import Data.Text (Text)
import Data.Text qualified as Text
import Data.Text.Encoding qualified as Text
import Effectful
import Effectful.State.Static.Local (State, evalState)
import Effectful.State.Static.Local qualified as State
import GHC.Generics (Generic)
import Test.Dramaturge
import Text.URI (URI)
import Text.URI qualified as URI
import Text.URI.Lens (uriPath, uriQuery, uriFragment)
import Text.URI.QQ qualified as URI
import Prelude hiding (writeFile)
import Data.Maybe (fromMaybe)
import Effectful.FileSystem (createDirectoryIfMissing)
import System.FilePath (takeDirectory)

isLocalPage :: Text -> Bool
isLocalPage t =
    not $
        Text.null t
            || Text.isInfixOf "//" t
            || Text.isPrefixOf "#" t

data S = S
    { visited :: HashSet URI
    , queue :: Seq URI
    }
    deriving stock (Generic)

emptyState :: S
emptyState = S{visited = mempty, queue = mempty}

enqueue :: URI -> S -> S
enqueue uri s
    | HashSet.member uri (visited s) = s
    | otherwise =
        s
            & #queue %~ (Seq.|> uri)
            & #visited %~ HashSet.insert uri

main :: IO ()
main = runEff . runDramaturge def . evalState emptyState $ do
    newSession
    visit [URI.uri|http://localhost:8080|]

type Dramaturge es =
    ( Marionette :> es
    , Concurrent :> es
    , Timeout :> es
    , Log :> es
    , FileSystem :> es
    , Hspec :> es
    )

step :: (State S :> es, Dramaturge es) => Eff es Bool
step =
    State.gets (Seq.viewl . queue) >>= \case
        Seq.EmptyL -> pure False
        url Seq.:< queue -> do
            State.modify \s -> s{queue}
            process url
            pure True

visit :: (State S :> es, Dramaturge es) => URI -> Eff es ()
visit uri = do
    logInfo_ $ "Visiting " <> URI.render uri
    State.modify $ enqueue uri
    whileM step

process :: (State S :> es, Dramaturge es) => URI -> Eff es ()
process uri = do
    logInfo_ $ "Processing " <> URI.render uri
    uri `shouldSatisfy` URI.isPathAbsolute
    let filename = Text.unpack . URI.render $ URI.emptyURI & uriPath .~ (uri ^. uriPath) <> pure [URI.pathPiece|index.html|]
    navigate $ URI.render uri
    waitForElement $ ByCSS "body > *"
    logInfo_ $ "Writing " <> Text.pack filename
    createDirectoryIfMissing True . takeDirectory $ filename
    writeFile filename . Text.encodeUtf8 =<< getPageSource
    findElements (ByTag "a")
        >>= mapM_ @[]
            ( getElementAttribute "href" >=> \case
                Just href | isLocalPage href -> do
                    let href' = fromMaybe href $ Text.stripPrefix "/" href
                    uri' <- URI.mkURI $ URI.render (uri & uriPath .~ [] & uriQuery .~ [] & uriFragment .~ Nothing) <> "/" <> href'
                    State.modify $ enqueue uri'
                _ -> pure ()
            )
