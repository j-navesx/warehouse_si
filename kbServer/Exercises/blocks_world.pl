:-ensure_loaded('../RTXengine/RTXstrips_planner').

strips([
    act   [unstack(X,Y)],
    pre   [on(X,Y), clear(X), handempty],
    add   [holding(X),clear(Y)],
    del   [on(X,Y),clear(X),handempty]
]).

strips([
    act   [stack(X,Y)],
    pre   [holding(X),clear(Y)],
    add   [on(X,Y), clear(X), handempty],
    del   [clear(Y),holding(X)]
]).

strips([
    act   [pickup(X)],
    pre   [ontable(X), clear(X), handempty],
    add   [holding(X)],
    del   [ontable(X), clear(X), handempty]
]).

strips([
    act   [putdown(X)],
    pre   [holding(X)],
    add   [ontable(X), clear(X), handempty],
    del   [holding(X)]
]).
