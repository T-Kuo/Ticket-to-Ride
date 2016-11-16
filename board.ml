open Color
open Player

type city = {name : string; connections : string list}
type route = {c0 : city; c1 : city; color : color; owner : player; length : int}


(* the type of a Ticket to Ride board *)
type board = {cities : city list; routes : route list}


let a = {name="a";connections=["b";"c"]}
let b = {name="b";connections=["a";"c";"e"]}
let c = {name="c";connections=["a";"b";"d"]}
let d = {name="d";connections=["c";"e";]}
let e = {name="e";connections=["b";"d"]}

let ab = {c0=a;c1=b;color=Colorless;owner=None;length=4}
let ac = {c0=a;c1=c;color=Colorless;owner=None;length=7}
let bc = {c0=b;c1=c;color=Colorless;owner=None;length=3}
let be = {c0=b;c1=e;color=Colorless;owner=None;length=3}
let cd = {c0=c;c1=d;color=Colorless;owner=None;length=2}
let de = {c0=d;c1=e;color=Colorless;owner=None;length=3}

(* [empty] is the empty board *)
let new_board = {cities=[a;b;c;d;e]; routes = [ab;ac;bc;be;cd;de]} (* TODO: add the cities and routes *)

(* a list of routes between two cities on a board *)
let routes_between c0 c1 b = 
	let rec rl c0 c1 i l =
		match l with
		|[] -> i
		|h::t when h.c0=c0 && h.c1=c1 || h.c0=c1 && h.c1=c0 ->
			rl c0 c1 (h::i) t
		|h::t -> rl c0 c1 i t
	in
	rl c0 c1 [] b.routes 

let routes_between_string s0 s1 b =
	let rec rl c0 c1 i l =
		match l with
		|[] -> i
		|h::t when h.c0.name=c0 && h.c1.name=c1 || h.c0.name=c1 && h.c1.name=c0 ->
			rl c0 c1 (h::i) t
		|h::t -> rl c0 c1 i t
	in
	rl s0 s1 [] b.routes 


(* determines the shortest path needed to connect two cities on a board *)
let shortest_path p c0 c1 b =
	let rec update_connections p (c,d,r) b l cl =
		let rec update_connection w rn l ct =
			match l with
			|[] -> ()
			|(cl,dl,rl)::t when cl.name = ct -> if w >= !dl then ()
				else (dl := w; rl := rn); ()			(*update distance/route, return list*)
			|(cl,dl,rl)::t ->  update_connection w rn t ct
		in
		match cl with
		|[] -> ()
		|h::t -> let rb = routes_between_string c.name h b |> List.hd in
			if rb.owner = None then (update_connection ((!d)+(rb.length)) (rb::(!r)) l h;
				update_connections p (c,d,r) b l t)
			else if rb.owner = p then (update_connection !d (rb::!r) l h;
				update_connections p (c,d,r) b l t)
			else if (List.length (routes_between_string c.name h b)) = 2 then
				let rb2 = List.nth (routes_between_string c.name h b) 1 in
				if rb2.owner = None then (update_connection (!d+rb2.length) (rb2::!r) l h;
				update_connections p (c,d,r) b l t)
				else if rb2.owner = p then (update_connection !d (rb2::!r) l h;
				update_connections p (c,d,r) b l t)
				else ()
			else ()
	in
	let rec step p c0 c1 b l =
		let (c,d,r) = List.hd l 
		in
		if c=c1 then (!d,!r)
		else (update_connections p (c,d,r) b l c.connections;
			List.fast_sort (fun (c0,d0,r0) (c1,d1,r1) -> compare !d0 !d1) (List.tl l)
			|>step p c0 c1 b)

	in
	step p c0 c1 b ((List.map (fun x -> if x=c0 then (x, ref 0, ref [])
		else (x, ref 50000000, ref [])) b.cities) |>
			List.fast_sort (fun (c0,d0,r0) (c1,d1,r1) ->
				let c = compare !d0 !d1 in if c <> 0 then c else
					compare (List.length !r0) (List.length !r1)))


(* determines if a player controls a route between two cities on a
 * board *)
let has_connected p c0 c1 b = failwith "unimplemented"

(* attempts to claim a route on a board *)
let claim_route p r = failwith "unimplemented"


