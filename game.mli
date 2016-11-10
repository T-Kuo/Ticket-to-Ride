(* the type of a state of a Ticket to Ride game *)
type state

(* checks if a player is a human player *)
val human_player : Board.player -> bool

(* the hand of a player in a given state of the game *)
val player_hand : Board.player -> state -> Card.TrainCard.t list

(* the state of the game after a turn is taken *)
val do_turn : state -> state

(* the score of a player in a given state of the game *)
val score_player : Board.player -> state -> int

(* the winner of the game in a given game state *)
val determine_winner : state -> Board.player

val main : unit