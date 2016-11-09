type player
type color
type city
type route

module City : sig
		type t = city
		val compare : city -> city -> int
end

type t

val empty : t

val add_city : city -> t -> t

val add_route : route -> t -> t

val shortest_path : player -> city -> city -> t -> route list

val has_connected : player -> city -> city -> t -> bool

val claim_route : player -> route -> int -> bool * t

val routes_between : city -> city -> route list