%%
%%   Copyright 2015 Zalando SE
%%
%%   Licensed under the Apache License, Version 2.0 (the "License");
%%   you may not use this file except in compliance with the License.
%%   You may obtain a copy of the License at
%%
%%       http://www.apache.org/licenses/LICENSE-2.0
%%
%%   Unless required by applicable law or agreed to in writing, software
%%   distributed under the License is distributed on an "AS IS" BASIS,
%%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%%   See the License for the specific language governing permissions and
%%   limitations under the License.
%%
%% @doc
%%   telemetry wired protocol
-module(aura_protocol).

-export([
   encode/3,
   decode/1
]).


%%
%%  
encode({urn, _, _} = Urn, T, X)
 when is_integer(X) ->
   <<"auraq:", (uri:s(Urn))/binary, $|, (scalar:s(tempus:u(T)))/binary, $,, (scalar:s(X))/binary>>;

encode({urn, _, _} = Urn, T, {_, _, _} = X) ->
   encode(Urn, T, tempus:u(X)).



%%
%%
decode(Pack) ->
   [Urn, Val] = binary:split(Pack, <<$|>>),
   [  T,   X] = binary:split(Val,  <<$,>>),
   {uri:new(Urn), tempus:t(u, scalar:i(T)), scalar:i(X)}.

