all : testPriority.ml priority.cmo graph.cmo graph.cmi 
	ocamlc -o testPriority priority.cmo testPriority.ml 
	ocamlc -o testGraph graph.cmo testGraph.ml

priority.cmo : priority.cmi 
	ocamlc -c ../structures/priority.ml -o ../tests/priority.cmo

priority.cmi :
	ocamlc -c ../structures/priority.mli -o ../tests/priority.cmi

graph.cmi : 
	ocamlc -c ../structures/graph.mli -o ../tests/graph.cmi

graph.cmo : graph.cmi
	ocamlc -c ../structures/graph.ml -o ../tests/graph.cmo

clean : 
	rm *.cmi *.cmo *.cmx *.o