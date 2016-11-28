open Action
open Board

let do_turn b tkh trh fup p b =  failwith "unimplemented"

let rec remove_dups l = match l with
	|[] -> []
	|h::t -> h::(remove_dups (List.filter (fun x -> x<>h) t))

let determine_best_route p rl b = 
	let (seperatel,seperater) = 
		(List.map (fun r -> shortest_path p (get_c0 r) (get_c1 r) b) rl) |>
List.fold_left (fun (tot,rtot) (l,rs) -> (tot+l,(rs @ rtot))) (0,[])
	in
	let routes_to_hub p b h c0 c1 = 
		let (c0d,c0r) = (shortest_path p h c0 b) in let (c1d,c1r) = (shortest_path p h c1 b) in
		(c0d+c1d,c0r @ c1r) in
	let (hubl,hubr) = 
		let hub_list = List.map (fun c -> (List.map (fun r -> routes_to_hub p b c (get_c0 r) (get_c1 r)) rl
			|> List.fold_left (fun (it,rst) (i,rs) -> (i+it,rs @ rst)) (0,[]))) (get_cities b) in
		let rec hub_min (ml,mr) = function
			|[] -> (ml,mr)
			|(hl,hr)::t -> if hl<ml then hub_min (hl,hr) t else hub_min (ml,mr) t in
		hub_min (5000000,[]) hub_list in
	let route_length rs = List.fold_left (fun tot (l,r) -> tot+l) 0 rs in
if (seperatel < hubl) then (seperater |> remove_dups) else (hubr |> remove_dups)