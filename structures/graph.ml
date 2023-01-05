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
    (**Un mapping qui a un noeud (clé) associe une liste de transition *)
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
    
    let nodes graph = List.map fst (Map.bindings graph)

    let neighbors node graph = 
      Map.find node graph 

    (**Cette fonction sera utile pour l'algorithme de Dijkstra *)
    (** Ici on ne veut que les voisins, pas les poids. *)
    let iter_neighbors f node graph = 
      let neighborsn = List.map (snd) (neighbors node graph) in 
      List.iter (fun (n, w) -> f n w) neighborsn

    let iter_nodes f graph = 
      let nodes = nodes graph in 
      List.iter f nodes

    (** Il faudra préciser au compilateur d'aller regarder dans ../bin/ *)
    open Priority

    (** Visited est une liste de noeuds. *)
    let dijkstra (source:node) (target:node) graph =
      (**A chaque etape, on part du noeud en bas de la file de priorité. *)
      (**Dans la queue, on a une prio, un noeud, et son chemin*)
      let rec aux target queue graph visited = 
        let (prio_actuelle,(noeud,path),new_queue) = Priority.extract queue in 
          if noeud = target then path 
          (**On prend les voisins et on regarde a quelle distance ils sont.*)
          (** Neighbors : (int*node) list *)
          else let neighbors = neighbors noeud graph in 
            let unvisited = List.fold_left (fun acc -> fun elt -> 
              (**Donc le type de node ici est noeud, et visited est une liste de noeud *)
              let node = snd elt in if List.mem node visited then acc 
              else elt::acc 
            ) [] neighbors in 
            (** On a une liste (distance,voisin), maintenant on les mets tous dans la file*)
            (** On fait un fold sur les non visités, on les ajoute tous dans la file de prio *)
            let last_queue = List.fold_left ( fun acc -> fun elt -> 
              let distance,noeudbis = elt in Priority.insert acc (prio_actuelle + distance) (
                noeudbis, noeudbis::path
              )
            ) new_queue unvisited in 
            aux (target) (last_queue) (graph) (noeud::visited)
      in List.rev (aux target (Priority.insert (Priority.empty) (0) (source,[source])) graph [])

  end 

