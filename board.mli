(* types needed to set up a Ticket to Ride board *)
type player
type city
type route

(* the type of a Ticket to Ride board *)
type board

(* [new_board] is the game board with all routes unclaimed *)
val new_board : board

(* the list of routes between two cities on a board *)
val routes_between : city -> city -> board -> route list

(* determines the shortest path needed to connect two cities on a board *)
val shortest_path : player -> city -> city -> board -> route list

(* determines if a player controls a route between two cities on a
 * board *)
val has_connected : player -> city -> city -> board -> bool

(* attempts to claim a route on a board *)
val claim_route : player -> route -> board -> bool * board

