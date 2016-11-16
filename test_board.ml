open OUnit2
open Board
open Color
open Player



let tests = [

"basic" >:: (fun _ -> assert_equal
	(4,[ab])
		(shortest_path Player1 a b new_board));

"alternate" >:: (fun _ -> assert_equal
	(7,[ac])
		(shortest_path Player1 a c new_board));

"longer" >:: (fun _ -> assert_equal
	(9,[cd;ac])
		(shortest_path Player1 a d new_board));


]