module SGraph = Graph.MakeGraph(String)

let _ = assert (SGraph.cardinal SGraph.empty = 0)

let _ = assert (SGraph.cardinal (SGraph.add_node "Hey" SGraph.empty) = 1)

let _ = assert (SGraph.cardinal (SGraph.add_node "Hey" (SGraph.add_node "Hey" SGraph.empty)) = 1)

let _ = assert (SGraph.cardinal (SGraph.add_node "Hey" (SGraph.add_node "Ho" SGraph.empty)) = 2)
