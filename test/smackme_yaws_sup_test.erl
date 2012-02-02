-module(smackme_yaws_sup_test).

-include_lib("eunit/include/eunit.hrl").


start_link_test() ->
    ?assert(false).


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


                 smackme_yaws_sup:build_sconf_list([{https, {0,0,0,0}, 443, "KeyFile", "CertFile"}, {http, {0,0,0,0}, 8080}]))

    ?assertEqual([], smackme_yaws_sup:build_sconf_list([])).

%EOF
