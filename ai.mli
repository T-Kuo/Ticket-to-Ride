val do_turn : Board.t -> TicketCard.t hand -> TrainCard.t hand -> TrainCard.t list -> int -> bool -> Action.t

val determine_best_route : (Board.city * Board.city) list -> Board.t -> Board.route list