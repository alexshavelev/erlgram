%%%-------------------------------------------------------------------
%%% @author alex_shavelev
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. Apr 2016 14:18
%%%-------------------------------------------------------------------
-module(erlgram).
-author("alex_shavelev").

-include("settings.hrl").

%% API
-export([
  test/0,
  send_message/1,
  forward_message/1,
  send_location/1
]).

test() ->
  send_message(#message{chat_id = <<"-133878532">>, text = <<"test">>}).

send_request(#http_req{type = Type, url = Url, headers = Headers, body = Body}) ->
  httpc:request(Type, {Url, Headers, "application/json", Body}, [], []).

send_message(Message) when is_record(message, Message) ->

  Body = ?RECORD_TO_TUPLELIST(message, Message),
  Url = erlgram_utils:get_url(send_message),
  send_to_telegram(Body, Url).

forward_message(ForwardMessage) when is_record(frwd_message, ForwardMessage) ->

  Body = ?RECORD_TO_TUPLELIST(frwd_message, ForwardMessage),
  Url = erlgram_utils:get_url(forward_message),
  send_to_telegram(Body, Url).

send_location(LocationMessage) when is_record(location, LocationMessage) ->

  Body = ?RECORD_TO_TUPLELIST(location, LocationMessage),
  Url = erlgram_utils:get_url(send_location),
  send_to_telegram(Body, Url).


send_to_telegram(PreBody, Url) ->

  Body = [{K,V} || {K,V} <-PreBody, V =/= undefined],
  JsonBody = util:to_json({Body}),

  send_request(#http_req{type = ?POST, url = Url, headers = [{"Content-Type", "application/json"}], body = JsonBody}).

