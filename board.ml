open Color

(* types needed to set up a Ticket to Ride board *)
type player = None | Player1 | Player2 | Player3 | Player4 | Player5
type city = {name : string; connections : city list}
type route = {c1 : city; c2 : city; color : color; owner : player; length : int}


(* the type of a Ticket to Ride board *)
type board = {cities : city list; routes : route list}

(* [empty] is the empty board *)
let new_board = {cities=[];routes=[]} (* TODO: add the cities and routes *)

(* a list of routes between two cities on a board *)
let routes_between c0 c1 b = failwith "unimplemented"

(* determines the shortest path needed to connect two cities on a board *)
let shortest_path p c0 c1 b =
	let rec update_connections p (c,d,r) b l cl =
		let rec update_connection w rn l ct =
			match l with
			|[] -> failwith "attempt to update nonexistent route"
			|(cl,dl,rl)::t when cl = ct -> if w >= !dl then ()
				else dl := w; rl := rn; ()			(*update distance/route, return list*)
			|h::t -> update_connection w rn t ct
		in
		match cl with
		|[] -> ()
		|h::t -> let rb = routes_between c h b |> List.hd in
if rb.owner = None then update_connection ((!d)+(List.length !r)) (rb::(!r)) l h
			else if rb.owner = p then update_connection !d (rb::!r) l h
			else if (List.length (routes_between c h b)) = 2 then
				let rb2 = List.nth (routes_between c h b) 1 in
				if rb2.owner = None then update_connection (!d+List.length !r) (rb2::!r) l h
				else if rb2.owner = p then update_connection !d (rb2::!r) l h
				else ()
			else ()
	in
	let rec step p c0 c1 b l =
		let (c,d,r) = List.hd l 
		in
		if c=c1 then !r
		else (update_connections p (c,d,r) b l c.connections;
			List.fast_sort (fun (c0,d0,r0) (c1,d1,r1) -> compare !d0 !d1) l
			|>step p c0 c1 b)

	in
	step p c0 c1 b (List.map (fun c -> if c=c0 then (c, ref 0, ref [])
		else (c, ref 50000000, ref [])) b.cities)


(* determines if a player controls a route between two cities on a
 * board *)
let has_connected p c0 c1 b = failwith "unimplemented"

(* attempts to claim a route on a board *)
let claim_route p r = failwith "unimplemented"


