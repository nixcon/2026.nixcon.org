module Page.MainPage where

import Miso.Html.Element
import Miso.Html.Property
import Miso.Prelude

page :: View model action
page =
    main_
        []
        [ section_
            [id_ "hero"]
            [ img_ [class_ "logo", src_ "/static/icon.svg"]
            , h1_ [] [text "JOIN NIXCON 2026"]
            , div_
                [id_ "about"]
                [ div_ []
                    $ p_ []
                    . pure
                    . text
                    <$> [ "NixCon is the annual gathering of the Nix community."
                        , "Developers, operators, researchers, and enthusiasts come together to share ideas, present new work, and explore the future of reproducible systems."
                        , "Join us for talks, workshops, and discussions about everything from Nix fundamentals to large-scale production deployments."
                        ]
                , ul_
                    [id_ "overview"]
                    [ li_ [] [text "25-28 September 2026\nFriday to Monday"]
                    , li_
                        []
                        [ text "Auditorium Maximum\nul. Krupnicza 33\n31-123 Kraków\nPolska"
                        ]
                    , li_ [] [text "600-700 attendees"]
                    , li_ [] [text "... and their spouses🥰"]
                    , li_ [] [text "First NixCon CTF ever!"]
                    ]
                ]
            ]
        , section_
            [id_ "tickets"]
            [ h2_ [] [text "Tickets"]
            , scrolls
                []
                [ Scroll
                    { title = "Standard"
                    , details = ["Full conference access"]
                    , price = "128 €"
                    }
                , Scroll
                    { title = "Supporter"
                    , details =
                        [ "Full conference access"
                        , "Help others attend NixCon"
                        , "A star on your badge"
                        ]
                    , price = "256 €"
                    }
                , Scroll
                    { title = "Professional"
                    , details =
                        [ "Full conference access"
                        , "Help others attend NixCon"
                        , "Company logo on your badge"
                        ]
                    , price = "512 €"
                    }
                ]
            , p_ [] [text "TODO link(s) to ticket shop"]
            , p_ [] [text "TODO mention contributor vouchers"]
            ]
        , section_
            [id_ "sponsors"]
            [ h2_ [] [text "Sponsors"]
            , p_ [] [text "TODO where do we show actual sponsors (logos)?"]
            , scrolls
                []
                [ Scroll
                    { title = "Bronze"
                    , details =
                        [ "Logo on website"
                        , "1 Professional ticket"
                        ]
                    , price = "1024 €"
                    }
                , Scroll
                    { title = "Silver"
                    , details =
                        [ "Everything in Bronze"
                        , "Shout-out in the opening"
                        , "2 Professional tickets"
                        ]
                    , price = "4096 €"
                    }
                , Scroll
                    { title = "Gold"
                    , details =
                        [ "Everything in Silver"
                        , "5 minute lightning talk slot"
                        , "Dedicated booth space"
                        , "4 Professional tickets"
                        ]
                    , price = "8192 €"
                    }
                , Scroll
                    { title = "Diamond"
                    , details =
                        [ "Everything in Gold"
                        , "Logo in promo materials"
                        , "Add item to tote bags"
                        , "8 Professional tickets"
                        ]
                    , price = "16483 €"
                    }
                ]
            , p_ [] [text "TODO describe how to become a sponsor"]
            ]
        , section_
            [id_ "organisers"]
            [ h2_ [] [text "Organisers"]
            , section_
                [id_ "main-organisers"]
                [ p_
                    []
                    [ text
                        "NixCon is not organised by a dedicated team of volunteers from the Nix community."
                    ]
                , organisers
                    []
                    [ Organiser
                        { image = "https://avatars.githubusercontent.com/u/50560955"
                        , name = "ners"
                        , github = "ners"
                        , matrix = "@ners:nixos.dev"
                        }
                    , Organiser
                        { image = "https://john-rodewald.github.io/img/tiger.png"
                        , name = "john"
                        , github = "john-rodewald"
                        , matrix = "@john-rodewald:nixos.dev"
                        }
                    , Organiser
                        { image = "https://avatars.githubusercontent.com/u/621759"
                        , name = "lassulus"
                        , github = "lassulus"
                        , matrix = "@lassulus:lassul.us"
                        }
                    , Organiser
                        { image = "https://avatars.githubusercontent.com/u/80830132"
                        , name = "rabbit"
                        , github = "ra33it0"
                        , matrix = "@ra33it0:matrix.org"
                        }
                    ]
                ]
            , section_
                [id_ "volunteers"]
                [ p_
                    []
                    [ "Thank you to all the volunteers that are taking tasks off our hands to help us make this event happen."
                    ]
                , ul_
                    []
                    [ li_ [] ["Farhad Mehta"]
                    , li_ [] ["Sigmanificient"]
                    , li_ [] ["Carina Hahn"]
                    , li_ [] ["Barbara Trojecka"]
                    , li_ [] ["Lorenz Bischof"]
                    ]
                ]
            , section_
                [id_ "venue"]
                [ p_
                    []
                    [ "We kindly thank the Jagiellonian University for all their assistance and for co-organising at their venue in Kraków."
                    ]
                , img_ [class_ "logo", src_ "/static/university-logo.svg"]
                ]
            ]
        , section_
            [id_ "ctf"]
            [ h2_ [] [text "CTF"]
            , p_ [] [text "TODO content"]
            ]
        ]

data Scroll = Scroll
    { title :: MisoString
    , details :: [MisoString]
    , price :: MisoString
    }

scroll :: Scroll -> View model action
scroll Scroll{..} =
    li_
        [class_ "scroll"]
        [ div_ [class_ "title"] [text title]
        , ul_ [class_ "details"] [li_ [] [text t] | t <- details]
        , ul_ [class_ "price"] [text price]
        ]

scrolls :: [Attribute action] -> [Scroll] -> View model action
scrolls attrs = ul_ (attrs <> [class_ "scrolls"]) . fmap scroll

data Organiser = Organiser
    { image :: MisoString
    , name :: MisoString
    , github :: MisoString
    , matrix :: MisoString
    }

organiser :: Organiser -> View model action
organiser Organiser{..} =
    li_
        []
        [ div_ [class_ "portrait"] [img_ [src_ image]]
        , div_ [] [text name]
        ]

organisers :: [Attribute action] -> [Organiser] -> View model action
organisers attrs = ul_ attrs . fmap organiser
