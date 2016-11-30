(* the type of a game action *)
type action =
| DrawFaceUp of int
| DrawDeck
| ClaimRoute of (Board.route * Color.color)
| RequestTickets