module Priority :
  sig
    type priority = int
    type 'a queue = Empty | Node of priority * 'a * 'a queue * 'a queue
    val empty : 'a queue
    
    (**
        @requires   : l'entier doit être positif non nul.
        @ensures    : Insère l'élément dans la file, au bon endroit selon sa priorité.
        Si l'élément existe deja, l'ancien est supprimé et le nouveau est ajouté. 
        De sorte que l'on "met a jour" sa priorité.
        @raises     : /
    *)
    val insert : 'a queue -> priority -> 'a -> 'a queue
    exception Queue_is_empty
    val delete_min : 'a queue -> 'a queue
    val extract : 'a queue -> priority * 'a * 'a queue
  end