module SGraph = Graph.MakeGraph(String)

let _ = assert (SGraph.cardinal SGraph.empty = 0)

let _ = assert (SGraph.cardinal (SGraph.add_node "Hey" SGraph.empty) = 1)

let _ = assert (SGraph.cardinal (SGraph.add_node "Hey" (SGraph.add_node "Hey" SGraph.empty)) = 1)

let _ = assert (SGraph.cardinal (SGraph.add_node "Hey" (SGraph.add_node "Ho" SGraph.empty)) = 2)

let _ = assert (SGraph.dijkstra "ho" "ho" (SGraph.add_node "ho" SGraph.empty) = ["ho"])

let simpleGraph = SGraph.add_edge "ho" 2 "ha" (
    SGraph.add_node "ho" (
        SGraph.add_node "ha" SGraph.empty
    )
)

let _ = assert (SGraph.dijkstra "ho" "ha" simpleGraph = ["ho";"ha"])

let tripleGraph = SGraph.add_edge "ha" 3 "hi" (
    SGraph.add_node "hi" simpleGraph
)

let _ = assert (SGraph.dijkstra "ho" "hi" tripleGraph = ["ho";"ha";"hi"])

let graphComplex = SGraph.add_edge "ho" 1 "hi" tripleGraph

let _ = assert (SGraph.dijkstra "ho" "hi" graphComplex = ["ho";"hi"])

let graphComplex2 = SGraph.add_edge "ho" 10 "hi" tripleGraph

let _ = assert (SGraph.dijkstra "ho" "hi" graphComplex2 = ["ho";"ha";"hi"])
