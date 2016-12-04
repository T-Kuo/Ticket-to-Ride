main:
	ocamlbuild main.byte && ./main.byte
	
test:
	ocamlbuild -pkgs oUnit test_main.byte && ./test_main.byte

clean:
	ocamlbuild -clean
	
zip:
	zip ttr	.zip *.ml{,i,y,l}
