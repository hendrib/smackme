
-module(smackme_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, M, Type), {I, {M, start_link, []}, permanent, 5000, Type, [M]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->

	RestartSpec = {rest_for_one, 1, 10},

	SmackServer = {smackme_server,
                      {smackme_smack_server, start_link, []},
                        permanent, 5000, worker, [smackme_smack_server]},

	Web = web_specs(smackme_web, 18080),

    {ok, { RestartSpec, [
                         SmackServer,
                         Web

                        ]} }.

web_specs(Mod, Port) ->
    WebConfig = [{ip, {0,0,0,0}},
                 {port, Port}],
    {Mod,
     {Mod, start, [WebConfig]},
     permanent, 5000, worker, dynamic}.
