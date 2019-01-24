###		
###     Made by Dario Frello and Jacques 
###

### Generate 32 bit executable : 1=yes, 0=no = machine target (16 or 32 or 8 ...)
M32?= 0 
### Including Debugging Symbols : 1=yes, 0=no step by step
DBG?= 0
### Including Compiler Optimizations : 1=yes, 0=no (line per line)
OPT?= 1
### Keep Assembly Files : 1=yes, 0=no (can change the value that is why there is a "?")
ASM?= 0

CC=g++
NAMEEXT=jack
#name of the exe
NAME=template
#Dependancies
DEPEND=dependencies
BINDIR= bin
INCDIR= inc
SRCDIR= src
OBJDIR= obj

#cast : poblem cast
#pointer : almost same as cast
#sign-compare : unsigned == signed (warning)
WARNINGS=-W -Wall -Wundef -Wpointer-arith -Wcast-qual -Wsign-compare 

#optimisation or not (-O3 : code size and vitess)
ifeq ($(OPT),1)
OPTIMIZATIONS=-O3 -fomit-frame-pointer -ffloat-store -ffast-math
else
OPTIMIZATIONS=-O0
endif


CFLAGS=$(WARNINGS) $(OPTIMIZATIONS) -std=c++11 -ffloat-store -fno-strict-aliasing -fsigned-char
ifeq ($(M32),1)
CFLAGS+=-m32
endif
ifeq ($(DBG),1)
CFLAGS+=-g
endif

#If you have a file more than 4G you can open it if you have compiled in 32 bits
#offset is if you want to go through 4GO when seek
FLAGS=$(CFLAGS) -I$(INCDIR) -D __USE_LARGEFILE64 -D _FILE_OFFSET_BITS=64 -D _XOPEN_SOURCE=500

#link to library math
LIBS=-lm
#extention for objects
OBJSUF= .o

#automatization of listing sources
SRC=    $(wildcard $(SRCDIR)/*.cpp) 
#all files included with .O is moved in the obj directory
OBJ=    $(SRC:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)

BIN=    $(BINDIR)/$(NAME).$(NAMEEXT)

#only these command are available
.PHONY: default clean depend tgz

#no make plus parameter than you do this
default: objdir_mk depend bin

clean:
	@rm -rf $(OBJDIR)
	@rm -rf ./asm/
	@rm -rf $(BINDIR)/$(NAME).$(NAMEEXT)
	@rm -rf $(DEPEND)
	@rm -rf $(NAME).tgz 
	@echo
	@echo Cleaning done!
	@echo
	
bin:    $(OBJ)
	@echo
	@echo 'creating binary "$(BIN)"'
	@$(CC) $(FLAGS) -o $(BIN) $(OBJ) $(LIBS)
	@echo 'Using Flags: $(FLAGS)'
	@echo 'Using Libs: $(LIBS)'
	@echo
	@echo '... done'
	@echo
	
#if you want to to compile with multi core and to avoid problems of linkings
#if there is the sed option there is no check in inc directory
depend:
	@echo
	@echo Compiler is: $(CC)
	@echo 'checking dependencies'
	@$(SHELL) -ec '$(CC) $(FLAGS) -MM $(INCLUDE) $(SRC) | sed '\''s@\(.*\)\.o[ :]@$(OBJDIR)/\1.o:@g'\'' >$(DEPEND)'
	@echo '... done'
	@echo
	 
$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
	@echo
	@echo 'Compiling file "$<"'
	@echo 'Using Flags: $(FLAGS)'
	@$(CC) -c -o $@ $(FLAGS) $<
ifeq ($(ASM),1)
	@mkdir -p ./asm/
	@$(CC) -c -S $(FLAGS) $<
	@mv *.s ./asm/
endif
	
objdir_mk:
	@echo 'Creating $(OBJDIR) ...'
	@mkdir -p $(OBJDIR)

tgz: clean
	@echo Making tgz archive
	@tar cvzf $(NAME).tgz $(SRCDIR) $(INCDIR) Makefile
	@echo 
	@echo $(NAME).tgz archive created...Bye!
	
-include $(DEPEND)

