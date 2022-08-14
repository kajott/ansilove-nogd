CFLAGS  = -std=c99 -D_GNU_SOURCE -Werror -Os
CFLAGS += -Ilibansilove/include -Ilibansilove/src -Ilibansilove/compat -Iansilove/compat -Igdstubs -Ilodepng
LDFLAGS =

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
	$(OBJDIR)/lodepng.c

ifneq ($(CROSS),)
	CROSS_PREFIX = x86_64-w64-mingw32-
	CC = $(CROSS_PREFIX)gcc
	STRIP = $(CROSS_PREFIX)strip
	CFLAGS += -Imingw_compat -include mingw_compat.h -static
	LDFLAGS += -static
	SOURCES += mingw_compat/mingw_compat.c
	VPATH_EXTRAS = :mingw_compat
	SUFFIX = .exe
else
	STRIP = strip
	SUFFIX = -$(shell uname -s | tr "[:upper:]" "[:lower:]")
endif

VPATH = $(OBJDIR):ansilove/src:libansilove/src:libansilove/src/loaders:ansilove/compat:libansilove/compat:gdstubs:lodepng${VPATH_EXTRAS}

OBJECTS = $(addprefix $(OBJDIR)/,$(addsuffix .o,$(basename $(notdir $(SOURCES)))))

LIBS = -lm -lpthread

BINARY = ansilove$(SUFFIX)

all: $(BINARY)

$(OBJDIR):
	mkdir $@

$(OBJDIR)/lodepng.c: lodepng/lodepng.cpp | $(OBJDIR)
	cp $< $@

$(OBJDIR)/loadfile.c: libansilove/src/loadfile.c | $(OBJDIR)
ifneq ($(CROSS),)
	sed -r "s/O_RDONLY/\0|O_BINARY/" $< >$@
else
	cp $< $@
endif

$(OBJDIR)/%.o: %.c | $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BINARY): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)
	$(STRIP) $@

clean:
	rm -rf $(OBJDIR)
distclean: clean
	rm -f $(BINARY)

ifeq ($(CROSS),)
PREFIX ?= /usr/local
INSTALL_BIN = $(PREFIX)/bin/ansilove
install: $(INSTALL_BIN)
$(INSTALL_BIN): $(BINARY)
	install -m 755 $< $@
uninstall:
	rm $(INSTALL_BIN)
endif

.PHONY: all clean distclean install uninstall
