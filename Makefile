INCLUDE_FILES := $(wildcard src/*.inc)
SOURCE_FILES := $(wildcard src/*.asm)

EMULATOR_PATH ?= /Users/sebastien.roccaserra/Applications/Games/RetroArch.app/Contents/Macos
EMULATOR_CMD ?= ./RetroArch -L ../Resources/cores/bsnes_mercury_performance_libretro.dylib
ROM_PATH ?= /Users/sebastien.roccaserra/Developer/learning-snes/build/first.smc

build/first.smc: build build/first.obj build/first.prj
	cd build ; \
		wlalink -v -r first.prj first.smc

build:
	mkdir -p build

build/first.prj: build
	echo [objects] > build/first.prj
	echo first.obj >> build/first.prj

build/first.obj: build $(SOURCE_FILES) $(INCLUDE_FILES)
	mkdir -p build
	cd src ; \
	wla-65816 -o ../build/first.obj first.asm

.PHONY: run
run: build/first.smc
	cd $(EMULATOR_PATH) && \
		$(EMULATOR_CMD) $(ROM_PATH)

.PHONY: clean
clean:
	rm -fr build
