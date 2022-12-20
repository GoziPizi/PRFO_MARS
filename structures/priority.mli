module type Contrat = 
    sig 
        type t 
        val compare : t->t->int
    end

module type Promesse =
    sig 
        type elt 
        type t 
        (**
            @requires   : /
            @ensures    : Renvoie une file vide
            @raises     : /
         *)
        val empty : t 
        (**
            @requires   : /
            @ensures    : Renvoie l'élément à la plus faible priorit, sans le retirer.
            @raises     : Empty_queue si la file est vide
         *)
        val find_min : t -> elt
        (**
            @requires   : /
            @ensures    : Renvoie vrai si la PQ est vide 
            @raises     : /
         *)
        val is_empty : t -> bool 
        (**
            @requires  
            
            
             : /
            @ensures    : Supprime l'élément avec la priorité la plus petite.
            @raises     : / (si la file est vide, on renvoie rien donc on la laisse vide)
         *)
        val delete_min : t -> t 
        (**
            @requires   : l'entier doit être positif non nul.
            @ensures    : Insère l'élément dans la file, au bon endroit selon sa priorité.
                          Si l'élément existe deja, l'ancien est supprimé et le nouveau est ajouté. 
                          De sorte que l'on "met a jour" sa priorité.
            @raises     : /
         *)
        val insert : elt -> int -> t -> t 

    end

module Priority : functor(X:Contrat)->Promesse with type elt=X.t