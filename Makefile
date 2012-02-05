
.PHONY: all deps clean test

./apps/smackme/ebin/smackme.app: apps/smackme/src/*.erl apps/smackme/test/*.erl
	./rebar compile

deps:
	./rebar get-deps

app: deps ./apps/smackme/ebin/smackme.app

release: app
	./rebar --force generate
	cd ./rel/smackme; tar -czf ../smackme.tar.gz *

clean:
	rm -f rel/smackme.tar.gz
	rm -f package/deb/*.deb
	rm -f package/deb/smackme
	rm -fr .eunit
	rm -fr ./deps/yaws/fake_lib_dir/
	rm -fr erl_crash.dump
	./rebar clean

test: app 
	mkdir -p .eunit
	./rebar skip_deps=true eunit

run: release
	./rel/smackme/bin/smackme console

deb: release ./package/deb/smackme.template ./package/deb/godeb.sh
	cd ./package/deb; ./godeb.sh

all: clean app test
	@echo "Done."
