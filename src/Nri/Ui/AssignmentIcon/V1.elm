module Nri.Ui.AssignmentIcon.V1 exposing (diagnostic, peerReview)

import Svg.Styled as Svg exposing (Svg)
import Svg.Styled.Attributes as Attributes


diagnostic : Svg msg
diagnostic =
    Svg.svg
        [ Attributes.x "0px"
        , Attributes.y "0px"
        , Attributes.viewBox "0 0 43.8 41"
        , Attributes.style "enable-background:new 0 0 43.8 41;"
        , Attributes.fill "currentcolor"
        , Attributes.width "100%"
        , Attributes.height "100%"
        ]
        [ Svg.path [ Attributes.d "M32.5,41c-1.1,0-2.1-0.4-2.9-1.1c-1.6-1.5-1.6-3.9-0.2-5.5c0,0,0,0,0,0l0.2-0.2c0.2-0.2,0.3-0.4,0.5-0.6H12.4l-0.1-0.1l0,0 l-0.1-0.1l0,0l-0.1-0.1l0,0L12,33l0,0c0,0,0-0.1,0-0.1l0,0c0,0,0-0.1,0-0.1v-0.1l0,0c0.1-0.9,0.5-1.8,1.2-2.4c0.9-0.8,1-2.2,0.1-3.1 c0,0-0.1-0.1-0.1-0.1c-1-0.9-2.6-0.9-3.6,0c-0.9,0.8-1,2.2-0.1,3.1l0.1,0.2c0.7,0.6,1.1,1.5,1.2,2.4c0.1,0.4-0.1,0.9-0.6,1 c0,0,0,0,0,0H10H0.8c-0.4,0-0.8-0.4-0.8-0.8v-11l0,0c0,0,0,0,0-0.1v-0.4l0.1-0.1h0.1h0.7c0.9,0.1,1.8,0.5,2.4,1.2 c0.4,0.5,1,0.7,1.6,0.7c0.6,0,1.2-0.3,1.6-0.7c0.9-1,0.9-2.6,0-3.7c-0.8-0.9-2.1-1-3-0.2c-0.1,0.1-0.1,0.1-0.2,0.2 c-0.6,0.7-1.5,1.2-2.5,1.2H0.2L0.1,20l0,0l-0.1-0.1l0,0L0,19.9l0,0v-0.1l0,0c0,0,0-0.1,0-0.1l0,0V8.2c0-0.4,0.4-0.8,0.8-0.8h8.1 C8.8,7.2,8.6,7,8.5,6.8C6.9,5.3,6.8,2.9,8.3,1.3l0.2-0.2c1.6-1.5,4.2-1.5,5.8,0c1.6,1.4,1.6,3.9,0.2,5.4l-0.2,0.2 c-0.2,0.2-0.3,0.4-0.5,0.6h17.7h0.1l0,0l0.1,0.1l0,0c0.2,0.2,0.2,0.4,0.2,0.7c-0.1,0.9-0.5,1.8-1.2,2.4c-0.9,0.9-1,2.3-0.1,3.3 c0,0,0.1,0.1,0.1,0.1c1,0.9,2.6,0.9,3.6,0c0.9-0.8,1-2.2,0.2-3.1l-0.2-0.1C33.5,10,33.1,9.2,33,8.3c0-0.1,0-0.2,0-0.2 c0-0.4,0.4-0.8,0.8-0.8H43c0.4,0,0.8,0.4,0.8,0.8v11c0,0,0,0.1,0,0.1l0,0v0.1l0,0v0.1l0,0l-0.1,0.1l0,0l-0.1,0.1l0,0l-0.1,0.1H43 c-0.9-0.1-1.8-0.5-2.4-1.2c-0.4-0.5-1-0.7-1.6-0.7c-0.6,0-1.2,0.3-1.6,0.7c-0.9,1-0.9,2.6,0,3.7c0.8,0.9,2.1,1,3,0.2 c0.1-0.1,0.2-0.1,0.2-0.2c0.6-0.6,1.5-1,2.4-1.1l0,0c0.4,0,0.8,0.3,0.8,0.8c0,0,0,0.1,0,0.1c0,0,0,0.1,0,0.1v10.9 c0,0.4-0.4,0.8-0.8,0.8h-8.1c0.1,0.2,0.3,0.4,0.4,0.6c1.6,1.4,1.6,3.9,0.2,5.4l-0.2,0.2C34.6,40.6,33.5,41,32.5,41z M31.9,33 c-0.1,0.9-0.5,1.8-1.2,2.4c-0.9,0.8-1,2.2-0.2,3.1l0.2,0.2c1,0.9,2.6,0.9,3.6,0c0.9-0.8,1-2.2,0.2-3.1l-0.2-0.2 c-0.7-0.6-1.1-1.5-1.2-2.4c0-0.1,0-0.1,0-0.2c0-0.2,0.1-0.4,0.2-0.5l0,0l0.1-0.1l0,0l0.1-0.1h8.7V23c-0.2,0.1-0.4,0.3-0.6,0.5 c-1.3,1.5-3.7,1.7-5.2,0.3c-0.1-0.1-0.2-0.2-0.3-0.3c-1.5-1.7-1.5-4.2,0-5.9c1.4-1.5,3.7-1.7,5.2-0.3c0.1,0.1,0.2,0.2,0.3,0.3 c0.2,0.2,0.4,0.3,0.6,0.5V9h-7.3c0.1,0.3,0.3,0.6,0.5,0.8c1.6,1.4,1.6,3.9,0.2,5.4l-0.2,0.2c-1.6,1.5-4.2,1.5-5.8,0 C28,14,27.9,11.5,29.4,10l0.2-0.2C29.8,9.6,29.9,9.3,30,9h-7.3v8.8c0.2-0.1,0.4-0.3,0.6-0.5c1.4-1.5,3.7-1.7,5.2-0.3 c0.1,0.1,0.2,0.2,0.3,0.3c1.5,1.7,1.5,4.2,0,5.9c-0.7,0.8-1.7,1.2-2.8,1.2c-1.1,0-2.1-0.5-2.8-1.2c-0.2-0.2-0.4-0.3-0.6-0.5V32h8.4 c0.1,0,0.3,0.1,0.4,0.1l0,0l0.1,0.1l0,0v0.1v0.1l0,0c0.1,0.1,0.1,0.3,0.1,0.4C31.7,32.8,31.8,32.9,31.9,33L31.9,33z M21.1,32V21.7 l0,0c0-0.4,0.3-0.8,0.7-0.8c0,0,0,0,0,0H22c1,0.1,1.8,0.5,2.5,1.2c0.4,0.5,1,0.7,1.6,0.7c0.6,0,1.2-0.3,1.6-0.7c0.9-1,0.9-2.6,0-3.7 c-0.8-0.9-2.1-1-3-0.2c-0.1,0.1-0.1,0.1-0.2,0.2c-0.6,0.7-1.5,1.2-2.5,1.2h-0.1c-0.4,0-0.8-0.3-0.8-0.8c0,0,0-0.1,0-0.1l0,0V9h-8.4 c-0.4,0-0.8-0.4-0.8-0.8l0,0c0.1-1,0.5-1.9,1.2-2.5c0.9-0.8,1-2.2,0.1-3.1l-0.1-0.1c-1-0.9-2.6-0.9-3.6,0c-0.9,0.8-1,2.2-0.1,3.1 l0.1,0.1c0.7,0.6,1.1,1.4,1.2,2.3c0,0.1,0,0.1,0,0.2C10.8,8.6,10.4,9,10,9H1.6v9c0.2-0.1,0.4-0.3,0.6-0.5c1.4-1.5,3.7-1.7,5.2-0.3 c0.1,0.1,0.2,0.2,0.3,0.3c1.5,1.7,1.5,4.2,0,5.9C7,24.2,6,24.7,5,24.7c-1.1,0-2.1-0.5-2.8-1.2c-0.2-0.2-0.4-0.3-0.6-0.5v9H9 c-0.1-0.2-0.3-0.4-0.5-0.6c-1.6-1.4-1.6-3.9-0.2-5.4l0.2-0.2c1.6-1.5,4.2-1.5,5.8,0c1.6,1.4,1.6,3.9,0.2,5.4l-0.2,0.2 c-0.2,0.2-0.3,0.4-0.5,0.6L21.1,32z" ] [] ]


peerReview : Svg msg
peerReview =
    Svg.svg
        [ Attributes.width "100%"
        , Attributes.height "100%"
        , Attributes.viewBox "0 0 57 58"
        ]
        [ Svg.g
            [ Attributes.fill "currentcolor"
            , Attributes.fillRule "evenodd"
            ]
            [ Svg.path [ Attributes.d "M16.441 43.288v-10.59l.002-.095v-3.781l-1.263 2.46c-.373.728-1.244 1.029-1.945.668-.7-.36-.966-1.243-.593-1.97l2.476-4.826c.044-.083.092-.162.147-.232a1.648 1.648 0 0 1 1.558-1.11h4.399l-2.218 4.32c-.723 1.414-.238 3.208 1.228 3.963.919.47 1.944.392 2.758-.08l.056-.036v11.309H20.16v-9.093h-.751v9.093h-2.968zm.45-23.648a2.95 2.95 0 1 1 5.903 0 2.953 2.953 0 0 1-2.952 2.952 2.952 2.952 0 0 1-2.95-2.952z" ] []
            , Svg.path [ Attributes.d "M24.376 43.288v-11.55c0-.035 0-.07.002-.108V27.464l-1.392 2.71c-.412.805-1.373 1.135-2.146.739-.774-.396-1.064-1.371-.653-2.174l2.729-5.319c.047-.091.102-.176.162-.255a1.818 1.818 0 0 1 1.716-1.224h6.54c.796 0 1.472.512 1.717 1.224.06.079.114.164.161.255l2.73 5.32c.412.802.12 1.777-.654 2.173-.773.396-1.734.066-2.144-.739l-1.392-2.708v4.104c0 .054-.002.106-.008.158v11.56h-3.291v-9.901h-.786v9.9h-3.291zm3.744-29.2h.006a3.255 3.255 0 0 1 3.251 3.253 3.255 3.255 0 0 1-3.254 3.254 3.255 3.255 0 0 1-3.254-3.254 3.255 3.255 0 0 1 3.251-3.253z" ] []
            , Svg.path [ Attributes.d "M33.073 43.288V31.972l.065.044c.815.47 1.84.55 2.758.079 1.468-.755 1.951-2.549 1.228-3.963l-2.217-4.32h4.398c.722 0 1.336.464 1.558 1.11.053.072.103.149.147.232l2.476 4.825c.373.728.108 1.612-.593 1.97-.7.362-1.572.06-1.947-.667l-1.261-2.46v3.725c0 .048-.002.095-.007.143V43.288h-2.967v-9.093h-.75v9.093h-2.888zm.37-23.648a2.951 2.951 0 1 1 5.902 0 2.953 2.953 0 0 1-2.951 2.952 2.953 2.953 0 0 1-2.952-2.952zM52.869 45.376c.773-.062 1.091.482 1.13.966.038.483-.191 1.072-.965 1.133l-4.29.343c-.01 0-.02-.005-.032-.004-.017.005-.035.012-.052.013-.483.038-1.07-.192-1.13-.968l-.342-4.303a1.053 1.053 0 0 1 .962-1.133 1.052 1.052 0 0 1 1.13.966l.155 1.953c6.516-8.931 6.1-23.482-1.259-31.686-.599-.663-.442-1.286-.099-1.634.336-.344.997-.505 1.661.226 8.007 8.926 8.49 24.528 1.453 34.262l1.678-.134zm-6.36-37.96c.004.018.011.035.012.053.039.484-.19 1.068-.966 1.13l-4.305.343a1.054 1.054 0 0 1-1.132-.963 1.051 1.051 0 0 1 .964-1.13l1.955-.155C34.105.178 19.554.593 11.35 7.954c-.662.6-1.285.441-1.633.097-.345-.335-.506-.994.227-1.66 8.925-8.008 24.527-8.489 34.26-1.452l-.133-1.678c-.062-.774.481-1.092.965-1.13.485-.04 1.072.19 1.133.963l.344 4.292c0 .01-.004.02-.004.03zm-.573 42.24c.343.34.503 1.001-.227 1.668-8.898 8.032-24.453 8.514-34.157 1.457l.133 1.683c.062.775-.479 1.094-.961 1.134-.483.038-1.068-.192-1.13-.967l-.342-4.304c-.001-.012.004-.022.003-.033-.002-.017-.011-.035-.012-.052-.039-.485.192-1.072.963-1.133l4.292-.343a1.052 1.052 0 0 1 .168 2.098l-1.932.154c8.905 6.53 23.398 6.119 31.573-1.26.66-.602 1.282-.445 1.63-.101zM6.848 15.622l-.154-1.954C.178 22.598.594 37.15 7.953 45.352c.6.663.442 1.288.099 1.634-.335.345-.996.506-1.66-.227-8.008-8.925-8.49-24.526-1.453-34.26l-1.679.134c-.772.062-1.091-.482-1.13-.966-.038-.485.19-1.071.964-1.133l4.292-.343c.01-.001.02.003.03.003.019 0 .036-.01.054-.012.483-.037 1.068.192 1.13.966l.342 4.306a1.052 1.052 0 0 1-.964 1.131 1.052 1.052 0 0 1-1.13-.964z" ] []
            ]
        ]