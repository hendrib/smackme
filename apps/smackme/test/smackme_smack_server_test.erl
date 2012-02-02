-module(smackme_smack_server_test).

-include_lib("eunit/include/eunit.hrl").

-compile(export_all).

start_link_test()->

    {ok, P} = smackme_smack_server:start_link(),

    ?assert(is_pid(P)),

    ?assertNot(undefined == whereis(smackme_smack_server)).

smackme_test()->

    ?assertEqual("You have been smacked 1 time(s)", smackme_smack_server:smackme()),
    ?assertEqual("You have been smacked 2 time(s)", smackme_smack_server:smackme()),
    ?assertEqual("You have been smacked 3 time(s)", smackme_smack_server:smackme()),
    ?assertEqual("You have been smacked 4 time(s)", smackme_smack_server:smackme()),
    ?assertEqual("You have been smacked 5 time(s)", smackme_smack_server:smackme()),
    ?assertEqual("You have been smacked 6 time(s)", smackme_smack_server:smackme()),
    ?assertEqual("You have been smacked 7 time(s)", smackme_smack_server:smackme()),
    ?assertEqual("You have been smacked 8 time(s)", smackme_smack_server:smackme()),
    ?assertEqual("You have been smacked 9 time(s)", smackme_smack_server:smackme()),
    ?assertEqual("You have been smacked 10 time(s)", smackme_smack_server:smackme()),

    ?assertEqual("You have been smacked 1 time(s)", smackme_smack_server:smackme()),
    ?assertEqual("You have been smacked 2 time(s)", smackme_smack_server:smackme()),
    ?assertEqual("You have been smacked 3 time(s)", smackme_smack_server:smackme()),
    ?assertEqual("You have been smacked 4 time(s)", smackme_smack_server:smackme()),
    ?assertEqual("You have been smacked 5 time(s)", smackme_smack_server:smackme()),
    ?assertEqual("You have been smacked 6 time(s)", smackme_smack_server:smackme()),
    ?assertEqual("You have been smacked 7 time(s)", smackme_smack_server:smackme()),
    ?assertEqual("You have been smacked 8 time(s)", smackme_smack_server:smackme()),
    ?assertEqual("You have been smacked 9 time(s)", smackme_smack_server:smackme()),
    ?assertEqual("You have been smacked 10 time(s)", smackme_smack_server:smackme()).




stop_test() ->

    ?assertNot(undefined == whereis(smackme_smack_server)),

    ?assertEqual(ok, smackme_smack_server:stop()),

    timer:sleep(2),

    ?assert(undefined == whereis(smackme_smack_server)).



handle_call_test() ->

    ?assertEqual({noreply, state}, smackme_smack_server:handle_call(crap, self(), state)).

handle_cast_test() ->

    ?assertEqual({noreply, state}, smackme_smack_server:handle_cast(crap, state)).

handle_info_test() ->

    ?assertEqual({noreply, state}, smackme_smack_server:handle_info(crap, state)).

terminate_test() ->

    ?assertEqual(ok, smackme_smack_server:terminate(reason, state)).

code_change_test() ->

    ?assertEqual({ok, state},  smackme_smack_server:code_change(bla, state, alb)).




    


%EOF
