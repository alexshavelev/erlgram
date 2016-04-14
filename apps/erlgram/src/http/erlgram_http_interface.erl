%%%-------------------------------------------------------------------
%%% @author alex_shavelev
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. Apr 2016 13:31
%%%-------------------------------------------------------------------
-module(erlgram_http_interface).
-author("alex_shavelev").

-include("records.hrl").

%% API
-export([
  send/1
]).

send(HttpMessage) when is_record(HttpMessage, http_req) ->
  http_tests:send(HttpMessage).

