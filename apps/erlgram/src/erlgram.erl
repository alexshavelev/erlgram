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
  send_message/2,
  get_bot_token/0,
  get_telegram_url/0
]).

send_message(_ChatId, _Message) ->
  ok.

get_bot_token() ->
  application:get_env(erlgram, bot_token, ?BOT_TOKEN).

get_telegram_url() ->
  application:get_env(erlgram, telegram_url, ?TELEGRAM_URL).
