{-# LANGUAGE CPP #-}

module Main where

import Control.Monad.Extra (unlessM)
import Data.Either.Extra (eitherToMaybe)
import Data.Generics.Labels ()
import Data.List qualified as List
import Data.List.Extra qualified as List
import Data.Maybe (maybeToList)
import GHC.Generics (Generic)
import Miso.FFI.QQ (js)
import Miso.Html.Element
import Miso.Html.Event (onClickPrevent)
import Miso.Html.Property
import Miso.Lens (fromVL, (&), (.=), (.~))
import Miso.Prelude hiding (update, view)
import Miso.Router hiding (href_)
import Miso.Router qualified as Router
import Miso.Util.Parser (ParserT (..))
import Page.CodeOfConduct qualified
import Page.LegalDisclosure qualified
import Page.MainPage qualified
import Page.PrivacyPolicy qualified as Page.PricavyPolicy

#if defined(WASM) && !defined(INTERACTIVE)
foreign export javascript "hs_start" main :: IO ()
#endif

main :: IO ()
main = do
    uri <- getURI
    consoleLog . ms . show $ route @PageId uri
    let model = emptyModel & either (const id) (fromVL #currentPage .~) (route uri)
    startApp defaultEvents
        $ (component model update view)
            { subs = [routerSub $ either (const NoOp) GoToPage]
            }

data Action
    = NoOp
    | GoToPage PageId

newtype Model = Model {currentPage :: PageId}
    deriving stock (Eq, Generic)

data PageId
    = MainPage
    | LegalDisclosure
    | PrivacyPolicy
    | CodeOfConduct
    deriving stock (Generic, Show, Eq, Bounded, Enum)

instance Router PageId where
    fromRoute MainPage = [IndexToken]
    fromRoute LegalDisclosure = [CaptureOrPathToken "legal"]
    fromRoute PrivacyPolicy = [CaptureOrPathToken "privacy"]
    fromRoute CodeOfConduct = [CaptureOrPathToken "conduct"]
    routeParser = Parser \_ tokens ->
        maybeToList
            $ List.firstJust
                (\r -> (r,) <$> List.stripPrefix (fromRoute @PageId r) tokens)
                [minBound .. maxBound]

emptyModel :: Model
emptyModel = Model{currentPage = MainPage}

getCurrentPageId :: IO (Maybe PageId)
getCurrentPageId = eitherToMaybe . route <$> getURI

scrollToTop :: IO ()
scrollToTop = [js| document.body.scrollTop = document.documentElement.scrollTop = 0; |]

update :: Action -> Effect ROOT Model Action
update NoOp = pure ()
update (GoToPage pageId) = do
    io_
        . unlessM ((Just pageId ==) <$> getCurrentPageId)
        . pushURI
        . toURI
        $ pageId
    io_ scrollToTop
    fromVL #currentPage .= pageId

view :: Model -> View Model Action
view Model{..} =
    div_
        [id_ "page"]
        [ header_
            []
            [ a_ [Router.href_ MainPage] [img_ [class_ "logo", src_ "/static/logo.svg"]]
            , nav_
                []
                [ ul_
                    []
                    [ li_ [] [a_ [href_ "/#tickets"] [text "Tickets"]]
                    , li_ [] [a_ [href_ "/#sponsors"] [text "Sponsors"]]
                    , li_ [] [a_ [href_ "/#organisers"] [text "Organisers"]]
                    , li_ [] [a_ [href_ "/#ctf"] [text "CTF"]]
                    ]
                ]
            ]
        , case currentPage of
            MainPage -> Page.MainPage.page
            LegalDisclosure -> Page.LegalDisclosure.page
            PrivacyPolicy -> Page.PricavyPolicy.page
            CodeOfConduct -> Page.CodeOfConduct.page
        , footer_
            []
            [ div_
                [class_ "content"]
                [ a_ [Router.href_ MainPage] [img_ [class_ "logo", src_ "/static/logo.svg"]]
                , ul_
                    []
                    [ li_ [] [pageLink LegalDisclosure [] [text "Legal disclosure"]]
                    , li_ [] [pageLink PrivacyPolicy [] [text "Privacy policy"]]
                    , li_ [] [pageLink CodeOfConduct [] [text "Code of conduct"]]
                    ]
                , ul_
                    []
                    [ li_ [] [a_ [href_ "https://github.com/nixcon/2026.nixcon.org"] [text "GitHub"]]
                    , li_
                        []
                        [ div_ [] [text "Previous NixCon editions:"]
                        , ul_
                            [id_ "years"]
                            [ li_
                                []
                                [ a_
                                    [ href_ $ "https://" <> year <> ".nixcon.org"
                                    , target_ "blank"
                                    ]
                                    [text year]
                                ]
                            | year <-
                                toMisoString @Int
                                    <$> [ 2025
                                        , 2024
                                        , 2023
                                        , 2022
                                        , 2020
                                        , 2019
                                        , 2018
                                        , 2017
                                        , 2015
                                        ]
                            ]
                        ]
                    ]
                ]
            ]
        ]

pageLink
    :: PageId
    -> [Attribute Action]
    -> [View Model Action]
    -> View Model Action
pageLink pageId = a_ . ([Router.href_ pageId, onClickPrevent (GoToPage pageId)] <>)
