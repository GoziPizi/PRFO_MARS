all : testPriority.ml priority.cmo
	ocamlc -o testPriority priority.cmo testPriority.ml 

priority.cmo : priority.cmi 
	ocamlc -c ../structures/priority.ml -o ../tests/priority.cmo

priority.cmi :
	ocamlc -c ../structures/priority.mli -o ../tests/priority.cmi

clean : 
	rm *.cmi *.cmo *.cmx *.o