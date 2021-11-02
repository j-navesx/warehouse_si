
% https://www.cs.ubc.ca/~poole/ci/lectures/ch8/lect5.pdf

:-ensure_loaded('RTXutil').

:-dynamic asserted_state/1.
:-dynamic strips/1.
:-dynamic world/2.
:-dynamic pre_conditions/1.
:-dynamic heap/1.
:-dynamic goals/1.
:-dynamic plan/1.

:-op(900, fy, act).
:-op(900, fy, pre).
:-op(900, fy, add).
% :- op(900, fy, add1).
% :- op(900, fy, add2).
:-op(900, fy, del).
:-op(900, fy, effect).
:-op(900, fy, iff).
%:-op(900, fy, condition).
:-op(900, fy, sequence).







solve(Goals, W0, W1, Plan):-
    retractall(goals(_)),
    assert(goals(Goals)),
    solve(Goals, W0, W1, [], Plan_nested),
    % ISTO NÂO DEVERIA SER NECESSARIO
    holds(Goals, W1),
    flatten(Plan_nested, Plan).

    %ground(Plan).


solve([], W0, W0, _,[]):-
    !.

solve(Goals, W0, W0, _,[]):-
    %ground_list(W0,Goals, Goals2),
    holds(Goals, W0),
    %forall(member(G, Goals2), member(G, W0)),
    !.

solve(Goals,W0, W3, Forbidden, Plan):-
    % get_a_goal(Goal, Goals, Remaining_goals),
    get_next_goal(Goal, Goals, Remaining_goals),

    \+ holds( [Goal], W0),   % passar à frente dum estado ja satisfeito

    %writeln(handling_goal(Goal, W0)),

    \+ member(Goal, W0),
    achieves(Action, Goal),

    strips(Spec_list)=Action,
    member(act Operator, Spec_list),


    member( pre PrecList, Spec_list),
    member( add AddList, Spec_list),

    %(   member( condition [CondList], Spec_list), CondList, ! ; true),

        retractall(world(_,_)),
        assert(world(W0, AddList)),
        retractall(pre_conditions(_)),
        assert(pre_conditions(PrecList)),
        %unify_Pre_with_World(PrecList, W0), % !!! magics here
        Action,                             % CHAMADA AO CORPO

     \+ member(Operator, Forbidden),

    solve(PrecList, W0, W1,[Operator|Forbidden], Plan_for_Precedences),

    %test if Action can still be done after getting plan for preconditions.
    subset(PrecList, W1),
    do(Action, W1, W2, Plan_for_Precedences),

    solve(Remaining_goals, W2, W3,Forbidden, Plan_for_remaining_goals),


    append([Plan_for_Precedences,Operator, Plan_for_remaining_goals ], Plan).


% there is magic in this operator...
% It does the job... wish understand why!
unify_Pre_with_World([], _) => true.
unify_Pre_with_World([E|R], Set) =>
    (   memberchk(E, Set),!;true),
    unify_Pre_with_World(R, Set).



achieves(strips(List_spec), G):-
    clause(strips(List_spec), _BODY),
    member(add AddList, List_spec),
    holds(G, AddList).


holds(G, W):-
    retractall(asserted_state(_)), % to be sure
    assert_states(W),
    test(G), %
    ground_it(W, G, _),
    %member(G, W),       % member is used to unify and instantiate arguments of action
    retract_states,
    !.

holds(_G, _W):-
    retract_states,
    fail.


testa([]).

testa(Goals):-
    get_next_goal(G, Goals, RemainingGoals),
    %format('g=~w    L=~w~n',[G,RemainingGoals]),
    log_nl(G),
    testa(RemainingGoals).

get_next_goal(NextGoal, Goals, RemainingGoals):-
    member(NextGoal, Goals),
    delete(Goals, NextGoal, RemainingGoals).



/*
get_next_goal(NextGoal, Goals, RemainingGoals):-
    member(G, Goals),
    extract_goal(G, Goals, RemainingGoals, NextGoal).


extract_goal(sequence [NextGoal|List], Goals, RemainingGoals,       NextGoal):-
    !,
    findall( Element,
             (

                 member(El, Goals),
                 (
                     El = (sequence X),
                     X \= [NextGoal], % it is not the last of the sequence
                     Element = (sequence List),
                     !;
                     El \= (sequence X),
                     Element = El
                 )
             )
           ,RemainingGoals).




extract_goal(sequence [], Goals, RemainingGoals,       NextGoal):-
    !,
    select( sequence [], Goals, RemainingGoalsTemp),
    get_next_goal(NextGoal, RemainingGoalsTemp,RemainingGoals),!.


extract_goal(Goal, Goals, RemainingGoals,       Goal):-
    Goal \= (sequence _L),
    select( Goal, Goals, RemainingGoals).
*/

/*
get_a_goal(Goal, Goals, Remaining_goals):-
    member(Goal, Goals),
    delete(Goals, Goal, Remaining_goals).
*/


do(Action, W1, W3, _PreviousPlan):-
   strips(Spec_List) = Action,
   member(add AddList, Spec_List),
   member(del DelList, Spec_List),
   %ground_list(W1, DelList, DelList2), % just to provide values to no grounded arguments of clauses
   %subtract_set(W1, DelList2, W2),
   subtract_set(W1, DelList, W2),
   append(W2,AddList, W3).
   %log_format('Act=~w,~n W1=~w,~n W3=~w~n~n',[Action, W1, W3]).
/*
   retractall(world(_,_)),
   assert(world(W1, W3)),
   retractall(plan(_)),
   assert(plan(PreviousPlan)),
   Action.                         % CHAMADA AO CORPO
*/





% just to provide values to no grounded arguments of clauses

ground_it(W, Term, Term):-
    \+ is_list(Term),
    member(Term, W),
    !.

ground_it(W, List, List2):-
    ground_list(W, List, List2).



ground_list(_W, [], []).
ground_list(W,[E|Tail], [E|Result]):-
    member(E, W),
    ground_list(W, Tail, Result),
    !.

ground_list(W,[E|Tail], [E|Result]):-
    ground_list(W, Tail, Result).



subtract_set(Set1, Set2, Result):-
   findall(Element,
           (
               member(Element, Set1),
               \+ member(Element, Set2)
           ), Result).



/*
holds(G,W):-
    member(G, W).
*/



test([]).

test(sequence L):-
    test(L),
    !.
test(G):-
    \+ is_list(G),
    catch(simula:G, _, false).

test([G|Goals]):-
    test(G),
    test(Goals).


assert_states([]).
assert_states([State|States]):-
    functor(State, Name, Arity),
    current_predicate(State, Name/Arity),
    assert_states(States),
    !.

assert_states([State|States]):-
    assert(simula:State),
    assert(asserted_state(State)),
    assert_states(States).

retract_states:-
    findall( _, ( asserted_state(S), retract(simula:S)), _),
    retractall(asserted_state(_)).


