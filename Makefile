CHIPLET=$(shell which chiplet)


build-dir:
	@mkdir -p "build"

clean :
	@rm -rf build

demo :
	@mkdir -p "build/demo"
	@$(CHIPLET) --no-line-info -o build/termlib_demo.8o -P src/demo_main.8o

run-demo: demo
	@octo-run build/termlib_demo.8o
