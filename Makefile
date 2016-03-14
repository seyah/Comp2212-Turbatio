#
# Rules for compiling and linking the typechecker/evaluator
#
# Type
#   make         to rebuild the executable file c
#   make clean   to remove all intermediate and temporary files
#   make depend  to rebuild the intermodule dependency graph that is used
#                  by make to determine which order to schedule
#	           compilations.  You should not need to do this unless
#                  you add new modules or new dependencies between
#                  existing modules.  (The graph is stored in the file
#                  .depend)

# These are the object files needed to rebuild the main executable file
#
OBJS = Parser.cmo Lexer.cmo Expressions.cmo Eval.cmo main.cmo

COMMONOBJS = str.cma

# Files that need to be generated from other files
DEPEND += Lexer.ml Parser.ml

# When "make" is invoked with no arguments, we build an executable
# typechecker, after building everything that it depends on
all: $(DEPEND) $(OBJS) main

# Include an automatically generated list of dependencies between source files
include .depend

# Build an executable typechecker
main: $(OBJS) main.cmo
	@echo Linking $@
	ocamlc -o $@ $(COMMONOBJS) $(OBJS)

# Compile an ML module interface
%.cmi : %.mli
	ocamlc -c $<

# Compile an ML module implementation
%.cmo : %.ml
	ocamlc -c $<

# Generate ML files from a parser definition file
Parser.ml Parser.mli: Parser.mly
	@rm -f Parser.ml Parser.mli
	ocamlyacc -v Parser.mly
	@chmod -w Parser.ml Parser.mli

# Generate ML files from a lexer definition file
%.ml %.mli: %.mll
	@rm -f $@
	ocamllex $<
	@chmod -w $@

# Clean up the directory
clean::
	rm -rf Lexer.ml Parser.ml Parser.mli *.o *.cmo *.cmi Parser.output \
	   c TAGS *~

# Rebuild intermodule dependencies
depend:: $(DEPEND)
	ocamldep $(INCLUDE) *.mli *.ml > .depend

#
test::
	bash test.sh
