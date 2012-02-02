-module(smackme_yaws_sup_test).

-include_lib("eunit/include/eunit.hrl").


start_link_test() ->

    {ok, P} = smackme_yaws_sup:start_link(),

    ?assert(is_pid(P)),

    ?assertEqual(P, whereis(smackme_yaws_sup)),

    ?assertEqual({error, {already_started, P}}, smackme_yaws_sup:start_link()),

    unlink(P),

    erlang:exit(P, shutdown),

    timer:sleep(2),

    ?assert(undefined == whereis(smackme_yaws_sup)).

build_sconf_list_test()->

    ?assertEqual([[
                    {port, 443}, 
                    {listen, {0,0,0,0}}, 
                    {allowed_scripts, []}, 
                    {ssl, [{keyfile, "KeyFile"}, {certfile, "CertFile"}, {verify, 0}, {depth, 0}]}, 
                    {appmods, [{"/",  smackme_yaws_fe_handler}]} 
                 ]], 

                 smackme_yaws_sup:build_sconf_list([{https, {0,0,0,0}, 443, "KeyFile", "CertFile"}])),


    ?assertEqual([[
                    {port, 8080}, 
                    {listen, {0,0,0,0}}, 
                    {allowed_scripts, []}, 
                    {appmods, [{"/",  smackme_yaws_fe_handler}]} 
                 ]], 

                 smackme_yaws_sup:build_sconf_list([{http, {0,0,0,0}, 8080}])),



    ?assertEqual([[
                    {port, 443}, 
                    {listen, {0,0,0,0}}, 
                    {allowed_scripts, []}, 
                    {ssl, [{keyfile, "KeyFile"}, {certfile, "CertFile"}, {verify, 0}, {depth, 0}]}, 
                    {appmods, [{"/",  smackme_yaws_fe_handler}]} 
                 ],
                 [
                    {port, 8080}, 
                    {listen, {0,0,0,0}}, 
                    {allowed_scripts, []}, 
                    {appmods, [{"/",  smackme_yaws_fe_handler}]} 
                 ]],


                 smackme_yaws_sup:build_sconf_list([{https, {0,0,0,0}, 443, "KeyFile", "CertFile"}, {http, {0,0,0,0}, 8080}])),

    ?assertEqual([], smackme_yaws_sup:build_sconf_list([])),

    ?assertException(error, function_clause, smackme_yaws_sup:build_sconf_list([crap])).


get_param_test() ->

    ?assertEqual(default, smackme_yaws_sup:get_param(xyz, default)),

    ?assertEqual(ok, application:set_env(smackme, xyz, some_value)),

    ?assertEqual(some_value, smackme_yaws_sup:get_param(xyz, default)).




%EOF
