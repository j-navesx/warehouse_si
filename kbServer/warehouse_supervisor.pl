:-ensure_loaded(web_services).


:-consult(warehouse_config).
:-consult(warehouse_monitoring).
:-consult(warehouse_dispatcher).
% :-consult(warehouse_diagnose).
% :-consult(warehouse_error_recovery).
:-consult(warehouse_planner).

read_sensor_values:-
        % output as JSON object
        writeln("{"),
        get_state_value(part_in_cage     , VCage, 1,  0    ),   format('"cage":"~w",~n' ,[VCage]),
        get_state_value(x_is_at(X)       , X,     X, 'N.A.'),   format('"x"   :"~w",~n',[X]),
        get_state_value(z_is_at(Z)       , Z,     Z, 'N.A.'),   format('"z"   :"~w", ~n',[Z]),
        get_state_value(y_is_at(Y)       , Y,     Y, 'N.A.'),   format('"y"   :"~w" ~n',[Y]),
        %don't put final comma at the last one......
        % TO BE COMPLETED
        writeln("}").
    
    
    get_state_value(Term, Variable, ValueOn, _ValueOff):-
            Term,
            Variable = ValueOn,
            !.
    
    get_state_value(_Term, Variable, _ValueOn, ValueOff):-
            Variable = ValueOff.
    

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
