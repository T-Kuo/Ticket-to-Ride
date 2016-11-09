module type Card = sig

	type t
	type t deck


	val new_deck : t deck

	val draw : t deck ->  t option * t deck

	val is_empty : t deck -> bool

	val shuffle : t deck -> t deck

	val discard : t list -> t deck -> t deck

end


module TrainCard : Card

module TicketCard : Card