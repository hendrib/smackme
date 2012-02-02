-module(smackme_yaws_fe_handler_test).

-include_lib("eunit/include/eunit.hrl").

out_test() ->

    ?assertMatch({ok, Pid}, smackme_smack_server:start_link()),

    
    ?assertEqual([{status, 200}, {content, "text/plain", "You have been smacked 1 time(s)"}], smackme_yaws_fe_handler:out(bla)),
    ?assertEqual([{status, 200}, {content, "text/plain", "You have been smacked 2 time(s)"}], smackme_yaws_fe_handler:out(bla)),
    ?assertEqual([{status, 200}, {content, "text/plain", "You have been smacked 3 time(s)"}], smackme_yaws_fe_handler:out(bla)),
    ?assertEqual([{status, 200}, {content, "text/plain", "You have been smacked 4 time(s)"}], smackme_yaws_fe_handler:out(bla)),
    ?assertEqual([{status, 200}, {content, "text/plain", "You have been smacked 5 time(s)"}], smackme_yaws_fe_handler:out(bla)),
    ?assertEqual([{status, 200}, {content, "text/plain", "You have been smacked 6 time(s)"}], smackme_yaws_fe_handler:out(bla)),

    ?assertEqual(ok, smackme_smack_server:stop()),

    timer:sleep(2).
