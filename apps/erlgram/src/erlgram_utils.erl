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

get_url(send_message) ->
  get_root_url() ++ "/sendmessage";

get_url(send_location) ->
  get_root_url() ++ "/sendlocation";

get_url(forward_message) ->
  get_root_url() ++ "/forwardmessage".
