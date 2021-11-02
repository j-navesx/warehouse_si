%omg

:-ensure_loaded('./RTXengine/RTXstrips_planner').

strips([
    act   [ subplan( goto_x_right(Xf), [move_x_right, wait_until(x_is_at(Xf)), stop_x]) ],
    pre   [x_is_at(Xi), x_moving('Not moving.')  ],
    add   [x_is_at(Xf)],
    del   [x_is_at(Xi)]
]):-
    world(Wi, _Wf),
    member(x_is_at(Xi), Wi),
    Xi < Xf.

strips([
    act   [ subplan( goto_x_left(Xf), [move_x_left, wait_until(x_is_at(Xf)), stop_x]) ],
    pre   [x_is_at(Xi), x_moving('Not moving.')  ],
    add   [x_is_at(Xf)],
    del   [x_is_at(Xi)]
]):-
    world(Wi, _Wf),
    member(x_is_at(Xi), Wi),
    Xi > Xf.

