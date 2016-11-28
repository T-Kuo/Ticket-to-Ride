open Card

(* performs a turn *)
val do_turn : Board.board -> TicketCard.hand -> TrainCard.hand -> TrainCard.t list -> Player.player -> bool -> Action.action

(* finds the best route on a board to take *)
val determine_best_route : Player.player -> Board.route list -> Board.board -> Board.route list