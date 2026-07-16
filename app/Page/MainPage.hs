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
                , span_ [id_ "nixcon-date-location"] [text "25-28 September | KRAKOW"]
                , h1_ [id_ "nixcon-title"] [text "JOIN NIXCON 2026"]
                , p_ [id_ "nixcon-description"] [text "NixCon is the annual gathering of the Nix community."]
                , ul_ [id_ "nixcon-hero-links"]
                    [ li_ [class_ "hero-link"] [
                        img_ [src_ "/static/chest.png"],
                        a_ [href_ "/"] [text "Get Tickets"]]
                    , li_ [class_ "hero-link"] [
                        img_ [class_ "image-45", src_ "/static/rocket.png"],
                        a_ [href_ "/"] [text "Become a Sponsor"]]
                    ]
            ]
        , section_
            [id_ "venue-images"]
            [ ul_ [id_ "venue-images-list"]
                [ li_ [id_ "venue-image-1"] [img_ [src_ "/static/venue/venue1.jpg", alt_ "Image of a large scale auditorium with two ranks of seats arranged in a half circle."]]
                , li_ [id_ "venue-image-2"] [img_ [src_ "/static/venue/venue2.jpg", alt_ "Image of the Krakow city skyline"]]
                , li_ [id_ "venue-image-3"] [img_ [src_ "/static/venue/venue3.jpg", alt_ "Image the atrium of the venue, consisting of indoor balconys and stairs in a brutalist style"]]
                ]
            ]
        , section_
            [id_ "about"]
                [ div_
                    []
                    [ p_ [class_ "highlight-text"] ["What to expect at this year's NixCon:"]
                    , p_
                        []
                        [ "Developers, operators, researchers, and enthusiasts come together to share ideas, present new work, and explore the future of reproducible systems."
                        ]
                    , p_
                        []
                        [ "Join us for talks, workshops, and discussions about everything from Nix fundamentals to large-scale production deployments."
                        ]
                    , p_
                        []
                        [ "We'll organise city activities so that you can bring along your partner or a friend that wants to experience Kraków with you."
                        ]
                    ]
                , ul_
                    [id_ "overview"]
                    [ li_ [] [text "In short"]
                    , li_ [] [text "25-28 September 2026\nFriday to Monday"]
                    , li_
                        []
                        [ text "Auditorium Maximum\nul. Krupnicza 33\n31-123 Kraków\nPolska"
                        ]
                    , li_ [] [text "600-700 attendees"]
                    , li_ [] [text "... and their spouses🥰"]
                    , li_ [] [text "First NixCon CTF ever!"]
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
                [class_ "note"]
                [ img_ [src_ "/static/chest.png"]
                , p_ [] ["NixCon tickets are now available!"]
                , a_ [href_ "https://tickets.nixcon.org/nixcon-2026/"] ["To the ticket shop"]
                ]
            , section_
                [class_ "note"]
                [ img_ [src_ "/static/heart.png"]
                , p_ [] ["Like last year, we will offer discounts for contributors."]
                , a_ [href_ "https://vouchers.nixcon.org"] ["Check if you're eligible"]
                ]
            , section_
                [class_ "note"]
                [ img_ [src_ "/static/home.png"]
                , p_ [] ["We are working out discounts with local hotels for you."]
                , a_ [href_ "/accommodation"] ["See all hotel options"]
                ]
            ]
        , section_
            [id_ "cfp"]
            [ h2_ [] [text "CfP"]
            , section_
                [class_ "note"]
                [ img_ [src_ "/static/document.png"]
                , h4_ [] ["The CfP for NixCon 2026 is open. Submit your talk proposals!"]
                , a_ [href_ "https://talks.nixcon.org/nixcon-2026/"] ["To the CfP"]
                ]
            ]
        , section_
            [id_ "organisers"]
            [ h2_ [] [text "Organisers"]
            , section_
                [id_ "main-organisers"]
                [ div_
                    [id_ "social"]
                    [ p_
                        [class_ "social-link"]
                        [ img_ [src_ "/static/keyboard.png"]
                        , a_ [href_ "https://matrix.to/#/#nixcon:nixos.org"] ["Join Matrix room"]
                        ]
                    , p_
                        [class_ "social-link"]
                        [ img_ [src_ "/static/letter.png"]
                        , a_ [href_ "mailto:nixcon@nixos.org"] ["Send us an email"]
                        ]
                    ]
                , p_
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
                    [ li_ [] ["Barbara Trojecka"]
                    , li_ [] ["Carina Hahn"]
                    , li_ [] ["Farhad Mehta"]
                    , li_ [] ["Lorenz Bischof"]
                    , li_ [] ["Maja Szelągowska"]
                    , li_ [] ["Marek Zalonc"]
                    , li_ [] ["Picnoir"]
                    , li_ [] ["Sigmanificient"]
                    , li_ [] ["andi-"]
                    , li_ [] ["hrmny"]
                    , li_ [] ["Cindy 😺"]
                    , li_ [] ["... maybe you?"]
                    ]
                ]
            , section_
                [id_ "venue"]
                [ p_
                    []
                    [ "We kindly thank the Jagiellonian University for all their assistance and for co-organising at their venue in Kraków."
                    ]
                , a_
                    [href_ "https://en.uj.edu.pl/en_GB"]
                    [img_ [class_ "logo", src_ "/static/university-logo.svg"]]
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
            [id_ "sponsorship"]
            [ h2_ [] [text "Sponsorship"]
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
                    , price = "16384 €"
                    }
                ]
            ]
        , section_
            [id_ "sponsors"]
            [ h2_ [] [text "Sponsors"]
            , sponsors
                [class_ "sponsor-rows"]
                [ Sponsor
                    { tier = Gold
                    , name = "Sponsor"
                    , image = "/static/sponsor-logos/pdt-partners.svg"
                    , website = "https://www.pdtpartners.com/"
                    }
                , Sponsor
                    { tier = Gold
                    , name = "Sponsor"
                    , image = "/static/sponsor-logos/flox.svg"
                    , website = "https://flox.dev/"
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
        , div_ [class_ "price"] [text price]
        , ul_ [class_ "details"] [li_ [] [text t] | t <- details]
        ]

ticketScrolls :: [Attribute action] -> [TicketScroll] -> View model action
ticketScrolls attrs = ul_ (attrs <> [class_ "ticket-scrolls"]) . fmap ticketScroll

data SponsorshipTier
    = Bronze
    | Silver
    | Gold
    | Diamond
    deriving (Eq)

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
            "mailto:sponsor@nixos.org?subject=NixCon%20Sponsorship%3A%20%3CYour%20Company%20Name%3E&body=Please%20provide%20at%20least%20the%20following%20information%3A%0A%20%20-%20Company%20Name%20and%20Website%3A%0A%20%20-%20Desired%20Tier%3A%20Bronze%0A%20%20-%20Desired%20Amount%3A%201024%20EUR%0A%20%20"
        Silver ->
            "mailto:sponsor@nixos.org?subject=NixCon%20Sponsorship%3A%20%3CYour%20Company%20Name%3E&body=Please%20provide%20at%20least%20the%20following%20information%3A%0A%20%20-%20Company%20Name%20and%20Website%3A%0A%20%20-%20Desired%20Tier%3A%20Silver%0A%20%20-%20Desired%20Amount%3A%204096%20EUR%0A%20%20"
        Gold ->
            "mailto:sponsor@nixos.org?subject=NixCon%20Sponsorship%3A%20%3CYour%20Company%20Name%3E&body=Please%20provide%20at%20least%20the%20following%20information%3A%0A%20%20-%20Company%20Name%20and%20Website%3A%0A%20%20-%20Desired%20Tier%3A%20Gold%0A%20%20-%20Desired%20Amount%3A%208192%20EUR%0A%20%20"
        Diamond ->
            "mailto:sponsor@nixos.org?subject=NixCon%20Sponsorship%3A%20%3CYour%20Company%20Name%3E&body=Please%20provide%20at%20least%20the%20following%20information%3A%0A%20%20-%20Company%20Name%20and%20Website%3A%0A%20%20-%20Desired%20Tier%3A%20Diamond%0A%20%20-%20Desired%20Amount%3A%2016384%20EUR%0A%20%20"

sponsorScroll :: SponsorScroll -> View model action
sponsorScroll SponsorScroll{..} =
    li_
        [class_ "scroll"]
        [ div_ [class_ "title"] [text title]
        , div_ [class_ "price"] [text price]
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

data Sponsor = Sponsor
    { name :: MisoString
    , tier :: SponsorshipTier
    , image :: MisoString
    , website :: MisoString
    }

sponsor :: Sponsor -> View model action
sponsor Sponsor{..} =
    a_
        [href_ website, class_ "sponsor-website"]
        [ li_
            []
            [ div_
                [class_ "sponsor"]
                [ img_ [class_ "sponsor-frame", src_ frame]
                , img_ [class_ "sponsor-logo", src_ image]
                ]
            ]
        ]
  where
    frame =
        case tier of
            Bronze -> "/static/sponsor-frames/bronze.png"
            Silver -> "/static/sponsor-frames/silver.png"
            Gold -> "/static/sponsor-frames/gold.png"
            Diamond -> "/static/sponsor-frames/diamond.png"

sponsorTierTitle :: SponsorshipTier -> View model action
sponsorTierTitle tier =
    h3_
        [class_ "sponsor-tier-title"]
        [ title
        ]
  where
    title = case tier of
        Bronze -> "Bronze Tier"
        Silver -> "Silver Tier"
        Gold -> "Gold Tier"
        Diamond -> "Diamond Tier"

sponsorRow :: MisoString -> [Sponsor] -> View model action
sponsorRow _ [] = section_ [class_ "hidden"] []
sponsorRow title sponsorsList =
    li_
        [class_ "sponsor-row"]
        [ titleElem
        , ul_ [] (sponsor <$> sponsorsList)
        ]
  where
    titleElem =
        h3_
            [class_ "sponsor-tier-title"]
            [ text title
            ]

sponsors :: [Attribute action] -> [Sponsor] -> View model action
sponsors attrs sponsorsList =
    ul_
        attrs
        [ sponsorRow
            "Diamond Tier"
            (filter (\s -> s.tier == Diamond) sponsorsList)
        , sponsorRow
            "Gold Tier"
            (filter (\s -> s.tier == Gold) sponsorsList)
        , sponsorRow
            "Silver Tier"
            (filter (\s -> s.tier == Silver) sponsorsList)
        , sponsorRow
            "Bronze Tier"
            (filter (\s -> s.tier == Bronze) sponsorsList)
        ]
