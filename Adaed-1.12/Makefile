# $Header: /griffin.a/ada/porter/all/RCS/Makefile,v 1.9 1992/02/04 19:19:56 porter Exp $

CC= gcc
CFLAGS=-g -m32

#CC= g++
#CFLAGS=-g

#CC= CC
#CFLAGS=-g -I/usr/lang/include/CC

LINKER= $(CC)
LFLAGS=-lg -m32

INSTALL = install

#BINDIR = /usr/local
#LIBDIR = /usr/local/lib
#MANDIR = /usr/local/man
BASE=$(PWD)
BINDIR = $(BASE)/installdir
LIBDIR = $(BINDIR)
MANDIR = $(BINDIR)

.SUFFIXES:
.SUFFIXES: .o .c .h .ch .s .vbs

.c.o:
	$(CC)$(CCVAR) $(CFLAGS) -c $<  

.s.o:
	$(CC)$(CCVAR) $(CFLAGS) -c $<

# always remake .h file when rebuild .c from .ch
# we make the derived files read-only so that attempts to edit them
# will fail, and so hopefully remind the user that the .ch file
# is the (single) file to be edited.

.ch.h:
	rm -f $*.h
	echo >$*.h
	chmod u+w $*.h
	makech -h  < $< > $*.h
	chmod a-w $*.h

.ch.c:
	rm -f $*.c
	echo >$*.c
	chmod u+w $*.c
	makech -c < $< > $*.c
	chmod a-w $*.c

.vbs.h:
	rm -f $*.h
	touch $*.h
	chmod u+w $*.h
	cdecom <$*.vbs | uniq >$*.h
	chmod a-w $*.h

# TARGET TO MAKE EVERYTHING

EXECS =	adaprs adasem adagen adabind adaexec adacomp adalib

all: $(EXECS)

predef: $(EXECS)
	rm -rf predef predefdir
	mkdir predefdir
	./adaprs -nl predefdir predef.ada
	./adasem -s p -nl predefdir predef
	./adagen -g p -nl predefdir predef
	touch predef

install : all predef
	-mkdir $(BINDIR)
	-mkdir $(LIBDIR)
	-mkdir $(MANDIR)
	-mkdir $(MANDIR)/manl
	install adacomp adabind adaexec adalib $(BINDIR)
	install adaprs adasem adagen $(LIBDIR)
	install predefdir/0.axq $(LIBDIR)/predef.axq
	install predefdir/0.trc $(LIBDIR)/predef.trc
	install predefdir/lib $(LIBDIR)/predef.lib
	-cp $(BINDIR)/adabind $(LIBDIR)/adabind
	install adabind.l adacomp.l adaed.l adaexec.l adalib.l $(MANDIR)/manl

# remove all targets
MADE_HDRS =	vars.h gvars.h ivars.h hdr.h libhdr.h ghdr.h
MADE_SRCS =	vars.c gvars.c ivars.c
clean:
	rm -f *.o *.lm core $(EXECS) adaint
	rm -f  $(MADE_HDRS) $(MADE_SRCS)
	rm -rf predefdir predef installdir testlib

#---------------------------#
# adalib FILES AND ACTIOONS #
#---------------------------#

LIB_OBJS = adalib.o misc.o libf.o

adalib: $(LIB_OBJS)
	$(LINKER) -o adalib -g $(LIB_OBJS) $(LFLAGS) -lm >lib.lm

#---------------------------#
# adacomp FILES AND ACTIONS #
#---------------------------#

COMP_OBJS = adacomp.o adamrg.o misc.o

adacomp: $(COMP_OBJS)
	$(LINKER) -o adacomp -g $(COMP_OBJS) $(LFLAGS) -lm >comp.lm

#--------------------------#
# adaprs FILES AND ACTIONS #
#--------------------------#

PRS_OBJS =	action.o acttoks.o adalex.o adaprs.o adared.o debug.o errs.o \
			follow.o libf.o lookup.o makecorr.o misc.o pnodes.o ppredef.o \
			prserr.o prsinit.o prsutil.o pspans.o recover.o reduce.o shift.o

adaprs: $(PRS_OBJS) 	
	$(LINKER) -o adaprs -g $(PRS_OBJS) $(LFLAGS) -lm >prs.lm

#--------------------------#
# adasem FILES and ACTIONS #
#--------------------------#

SEM_OBJS =	0a.o 0b.o 2.o 3a.o 3b.o 4a.o 4b.o 4c.o 5.o 6.o 7.o 8.o 9.o 10.o \
			11.o 12a.o 12b.o 12c.o 13.o 14.o arith.o astread.o dbx.o dclmap.o \
			errmsg.o eval.o lib.o libf.o libr.o libw.o machine.o  \
			main.o misc.o nodes.o set.o smisc.o sspans.o units.o util.o vars.o

adasem: $(SEM_OBJS) 
	$(LINKER) -o adasem -g $(SEM_OBJS) $(LFLAGS) -lm >sem.lm


#--------------------------------------#
# adagen and adabind FILES AND ACTIONS #
#--------------------------------------#

GEN_OBJS =	12b.o aggr.o arith.o axqr.o axqw.o dbg.o dbx.o dclmap.o decl.o \
			expand.o expand2.o expr.o g0a.o gen.o glib.o  gmain.o gmisc.o \
			gnodes.o gpredef.o gutil.o gvars.o init.o initobj.o lang.o lib.o \
			libf.o libr.o libw.o maincase.o misc.o nam.o opdesc.o pack.o \
			peep.o proc.o read.o segment.o sep.o set.o smisc.o stat.o \
			type.o util.o vars.o

BND_OBJS =	12b.o arith.o axqr.o axqw.o blib.o bmisc.o bmain.o bnodes.o \
			dbg.o dbx.o dclmap.o g0a.o gen.o ginter.o glib.o gpredef.o \
			gutil.o gvars.o init.o lang.o lib.o libf.o libr.o libw.o misc.o \
			opdesc.o peep.o read.o segment.o sep.o set.o smisc.o util.o vars.o

adagen: gvars.c vars.c hdr.h ghdr.h libhdr.h $(GEN_OBJS) 
	$(LINKER) -o adagen -g $(GEN_OBJS) $(LFLAGS) -lm >gen.lm

adabind: vars.c gvars.c hdr.h ghdr.h libhdr.h $(BND_OBJS)
	$(LINKER) -o adabind -g $(BND_OBJS) $(LFLAGS) -lm >bind.lm

# $(GEN_OBJS): gvars.c vars.c hdr.h libhdr.h

# $(BND_OBJS): vars.c

# Dependence on gmisc.o causes extra compile but gets dependencies right.
bmisc.o: gmisc.o
	cp gmisc.c bmisc.c
	$(CC) -DBINDER -c -g bmisc.c $(CFLAGS)
	rm -f bmisc.c

# Look at last comment.
bnodes.o: gnodes.o
	cp gnodes.c bnodes.c
	$(CC) -DBINDER -c -g bnodes.c $(CFLAGS)
	rm -f bnodes.c

#---------------------------#
# adaexec FILES AND ACTIONS #
#---------------------------#

INT_OBJS = 	axqr.o farith.o ilist.o imain.o imisc.o intb.o intc.o \
			ipar.o ivars.o libf.o machine.o  misc.o opname.o \
			predef1.o predef2.o predef3.o predef4.o predef5.o \
			predef6.o tasking.o

XINT_OBJS =	inta.o load.o

adaexec: ivars.c inta_interface.o load_interface.o $(INT_OBJS)
	$(LINKER) -o adaexec -g $(LFLAGS) $(INT_OBJS) $(XINT_OBJS) -lm >int.lm
	ld -r -x load_interface.o -m elf_i386 \
		$(INT_OBJS) inta_interface.o >adaint.lm
	mv a.out adaint

#inta_interface.o: inta.o
#	$(CC)$(CCVAR) -c -DINTERFACE $(CFLAGS) -o inta_interface.o inta.c

inta_interface.o: inta.o
	mv inta.o inta.o.b
	$(CC)$(CCVAR) -c -DINTERFACE $(CFLAGS) inta.c
	mv inta.o inta_interface.o
	mv inta.o.b inta.o
	touch inta_interface.o

load_interface.o: load.o
	mv load.o load.o.b
	$(CC)$(CCVAR) $(CFLAGS) -DINTERFACE -c load.c
	mv load.o load_interface.o
	mv load.o.b load.o
	touch load_interface.o

misc.o :
	$(CC) $(CFLAGS) -DLIBDIR=\"$(LIBDIR)\" -c misc.c

ALL_OBJS =  $(PRS_OBJS) $(SEM_OBJS) $(GEN_OBJS) $(BND_OBJS) $(INT_OBJS) \
			$(XINT_OBJS)

Makeext :
	x2hdeps $(ALL_OBJS) >Makeext

include Makeext
