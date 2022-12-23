all : testPriority.ml priority.cmo
	ocamlc -o testGraph testGraph.ml 
	ocamlc -o testPriority testPriority.ml 

priority.cmo : priority.cmi 
	ocamlc -c ../structures/priority.ml -o ../tests/priority.cmo

priority.cmi :
	ocamlc -c ../structures/priority.mli -o ../tests/priority.cmi