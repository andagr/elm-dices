import Svg exposing (svg, rect, circle)
import Svg.Attributes exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
import Random

main : Program Never Model Msg
main =
  Html.program
    { init = init,
      view = view,
      update = update,
      subscriptions = (\m -> Sub.none) }

type alias Model =
  { dieFace1 : Int,
    dieFace2 : Int }

type Msg = 
    Roll
  | NewFace (Int, Int)

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.pair (Random.int 1 6) (Random.int 1 6)))
    NewFace (newFace1, newFace2) ->
      (Model newFace1 newFace2, Cmd.none)

view: Model -> Html Msg
view model =
  div []
    [ div []
        [ die model.dieFace1,
          die model.dieFace2 ],
      button [ onClick Roll ] [ text "Roll" ] ]

die : number -> Html Msg
die nbr =
  svg
    [ width "120", height "120", viewBox "0 0 120 120" ]
    ([ rect [ fill "#FFF", stroke "#000", x "10", y "10", width "100", height "100", rx "15", ry "15" ] [] ] ++ renderDie nbr)

renderDie : number -> List (Svg.Svg Msg)
renderDie nbr =
  case nbr of
    1 -> dieOne
    2 -> dieTwo
    3 -> dieOne ++ dieTwo
    4 -> dieFour
    5 -> dieOne ++ dieFour
    6 -> dieFour ++ dieOdd
    _ -> Debug.crash "MEH"


dieOne : List(Svg.Svg msg)
dieOne =
  [ circle [ fill "#000", stroke "#000", cx "60", cy "60", r "5" ] [] ]

dieTwo : List (Svg.Svg msg)
dieTwo =
  [ circle [ fill "#000", stroke "#000", cx "30", cy "30", r "5" ] [],
    circle [ fill "#000", stroke "#000", cx "90", cy "90", r "5" ] [] ]

dieFour : List (Svg.Svg msg)
dieFour =
  [ circle [ fill "#000", stroke "#000", cx "30", cy "30", r "5" ] [],
    circle [ fill "#000", stroke "#000", cx "90", cy "30", r "5" ] [],
    circle [ fill "#000", stroke "#000", cx "30", cy "90", r "5" ] [],
    circle [ fill "#000", stroke "#000", cx "90", cy "90", r "5" ] [] ]

dieOdd : List (Svg.Svg msg)
dieOdd =
  [ circle [ fill "#000", stroke "#000", cx "30", cy "60", r "5" ] [],
    circle [ fill "#000", stroke "#000", cx "90", cy "60", r "5" ] [] ]

init: (Model, Cmd Msg)
init =
  (Model 1 1, Cmd.none)
