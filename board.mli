open Player
open Color

(* types needed to set up a Ticket to Ride board *)
type city = {name : string; connections : string list}
type route = {c0 : city; c1 : city; color : color; owner : player; length : int}

(* the type of a Ticket to Ride board *)
type board = {cities : city list; routes : route list}

(* TODO add the cities and routes so they can be referenced in other modules *)
val a : city

(* [new_board] is the game board with all routes unclaimed *)
val new_board : board

(* [cnames_list ()] generates a string list of all city names found on the
 * board *)
val cnames_list : unit -> string list

(* the list of routes between two cities on a board *)
val routes_between : city -> city -> board -> route list

(* determines the shortest path needed to connect two cities on a board *)
val shortest_path : player -> city -> city -> board -> int * route list

(* determines if a player controls a route between two cities on a
 * board *)
val has_connected : player -> city -> city -> board -> bool

(* attempts to claim a route on a board *)
val claim_route : player -> route -> board -> bool * board

