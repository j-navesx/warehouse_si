:-ensure_loaded(web_services).


:-consult(warehouse_config).
:-consult(warehouse_monitoring).
:-consult(warehouse_dispatcher).
% :-consult(warehouse_diagnose).
% :-consult(warehouse_error_recovery).
:-consult(warehouse_planner).



write_comma(0):-!.
write_comma(Position):-
        Position > 0,
        write(',').

write_ports_list(_,[]):-!.

write_ports_list(Position,[ (Port,Value)|List ]):-
        write_comma(Position),
        format('{"port": "~w", "value" : "~w"}',[Port, Value]),
        Position2 is Position +1,
        write_ports_list(Position2,List).


get_output_port_values:-
        findall( (Port , Value), (
                    between(3,5,Port),
                    port_value(Port, Value)
                ),
                List),
        get_time(TimeStamp),
        format('{~n"ts: ": "~w",~n',[TimeStamp]),
        write('"ports": ['),
        write_ports_list(0,List),
        %forall(      member( (Port, Value), List),
        %             format('{"port": "~w", "value" : "~w"},',[Port, Value])
        %      ),
        writeln(']'),
        write('}'),nl.




start:-
        writeln(lets_begin).
