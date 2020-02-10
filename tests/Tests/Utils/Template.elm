module Tests.Utils.Template exposing (suite)

import Expect
import Fuzz
import Test exposing (Test, describe, fuzz, test)
import Utils.Template


suite : Test
suite =
    describe "Utils.Template"
        [ describe "customType"
            [ test "returns empty string for empty list" <|
                \_ ->
                    Utils.Template.customType []
                        |> Expect.equal ""
            , test "returns single item for singleton" <|
                \_ ->
                    Utils.Template.customType [ "A" ]
                        |> Expect.equal "= A"
            , test "formats multiple items as expected" <|
                \_ ->
                    Utils.Template.customType [ "A", "B", "C" ]
                        |> Expect.equal (String.trim """
= A
| B
| C
                        """)
            ]
        , describe "list"
            [ test "returns empty list for empty list" <|
                \_ ->
                    Utils.Template.list []
                        |> Expect.equal "[]"
            , test "returns single item for singleton" <|
                \_ ->
                    Utils.Template.list [ "A" ]
                        |> Expect.equal "[ A\n]"
            , test "formats multiple items as expected" <|
                \_ ->
                    Utils.Template.list [ "A", "B", "C" ]
                        |> Expect.equal (String.trim """
[ A
, B
, C
]
                        """)
            ]
        , describe "indent"
            [ test "indents with 4 spaces" <|
                \_ ->
                    "Hello!"
                        |> Utils.Template.indent 1
                        |> Expect.equal "    Hello!"
            , test "indent 2 uses 8 spaces" <|
                \_ ->
                    "Hello!"
                        |> Utils.Template.indent 2
                        |> Expect.equal "        Hello!"
            , fuzz (Fuzz.intRange 0 100) "should use 4 spaces for everything" <|
                \num ->
                    "Hello!"
                        |> Utils.Template.indent num
                        |> String.length
                        |> Expect.equal (String.length "Hello!" + 4 * num)
            , test "works with multiple lines" <|
                \_ ->
                    """
[ A
, B
, C
]"""
                        |> String.trim
                        |> Utils.Template.indent 1
                        |> String.append "\n"
                        |> Expect.equal
                            """
    [ A
    , B
    , C
    ]"""
            ]
        , describe "sluggify"
            [ test "works with CamelCase things" <|
                \_ ->
                    [ "HelloThere"
                    , "What"
                    , "IsUpDood?"
                    ]
                        |> List.map Utils.Template.sluggify
                        |> Expect.equalLists
                            [ "hello-there"
                            , "what"
                            , "is-up-dood?"
                            ]
            , fuzz Fuzz.string "never has uppercase letters" <|
                \str ->
                    Utils.Template.sluggify str
                        |> Expect.equal (String.toLower (Utils.Template.sluggify str))
            , fuzz Fuzz.string "never has any spaces" <|
                \str ->
                    Utils.Template.sluggify str
                        |> String.toList
                        |> List.filter ((==) ' ')
                        |> List.length
                        |> Expect.equal 0
            ]
        ]
