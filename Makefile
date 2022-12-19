CC=ocamlc -w A 

all : mars1.cmo mars2.cmo mars3.cmo
	$(CC) mars.ml -o MarsPathFinding

%.cmo : %.ml 
	$(CC) -c $<

mars%.cmo : graph.mli

%.mli : %.ml 

