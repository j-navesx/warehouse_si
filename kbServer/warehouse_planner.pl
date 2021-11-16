%omg

:-ensure_loaded('./RTXengine/RTXstrips_planner').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          X Movement                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

strips([
    act   [ subplan( goto_x_right(Xf), [move_x_right, wait_until(x_is_at(Xf)), stop_x]) ],
    pre   [x_is_at(Xi), x_moving(0)  ],
    add   [x_is_at(Xf)],
    del   [x_is_at(Xi)]
]):-
    world(Wi, _Wf),
    member(x_is_at(Xi), Wi),
    Xi < Xf.

strips([
    act   [ subplan( goto_x_left(Xf), [move_x_left, wait_until(x_is_at(Xf)), stop_x]) ],
    pre   [x_is_at(Xi), x_moving(0)  ],
    add   [x_is_at(Xf)],
    del   [x_is_at(Xi)]
]):-
    world(Wi, _Wf),
    member(x_is_at(Xi), Wi),
    Xi > Xf.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Z Movement                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

strips([
    act     [subplan( goto_z_up(Zf), [move_z_up, wait_unitl(z_is_at(Zf)), stop_z])],
    pre     [z_is_at(Zi), z_moving(0)], 
    add     [z_is_at(Zf)],
    del     [z_is_at(Zi)]
]):-
    world(Wi, _Wf),
    member(z_is_at(Zi), Wi),
    Zi < Zf.

strips([
    act     [subplan( goto_z_down(Zf), [move_z_down, wait_unitl(z_is_at(Zf)), stop_z])],
    pre     [z_is_at(Zi), z_moving(0)], 
    add     [z_is_at(Zf)],
    del     [z_is_at(Zi)]
]):-
    world(Wi, _Wf),
    member(z_is_at(Zi), Wi),
    Zi > Zf.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Y Movement                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 

strips([
    act     [subplan(goto_y_in(Yf), [move_y_in, wait_until(y_is_at(Yf)), stop_y])],
    pre     [y_is_at(Yi), y_moving(0)],
    add     [y_is_at(Yf)],
    del     [y_is_at(Yi)]    
]):-
    world(Wi, _Wf),
    member(y_is_at(Yi), Wi),
    Yi > Yf.

strips([
    act     [subplan(goto_y_out(Yf), [move_y_out, wait_until(y_is_at(Yf)), stop_y])],
    pre     [y_is_at(Yi), y_moving(0)],
    add     [y_is_at(Yf)],
    del     [y_is_at(Yi)]    
]):-
    world(Wi, _Wf),
    member(y_is_at(Yi), Wi),
    Yi < Yf.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Left Station                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% // TODO: WAIT FOR LEFT STATION BOX
strips([
    act     [subplan(receive, [move_left_station_in, wait_until(part_at_left_station), stop_left_station])],
    pre     [left_station_moving(0)],
    add     [part_at_left_station],
    del     []    
]).

% // TODO: INPUT BOX FROM LEFT STATION
strips([
    act     [subplan(get_box, [move_y_in, wait_unitl(y_is_at(1)), move_z_up, wait_unitl(z_is_at(1.5)), move_y_out, wait_unitl(y_is_at(2))])],
    pre     [left_station_moving(0), part_at_left_station, x_is_at(1), z_is_at(1), y_is_at(2)],
    add     [part_in_cage],
    del     [part_at_left_station]    
]).
% // TODO: INSERT BOX IN CELL
% // TODO: REMOVE BOX FROM CELL
% // TODO: OUTPUT BOX ON RIGHT STATION
% // TODO: CLEAR RIGHT STATION