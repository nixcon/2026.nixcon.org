module Page.Accommodation where

import Miso.Html.Element
import Miso.Html.Property
import Miso.Prelude

page :: View model action
page =
    main_
        [id_ "hotels"]
        [ h1_ [] ["Hotels"]
        , p_
            []
            [ text
                "We're talking to local hotels in Kraków to inform them about NixCon 2026 and to ask if they can offer discounts or other benefits to our attendees."
            ]
        , p_ [] [text "Check back frequently!"]
        , article_
            []
            [ div_
                []
                [ h2_ [] [text "B&B Hotel Kraków Centrum"]
                , p_
                    []
                    [ text
                        "Located on the banks of the Vistula River, just a short walk from Wawel Castle and Kraków's Old Town, B&B Hotel Kraków Centrum offers modern accommodation in a quieter part of the city while remaining within easy reach of Kraków's main attractions.\n\nGuests can choose from double, twin, triple and family rooms, with breakfast available.\n\nNixCon attendees can use the code NIXCON to receive a 16% discount on direct bookings."
                    ]
                , a_
                    [href_ "https://www.hotel-bb.com/pl/hotel/krakow-centrum"]
                    [button_ [] [text "Visit website"]]
                ]
            , img_ [src_ "/static/accommodation/hotel-bb.jpg"]
            ]
        , article_
            []
            [ div_
                []
                [ h2_ [] [text "Hotel Wyspiański"]
                , p_
                    []
                    [ text
                        "Located in the heart of Kraków, only a few minutes from the Main Market Square and Kraków Główny railway station, Hotel Wyspiański is a popular choice for visitors who want to stay right in the city centre.\n\nThe hotel offers a variety of room types, an on-site restaurant, lobby bar and conference facilities, making it well suited to both conference attendees and accompanying guests.\n\nNixCon attendees can use the code NIXCON to receive a 10% discount on direct bookings."
                    ]
                , a_
                    [href_ "https://www.hotel-wyspianski.pl"]
                    [button_ [] [text "Visit website"]]
                ]
            , img_ [src_ "/static/accommodation/hotel-wysp.webp"]
            ]
        ]
