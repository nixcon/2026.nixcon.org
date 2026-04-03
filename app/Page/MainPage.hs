{-# LANGUAGE DuplicateRecordFields #-}

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
            , ticketScrolls
                [id_ "ticket-scrolls"]
                [ TicketScroll
                    { title = "Standard"
                    , details = ["Full conference access"]
                    , price = "128 €"
                    }
                , TicketScroll
                    { title = "Supporter"
                    , details =
                        [ "Full conference access"
                        , "Help others attend NixCon"
                        , "A star on your badge"
                        ]
                    , price = "256 €"
                    }
                , TicketScroll
                    { title = "Professional"
                    , details =
                        [ "Full conference access"
                        , "Help others attend NixCon"
                        , "Company logo on your badge"
                        ]
                    , price = "512 €"
                    }
                ]
            , section_
                [class_ "ticket-note"]
                [ img_ [src_ "/static/chest.png"]
                , p_ [] ["NixCon tickets will be available soon!"]
                , a_ [href_ "https://tickets.nixcon.org/nixcon-2026/"] ["To the ticket shop"]
                ]
            , section_
                [class_ "ticket-note"]
                [ img_ [src_ "/static/heart.png"]
                , p_ [] ["Like last year, we will offer discounts for contributors."]
                , a_ [href_ "/"] ["Check if you're eligible"]
                ]
            ]
        , section_
            [id_ "organisers"]
            [ h2_ [] [text "Organisers"]
            , section_
                [id_ "main-organisers"]
                [ p_
                    []
                    [ text
                        "NixCon is organised by a dedicated team of volunteers from the Nix community."
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
                    , li_ [] ["... maybe you?"]
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
            [ h2_
                []
                [text "CTF"]
            , p_
                [class_ "ctf-note"]
                [ img_ [src_ "/static/crown.png"]
                , span_
                    []
                    [ "Take part in the very first NixCon CTF!"
                    ]
                ]
            , p_
                []
                [ text
                    "Join the first-ever Nix CTF for a fun experience. Collaborate, hack, and experiment with others to solve interesting challenges and learn more about Nix. The event is beginner-friendly and open to all levels, so anyone can jump in and meet new people."
                ]
            , p_
                []
                [ text
                    "The winner gets a lousy t-shirt with a special print. The CTF will take place on Sunday (27 September). You can either join in person or online from wherever you are."
                ]
            , p_
                []
                [ text
                    "Check back here frequently and join our conference communication channels as the event draws closer to stay up-to-date."
                ]
            ]
        , section_
            [id_ "sponsors"]
            [ h2_ [] [text "Sponsors"]
            , sponsorScrolls
                [id_ "sponsor-scrolls"]
                [ SponsorScroll
                    { tier = Bronze
                    , title = "Bronze"
                    , details =
                        [ "Logo on website"
                        , "1 Professional ticket"
                        ]
                    , price = "1024 €"
                    }
                , SponsorScroll
                    { tier = Silver
                    , title = "Silver"
                    , details =
                        [ "Everything in Bronze"
                        , "Shout-out in the opening"
                        , "2 Professional tickets"
                        ]
                    , price = "4096 €"
                    }
                , SponsorScroll
                    { tier = Gold
                    , title = "Gold"
                    , details =
                        [ "Everything in Silver"
                        , "5 minute lightning talk slot"
                        , "Dedicated booth space"
                        , "4 Professional tickets"
                        ]
                    , price = "8192 €"
                    }
                , SponsorScroll
                    { tier = Diamond
                    , title = "Diamond"
                    , details =
                        [ "Everything in Gold"
                        , "Logo in promo materials"
                        , "Add item to tote bags"
                        , "8 Professional tickets"
                        ]
                    , price = "16483 €"
                    }
                ]
            ]
        ]

data TicketScroll = TicketScroll
    { title :: MisoString
    , details :: [MisoString]
    , price :: MisoString
    }

ticketScroll :: TicketScroll -> View model action
ticketScroll TicketScroll{..} =
    li_
        [class_ "scroll"]
        [ div_ [class_ "title"] [text title]
        , ul_ [class_ "details"] [li_ [] [text t] | t <- details]
        , ul_ [class_ "price"] [text price]
        ]

ticketScrolls :: [Attribute action] -> [TicketScroll] -> View model action
ticketScrolls attrs = ul_ (attrs <> [class_ "ticket-scrolls"]) . fmap ticketScroll

data SponsorshipTier
    = Bronze
    | Silver
    | Gold
    | Diamond

data SponsorScroll = SponsorScroll
    { tier :: SponsorshipTier
    , title :: MisoString
    , details :: [MisoString]
    , price :: MisoString
    }

mkSponsorshipTierLink :: SponsorshipTier -> MisoString
mkSponsorshipTierLink tier =
    case tier of
        Bronze ->
            "mailto:sponsor@nixos.org?subject=NixCon%202025%20Sponsorship%3A%20%3CYour%20Company%20Name%3E&body=Please%20provide%20at%20least%20the%20following%20information%3A%0A%20%20-%20Company%20Name%20and%20Website%3A%0A%20%20-%20Desired%20Tier%3A%20Bronze%0A%20%20-%20Desired%20Amount%3A%201024%20EUR%0A%20%20"
        Silver ->
            "mailto:sponsor@nixos.org?subject=NixCon%202025%20Sponsorship%3A%20%3CYour%20Company%20Name%3E&body=Please%20provide%20at%20least%20the%20following%20information%3A%0A%20%20-%20Company%20Name%20and%20Website%3A%0A%20%20-%20Desired%20Tier%3A%20Silver%0A%20%20-%20Desired%20Amount%3A%204096%20EUR%0A%20%20"
        Gold ->
            "mailto:sponsor@nixos.org?subject=NixCon%202025%20Sponsorship%3A%20%3CYour%20Company%20Name%3E&body=Please%20provide%20at%20least%20the%20following%20information%3A%0A%20%20-%20Company%20Name%20and%20Website%3A%0A%20%20-%20Desired%20Tier%3A%20Gold%0A%20%20-%20Desired%20Amount%3A%208192%20EUR%0A%20%20"
        Diamond ->
            "mailto:sponsor@nixos.org?subject=NixCon%202025%20Sponsorship%3A%20%3CYour%20Company%20Name%3E&body=Please%20provide%20at%20least%20the%20following%20information%3A%0A%20%20-%20Company%20Name%20and%20Website%3A%0A%20%20-%20Desired%20Tier%3A%20Diamond%0A%20%20-%20Desired%20Amount%3A%2016384%20EUR%0A%20%20"

sponsorScroll :: SponsorScroll -> View model action
sponsorScroll SponsorScroll{..} =
    li_
        [class_ "scroll"]
        [ div_ [class_ "title"] [text title]
        , div_ [class_ "sponsorship-price"] [text price]
        , ul_ [class_ "details"] [li_ [] [text t] | t <- details]
        , section_
            [class_ "sponsorship-cta"]
            [ img_ [src_ "/static/coin-single.png"]
            , a_ [href_ $ mkSponsorshipTierLink tier] [text "Sponsor now!"]
            ]
        ]

sponsorScrolls :: [Attribute action] -> [SponsorScroll] -> View model action
sponsorScrolls attrs = ul_ (attrs <> [class_ "sponsor-scrolls"]) . fmap sponsorScroll

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
