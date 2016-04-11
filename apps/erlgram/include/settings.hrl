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
-define(RECORD_TO_TUPLELIST(Rec, Ref), lists:zip(record_info(fields, Rec),tl(tuple_to_list(Ref)))).
-define(POST, post).
-define(GET, get).
