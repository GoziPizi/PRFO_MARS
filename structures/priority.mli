module Priority :
  sig
    type priority = int
    type 'a queue = Empty | Node of priority * 'a * 'a queue * 'a queue
    val empty : 'a queue
    (**
      requires : /
      ensures : Insere l'element dans la file avec sa bonne priorité.
      raises : /
     *)
    val insert : 'a queue -> priority -> 'a -> 'a queue
    (**
      requires : / 
      ensures : Renvoie vrai si la file est vide. 
      raises : /
     *)
    val is_empty : 'a queue -> bool
    exception Queue_is_empty
    (**
      requires : /
      ensures : Supprime le min de la file, puis renvoie la file
      raises : Queue_ie_empty, si la file est vide. 
     *)
    val delete_min : 'a queue -> 'a queue
    (**
      requires : /
      ensures : Renvoie la priorite et la valeur du premier element, aisin que la file, a laquelle on a enleve le premier emlement.  
      raises : Queue_is_empty si la file est vide.
     *)
    val extract : 'a queue -> priority * 'a * 'a queue
  end