CFLAGS  = -std=c99 -D_GNU_SOURCE -Werror
CFLAGS += -Ilibansilove/include -Ilibansilove/src -Ilibansilove/compat -Iansilove/compat -Igdstubs -Ilodepng

OBJDIR = _obj

SOURCES = \
	ansilove/src/ansilove.c \
	ansilove/src/types.c \
	ansilove/src/strtolower.c \
	ansilove/src/sauce.c \
	libansilove/src/clean.c \
	libansilove/src/drawchar.c \
	libansilove/src/fonts.c \
	libansilove/src/error.c \
	$(OBJDIR)/loadfile.c \
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
	libansilove/compat/reallocarray.c \
	gdstubs/gdstubs.c \
	lodepng/lodepng.c

ifneq ($(CROSS),)
	CC = x86_64-w64-mingw32-gcc
	CFLAGS += -Imingw_compat -include mingw_compat.h
	SOURCES += mingw_compat/mingw_compat.c
	VPATH_EXTRAS = :mingw_compat
endif

VPATH = $(OBJDIR):ansilove/src:libansilove/src:libansilove/src/loaders:ansilove/compat:libansilove/compat:gdstubs:lodepng${VPATH_EXTRAS}

OBJECTS = $(addprefix $(OBJDIR)/,$(addsuffix .o,$(basename $(notdir $(SOURCES)))))

LIBS = -lm -lpthread

BINARY = ansilove.exe

all: $(BINARY)

$(OBJDIR):
	mkdir $@

lodepng/lodepng.c: lodepng/lodepng.cpp
	cp $< $@

$(OBJDIR)/loadfile.c: libansilove/src/loadfile.c | $(OBJDIR)
ifneq ($(CROSS),)
	sed 's/O_RDONLY/O_RDONLY|O_BINARY/' $< >$@
else
	cp $< $@
endif

$(OBJDIR)/%.o: %.c | $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BINARY): $(OBJECTS)
	$(CC) -o $@ $^ $(LIBS)

clean:
	rm -rf $(OBJDIR) $(BINARY)

.PHONY: all clean
