
type playerTurn = Player1 | Player2 | Player3 | Player4 | Player5

type playerMove = DrawCard | DrawDeck | MakeTrack

type playerHand

type winner = Player1 | Player2 | Player3 | Player4 | Player5

type game_state = Start | Player1Turn | Player2Turn | Player3Turn | Player4Turn
  | Player5Turn | EndGame