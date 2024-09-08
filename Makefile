
build:
	ocamlc -c -o drawingType.cmi drawingType.mli
	ocamlc -c -o drawingType.cmo drawingType.ml
	ocamlc -c -o draw.cmo draw.ml
	ocamlc -c -I +../graphics -I +graphics -o main.cmo main.ml 
	ocamlc -I +../graphics -I +graphics graphics.cma drawingType.cmo draw.cmo main.cmo -o main	

withof:
	ocamlc -c -o drawingType.cmi drawingType.mli
	ocamlc -c -o drawingType.cmo drawingType.ml
	ocamlc -c -o draw.cmo draw.ml
	ocamlfind ocamlc -c -package graphics -o main.cmo main.ml 
	ocamlfind ocamlc -package graphics -linkpkg drawingType.cmo draw.cmo main.cmo -o main	

clean:
	rm -f drawingType.cmi
	rm -f drawingType.cmo
	rm -f main.cmi
	rm -f main.cmo
	rm -f draw.cmi
	rm -f draw.cmo
	rm -f main
