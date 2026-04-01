module Page.LegalDisclosure where

import Miso.Html.Element
import Miso.Prelude
import Miso.String qualified as MisoString

page :: View model action
page =
    main_
        []
        [ h1_ [] [text "Legal disclosure"]
        , p_ [] [text "This website and event is hosted by:"]
        , pre_
            []
            [ text
                . MisoString.unlines
                $ [ "Stichting NixOS Foundation"
                  , "Korte Lijnbaanssteeg 1-4318"
                  , "1012 SL, Amsterdam"
                  , "The Netherlands"
                  ]
            ]
        , pre_ [] [text "KvK 63520583"]
        , pre_ [] [text "VAT: NL855271851B01"]
        , pre_ [] [text "E-Mail: foundation@nixos.org"]
        ]
