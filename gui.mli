open Async.Std
(* performs a turn *)
val do_turn : Board.board -> Player.player -> Card.TicketCard.hand -> Card.TrainCard.hand -> Card.TrainCard.t list -> int -> bool -> Action.action

val main_gui: (Board.board * Player.player * Card.TicketCard.hand * Card.TrainCard.hand * Card.TrainCard.t list *
          int * bool)
         Ivar.t ref ->

 Action.action Ivar.t ref -> unit -> unit