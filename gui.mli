(* performs a turn *)
val do_turn : Board.t -> Board.player -> TicketCard.t hand -> TrainCard.t hand -> TrainCard.t list -> int -> bool -> Action.t