type player = NoPlayer | Player1 | Player2 | Player3 | Player4 | Player5

type color = Colorless | Red | Blue | Yellow | Green | Orange | Black | Pink

type city = string

type route = {n0 : city; n2 : city; length : int; color : color; owner : player}


module Board = sig

	module City = struct
		type t = city
		let compare n1 n2 = String.compare n1 n2
	end

	module BMap = Map.Make(City)

	type board = ((route ref list) BMap.t)

	val empty : board

	val add_city : city -> board -> board

	val add_route : route -> board -> board

	val shortest_path : player -> city -> city -> board -> route list

	val has_connected : player -> city -> city -> board -> bool

	val claim_route : player -> route -> int -> bool * board

	val routes_between : city -> city -> route list


end