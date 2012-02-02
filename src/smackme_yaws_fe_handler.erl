-module(smackme_yaws_fe_handler).

-include("../deps/yaws/include/yaws_api.hrl").

-compile(export_all).

-export([out/1]).

out(_Args) ->

    Rsp = smackme_smack_server:smackme(),

    [{status, 200}, {content, "text/plain", Rsp}].
