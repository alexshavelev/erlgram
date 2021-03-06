%%%-------------------------------------------------------------------
%%% @author alex_shavelev
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. Apr 2016 15:39
%%%-------------------------------------------------------------------
-author("alex_shavelev").

-record(message, {
  chat_id,
  text,
  parse_mode = undefined,
  disable_web_page_preview = undefined,
  disable_notification = undefined,
  reply_to_message_id = undefined,
  reply_markup = undefined
}).

-record(frwd_message, {
  chat_id,
  from_chat_id,
  disable_notification = false,
  message_id
}).

-record(location, {
  chat_id,
  latitude,
  longitude,
  disable_notification = undefined,
  reply_to_message_id = undefined,
  reply_markup = undefined
}).

-record(chat_action, {
  chat_id,
  action
}).

-record(http_req, {
  type,
  url,
  headers,
  body,
  port = 443,
  timeout = 5000
}).

-record(user_photos, {
  user_id,
  offset = undefined,
  limit = undefined
}).

-record(contact, {
  chat_id,
  phone_number,
  first_name,
  last_name,
  disable_notification,
  reply_to_message_id,
  reply_markup
}).


-record(file, {
  file_id
}).

-record(photo, {
  chat_id,
  photo,
  caption,
  disable_notification,
  reply_to_message_id,
  reply_markup,
  type :: file | link
}).