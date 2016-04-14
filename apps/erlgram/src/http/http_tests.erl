%%%-------------------------------------------------------------------
%%% @author alex_shavelev
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. Apr 2016 13:47
%%%-------------------------------------------------------------------
-module(http_tests).
-author("alex_shavelev").

-include("records.hrl").

%% API
-export([
  send/1,
  test/0
]).

test() ->
  {ok, ConnPid} = gun:open("google.com", 443),
  MRef = monitor(process, ConnPid),
  StreamRef = gun:get(ConnPid, "/"),


  receive
    {gun_data, ConnPid, StreamRef, nofin, Data} ->
      io:format("~s~n", [Data]),
      receive_data(ConnPid, MRef, StreamRef);
    {gun_data, ConnPid, StreamRef, fin, Data} ->
      io:format("~s~n", [Data]);
    {'DOWN', MRef, process, ConnPid, Reason} ->
      error_logger:error_msg("Oops!"),
      exit(Reason)
  after 1000 ->
    exit(timeout)
  end.

%%  receive
%%    {gun_response, ConnPid, StreamRef, fin, _Status, _Headers} ->
%%      no_data;
%%    {gun_response, ConnPid, StreamRef, nofin, _Status, _Headers} ->
%%      receive_data(ConnPid, MRef, StreamRef);
%%    {'DOWN', MRef, process, ConnPid, Reason} ->
%%      error_logger:error_msg("Oops!"),
%%      exit(Reason)
%%  after 1000 ->
%%    exit(timeout)
%%  end.

send(#http_req{url = Url, body = Body0, headers = Headers, port = Port}) ->
  io:format("url ~p port ~p~n", [Url, Port]),
  {ok, ConnPid} = gun:open("https://api.telegram.org", Port),
  MRef = monitor(process, ConnPid),
  Body = binary_to_list(Body0),
  io:format("Headers ~p~n Body ~p~n", [Headers, Body]),
  StreamRef =
    gun:post(ConnPid, "/bot99434746:AAETpph94f6EIIBY-reY6CNoJp50nw-fdoQ/sendMessage", Headers, Body),
  io:format("1 ~p 2 ~p~n", [MRef, StreamRef]),
  receive_data(ConnPid, MRef, StreamRef).

%%  case gun:await(ConnPid, StreamRef) of
%%    {response, fin, _Status, Headers} ->
%%      no_data;
%%    {response, nofin, _Status, Headers} ->
%%      {ok, Body} = gun:await_body(ConnPid, StreamRef),
%%      io:format("~s~n", [Body])
%%  end.

receive_data(ConnPid, MRef, StreamRef) ->
  receive
    {gun_data, ConnPid, StreamRef, nofin, Data} ->
      io:format("~s~n", [Data]),
      receive_data(ConnPid, MRef, StreamRef);
    {gun_data, ConnPid, StreamRef, fin, Data} ->
      io:format("~s~n", [Data]);
    {'DOWN', MRef, process, ConnPid, Reason} ->
      error_logger:error_msg("Oops!"),
      exit(Reason);
    Res ->
      io:format("REs ~p~n", [Res])
  after 10000 ->
    exit(timeout)
  end.