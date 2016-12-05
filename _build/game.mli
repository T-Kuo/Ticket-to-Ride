open Async.Std
(* the type of a state of a Ticket to Ride game *)
type player_state = {
  pid : Player.player;
  ptype : Player.player_type;
  color : Color.color;
	train_hand : Card.TrainCard.hand;
  ticket_hand : Card.TicketCard.hand;
  trains_left : int;
  score : int
  }

(* The player who's turn it is is the first player in player_info *)
type state = {
  board: Board.board;
  train_deck : Card.TrainCard.deck;
  ticket_deck : Card.TicketCard.deck;
	player_info : player_state list
  }

val current_state : state ref
val current_gui_state :(Board.board * Player.player * Card.TicketCard.hand * Card.TrainCard.hand * Card.TrainCard.t list *
          int * bool)
         Ivar.t ref
val human_action: Action.action Ivar.t ref

(* checks if a player is a human player *)
val human_player : Player.player -> state -> bool

(* the hand of a player in a given state of the game *)
val player_hand : Player.player -> state -> Card.TrainCard.hand

(* the state of the game after a turn is taken *)
val do_turn : int -> state -> unit

(* the score of a player in a given state of the game *)
val score_player : Player.player -> state -> int

(* the winner of the game in a given game state *)
val determine_winner : state -> Player.player

val main : unit