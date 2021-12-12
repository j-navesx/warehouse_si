
:-dynamic x_axis_spec/4.
:-dynamic y_axis_spec/4.
:-dynamic z_axis_spec/4.
:-dynamic port_value/2.
:-dynamic all_current_states/1.
:-dynamic all_previous_states/1.

:-dynamic cell/2.
:-dynamic recovering_mutex/0.

:-dynamic plan/2.

:-dynamic last_id/1.

:-dynamic time_on/2.
:-dynamic time_off/2.
:-dynamic x_between/3.
:-dynamic y_between/3.
:-dynamic z_between/3.
:-dynamic previous_state/2.

:-dynamic time_register/2.
:-dynamic execute/1.
:-dynamic ex/1.
:-dynamic alert/5.
:-dynamic failure/6.

:-dynamic part_in_cage/0.
:-dynamic x_is_at/1.
:-dynamic z_is_at/1.
:-dynamic y_is_at/1.

:-dynamic move_x_left/0.
:-dynamic move_x_right/0.
:-dynamic stop_x/0.

:-dynamic move_z_up/0.
:-dynamic move_z_down/0.
:-dynamic stop_z/0.

:-dynamic move_y_in/0.
:-dynamic move_y_out/0.
:-dynamic stop_y/0.


:-dynamic move_left_station_in/0.
:-dynamic move_left_station_out/0.
:-dynamic stop_left_station/0.

:-dynamic move_right_station_in/0.
:-dynamic move_right_station_out/0.
:-dynamic stop_right_station/0.


:- multifile aa/1.

all_storage_states_sensors([
    x_is_at(_X),     y_is_at(_Y),      z_is_at(_Z),
    x_moving(_),     y_moving(_),      z_moving(_),
    left_station_moving(_),
    right_station_moving(_),
    part_in_cage,
    part_at_left_station,
    part_at_right_station
]).

all_storage_states(List):-
     all_storage_states_sensors(States),
     load_all_occupied_cells(Cells),
     append(States, [x_between(_,_,_), y_between(_,_,_), z_between(_,_,_)], States2),
     append(States2,Cells,ListT),
     flatten(ListT,List).


load_all_storage_states(List):-
    all_storage_states(States),
    findall( State, (
                 member(State, States),
                 State
             ), List).

load_all_occupied_cells(List):-
    findall(cell(X,Z), cell(X,Z), List).


/* all_storage_states([
    x_is_at(_X),     y_is_at(_Y),      z_is_at(_Z),
    x_moving(_),     y_moving(_),      z_moving(_),
    left_station_moving(_),
    right_station_moving(_),
    part_in_cage,
    part_at_left_station,
    part_at_right_station
]).

load_all_storage_states(List):-
    all_storage_states(States),
    findall( State, (
                 member(State, States),
                 State
             ), List). */

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

generate_unique_id(ID):-
    \+ last_id(_),
    ID = 0,
    assert(last_id(ID)),
    !.

generate_unique_id(ID):-
    last_id(PreviousID),
    ID is PreviousID + 1,
    retractall(last_id(_)),
    assert(last_id(ID)),
    !.

