port module Ports exposing (log)


port log : String -> Cmd msg



-- import File exposing (File)
-- import Json.Encode as Json
-- port outgoing :
--     { action : String
--     , data : Json.Value
--     }
--     -> Cmd msg
-- generateFiles : List File -> Cmd msg
-- generateFiles files =
--     outgoing
--         { action = "generateFiles"
--         , data = Json.list File.encode files
--         }
