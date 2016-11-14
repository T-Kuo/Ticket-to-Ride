(* types needed to set up a Ticket to Ride board *)
type player
type color
type city
type route

(* A [City] is a city on a Ticket to Ride board. *)
module City : sig
		type t = city
		val compare : city -> city -> int
end

(* the type of a Ticket to Ride board *)
type t

(* [empty] is the empty board *)
val empty : t

(* adds a city to a board *)
val add_city : city -> t -> t

(* adds a route to a board *)
val add_route : route -> t -> t

val construct : t

(* determines the shortest path needed to connect two cities on a board *)
val shortest_path : player -> city -> city -> t -> route list

(* determines if a player controls a route between two cities on a
 * board *)
val has_connected : player -> city -> city -> t -> bool

(* attempts to claim a route on a board *)
val claim_route : player -> route -> int -> bool * t

(* the list of routes between two cities on a board *)
val routes_between : city -> city -> route list