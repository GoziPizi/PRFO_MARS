CC=ocamlc -w A -I ./bin -I ../bin

all : mars1.cmo mars2.cmo mars3.cmo
	$(CC) mars.ml -o MarsPathFinding

%.cmo : %.ml 
	$(CC) -c $< -o ./bin/$<

mars%.cmo : graph.mli

%.mli : %.ml 

