module Page.Accommodation where

import Miso.Html.Element
import Miso.Html.Property
import Miso.Prelude

page :: View model action
page =
    main_
        []
        [ h1_ [] ["Hotels"]
        , p_
            []
            [ text
                "We're talking to local hotels in Kraków to inform them about NixCon 2026 and to ask if they can offer discounts or other benefits to our attendees."
            ]
        , p_ [] [text "Check back frequently!"]
        ]
