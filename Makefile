# Makefile for qrencode library for Lua
version=0.1

name=lua-resty-qrencode
LUA_VERSION =   5.1

# See http://lua-users.org/wiki/BuildingModules for platform specific
# details.

PREFIX ?=           /usr/local/openresty

ifeq ($(shell uname), Linux)
## Linux/BSD
LDFLAGS +=         -shared
else
## OSX (Macports)
LDFLAGS +=         -bundle -undefined dynamic_lookup
endif

## find your luajit path
LUA_INCLUDE_DIR ?= $(PREFIX)/luajit/include/luajit-2.1
LUA_LIB_DIR ?=     $(PREFIX)/lualib

# Some versions of Solaris are missing isinf(). Add -DMISSING_ISINF to
# CFLAGS to work around this bug.

#CFLAGS ?=          -g -Wall -pedantic -fno-inline
CFLAGS ?=          -g -O3 -Wall -pedantic
override CFLAGS += -fpic -I$(LUA_INCLUDE_DIR) -lpng -lqrencode

INSTALL ?= install

.PHONY: all clean install

all: qrencode.so

qrencode.so: qrencode.c
	$(CC) $(LDFLAGS) $(CFLAGS) -o $@ $^

install:
	$(INSTALL) -d $(LUA_LIB_DIR)
	$(INSTALL) qrencode.so $(LUA_LIB_DIR)

clean:
	rm *.so
