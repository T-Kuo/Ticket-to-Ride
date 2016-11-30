(* the type of a state of a Ticket to Ride game *)
type player_state = {
  pid : Player.player;
  ptype : Player.player_type;
  color : Color.color;
	train_hand : TrainCard.hand;
  ticket_hand : TicketCard.hand;
  trains_left : int;
  score : int
  }

(* The player who's turn it is is the first player in player_info *)
type state = {
  board: Board.board;
  train_deck : TrainCard.deck;
  ticket_deck : TicketCard.deck;
	player_info : player_state list
  }

(* checks if a player is a human player *)
val human_player : Player.player -> state -> bool

(* the hand of a player in a given state of the game *)
val player_hand : Player.player -> state -> Card.TrainCard.hand

(* the state of the game after a turn is taken *)
val do_turn : state -> state

(* the score of a player in a given state of the game *)
val score_player : Player.player -> state -> int

(* the winner of the game in a given game state *)
val determine_winner : state -> Player.player

val main : unit