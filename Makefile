CFLAGS  = -std=c99 -D_GNU_SOURCE -Werror
CFLAGS += -Ilibansilove/include -Ilibansilove/src -Ilibansilove/compat -Iansilove/compat -Igdstubs

ifneq ($(CROSS),)
	CC = x86_64-w64-mingw32-gcc
endif

SOURCES = \
	ansilove/src/ansilove.c \
	ansilove/src/types.c \
	ansilove/src/strtolower.c \
	ansilove/src/sauce.c \
	libansilove/src/clean.c \
	libansilove/src/drawchar.c \
	libansilove/src/fonts.c \
	libansilove/src/error.c \
	libansilove/src/loadfile.c \
	libansilove/src/init.c \
	libansilove/src/output.c \
	libansilove/src/savefile.c \
	libansilove/src/loaders/ansi.c \
	libansilove/src/loaders/artworx.c \
	libansilove/src/loaders/binary.c \
	libansilove/src/loaders/icedraw.c \
	libansilove/src/loaders/pcboard.c \
	libansilove/src/loaders/tundra.c \
	libansilove/src/loaders/xbin.c \
	ansilove/compat/pledge.c \
	ansilove/compat/strtonum.c \
	gdstubs/gdstubs.c

VPATH = ansilove/src:libansilove/src:libansilove/src/loaders:ansilove/compat:gdstubs

OBJDIR = _obj
OBJECTS = $(addprefix $(OBJDIR)/,$(addsuffix .o,$(basename $(notdir $(SOURCES)))))

LIBS = -lm

BINARY = ansilove.exe

all: $(BINARY)

$(OBJDIR):
	mkdir $(OBJDIR)

$(OBJDIR)/%.o: %.c | $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BINARY): $(OBJECTS)
	$(CC) -o $@ $^ $(LIBS)

clean:
	rm -rf $(OBJDIR) $(BINARY)

.PHONY: all clean
