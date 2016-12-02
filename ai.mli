open Card

(* performs a turn *)
val do_turn : Board.board -> TicketCard.hand -> TrainCard.hand -> TrainCard.t list -> Player.player -> bool -> Action.action

(* finds the best route on a board to take *)
val determine_best_route : Player.player -> (Board.city * Board.city) list -> Board.board -> Board.route list

(* given a number of ticket cards, choose which tickets to keep *)
val choose_tickets : TicketCard.t list -> int -> TicketCard.t list