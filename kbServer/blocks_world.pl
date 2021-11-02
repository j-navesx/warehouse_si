:-ensure_loaded('RTXengine/RTXstrips_planner').

strips([
   act  [unstack(X,Y)                ],
   pre  [on(X,Y), clear(X), handempty],
   add  [holding(X),clear(Y)],
   del  [on(X,Y), clear(X), handempty]
]).


strips([
   act  [pickup(X)],
   pre  [ontable(X), clear(X), handempty],
   add  [holding(X)],
   del  [ontable(X), clear(X), handempty]
]).


strips([
   act  [putdown(X)],
   pre  [holding(X)],
   add  [ontable(X), clear(X), handempty],
   del  [holding(X)]
]).



strips([
   act  [stack(X,Y)],
   pre  [holding(X), clear(Y)],
   add  [on(X,Y), clear(X), handempty],
   del  [clear(Y), holding(X)]
]).

/*


 * solve([on(a,b)], [ontable(a), ontable(b), clear(a), clear(b),handempty] ,W, Plan).
 * solve([on(a,b), on(b,c)], [ontable(a), ontable(b), ontable(c),clear(a), clear(b), clear(c), handempty] ,W, Plan).
 * solve([on(b,c), on(a,b)], [ontable(a), ontable(b), ontable(c),clear(a), clear(b), clear(c), handempty]  ,W,   Plan).
 * solve([ontable(c), on(b,c), on(a,b)], [ontable(a), on(b,a),on(c,b),clear(c),handempty], W, Plan).

 solve([on(a,b), on(b,c)], [ontable(a), on(b,a), on(c,b),clear(c),handempty], W, Plan),  member((Operator, World1, Worl2), Plan).
*/
