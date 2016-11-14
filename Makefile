main:
	ocamlbuild main.byte
	
test:
	ocamlbuild test.byte && ./test.byte

clean:
	ocamlbuild -clean
	
zip:
	zip a4src.zip *.ml{,i,y,l}
