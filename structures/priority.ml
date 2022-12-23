module Priority =
    struct
      type priority = int
      type 'a queue = Empty | Node of priority * 'a * 'a queue * 'a queue
      let empty = Empty
      let rec insert queue prio elt =
        match queue with
          Empty -> Node(prio, elt, Empty, Empty)
        | Node(p, e, left, right) ->
            if prio <= p
            then Node(prio, elt, insert right p e, left)
            else Node(p, e, insert right prio elt, left)
      exception Queue_is_empty
      let rec delete_min = function
          Empty -> raise Queue_is_empty
        | Node(prio, elt, left, Empty) -> left
        | Node(prio, elt, Empty, right) -> right
        | Node(prio, elt, (Node(lprio, lelt, _, _) as left),
                          (Node(rprio, relt, _, _) as right)) ->
            if lprio <= rprio
            then Node(lprio, lelt, delete_min left, right)
            else Node(rprio, relt, left, delete_min right)
      let extract = function
          Empty -> raise Queue_is_empty
        | Node(prio, elt, _, _) as queue -> (prio, elt, delete_min queue)
    end