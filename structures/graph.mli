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

module MakeGraph : functor(X:Contrat) -> Graph with type node = X.t