-module(smackme_web_tests).

-include_lib("eunit/include/eunit.hrl").

-export([respond/1]).

out_test() ->

    ?assertMatch({ok, Pid}, smackme_smack_server:start_link()),

    
    ?assertEqual({200, [{"Content-Type", "text/plain"}], "You have been smacked 1 time(s)"}, smackme_web:loop(?MODULE, bla)),
    ?assertEqual({200, [{"Content-Type", "text/plain"}], "You have been smacked 2 time(s)"}, smackme_web:loop(?MODULE, bla)),
    ?assertEqual({200, [{"Content-Type", "text/plain"}], "You have been smacked 3 time(s)"}, smackme_web:loop(?MODULE, bla)),
    ?assertEqual({200, [{"Content-Type", "text/plain"}], "You have been smacked 4 time(s)"}, smackme_web:loop(?MODULE, bla)),
    ?assertEqual({200, [{"Content-Type", "text/plain"}], "You have been smacked 5 time(s)"}, smackme_web:loop(?MODULE, bla)),
    ?assertEqual({200, [{"Content-Type", "text/plain"}], "You have been smacked 6 time(s)"}, smackme_web:loop(?MODULE, bla)),

    ?assertEqual(ok, smackme_smack_server:stop()),

    timer:sleep(2).


respond(V) -> V.

