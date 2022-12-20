module type Contrat = 
    sig 
        type t 
        val compare : t->t->int
    end 

module type Promesse =
    sig 
        type elt 
        type t 
        val empty : t 
        val find_min : t -> elt
        val is_empty : t -> bool 
        val delete_min : t -> t 
        val insert : elt -> int -> t -> t 

    end

module Priority(X:Contrat) =
  struct
    type elt = X.t

    type prio_element = int * elt 

    type t = 
        | Empty 
        | Node of prio_element * t list 

    exception Empty_queue

    let empty = Empty 

    let is_empty pq = pq = Empty

    let rec merge p1 p2 = 
        match p1,p2 with 
        |Empty, p 
        |p, Empty -> p 
        |Node((p1,e1),l1),Node((p2,e2),l2) -> 
            if p1 <= p2 then 
                Node((p1,e1),[Node((p2,e2),[])]@l1@l2)
            else
                Node((p2,e2),[Node((p1,e1),[])]@l1@l2)

    let insert p e pq = merge (pq) (Node((p,e),[]))

    let find_min pq = match pq with 
        Empty -> raise Empty_queue
        |Node((_,e),_) -> e 

    let delete_min pq = match pq with 
        Empty -> Empty 
        |Node((p,e),l) -> List.fold_left merge Empty l

  end