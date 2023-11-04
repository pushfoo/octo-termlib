# These can be overriden at the CLI; example: OCTO_PRE=value
OCTO_PRE      ?= chiplet
OCTO_COMPILER ?= chiplet
CHIP_8_EMU    ?= octo-run


build-dir:
	@mkdir -p "build"

.PHONY: clean
clean :
	@rm -rf build

demo-src : clean build-dir
	@mkdir -p "build/demo"
	$(OCTO_PRE) --no-line-info -o build/demo/termlib_demo.8o -P src/demo_main.8o

demo-rom : demo-src
	$(OCTO_COMPILER) -o build/demo/termlib_demo.ch8 build/demo/termlib_demo.8o

run-demo: demo-rom
	$(info Using emulator command: $(CHIP_8))
	$(CHIP_8_EMU) "build/demo/termlib_demo.ch8"
