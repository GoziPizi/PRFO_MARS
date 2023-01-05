module type Contrat = 
  sig 
    type t 
    val compare : t -> t -> int
  end

module type Graph = 
  sig 
    type t
    type node 
    type transition

    val empty : t 
    val cardinal : t -> int
    val add_node : node -> t -> t 
    val add_edge : node -> int -> node -> t -> t 
    val neighbors : node -> t -> transition list
    val dijkstra : node -> node -> t -> node list
  end 

module MakeGraph (X:Contrat)=
  struct 
    module Map = Map.Make(X)
    type node = X.t
    type transition = int*node
    type t = transition list Map.t

    let empty = Map.empty
    
    let cardinal t = Map.cardinal t

    let add_node node graph = 
      if Map.mem node graph then graph 
      else Map.add node [] graph

    let add_edge node1 distance node2 graph = 
      if not(Map.mem node1 graph && Map.mem node2 graph) then graph 
      else 
        let transition1 = Map.find node1 graph in 
        let transition2 = Map.find node2 graph in 
        let newt1 = (distance, node2)::transition1 in 
        let newt2 = (distance, node1)::transition2 in  
        Map.add node1 newt1 (Map.add node2 newt2 graph)
    
    let neighbors node graph = 
      Map.find node graph 

    (** Il faudra préciser au compilateur d'aller regarder dans ../bin/ *)
    open Priority

    let dijkstra start finish graph =
      let distances = Hashtbl.create (G.cardinal graph) in
      let previous = Hashtbl.create (G.cardinal graph) in
      let q = ref P.empty in
      G.iter_nodes (fun node ->
        if node = start then Hashtbl.add distances node 0
        else Hashtbl.add distances node max_int;
        Hashtbl.add previous node None;
        q := P.insert !q (Hashtbl.find distances node) node
      ) graph;
      while not (P.is_empty !q) do
        let (priority, min_node, q') = P.extract !q in
        q := q';
        if min_node = finish then () (* We have reached the destination node, so we can stop the loop. *)
        else 
          G.iter_neighbors min_node (fun neighbor (weight, _) ->
            let alt = Hashtbl.find distances min_node + weight in
            if alt < Hashtbl.find distances neighbor then begin
              Hashtbl.replace distances neighbor alt;
              Hashtbl.replace previous neighbor (Some min_node);
              q := P.insert !q alt neighbor
            end
          ) graph
      done;
      let rec construct_path node path =
        match Hashtbl.find previous node with
        | None -> node::path
        | Some prev -> construct_path prev (node::path)
      in
      List.rev (construct_path finish [])
  end 

