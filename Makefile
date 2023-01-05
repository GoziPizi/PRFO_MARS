CC=ocamlc -w A -I ./bin -I ../bin -I bin

all : mars.ml 
	ocamlc graph.cmo mars.ml

graph.cmo : graph.cmi 

graph.cmi : 
	ocamlc -c structures/graph.mli

