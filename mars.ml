
let do_parse cin a =
  let l = input_line cin in
  Scanf.sscanf l a


let analyse_base cin = 
  let n = do_parse cin "%d" (fun x -> x) in
  Array.to_list
    (Array.init n
       (fun _ ->
         do_parse cin "%s %s %d" (fun a b c -> a,b,c)
       )
    )
  
let analyse_file_1 fn =
  let cin = open_in fn in
  let transitions = analyse_base cin in 
  let start_stop = do_parse cin "%s %s" (fun a b -> a,b) in
  let _ = close_in cin in
  transitions,start_stop
                
                
let output_sol_1 time mod_list =
  Format.printf "%d : %s" time (List.hd mod_list);
  List.iter (Format.printf " -> %s") (List.tl mod_list);
  Format.printf "@."
    

let split_on_char c s =
  let rec aux i =
    try
      let j = String.index_from s i c in
      String.sub s i (j-i)::aux (j+1)
    with _ -> [String.sub s i (String.length s - i)]
  in
  aux 0
  
let parse_trajets cin =
  let m = do_parse cin "%d" (fun x -> x) in
  Array.to_list (Array.init m (fun _ ->
      let s = input_line cin in
      List.filter (fun s -> s<>"" && s<> "->") (split_on_char ' ' s)
    ))
  
let analyse_file_2 fn =
  let cin = open_in fn in
  let transitions = analyse_base cin in
  let trajets = parse_trajets cin in
  transitions,trajets

let parse_trajets_2 cin =
  let m = do_parse cin "%d" (fun x -> x) in
  Array.to_list (Array.init m (fun _ ->
      let s = input_line cin in
      match List.filter (fun s -> s<>"" && s<> "->") (split_on_char ' ' s) with
      | src::dst::[] -> src,dst
      | _ -> raise (Scanf.Scan_failure "format invalide")
    ))

  
let analyse_file_3 fn =
  let cin = open_in fn in
  let transitions = analyse_base cin in
  let trajets = parse_trajets_2 cin in
  transitions,trajets

  

let output_sol_2 sol_list =
  List.iter (fun (mvs,sol) ->
      Format.printf "%s" (List.hd mvs);
      List.iter2 (fun n t -> Format.printf " -%d-> %s" t n) (List.tl mvs) sol;
      Format.printf "@."
    )
    sol_list

module SGraph = Graph.MakeGraph(String)

let construire_graph liste = 
    (**Un elt est un triplet nom1 nom2 distance, et l'accumulateur est le graph *)
    let fold_fonction acc elt = 
        let nom1,nom2,d = elt in 
            SGraph.add_edge nom1 d nom2 (
                SGraph.add_edge nom2 d nom1 (
                    SGraph.add_node nom1 (
                        SGraph.add_node nom2 acc
                        (** On ajoute les noeuds et les aretes (dans les deux sens) *)
                        (** Pas besoin de vérifier si ils y sont déjà, cela est deja fait par les fonctions d'ajouts, donc on en perd pas de temps. *)
                    )
                )
            )
    in List.fold_left fold_fonction SGraph.empty liste

(** Doit renvoyer -1 à la fin car erreur *)
let print_utilisation () = 
    Printf.printf "Mauvais nombre d'arguments.\n";
    Printf.printf "Expéctés deux. \n";  
    Printf.printf "Utilisation : \n"; 
    Printf.printf "./MarsPathFinding epoque(int) filename \n";
    -1

(** Doit renvoyer 0 à la fin *)
let print_soluce_1 chemin graph = 
    List.fold_right (
        fun acc -> fun elt -> Printf.printf "%s->" elt
    ) () chemin

let soluce_1 filename = 
    let liste,(debut,fin) = analyse_file_1 filename in 
    let graph = construire_graph liste in 
    print_soluce_1 (SGraph.dijkstra debut fin graph) graph

let soluce_2 filename = failwith "TODO"

let soluce_3 filename = failwith "TODO"

let _ = if (Array.length Sys.argv <> 3) then print_utilisation ()
    else let choice = Sys.argv.(1) in 
        match choice with 
            | "1" -> soluce_1 Sys.argv.(2)
            | "2" -> soluce_2 Sys.argv.(2)
            | "3" -> soluce_3 Sys.argv.(2)
            |_ -> Printf.printf "Epoque invalide\n Choisir entre 1,2,3.\n"; -1

