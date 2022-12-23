module GRAPH = 
struct
  type t = bool array array
  type vertex = int
  type edge = int * int

  (* Creates a new, empty graph. *)
  let create () : t = [||]

  (* Adds a new vertex to the graph. *)
  let add_vertex (g:t) (v:vertex) : t =
    let n = Array.length g in
    let g' = Array.make_matrix (n+1) (n+1) false in
    for i = 0 to n - 1 do
      for j = 0 to n - 1 do
        g'.(i).(j) <- g.(i).(j)
      done;
    done;
    g'

  (* Adds a new edge to the graph, connecting two vertices. *)
  let add_edge (g:t) (v1:vertex) (v2:vertex) (_:edge) : t =
    let n = Array.length g in
    if v1 >= 0 && v1 < n && v2 >= 0 && v2 < n then begin
      g.(v1).(v2) <- true;
      g.(v2).(v1) <- true;
    end;
    g

  (* Removes a vertex from the graph. *)
  let remove_vertex (g:t) (v:vertex) : t =
    let n = Array.length g in
    if n = 0 then g
    else if v < 0 || v >= n then invalid_arg "vertex out of bounds"
    else begin
      let g' = Array.make_matrix (n-1) (n-1) false in
      for i = 0 to n - 1 do
        if i <> v then begin
          let gi = if i < v then i else i - 1 in
          for j = 0 to n - 1 do
            if j <> v then begin
              let gj = if j < v then j else j - 1 in
              g'.(gi).(gj) <- g.(i).(j)
            end
          done
        end
      done;
      g'
    end

  (* Removes an edge from the graph. *)
  let remove_edge (g:t) (e:edge) : t =
    let v1, v2 = e in
    let n = Array.length g in
    if v1 >= 0 && v1 < n && v2 >= 0 && v2 < n then begin
      g.(v1).(v2) <- false;
      g.(v2).(v1) <- false;
    end;
    g

  (* Returns a list of all the vertices in the graph. *)
  let vertices (g:t) : vertex list =
    let rec vertices_rec acc = function
      | i when i = Array.length g -> acc
      | i -> vertices_rec (i :: acc) (i + 1)
    in
    vertices_rec [] 0

  (* Returns a list of all the edges in the graph. *)
  let edges (g:t) : edge list =
    let n = Array.length g in
    let rec edges_rec acc i =
      if i = n then acc
      else begin
        let rec edges_from_i_rec acc j =
          if j = n then acc
          else if g.(i).(j) then edges_from_i_rec ((i, j) :: acc) (j + 1)
          else edges_from_i_rec acc (j + 1)
        in
        edges_rec (edges_from_i_rec acc (i + 1)) (i + 1)
      end
    in
    edges_rec [] 0


  (* Returns a list of the vertices that are connected to a given vertex by an edge. *)
  let neighbors (g:t) (v:vertex) : vertex list =
    let n = Array.length g in
    if v < 0 || v >= n then invalid_arg "vertex out of bounds"
    else begin
      let rec neighbors_rec acc i =
        if i = n then acc
        else if g.(v).(i) then neighbors_rec (i :: acc) (i + 1)
        else neighbors_rec acc (i + 1)
      in
      neighbors_rec [] 0
    end

  (* Returns true if the given vertex is in the graph, and false otherwise. *)
  let has_vertex (g:t) (v:vertex) : bool =
    v >= 0 && v < Array.length g

  (* Returns true if the given edge is in the graph, and false otherwise. *)
  let has_edge (g:t) (e:edge) : bool =
    let v1, v2 = e in
    let n = Array.length g in
    v1 >= 0 && v1 < n && v2 >= 0 && v2 < n && g.(v1).(v2)

  (* Returns the edge connecting two given vertices, if it exists, or None otherwise. *)
  let find_edge (g:t) (v1:vertex) (v2:vertex) : edge option =
    let n = Array.length g in
    if v1 >= 0 && v1 < n && v2 >= 0 && v2 < n && g.(v1).(v2) then Some (v1, v2)
    else None

  (* Applies a given function to each vertex in the graph and accumulates the results. *)
  let fold_vertices (f:'a -> vertex -> 'a) (g:t) (acc:'a) : 'a =
    let n = Array.length g in
    let rec fold_vertices_rec acc i =
      if i = n then acc
      else fold_vertices_rec (f acc i) (i + 1)
    in
    fold_vertices_rec acc 0

  (* Applies a given function to each edge in the graph and accumulates the results. *)
  let fold_edges (f:'a -> edge -> 'a) (g:t) (acc:'a) : 'a =
    let n = Array.length g in
    let rec fold_edges_rec acc i =
      if i = n then acc
      else begin
        let acc = fold_edges_rec acc (i + 1) in
        let rec fold_edges_from_i_rec acc j =
          if j = n then acc
          else if g.(i).(j) then fold_edges_from_i_rec (f acc (i, j)) (j + 1)
          else fold_edges_from_i_rec acc (j + 1)
        in
        fold_edges_from_i_rec acc (i + 1)
      end
    in
    fold_edges_rec acc 0
end

