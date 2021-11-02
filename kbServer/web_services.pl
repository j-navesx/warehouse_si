:- encoding(iso_latin_1).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_path)).
:- use_module(library(http/http_header)).
:- use_module(library(http/http_open)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_client)).
:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- autoload(library(writef), [swritef/3]).


start_server(Port):-
    server(Port).

:-dynamic server_activado/0.
server(Port) :-
        \+ server_activado,
        assert(server_activado),
        http_server(http_dispatch, [port(Port)]),
        !
        ;
        true.

%NOVA VERSAO
execute_query([query=QueryString],Result):-
    term_string(QueryTerm, QueryString),
    catch(
         findall(true, QueryTerm, L),
	 error(Err,_Context) ,
	 (   log_format('Error in your query: ~w\n', [Err]), L=[false])
    ),
    [Result|_]=L,
    !.

execute_query(_,false).
/*
             current_output(Curr),
             set_output(user_output),
             log_format('Error in your query: ~w\n', [Err]), L=[false]),
             set_output(Curr)
*/

exec_it(QueryString, Result):-
    term_string(QueryTerm, QueryString),
    catch(
              findall(true, QueryTerm, L),
              error(Err,_Context) ,
	      (
                    current_output(Curr),
                    set_output(user_output),
                    format('Error in your query: ~w\n', [Err]),
                    L=[false],
                    set_output(Curr)
              )

    ),
    [Result|_]=L,
    !.

rtxengine(Request) :-					% (3)
        format('Content-type: text/html~n~n'),
        http_read_data(Request, [query=Query|_], []),
        current_output(Curr),
        set_output(user_output),
        writeln(Query),
        set_output(Curr),

        exec_it(Query, R),nl,
        writeln(R).
        %debug(hello, 'About to say hello', []),
        %format('<H2>Hi there, are you ready?</H2>~n').


rtx_get(Request):-

        format('Content-type: text/html~n~n'),
        member(search(List), Request),
        member( query=Query, List),

        current_output(Curr),
        set_output(user_output),
        % UNCOMENT HERE IF YOU WANT TO
        % SEE WHAT'S PROLOG IS RECEIVING
        % writeln(Query),
        set_output(Curr),
        exec_it(Query, _R),
        flush_output,
        !.

rtx_get(Request):-
      member(search(List), Request),
      member( query=Query, List),
      current_output(Curr),
      set_output(user_output),
      writeln(Query),
      writeln(false),
      set_output(Curr),
      flush_output,
      !.




hello(_Request) :-					% (3)
        current_output(Curr),
        set_output(user_output),
        writeln(hello),
        set_output(Curr),

        format('Content-type: text/html~n~n'),
        writeln('<H2>hello</H2>').
