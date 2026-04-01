module Page.PrivacyPolicy where

import Miso.Html.Element
import Miso.Html.Property
import Miso.Prelude

page :: View model action
page =
    main_
        []
        [ h1_ [] [text "Privacy policy"]
        , p_
            []
            [ text
                "By using the website, you agree to the collection and use of information in accordance with this Privacy Policy."
            ]
        , h2_ [] [text "Data collection"]
        , p_
            []
            [ text "This website is hosted on GitHub Pages, which may collect some data. See "
            , a_
                [ href_
                    "https://docs.github.com/en/pages/getting-started-with-github-pages/what-is-github-pages#data-collection"
                ]
                [text "this page"]
            , " for details on GitHub Pages data collection and "
            , a_
                [ href_
                    "https://docs.github.com/en/site-policy/privacy-policies/github-general-privacy-statement"
                ]
                [text "this page"]
            , text " for GitHub's General Privacy Statement."
            ]
        , h2_ [] [text "Third-party links"]
        , p_
            []
            [ text
                "This website may contain links to other websites that are not operated by us. If you click on such links, you will be directed to that third party's site. We strongly advise you to review the Privacy Policy of every site you visit. We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services."
            ]
        , h2_ [] [text "Conference schedule and Pretalx widget"]
        , p_
            []
            [ text
                "To display our conference schedule, we use a widget provided by our conference management partner, pretalx. This service is hosted by pretalx on servers within the European Union (Germany). When you visit our schedule page, your browser will load JavaScript and content directly from our event page, which is hosted by pretalx, at "
            , a_ [href_ "https://talks.nixcon.org/nixcon-2026/"] [text "talks.nixcon.org"]
            , text
                ". The main website content is viewable without JavaScript, but the schedule page requires JavaScript to display the pretalx widget."
            ]
        , p_
            []
            [ text
                "The legal basis for this data processing is our legitimate interest in providing a functional and interactive conference schedule to our visitors. This processing involves your IP address being sent to the pretalx service to enable the connection and deliver the content. According to pretalx's policy, they do not log this data for attendees viewing the schedule. For more information, please see the "
            , a_
                [href_ "https://talks.nixcon.org/nixcon-2026/privacy"]
                [text "pretalx privacy policy"]
            , text "."
            ]
        , h2_ [] [text "Policy changes"]
        , p_
            []
            [ text
                "We may change this Privacy Policy from time to time. You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page."
            ]
        , h2_ [] [text "Contact us"]
        , p_
            []
            [ text
                "If you have any questions, don't hesitate to send an email to "
            , a_ [href_ "mailto:foundation@nixos.org"] [text "foundation@nixos.org"]
            , text "."
            ]
        ]
