
:-dynamic x_axis_spec/4.
:-dynamic y_axis_spec/4.
:-dynamic z_axis_spec/4.
:-dynamic port_value/2.
:-dynamic all_current_states/1.
:-dynamic all_previous_states/1.

:- multifile aa/1.


all_storage_states([
    x_is_at(_X),     y_is_at(_Y),      z_is_at(_Z),
    x_moving(_),     y_moving(_),      z_moving(_),
    left_station_moving(_),
    right_station_moving(_),
    part_in_cage,
    part_at_left_station,
    part_at_right_station
]).

% each position represented by tuple
% (X_Position, Port_Number,Bit_position, Bit_value)
% int pp[10] = { 0,0,0,0,0,0,0,0,1,1 };
% int bb[10] = { 0,1,2,3,4,5,6,7,0,1 };

x_moving_spec( 1, 4, 0, 1).
x_moving_spec(-1, 4, 1, 1).

x_axis_spec(1, 0, 0, 0). % x_pos=1, port=0, bit=0, value=0
x_axis_spec(2, 0, 1, 0). % x_pos=2, port=0, bit=1, value=0
x_axis_spec(3, 0, 2, 0).
x_axis_spec(4, 0, 3, 0).
x_axis_spec(5, 0, 4, 0).
x_axis_spec(6, 0, 5, 0).
x_axis_spec(7, 0, 6, 0).
x_axis_spec(8, 0, 7, 0).
x_axis_spec(9, 1, 0, 0).
x_axis_spec(10, 1, 1, 0).

% int pp[3] = { 1,1,1 };
% int bb[3] = { 2,3,4 };
y_axis_spec(1,   1, 2, 0).
y_axis_spec(2,   1, 3, 0).
y_axis_spec(3,   1, 4, 0).


% int pp[5] = { 2,2,2,2,1 };
% int bb[5] = { 6,4,2,0,6 };
z_axis_spec(1,   2, 6, 0).
z_axis_spec(2,   2, 4, 0).
z_axis_spec(3,   2, 2, 0). %down
z_axis_spec(4,   2, 0, 0).
z_axis_spec(5,   1, 6, 0).


z_axis_spec(1.5, 2, 5, 0).
z_axis_spec(2.5, 2, 3, 0).
z_axis_spec(3.5, 2, 1, 0). %up
z_axis_spec(4.5, 1, 7, 0).
z_axis_spec(5.5, 1, 5, 0).



write_bits(Byte_val):-
    findall(Bit,(
           between(0, 7, Position),
           Bit is getbit(Byte_val, Position)
     ),List),
    reverse(List, List2),
    forall(member(B,List2), write(B)).


get_port_value(Port, 0):-
    \+ port_value(Port, _),
    !.

get_port_value(Port, Value):-
    port_value(Port, Value).

set_bit_value(Port, Bit_number,  0):-
    get_port_value(Port, Byte_value),
    New_value is (Byte_value /\  (0xff-(1<<Bit_number))),
    % write('old_value='), write_bits(Byte_value),nl,
    % write('new_value='), write_bits(New_value),
    retractall(port_value(Port, _)),
    assert(port_value(Port, New_value)),
    !.

set_bit_value(Port, Bit_number,  1):-
    get_port_value(Port, Byte_value),
    New_value is (Byte_value \/  (1<<Bit_number)),
    % write('old_value='), write_bits(Byte_value),nl,
    % write('new_value='), write_bits(New_value),
    retractall(port_value(Port, _)),
    assert(port_value(Port, New_value)).



