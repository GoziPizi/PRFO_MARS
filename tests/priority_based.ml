exception Queue_is_empty

let empty = [] 

let extract pq = match pq with 
    [] -> raise Queue_is_empty
    |x::q' -> let (p,e) = x in p,e,q'

let delete_min pq = match pq with 
    [] -> []
    |x::q' -> q'

let insert e p pq = match pq with 
    [] -> [(p,e)]
    |x::q' -> let (p',e') = x in 
        if p > p' then (p,e)::pq
        else x::(insert e p q')

let is_empty pq = pq = []

type cmd = 
    |Extract
    |Delete_min 
    |Insert of int*int

let gen_cmd = 
    Gen.ofeof
        [
            Gen.return Extract;
            Gen.return Delete_min;
            Gen.return Is_empty;
            Gen.map (fun v w-> Insert (v,w)) Gen.small_nat Gen.small_nat;
        ]

(**Creation d'une liste de commande *)
let arb_cmd = make gen_cmd 
let arb_cmds = list arb_cmd

(**Typage des états et des differentes valeurs de sorties *)
(**Les etats sont une liste de couple d'entier, puisque c'est 
l'implémentation des files pour la comparaison *)

type state = (int*int) list 
type value = Int of int | Absent | Error

let cmd_model cmd state = match cmd with 
    Extract -> match (extract state) with Queue_is_empty -> Error | p,e,q -> (Int e, q)
    |Delete_min -> (Absent, delete_min state)
    |Insert e,p -> (Absent, insert e p state)

let cmd_pq cmd pq = match cmd with 
    Extract -> match (Priority.extract pq) with Queue_is_empty -> Error | p,e,q -> (Int e, p) 
    |Delete_min -> (Absent, Priority.delete_min pq)
    |Insert e,p -> (Absent, Priority.insert e p pq) 

let rec interp_agree state pq cmd_list = match cmd_list with 
    [] -> true 
    |cmd :: cmd_list' -> let (value, state') = cmd_model cmd state in 
        let (value', pq') = cmd_pq cmd pq in 
            if value = value' 
                then interp_agree state' pq' cmd_list'
                else false

let property_priority cs = interp_agree (create ()) (Priority.empty) cs
let test_property_priority = QCheck.(Test.make ~count:1000(arb_cmds) property_priority)
let _ = QCheck_runner.run_tests[test_property_priority]