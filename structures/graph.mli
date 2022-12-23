module type GRAPH = sig
  type t
  type vertex
  type edge

  val create : unit -> t
  val add_vertex : t -> vertex -> t
  val add_edge : t -> vertex -> vertex -> edge -> t
  val remove_vertex : t -> vertex -> t
  val remove_edge : t -> edge -> t
  val vertices : t -> vertex list
  val edges : t -> edge list
  val neighbors : t -> vertex -> vertex list
  val has_vertex : t -> vertex -> bool
  val has_edge : t -> edge -> bool
  val find_edge : t -> vertex -> vertex -> edge option
  val fold_vertices : (vertex -> 'a -> 'a) -> t -> 'a -> 'a
  val fold_edges : (edge -> 'a -> 'a) -> t -> 'a -> 'a
end