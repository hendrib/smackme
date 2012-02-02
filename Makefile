
.PHONY: all deps clean test

./apps/smackme/ebin/smackme.app: apps/smackme/src/*.erl apps/smackme/test/*.erl
	./rebar compile

deps:
	./rebar get-deps

app: deps ./apps/smackme/ebin/smackme.app

release: app
	./rebar --force generate

clean:
	rm -fr .eunit
	rm -fr ./deps/yaws/fake_lib_dir/
	rm -fr erl_crash.dump
	./rebar clean

test: app 
	mkdir -p .eunit
	./rebar skip_deps=true eunit

all: clean app test
	@echo "Done."
