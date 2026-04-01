module Page.CodeOfConduct where

import Miso.Html.Element
import Miso.Prelude

page :: View model action
page =
    main_
        []
        [ h1_ [] ["Code of conduct"]
        , p_
            []
            [ "This Code of Conduct outlines our expectations for all participants at NixCon. We are committed to providing a respectful and inclusive experience for everyone."
            ]
        , p_
            []
            [ "This Code of Conduct is still subject to change. Check back here for the latest version. Last update: 2025-05-29."
            ]
        , h2_ [] ["Core principles"]
        , h3_ [] ["1. Respectful interaction"]
        , p_ [] ["Encounter everyone with as little bias as possible."]
        , p_
            []
            [ "Act considerately and respectfully towards others, their needs, and boundaries. This includes respecting personal space, listening attentively, and refraining from interrupting."
            ]
        , p_
            []
            [ "Use gender-neutral ways of addressing people by default. Only use pronouns when you know which pronouns (if any) an individual prefers. Ask respectfully how others wish to be addressed. Respect preferences for names only or no pronouns. Support others in using correct pronouns."
            ]
        , h3_ [] ["2. Personal responsibility & consent"]
        , p_
            []
            [ "Take responsibility for your own wellbeing and look after your needs. You can leave any conversation or situation at any time if you feel uncomfortable."
            ]
        , p_
            []
            [ "Do not photograph or record individuals that are wearing a red lanyard. If a person wearing a red lanyard appears in a crowd photo, either choose a different photo or edit the photo to make the person and their badge unrecognisable."
            ]
        , h3_ [] ["3. Openness & support"]
        , p_
            []
            [ "If you are unsure if your behaviour is acceptable, ask. Boundaries and discrimination are defined by those who experience them."
            ]
        , p_
            []
            [ "Approach conflicts or differences of opinion with openness, curiosity, and a willingness to listen."
            ]
        , p_
            []
            [ "If someone asks for your support or if you notice something concerning, offer support if appropriate, but respect their wishes. Alert event staff if necessary."
            ]
        , p_
            []
            [ "You are not alone. Ask for help or advice from event staff when you don't know what to do."
            ]
        , h3_ [] ["4. Accountability & learning"]
        , p_
            []
            [ "Apologise when you make mistakes and be open to criticism and feedback. View feedback as an opportunity to learn."
            ]
        , h3_ [] ["5. Respect for the environment"]
        , p_
            []
            [ "Respect the event venue and any specific rules it may have. Help keep shared spaces tidy."
            ]
        , h3_ [] ["Reporting & assistance"]
        , p_
            []
            [ "If you experience or witness behavior that violates this Code of Conduct, or if you need assistance for any reason:"
            ]
        , p_ [] ["Please contact event organisers or designated support staff."]
        , p_
            []
            [ "All reports will be treated with discretion. Event organisers are empowered to take appropriate actions in response to violations."
            ]
        , h3_ [] ["Adaptation"]
        , p_
            []
            [ "This Code of Conduct is adapted from the NixCon 2024 Code of Conduct and the bUm Code of Conduct."
            ]
        ]
