(**On sait que Sys.argv contient 3 elements, le premier élément est le nom du programme, le deuxieme l'epoque et le troisieme le fichier à traiter. *)
let _ = if Array.length Sys.argv <> 3 then 
    let _ = Printf.printf "Mauvais nombre d'arguments.\n" in 
    let _ = Printf.printf "Expéctés deux. \n" in 
    let _ = Printf.printf "Utilisation : \n" in 
    let _ = Printf.printf "./MarsPathFinding epoque(int) filename \n" in -1
    else match Sys.argv.(1) with 
        "1" -> Mars1.main
        | "2" -> Mars2.main
        | "3" -> Mars3.main
        | _ -> -1