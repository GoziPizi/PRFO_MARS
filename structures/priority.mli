module Priority :
  sig
    type priority = int
    type 'a queue = Empty | Node of priority * 'a * 'a queue * 'a queue
    val empty : 'a queue
    val insert : 'a queue -> priority -> 'a -> 'a queue
    val is_empty : 'a queue -> bool
    exception Queue_is_empty
    val delete_min : 'a queue -> 'a queue
    val extract : 'a queue -> priority * 'a * 'a queue
  end