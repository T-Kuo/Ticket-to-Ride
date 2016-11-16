open OUnit2
open Board
open Color
open Player



let tests = [

"basic" >:: (fun _ -> assert_equal
	([ab;])
		(shortest_path Player1 a b new_board))
]