:-ensure_loaded('RTXengine/RTXengine.pl').
:-ensure_loaded(warehouse_config).
:-dynamic x_moving/1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      X MOVEMENT                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% move_x_right, port=4, bit(0)=1, bit(1)=0
defrule([name: move_x_right_rule],
    if  move_x_right
    then (
       set_bit_value(4, 0, 1),
       set_bit_value(4, 1, 0),
       retract(move_x_right)
    )
 ).

% move_x_left, port=4, bit(0)=0, bit(1)=1
defrule([name: move_x_left_rule],
    if  move_x_left
    then (
       set_bit_value(4, 0, 0),
       set_bit_value(4, 1, 1),
       retract(move_x_left)
    )
 ).


% stop_x, port=4, bit(0)=0, bit(1)=0
defrule([name: stop_x_rule],
    if  stop_x
    then (
       set_bit_value(4, 0, 0),
       set_bit_value(4, 1, 0),
       retract(stop_x)
    )
 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Y MOVEMENT                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% move_y_in, port=4, bit(3)=0, bit(4)=1
defrule([name: move_y_in_rule],
    if  move_y_in
    then (
       set_bit_value(4, 4, 1),
       set_bit_value(4, 3, 0),
       retract(move_y_in)
    )
 ).

% move_y_out, port=4, bit(3)=1, bit(4)=0
defrule([name: move_y_out_rule],
    if  move_y_out
    then (
       set_bit_value(4, 4, 0),
       set_bit_value(4, 3, 1),
       retract(move_y_out)
    )
 ).


% stop_y, port=4, bit(3)=0, bit(4)=0
defrule([name: stop_y_rule],
    if  stop_y
    then (
       set_bit_value(4, 4, 0),
       set_bit_value(4, 3, 0),
       retract(stop_y)
    )
 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Z MOVEMENT                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% move_z_up, port=4, bit(5)=1, bit(6)=0
defrule([name: move_z_up_rule],
    if  move_z_up
    then (
       set_bit_value(4, 5, 1),
       set_bit_value(4, 6, 0),
       retract(move_z_up)
    )
 ).

% move_z_down, port=4, bit(5)=0, bit(6)=1
defrule([name: move_z_down_rule],
    if  move_z_down
    then (
       set_bit_value(4, 5, 0),
       set_bit_value(4, 6, 1),
       retract(move_z_down)
    )
 ).


% stop_z, port=4, bit(5)=0, bit(6)=0
defrule([name: stop_z_rule],
    if  stop_z
    then (
       set_bit_value(4, 5, 0),
       set_bit_value(4, 6, 0),
       retract(stop_z)
    )
 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 LEFT STATION MOVEMENT                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% move_left_station_in, port=4, bit(7)=1, port=5, bit(0)=0
defrule([name: move_left_station_in_rule],
    if  move_left_station_in
    then (
       set_bit_value(4, 7, 1),
       set_bit_value(5, 0, 0),
       retract(move_left_station_in)
    )
 ).

% move_left_station_out, port=4, bit(7)=0, port=5, bit(0)=1
defrule([name: move_left_station_out_rule],
    if  move_left_station_out
    then (
       set_bit_value(4, 7, 0),
       set_bit_value(5, 0, 1),
       retract(move_left_station_out)
    )
 ).

% stop_left_station, port=4, bit(7)=0, port=5, bit(0)=0
defrule([name: stop_left_station_rule],
    if  stop_left_station
    then (
       set_bit_value(4, 7, 0),
       set_bit_value(5, 0, 0),
       retract(stop_left_station)
    )
 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 RIGHT STATION MOVEMENT               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% move_right_station_in, port=5, bit(1)=1, bit(2)=0
defrule([name: move_right_station_in_rule],
    if  move_right_station_in
    then (
       set_bit_value(5, 1, 1),
       set_bit_value(5, 2, 0),
       retract(move_right_station_in)
    )
 ).

% move_right_station_out, port=5, bit(1)=0, bit(2)=1
defrule([name: move_right_station_out_rule],
    if  move_right_station_out
    then (
       set_bit_value(5, 1, 0),
       set_bit_value(5, 2, 1),
       retract(move_right_station_out)
    )
 ).


% stop_right_station, port=5, bit(1)=0, bit(2)=0
defrule([name: stop_right_station_rule],
    if  stop_right_station
    then (
       set_bit_value(5, 1, 0),
       set_bit_value(5, 2, 0),
       retract(stop_right_station)
    )
 ).
