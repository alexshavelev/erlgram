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
  get_bot_token/0,
  get_telegram_url/0,
  forward_message/1
]).

test() ->
  send_message(#message{chat_id = <<"-133878532">>, text = <<"test">>}).

send_message(Message) ->
  #message{
    chat_id = ChatId,
    text = Text,
    parse_mode = ParseMode,
    disable_web_page_preview = DisableWebPagePreview,
    disable_notification = DisableNotification,
    reply_to_message_id = ReplyToMessageId,
    reply_markup = ReplyMarkup
  } = Message,

  PreBody =
  [
    {<<"chat_id">>, ChatId},
    {<<"text">>, Text},
    {<<"parse_mode">>, ParseMode},
    {<<"disable_web_page_preview">>, DisableWebPagePreview},
    {<<"disable_notification">>, DisableNotification},
    {<<"reply_to_message_id">>, ReplyToMessageId},
    {<<"reply_markup">>, ReplyMarkup}
  ],

  Body = [{K,V} || {K,V} <-PreBody, V =/= undefined],

  JsonBody = util:to_json({Body}),
  Url = get_url(send_message),

  send_request(#http_req{type = ?POST, url = Url, headers = [{"Content-Type", "application/json"}], body = JsonBody}).

get_bot_token() ->
  application:get_env(erlgram, bot_token, ?BOT_TOKEN).

get_telegram_url() ->
  application:get_env(erlgram, telegram_url, ?TELEGRAM_URL).

get_root_url() ->
  get_telegram_url() ++ "bot" ++ get_bot_token().

get_url(send_message) ->
  get_root_url() ++ "/sendmessage";

get_url(forward_message) ->
  get_root_url() ++ "/forwardmessage".

send_request(#http_req{type = Type, url = Url, headers = Headers, body = Body}) ->
  httpc:request(Type, {Url, Headers, "application/json",Body}, [], []).

forward_message(ForwardMessage) ->

  #frwd_message{
    chat_id = ChatId,
    from_chat_id = FromChatId,
    disable_notification = DisableNotifications,
    message_id = MessageId
  } = ForwardMessage,

  PreBody =
  [
    {<<"chat_id">>, ChatId},
    {<<"from_chat_id">>, FromChatId},
    {<<"disable_notification">>, DisableNotifications},
    {<<"message_id">>, MessageId}
  ],

  Body = [{K,V} || {K,V} <-PreBody, V =/= undefined],

  JsonBody = util:to_json({Body}),
  Url = get_url(forward_message),

  send_request(#http_req{type = ?POST, url = Url, headers = [{"Content-Type", "application/json"}], body = JsonBody}).