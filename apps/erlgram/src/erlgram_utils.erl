%%%-------------------------------------------------------------------
%%% @author alex_shavelev
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. Apr 2016 15:22
%%%-------------------------------------------------------------------
-module(erlgram_utils).
-author("alex_shavelev").

-include("settings.hrl").

%% API
-export([
  get_bot_token/0,
  get_telegram_url/0,
  get_url/1
]).

get_bot_token() ->
  application:get_env(erlgram, bot_token, ?BOT_TOKEN).

get_telegram_url() ->
  application:get_env(erlgram, telegram_url, ?TELEGRAM_URL).

get_root_url() ->
  get_telegram_url() ++ "bot" ++ get_bot_token().

get_url(Method) ->
  get_root_url() ++ get_path(Method).

get_path(send_message) ->"/sendMessage";
get_path(contact) ->"/sendContact";
get_path(file) ->"/getFile";
get_path(send_location) ->"/sendLocation";
get_path(chat_action) -> "/sendChatAction";
get_path(photo) -> "/sendPhoto";
get_path(get_user_photos) -> "/getUserProfilePhotos";
get_path(forward_message) -> "/forwardMessage".
