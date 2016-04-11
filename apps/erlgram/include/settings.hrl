%%%-------------------------------------------------------------------
%%% @author alex_shavelev
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. Apr 2016 12:05
%%%-------------------------------------------------------------------
-author("alex_shavelev").

-define(BOT_TOKEN, "99434746:AAETpph94f6EIIBY-reY6CNoJp50nw-fdoQ").
-define(TELEGRAM_URL, "https://api.telegram.org/").

-record(message, {
  chat_id,
  text,
  parse_mode = undefined,
  disable_web_page_preview = undefined,
  disable_notification = undefined,
  reply_to_message_id = undefined,
  reply_markup = undefined
}).

-record(http_req, {
  type,
  url,
  headers,
  body,
  timeout = 5000
}).

-define(POST, post).
-define(GET, get).
