module Tests.Route exposing (suite)

import Expect
import Route
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Route"
        [ describe "render"
            [ test "works with one item" <|
                \_ ->
                    [ "Dashboard" ]
                        |> Route.render
                        |> Expect.equal (String.trim """
module Route exposing (routes)

import Url.Parser as Parser exposing (Parser)


type Route
    = Dashboard


routes : Parser (Route -> a) a
routes =
    Parser.oneOf
        [ Parser.map Dashboard (Parser.s "dashboard")
        ]
                    """)
            , test "works with multiple items" <|
                \_ ->
                    [ "Dashboard", "AboutUs", "NotFound" ]
                        |> Route.render
                        |> Expect.equal (String.trim """
module Route exposing (routes)

import Url.Parser as Parser exposing (Parser)


type Route
    = Dashboard
    | AboutUs
    | NotFound


routes : Parser (Route -> a) a
routes =
    Parser.oneOf
        [ Parser.map Dashboard (Parser.s "dashboard")
        , Parser.map AboutUs (Parser.s "about-us")
        , Parser.map NotFound (Parser.s "not-found")
        ]
                    """)
            ]
        ]
