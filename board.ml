open Color
open Player

type city = {name : string; connections : string list}
type route = {c0 : city; c1 : city; color : color; owner : player; length : int}


(* the type of a Ticket to Ride board *)
type board = {cities : city list; routes : route list}


let a = {name="Vancouver";connections=["Seattle";"Calgary"]}
let b = {name="Seattle";connections=["Vancouver";"Calgary";"Portland";"Helena"]}
let c = {name="Calgary";connections=["Vancouver";"Seattle";"Helena";"Winnipeg"]}
let d = {name="Portland";connections=["Seattle";"Salt Lake City";
  "San Francisco"]}
let e = {name="San Francisco";connections=["Portland";"Salt Lake City";
  "Los Angles"]}
let f = {name="Los Angeles";connections=["San Francisco";"Las Vegas";"Phoenix";
  "El Paso"]}
let g = {name="Salt Lake City";connections=["San Francisco";"Portland";
  "Las Vegas";"Helena";"Denver"]}
let h = {name="Helena";connections=["Seattle";"Calgary";"Winnipeg";"Duluth";
  "Omaha";"Denver";"Salt Lake City"]}
let i = {name="Las Vegas";connections=["Los Angeles";"Salt Lake City"]}
let j = {name="Phoenix";connections=["Los Angeles";"Denver";"Santa Fe";
  "El Paso"]}
let k = {name="Santa Fe";connections=["Phoenix";"Denver";"El Paso";
  "Oklahoma City"]}
let l = {name="El Paso";connections=["Los Angeles";"Phoenix";"Santa Fe";
  "Oklahoma City";"Dallas";"Houston"]}
let m = {name="Denver";connections=["Salt Lake City";"Helena";"Omaha";
  "Kansa City"; "Oklahoma City";"Santa Fe";"Phoenix"]}
let n = {name="Winnpeg";connections=["Calgary";"Helena";"Duluth";
  "Sault St. Marie"]}
let o = {name="Duluth";connections=["Helena";"Winnpeg";"Sault St. Marie";
  "Toronto";"Chicago";"Omaha"]}
let p = {name="Oklahoma City";connections=["Denver";"Kansas City";"Little Rock";
  "Dallas";"El Paso";"Santa Fe"]}
let q = {name="Omaha";connections=["Duluth";"Chicago";"Kansas City";"Denver";
  "Helena"]}
let r = {name="Kansas City";connections=["Omaha";"Saint Louis";"Oklahoma City";
  "Denver"]}
let s = {name="Dallas";connections=["El Paso";"Oklahoma City";"Little Rock";
  "Houston"]}
let t = {name="Houston";connections=["Dallas";"El Paso";"New Orleans"]}
let u = {name="Little Rock";connections=["Oklahoma City";"Dallas";"New Orleans";
  "Nashville";"Saint Louis"]}
let v = {name="New Orleans";connections=["Houston";"Little Rock";"Atlanta";
  "Miami"]}
let w = {name="Sault St. Marie";connections=["Winnpeg";"Duluth";"Toronto";
  "Montreal"]}
let x = {name="Chicago";connections=["Duluth";"Omaha";"Saint Louis";
  "Pittsburgh";"Toronto"]}
let y = {name="Saint Louis";connections=["Kansas City";"Chicago";"Pittsburgh";
  "Nashville";"Little Rock"]}
let z = {name="Toronto";connections=["Sault St. Marie";"Duluth";"Chicago";
  "Pittsburgh";"Montreal"]}
let a_1 = {name="Nashville";connections=["Saint Louis";"Little Rock";
  "Pittsburgh";"Atlanta";"Raleigh"]}
let b_1 = {name="Atlanta";connections=["Nashville";"Raleigh";"Charleston";
  "Miami";"New Orleans"]}
let c_1 = {name="Pittsburgh";connections=["Chicago";"Saint Louis";"Nashville";
  "Raleigh";"Washington";"New York";"Toronto"]}
let d_1 = {name="Raleigh";connections=["Nashville";"Atlanta";"Charleston";
  "Washington";"Pittsburgh"]}
let e_1 = {name="Charleston";connections=["Raleigh";"Atlanta";"Miami"]}
let f_1 = {name="Miami";connections=["New Orleans";"Atlanta";"Charleston"]}
let g_1 = {name="Washington";connections=["Raleigh";"Pittsburgh";"New York"]}
let h_1 = {name="New York";connections=["Washington";"Pittsburgh";"Montreal";
  "Boston"]}
let i_1 = {name="Boston";connections=["New York";"Montreal"]}
let j_1 = {name="Montreal";connections=["Sault St. Marie";"Toronto";"Boston";
  "New York"]}

let ab1 = {c0=a;c1=b;color=Colorless;owner=None;length=1}
let ab2 = {c0=a;c1=b;color=Colorless;owner=None;length=1}
let ac = {c0=a;c1=c;color=Colorless;owner=None;length=3}
let bc = {c0=b;c1=c;color=Colorless;owner=None;length=4}
let bh = {c0=b;c1=h;color=Yellow;owner=None;length=6}
let bd1 = {c0=b;c1=d;color=Colorless;owner=None;length=1}
let bd2 = {c0=b;c1=d;color=Colorless;owner=None;length=1}
let de1 = {c0=d;c1=e;color=Green;owner=None;length=5}
let de2 = {c0=d;c1=e;color=Pink;owner=None;length=5}
let dg = {c0=d;c1=g;color=Blue;owner=None;length=6}
let ef1 = {c0=e;c1=f;color=Yellow;owner=None;length=3}
let ef2 = {c0=e;c1=f;color=Pink;owner=None;length=3}
let eg1 = {c0=e;c1=g;color=White;owner=None;length=5}
let eg2 = {c0=e;c1=g;color=Orange;owner=None;length=5}
let fi = {c0=f;c1=i;color=Colorless;owner=None;length=2}
let fj = {c0=f;c1=j;color=Colorless;owner=None;length=3}
let fl = {c0=f;c1=l;color=Black;owner=None;length=6}
let ig = {c0=i;c1=g;color=Orange;owner=None;length=3}
let gm1 = {c0=g;c1=m;color=Red;owner=None;length=3}
let gm2 = {c0=g;c1=m;color=Yellow;owner=None;length=3}
let gh = {c0=g;c1=h;color=Pink;owner=None;length=3}
let jm = {c0=j;c1=m;color=White;owner=None;length=5}
let jk = {c0=j;c1=k;color=Colorless;owner=None;length=3}
let jl = {c0=j;c1=l;color=Colorless;owner=None;length=3}
let lk = {c0=l;c1=k;color=Colorless;owner=None;length=2}
let km = {c0=k;c1=m;color=Colorless;owner=None;length=2}
let ch = {c0=c;c1=h;color=Colorless;owner=None;length=4}
let cn = {c0=c;c1=n;color=White;owner=None;length=6}
let hn = {c0=h;c1=n;color=Blue;owner=None;length=4}
let ho = {c0=h;c1=o;color=Orange;owner=None;length=6}
let hq = {c0=h;c1=q;color=Red;owner=None;length=5}
let hm = {c0=h;c1=m;color=Green;owner=None;length=4}
let mq = {c0=m;c1=q;color=Pink;owner=None;length=4}
let mr1 = {c0=m;c1=r;color=Black;owner=None;length=4}
let mr2 = {c0=m;c1=r;color=Orange;owner=None;length=4}
let mp = {c0=m;c1=p;color=Red;owner=None;length=4}
let kp = {c0=k;c1=p;color=Blue;owner=None;length=3}
let lp = {c0=l;c1=p;color=Yellow;owner=None;length=5}
let ls = {c0=l;c1=s;color=Red;owner=None;length=4}
let lt = {c0=l;c1=t;color=Green;owner=None;length=6}
let ts1 = {c0=t;c1=s;color=Colorless;owner=None;length=1}
let ts2 = {c0=t;c1=s;color=Colorless;owner=None;length=1}
let tv = {c0=t;c1=v;color=Colorless;owner=None;length=2}
let sp1 = {c0=s;c1=p;color=Colorless;owner=None;length=2}
let sp2 = {c0=s;c1=p;color=Colorless;owner=None;length=2}
let su = {c0=s;c1=u;color=Colorless;owner=None;length=2}
let pr1 = {c0=p;c1=r;color=Colorless;owner=None;length=2}
let pr2 = {c0=p;c1=r;color=Colorless;owner=None;length=2}
let pu = {c0=p;c1=u;color=Colorless;owner=None;length=2}
let ry1 = {c0=r;c1=y;color=Blue;owner=None;length=2}
let ry2 = {c0=r;c1=y;color=Pink;owner=None;length=2}
let rq1 = {c0=r;c1=q;color=Colorless;owner=None;length=1}
let rq2 = {c0=r;c1=q;color=Colorless;owner=None;length=1}
let qo1 = {c0=q;c1=o;color=Colorless;owner=None;length=2}
let qo2 = {c0=q;c1=o;color=Colorless;owner=None;length=2}
let qx = {c0=q;c1=x;color=Blue;owner=None;length=4}
let nw = {c0=n;c1=w;color=Colorless;owner=None;length=6}
let no = {c0=n;c1=o;color=Black;owner=None;length=4}
let ow = {c0=o;c1=w;color=Colorless;owner=None;length=3}
let oz = {c0=o;c1=z;color=Pink;owner=None;length=6}
let ox = {c0=o;c1=x;color=Red;owner=None;length=3}
let xz = {c0=x;c1=z;color=White;owner=None;length=4}
let xc_11 = {c0=x;c1=c_1;color=Orange;owner=None;length=3}
let xc_12 = {c0=x;c1=c_1;color=Black;owner=None;length=3}
let xy1 = {c0=x;c1=y;color=White;owner=None;length=2}
let xy2 = {c0=x;c1=y;color=Green;owner=None;length=2}
let yu = {c0=y;c1=u;color=Colorless;owner=None;length=2}
let ya_1 = {c0=y;c1=a_1;color=Colorless;owner=None;length=2}
let yc_1 = {c0=y;c1=c_1;color=Green;owner=None;length=5}
let ua_1 = {c0=u;c1=a_1;color=White;owner=None;length=3}
let vu = {c0=v;c1=u;color=Green;owner=None;length=3}
let vb_11 = {c0=v;c1=b_1;color=Yellow;owner=None;length=4}
let vb_12 = {c0=v;c1=b_1;color=Orange;owner=None;length=4}
let vf_1 = {c0=v;c1=f_1;color=Red;owner=None;length=6}
let f_1b_1 = {c0=f_1;c1=b_1;color=Blue;owner=None;length=5}
let f_1e_1 = {c0=f_1;c1=e_1;color=Pink;owner=None;length=4}
let e_1b_1 = {c0=e_1;c1=b_1;color=Colorless;owner=None;length=2}
let e_1d_1 = {c0=e_1;c1=d_1;color=Colorless;owner=None;length=2}
let d_1b_11 = {c0=d_1;c1=b_1;color=Colorless;owner=None;length=2}
let d_1b_12 = {c0=d_1;c1=b_1;color=Colorless;owner=None;length=2}
let d_1a_1 = {c0=d_1;c1=a_1;color=Black;owner=None;length=3}
let d_1c_1 = {c0=d_1;c1=c_1;color=Colorless;owner=None;length=2}
let d_1g_11 = {c0=d_1;c1=g_1;color=Colorless;owner=None;length=2}
let d_1g_12 = {c0=d_1;c1=g_1;color=Colorless;owner=None;length=2}
let b_1a_1 = {c0=b_1;c1=a_1;color=Colorless;owner=None;length=1}
let a_1c_1 = {c0=a_1;c1=c_1;color=Yellow;owner=None;length=4}
let c_1z = {c0=c_1;c1=z;color=Colorless;owner=None;length=2}
let c_1g_1 = {c0=c_1;c1=g_1;color=Colorless;owner=None;length=2}
let c_1h_11 = {c0=c_1;c1=h_1;color=White;owner=None;length=2}
let c_1h_12 = {c0=c_1;c1=h_1;color=Green;owner=None;length=2}
let wz = {c0=w;c1=z;color=Colorless;owner=None;length=2}
let wj_1 = {c0=w;c1=j_1;color=Black;owner=None;length=5}
let g_1h_11 = {c0=g_1;c1=h_1;color=Orange;owner=None;length=2}
let g_1h_12 = {c0=g_1;c1=h_1;color=Black;owner=None;length=2}
let h_1i_11 = {c0=h_1;c1=i_1;color=Yellow;owner=None;length=2}
let h_1i_12 = {c0=h_1;c1=i_1;color=Red;owner=None;length=2}
let j_1i_11 = {c0=j_1;c1=i_1;color=Colorless;owner=None;length=2}
let j_1i_12 = {c0=j_1;c1=i_1;color=Colorless;owner=None;length=2}
let j_1h_1 = {c0=j_1;c1=h_1;color=Blue;owner=None;length=3}
let j_1z = {c0=j_1;c1=z;color=Colorless;owner=None;length=3}


(* [empty] is the empty board where for all routes have no owner *)
let new_board = {cities=[a;b;c;d;e;f;g;h;i;j;k;l;m;n;o;p;q;r;s;t;u;v;w;x;y;z;
  a_1;b_1;c_1;d_1;e_1;f_1;g_1;h_1;i_1;j_1]; routes = [ab1;ab2;ac;bc;bh;bd1;bd2;
  de1;de2;dg;ef1;ef2;eg1;eg2;fi;fj;fl;ig;gm1;gm2;gh;jm;jk;jl;lk;km;ch;cn;hn;ho;
  hq;hm;mq;mr1;mr2;mp;kp;lp;ls;lt;ts1;ts2;tv;sp1;sp2;su;pr1;pr2;pu;ry1;ry2;rq1;
  rq2;qo1;qo2;qx;nw;no;ow;oz;ox;xz;xc_11;xc_12;xy1;xy2;yu;ya_1;yc_1;ua_1;vu;
  vb_11;vb_12;vf_1;f_1b_1;f_1e_1;e_1b_1;e_1d_1;d_1b_11;d_1b_12;d_1a_1;d_1c_1;
  d_1g_11;d_1g_12;b_1a_1; a_1c_1;c_1z;c_1g_1;c_1h_11;c_1h_12;wz;wj_1;g_1h_11;
  g_1h_12;h_1i_11;h_1i_12;j_1i_11;j_1i_12;j_1h_1;j_1z]}

(* Helper function of [cnames_list ()]:
 * Retrieves string names of all cities and returns as a list *)
let rec get_names clist =
   match clist with
   | [] -> []
   | h::t -> h.name::(get_names t)

(* Returns list of string names of all cities on board *)
let cnames_list () =
  get_names (new_board.cities)

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
	let rec step p c0 c1 b col dol rol l=
		let (c,d,r) = List.hd l
		in
		if (c,!d,!r) = (col,dol,rol) then (0,[])
		else if c=c1 then (!d,!r)
		else (update_connections p (c,d,r) b l c.connections;
			List.fast_sort (fun (c0,d0,r0) (c1,d1,r1) -> compare !d0 !d1) (List.tl l)
			|>step p c0 c1 b c !d !r)

	in
	step p c0 c1 b a 100000000 [] ((List.map (fun x -> if x=c0 then (x, ref 0, ref [])
		else (x, ref 50000000, ref [])) b.cities) |>
			List.fast_sort (fun (c0,d0,r0) (c1,d1,r1) ->
				let c = compare !d0 !d1 in if c <> 0 then c else
					compare (List.length !r0) (List.length !r1)))

(* [dfs p c0 c1 b visited connections] traverses the board [b] and returns true
 * if the player [p] owns a path on the board [b] from the city [c0] to the city
 * [c1], otherwise, [dfs p c0 c1 b visited connections] returns false.
 * Preconditions: [visited] is the list of names of cities that have already
 * been visited in the traversal, [connections] is the list of names of
 * unvisited cities that are one route away from the city [c0] *)
let rec dfs p c0 c1 b (visited: string list ref) connections =
  match connections with
  | [] -> false
  | h::t when h = c1.name -> (let route = List.find (fun r -> r.c0 = c0 &&
                                         r.c1 = c1 || r.c0 = c1 && r.c1 = c0)
                                         b.routes in
                             if route.owner = p then true
                             else false)
  | h::t -> (let city = List.find (fun c -> c.name = h) b.cities in
            let route = List.find (fun r -> c0 = c0 &&  c1 = c1 ||
                        c0 = c1 && c1 = c0) b.routes in
            let _ = if not (List.exists (fun x -> x = h) !visited) then
                      visited := h::!visited
                    else
                      () in
            let cities = List.filter (fun c -> not (List.exists (fun x -> x = c)
                                               !visited)) city.connections in
            if route.owner = p then
              dfs p city c1 b visited cities ||  dfs p c0 c1 b visited t
            else
              dfs p c0 c1 b visited t)

(* determines if a player controls a route between two cities on a
 * board *)
let has_connected p c0 c1 b =
  dfs p c0 c1 b (ref [c0.name]) c0.connections

(* attempts to claim a route on a board *)
let claim_route p r b =
  if List.mem r b.routes then
    if r.owner = None then
      let r1 = {r with owner = p} in
      let routes1 = List.filter (fun x -> x.c0<>r.c0 || x.c1<>r.c1) b.routes in
      (true, {b with routes = r1::routes1})
    else
      (false, b)
  else
    failwith "Route is not on the board"


