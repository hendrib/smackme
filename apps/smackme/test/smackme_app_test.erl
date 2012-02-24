-module(smackme_app_test).

-include_lib("eunit/include/eunit.hrl").

-compile(export_all).

start_test() ->

    ?assertEqual(ok, application:start(smackme, permanent)),

    ?assertNot(undefined == erlang:whereis(smackme_sup)),
    
    ?assertNot(undefined == erlang:whereis(smackme_smack_server)),

    ?assertMatch([{smackme, _, _}], [A || {Id, _, _} = A <- application:which_applications(), Id == smackme]).


stop_test() ->

    ?assertEqual(ok, application:stop(smackme)),


    ?assert(undefined == erlang:whereis(smackme_sup)).


%EOF
