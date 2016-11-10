(* performs a turn *)
val do_turn : Board.t -> TicketCard.t hand -> TrainCard.t hand -> TrainCard.t list -> int -> bool -> Action.t

(* finds the best route on a board to take *)
val determine_best_route : (Board.city * Board.city) list -> Board.t -> Board.route list