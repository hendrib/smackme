
.PHONY: all deps clean test

./ebin/smackme.app: src/*.erl test/*.erl
	./rebar compile

deps:
	./rebar get-deps

app: deps ./ebin/smackme.app

clean:
	rm -fr .eunit
	rm -fr erl_crash.dump
	./rebar clean

test: app 
	mkdir -p .eunit
	./rebar skip_deps=true eunit

all: clean app test
	@echo "Done."
