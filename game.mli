type state

val human_player : Board.player -> bool

val player_hand : Board.player -> state -> Card.TrainCard.t list

val do_turn : state -> state

val score_player : Board.player -> state -> int

val determine_winner : state -> Board.player

val main : unit