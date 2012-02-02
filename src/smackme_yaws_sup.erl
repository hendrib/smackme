-module(smackme_yaws_sup).
-behaviour(supervisor).

-include("../deps/yaws/include/yaws_api.hrl").
-include("../deps/yaws/include/yaws.hrl").

-compile(export_all).


-export([
        start_link/0,
        init/1
        ]).


get_param(Param, Default) ->

    case application:get_env(smackme, Param) of
    undefined ->
        Default;

    {ok, Value} ->
        Value
    end.

start_link() -> 

    ok = filelib:ensure_dir("./log/"),

    HttpIfConfig = get_param(http_if_cfg, [{http, {0,0,0,0}, 18080}]),

    ServerId = "smackme",

    Docroot = "./priv/www",

    GconfList = [
                {logdir, "./log/"},

                {docroot, "./priv/www"},

                {ebin_dir, ["./ebin"]},

                {id, ServerId}
                ],

    SconfList = build_sconf_list(HttpIfConfig),

    {ok, SCList, GC, ChildSpecsAll} = yaws_api:embedded_start_conf(Docroot, SconfList, GconfList, ServerId),

    BootstrapChildSpecs = [ C || {CId, _, _, _, _, _} = C <- ChildSpecsAll, CId =/= yaws_sup_restarts],
    
	case supervisor:start_link({local, ?MODULE}, ?MODULE, [BootstrapChildSpecs]) of
    {ok, Pid} ->

        EnableYawsAccessLog = true,

        ok = yaws_api:setconf(GC, [[?sc_set_access_log(SC, EnableYawsAccessLog)] || [SC] <- SCList]),

        [YawsSupRestartCSpec | _] = [ C || {CId, _, _, _, _, _} = C <- ChildSpecsAll, CId =:= yaws_sup_restarts],

        {ok, _} = supervisor:start_child(?MODULE, YawsSupRestartCSpec),

        {ok, Pid};

    Error ->
        Error

    end.

init([ChildSpecs]) -> 

	RestartSpec = {one_for_one, 1, 10},

    {ok, { RestartSpec, ChildSpecs }}.


build_sconf_list([])-> [];

build_sconf_list([{https, If, Port, KeyFile, CertFile} | T]) ->

    Sconf = [
            {port, Port},
            {listen, If},

            {allowed_scripts, []},

            {ssl, [{keyfile, KeyFile}, {certfile, CertFile}, {verify, 0}, {depth, 0}]},

            {appmods,   [
                        {"/",  smackme_yaws_fe_handler}
                        ]}
            ],

    [Sconf | build_sconf_list(T)];


build_sconf_list([{http, If, Port} | T]) ->

    Sconf = [
            {port, Port},
            {listen, If},

            {allowed_scripts, []},

            {appmods,   [
                        {"/",  smackme_yaws_fe_handler}
                        ]}
            ],

    [Sconf | build_sconf_list(T)].


% EOF
