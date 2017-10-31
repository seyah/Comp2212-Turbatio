OBJS = Expressions.cmo Lexer.cmo Parser.cmo main.cmo
COMMONOBJS = str.cma
DEPEND += Lexer.ml Parser.ml
all: $(DEPEND) $(OBJS) main
include .depend
main: $(OBJS) main.cmo
	ocamlc -o mysplinterpreter $(COMMONOBJS) $(OBJS)
%.cmi : %.mli
	ocamlc -c $<
%.cmo : %.ml
	ocamlc -c $<
%.ml %.mli: %.mll
	@rm -f $@
	ocamllex $<
	@chmod -w $@
Parser.ml Parser.mli: Parser.mly
	@rm -f Parser.ml Parser.mli
	ocamlyacc -v Parser.mly
	@chmod -w Parser.ml Parser.mli
clean::
	rm -rf Lexer.ml Parser.ml Parser.mli *.o *.cmo *.cmi Parser.output \
	   c TAGS *~
depend:: $(DEPEND)
	ocamldep $(INCLUDE) *.mli *.ml > .depend