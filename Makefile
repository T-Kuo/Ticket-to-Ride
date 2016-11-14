main:
	ocamlbuild main.byte
	
test:
	ocamlbuild test.byte && ./test.byte

check:
	bash checkenv.sh && bash checktypes.sh

clean:
	ocamlbuild -clean
	
zip:
	zip a4src.zip *.ml{,i,y,l}
