module Priority = 
    struct 
        type 'a t = 
            | Empty
            | Node of 'a * int * 'a t list

        exception Empty_queue

        exception Not_found

        let empty = Empty 

        let singleton e p = Node(e,p,[])

        let find_min file = match file with 
            | Empty -> Empty_queue
            | Node of (e,_,_) -> e

        let delete_min file = match file with 
            | Empty -> Empty
            | Node of (_,_,[]) -> Empty 
            | Node of (_,_,l) -> meld_list l 

        let meld f1 f2 = 
            if is_empty f1 then f2 
            else if is_empty f2 then f1 
            else 
                match f1,f2 with Node of (e1,p1,l1), Node(e2,p2,l2) -> 
                    if p1 < p2 then Node(e1,p1,(singleton e2 p2)::l1::l2)
                    else Node(e2,p2,(singleton e1 p1)::l1::l2)

        let meld_list l = 
            List.fold_left (meld) Empty l

        let insert e p f = 
            meld (singleton e p) f

        

          
    end