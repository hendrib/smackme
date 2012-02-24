-module(smackme_web).

-export([start/1, loop/2]).

start(Options) ->
    Loop = fun (Req) ->
                   ?MODULE:loop(Req, "")
           end,
    mochiweb_http:start([{name, ?MODULE}, {loop, Loop} | Options]).

loop(Req, _) ->

    Smack = smackme_smack_server:smackme(),
					
	Req:respond({200, [{"Content-Type", "text/plain"}], Smack}).

