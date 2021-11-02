:-ensure_loaded('RTXengine/RTXengine.pl').

:-ensure_loaded(warehouse_config).

defrule([name:start_rule, priority:1000],
    if    true     then (
        % reset warehouse states
        % retractall(x_is_at(_)),
        % retractall(z_is_at(_)),
        % ....
        all_storage_states(L),
        forall(member(State, L), retractall(State))
     )
).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      X POSITION                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% we can make a single rule for all the positions
defrule([name: x_position],
    if  x_axis_spec(X_position,Port, Bit_pos, Bit_val)     and
        port_value(Port, Byte_val)                            and
        (  Bit_val is getbit(Byte_val, Bit_pos) )
    then (
       assert(x_is_at(X_position))
    )
 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Y POSITION                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% or set a rule per position like in yy_position
% yy=1, port =1, bit=2, value= 0
defrule([name: y_position1],
    if port_value(1, Byte_val)  and (  0 is getbit(Byte_val, 2) )
    then (
       assert(y_is_at(1))
    )
 ).

% yy=2, port =1, bit=3, value= 0
defrule([name: y_position2],
    if port_value(1, Byte_val)  and (  Val is getbit(Byte_val, 3) ) and (Val==0)
    then (
       assert(y_is_at(2))
    )
 ).

% yy=3, port =1, bit=4, value= 0
defrule([name: y_position3],
    if port_value(1, Byte_val)  and (  0 is getbit(Byte_val, 4) )
    then (
       assert(y_is_at(3))
    )
 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Z POSITION                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

defrule([name: z_position],
    if  z_axis_spec(Z_position,Port, Bit_pos, Bit_val)      and
        port_value(Port, Byte_val)                            and
        (  Bit_val is getbit(Byte_val, Bit_pos) )
    then (
       assert(z_is_at(Z_position))
    )
 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      X MOVEMENT                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

defrule([name: x_moving0],
    if port_value(4, Byte_val)  and (  1 is getbit(Byte_val, 0) )
    then (
       assert(x_moving("Moving Right."))
    )
 ).

defrule([name: x_moving1],
    if port_value(4, Byte_val)  and (  1 is getbit(Byte_val, 1) )
    then (
       assert(x_moving("Moving Left."))
    )
 ).

defrule([name: x_moving2],
    if port_value(4, Byte_val)  and (  0 is getbit(Byte_val, 0) ) and (  0 is getbit(Byte_val, 1) )
    then (
       assert(x_moving("Not Moving."))
    )
 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Y MOVEMENT                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

defrule([name: y_moving0],
    if port_value(4, Byte_val)  and (  1 is getbit(Byte_val, 4) )
    then (
       assert(y_moving("Moving In."))
    )
 ).

defrule([name: y_moving1],
    if port_value(4, Byte_val)  and (  1 is getbit(Byte_val, 3) )
    then (
       assert(y_moving("Moving Out."))
    )
 ).

defrule([name: y_moving2],
    if port_value(4, Byte_val)  and (  0 is getbit(Byte_val, 4) ) and (  0 is getbit(Byte_val, 3) )
    then (
       assert(y_moving("Not Moving."))
    )
 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Z MOVEMENT                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

defrule([name: z_moving0],
    if port_value(4, Byte_val)  and (  1 is getbit(Byte_val, 5) )
    then (
       assert(z_moving("Moving Up."))
    )
 ).

defrule([name: z_moving1],
    if port_value(4, Byte_val)  and (  1 is getbit(Byte_val, 6) )
    then (
       assert(z_moving("Moving Down."))
    )
 ).

defrule([name: z_moving2],
    if port_value(4, Byte_val)  and (  0 is getbit(Byte_val, 5) ) and (  0 is getbit(Byte_val, 6) )
    then (
       assert(z_moving("Not Moving."))
    )
 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      CAGE RULE                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

defrule([name: part_in_cage_rule],
    if port_value(2, Byte_val)  and (  1 is getbit(Byte_val, 7) )
    then (
       assert(part_in_cage)
    )
 ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    LEFT STATION                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

defrule([name: left_station_moving_in_rule],
    if port_value(4, Byte_val)  and (  1 is getbit(Byte_val, 7) )
    then (
       assert(left_station_moving("Left Station Moving In"))
    )
 ).

defrule([name: left_station_moving_out_rule],
    if port_value(5, Byte_val)  and (  1 is getbit(Byte_val, 0) )
    then (
       assert(left_station_moving("Left Station Moving Out"))
    )
 ).


defrule([name: left_station_stopped_rule],
    if (port_value(4, Byte_val) and (  0 is getbit(Byte_val, 7) ) and  port_value(5, Byte_val2) and (  0 is getbit(Byte_val2, 0) ))
    then (
        assert(left_station_moving("Left Station Not Moving."))
    )
 ).

defrule([name: part_left_station_rule],
    if port_value(3, Byte_val)  and (  1 is getbit(Byte_val, 0) )
    then (
       assert(part_at_left_station)
    )
 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   RIGHT STATION                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

defrule([name: right_station_moving_in_rule],
    if port_value(5, Byte_val)  and (  1 is getbit(Byte_val, 1) )
    then (
       assert(right_station_moving("Right Station Moving In"))
    )
 ).

defrule([name: right_station_moving_out_rule],
    if port_value(5, Byte_val)  and (  1 is getbit(Byte_val, 2) )
    then (
       assert(right_station_moving("Right Station Moving Out"))
    )
 ).

defrule([name: right_station_stopped_rule],
    if port_value(5, Byte_val)  and (  0 is getbit(Byte_val, 1) ) and (  0 is getbit(Byte_val, 2) )
    then (
       assert(right_station_moving("Right Station Not Moving."))
    )
 ).

defrule([name: part_right_station_rule],
    if port_value(3, Byte_val)  and (  1 is getbit(Byte_val, 1) )
    then (
       assert(part_at_right_station)
    )
 ).