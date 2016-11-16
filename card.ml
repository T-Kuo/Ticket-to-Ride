open Color

(* A [Card] has types and values for manipulating Ticket to Ride cards *)
module type Card = sig

  (* the type of a Ticket to Ride card *)
	type t
	(* the type of a hand *)
	type hand
	(* the type of a deck of cards *)
	type deck

  (* [new_deck] is a new deck of cards *)
	val new_deck : deck

  (* checks if a deck of cards is empty *)
	val is_empty : deck -> bool

  (* draws a card from a deck *)
	val draw : deck ->  t option * deck

  (* adds a card to the discard pile *)
	val discard : t -> deck -> deck

  (* checks if a hand contains at least a card of the same type as t *)
	val hand_contains : t -> hand -> bool

  (* adds a card to a hand *)
	val add_to_hand : t -> hand -> hand

  (* removes a card from a hand *)
	val remove_from_hand : t -> hand -> hand

  (* shuffles a deck of cards *)
	val shuffle : deck -> deck

end

(* A [Card] implementation that manipulates the train cards in Ticket to Ride *)
module TrainCard : sig
	include Card
end = struct
	type t = color

	type hand = {rainbow:int;red:int;blue:int;yellow:int;green:int;orange:int;pink:int;white:int;black:int}

	type deck = {draw_pile: t list; discard_pile: t list}

	let new_deck = 
		let () = Random.self_init ()
		in
		let rec add_cards c n d =
			if n=0 then d else add_cards c (n-1) (((Random.int 400),c)::d)
		in
		let (n,l) = add_cards Rainbow 14 []
		|> add_cards Red 12
		|> add_cards Blue 12
		|> add_cards Yellow 12
		|> add_cards Green 12
		|> add_cards Orange 12
		|> add_cards Pink 12
		|> add_cards White 12
		|> add_cards Black 12
		|> List.fast_sort (fun (n0,c1) (n1,c1) -> compare n0 n1)
		|> List.split
		in {draw_pile=l; discard_pile=[]}

	let is_empty d = 
		List.length d.draw_pile = 0

	let draw d =
		if (is_empty d) then (None, d)
		else (Some (List.hd d.draw_pile),
			{d with draw_pile=(List.tl d.draw_pile)})

	let discard c d =
		{d with discard_pile = c::d.discard_pile}

	let hand_contains c h =
		match c with
		|Rainbow -> h.rainbow>0
		|Red -> h.red>0
		|Blue -> h.blue>0
		|Yellow -> h.yellow>0
		|Green -> h.green>0
		|Orange -> h.orange>0
		|Pink -> h.pink>0
		|White -> h.white>0
		|Black -> h.black>0
		|Colorless -> false

	let add_to_hand c h = 
		match c with
		|Rainbow -> {h with rainbow = h.rainbow+1}
		|Red -> {h with red = h.red+1}
		|Blue -> {h with blue = h.blue+1}
		|Yellow -> {h with yellow = h.yellow+1}
		|Green -> {h with green = h.green+1}
		|Orange -> {h with orange = h.orange+1}
		|Pink -> {h with pink = h.pink+1}
		|White -> {h with white = h.white+1}
		|Black -> {h with black = h.black+1}
		|Colorless -> h

	let remove_from_hand c h =
		match c with
		|Rainbow -> {h with rainbow = h.rainbow-1}
		|Red -> {h with red = h.red-1}
		|Blue -> {h with blue = h.blue-1}
		|Yellow -> {h with yellow = h.yellow-1}
		|Green -> {h with green = h.green-1}
		|Orange -> {h with orange = h.orange-1}
		|Pink -> {h with pink = h.pink-1}
		|White -> {h with white = h.white-1}
		|Black -> {h with black = h.black-1}
		|Colorless -> h

  (* shuffles a deck of cards *)
	let shuffle d = 
		let () = Random.self_init ()
		in
		let (n,l) = List.rev_map (fun c -> (Random.int 400),c) d.discard_pile
			|> List.fast_sort (fun (n0,c0) (n1,c1) -> compare n0 n1)
			|> List.split
		in
		{draw_pile=l; discard_pile = []}

end

(* A [Card] implementation that manipulates the ticket cards in Ticket to Ride *)
module TicketCard : sig 
include Card
end = struct
	type t = Board.city * Board.city

	type hand = t list

	type deck = {draw_pile : t list; discard_pile : t list}

	let new_deck = let dp = [] (* TODO: add all of the TTR tickets *)
		in
		{draw_pile=dp;discard_pile=[]}

	let is_empty d = List.length d.draw_pile = 0

	let draw d = if is_empty d then (None,d)
		else (Some (List.hd d.draw_pile),
			{d with draw_pile=(List.tl d.draw_pile)})

	let discard c d = {d with draw_pile=(c::d.discard_pile)}

	let hand_contains c h = List.mem c h

	let add_to_hand c h = c::h

	let remove_from_hand c h = 
		let rec rem  e l = match l with
		|[] -> []
		|h::t when h=e -> t
		|h::t -> rem e t |> List.cons h (* not tail recursive, but only used on small lists *)
		in
		rem c h

	let shuffle d = 
		let () = Random.self_init ()
		in
		let (n,l) = List.rev_map (fun c -> (Random.int 400),c) d.discard_pile
			|> List.fast_sort (fun (n0,c0) (n1,c1) -> compare n0 n1)
			|> List.split
		in
		{draw_pile=l; discard_pile = []}

end
