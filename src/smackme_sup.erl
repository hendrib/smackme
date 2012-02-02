
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
    {ok, { {one_for_one, 5, 10}, [
                                    ?CHILD(smackme_server, smackme_smack_server, worker),
                                    ?CHILD(yaws_sup, smackme_yaws_sup, supervisor)

                                 ]} }.

