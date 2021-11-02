:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).

:- http_handler(root(hello_world), say_hi, []).		% (1)

server(Port) :-						% (2)
        http_server(http_dispatch, [port(Port)]).

say_hi(_Request) :-					% (3)
        format('Content-type: text/html~n~n'),
        format('<H1>Welcome Intelligent Supervision!</H1>~n'),
        format('<H4>We are here to learn fancy things!</H4>~n').





