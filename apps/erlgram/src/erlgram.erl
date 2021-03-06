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
-include("records.hrl").

-export([
  test/0,
  test/1,
  test_pic/0
]).

%% API
-export([
  send_message/1,
  forward_message/1,
  send_location/1,
  send_chat_action/1,
  get_user_profile_photo/1,
  send_request/1,
  send_contact/1,
  get_file/1,
  send_photo/1
]).

-define(CHAT_ID, <<"-133878532">>).

test(Msg) ->
  send_message(#message{chat_id = ?CHAT_ID, text = Msg}).
test() ->
  test(<<"test">>).

test_pic() ->
  {ok, File} = file:read_file("/home/alex_shavelev/download.jpg"),
  send_photo(#photo{chat_id = ?CHAT_ID, photo = File, type = file}).

send_request(#http_req{type = Type, url = Url, headers = Headers, body = Body}) ->
  httpc:request(Type, {Url, Headers, "application/json", Body}, [], []).

send_message(Message) when is_record(Message, message) ->

  Body = ?RECORD_TO_TUPLELIST(message, Message),
  Url = erlgram_utils:get_url(send_message),
  send_to_telegram(Body, Url).

forward_message(ForwardMessage) when is_record(ForwardMessage, frwd_message) ->

  Body = ?RECORD_TO_TUPLELIST(frwd_message, ForwardMessage),
  Url = erlgram_utils:get_url(forward_message),
  send_to_telegram(Body, Url).

send_location(LocationMessage) when is_record(LocationMessage, location) ->

  Body = ?RECORD_TO_TUPLELIST(location, LocationMessage),
  Url = erlgram_utils:get_url(send_location),
  send_to_telegram(Body, Url).

send_chat_action(ChatActionMessage) when is_record(ChatActionMessage, chat_action) ->

  Body = ?RECORD_TO_TUPLELIST(chat_action, ChatActionMessage),
  Url = erlgram_utils:get_url(chat_action),
  send_to_telegram(Body, Url).

get_user_profile_photo(UserProfilePhotos) when is_record(UserProfilePhotos, user_photos) ->

  Body = ?RECORD_TO_TUPLELIST(user_photos, UserProfilePhotos),
  Url = erlgram_utils:get_url(get_user_photos),
  send_to_telegram(Body, Url).

send_contact(Contact) when is_record(Contact, contact) ->

  Body = ?RECORD_TO_TUPLELIST(contact, Contact),
  Url = erlgram_utils:get_url(contact),
  send_to_telegram(Body, Url).

get_file(File) when is_record(File, file) ->

  Body = ?RECORD_TO_TUPLELIST(file, File),
  Url = erlgram_utils:get_url(file),
  send_to_telegram(Body, Url).

send_photo(#photo{type = link} = Photo) ->

  Body = ?RECORD_TO_TUPLELIST(photo, Photo),
  Url = erlgram_utils:get_url(photo),
  send_to_telegram(Body, Url);

send_photo(#photo{type = file} = Photo) ->

  Body = ?RECORD_TO_TUPLELIST(photo, Photo),
  Url = erlgram_utils:get_url(photo),
  send_to_telegram(Body, Url).

send_to_telegram(PreBody, Url) ->
  send_to_telegram(PreBody, Url, undefined).

send_to_telegram(PreBody, Url, ContentType) ->

  F = fun(Param) -> if Param =:= undefined -> {"Content-Type", "application/json"}; true -> Param end end,

  Body = [{K,V} || {K,V} <-PreBody, V =/= undefined],
  JsonBody = util:to_json({Body}),
  io:format("JsonBdy ~p~n", [JsonBody]),
%%  erlgram_http_interface:send(#http_req{type = ?POST, url = Url, headers = [{<<"content-type">>, "application/json"}], body = JsonBody}).
  send_request(#http_req{type = ?POST, url = Url, headers = [F(ContentType)], body = JsonBody}).

