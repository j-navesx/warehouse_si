:- use_module(library(occurs)).

:- ensure_loaded('RTXutil').
/*
:- use_module('RTXutil').
*/


:-op(500, fx, if). % iProlog has "if" predefined
:-op(600, xfx, then).
:-op(700, xfx, elseif).
:-op(800, xfx, else).
:-op(10, xfy, or).
:-op(10, xfy, and).


%:-op(100, fx,  nott).


:-multifile defrule/2.

:-dynamic debug_info/0.
:-multifile debug_info/0.

:-retractall(debug_info).
%:-assert(debug_info).


:-dynamic do/1.       % do(Action)
:-dynamic goal/1.     % goal(Goal)
:-dynamic done/1.     % done(Goal)
:-dynamic diagnose/1. % diagnose(Goal).
:-dynamic action/1.

:-dynamic sequence_task/3.


/*
defrule([name: sequence_not_empty],
    if sequence_task(ID,Type,[(PreCond,Goal)|Sequence]) and PreCond
    then (

       retract( sequence_task(ID,_, _)),
       assert(sequence_task(ID,Type,Sequence)),
       % format('sequence_non_empty ~w type:~w  cond:~w goal:~w~n',[ID, Type, PreCond, Goal]),
       Goal,
        writeln(Sequence)
    )
 ).


defrule([name: sequence_empty],
    if sequence_task(ID,_,[])
    then (
       retract(sequence_task(ID,_,[]))
    )
 ).
*/

forward:-
    forward(_ListOfFiredRules).

forward(FiredRules):-
    findall( (Name, P),
    (
         pick_a_rule(name:Name, priority:P, description:_D, _IfCond, _Conclusions, _ElseIfCond, _ElseIfConclusions, _ElseConclusions) ,
         Name\=not_named
    ),L),
    list_to_set(L, Set),
    ord_subtract(L, Set, Sub),
    tell_if_has_repeated_names(Sub),

    sort(2, @>=, L, SortedRules),
    do_forward(SortedRules,[], FiredRules_aux),
    reverse(FiredRules_aux, FiredRules).


tell_if_has_repeated_names([]):-
    !.

tell_if_has_repeated_names([X|List]):-
    log_nl(rules_with_repeated_name([X|List])).


do_forward(SortedRules,PreviousFiredRules, FinalFiredRules):-
    forward_step(SortedRules,PreviousFiredRules,NewFiredRule),
    !,
    do_forward(SortedRules,[NewFiredRule|PreviousFiredRules],FinalFiredRules)
    ;
    FinalFiredRules = PreviousFiredRules.

forward_step(SortedRules, PreviousFiredRules,NewFiredRule):-
    member( (Name, Priority), SortedRules),
    %pick_a_rule(Name,  Conditions,  Conclusions, ElseConds,  ElseConc, Priority, _Description),
    pick_a_rule(name:Name, priority:Priority, description:_Description, IfConditions, Conclusions, ElseIfCond, ElseIfConclusions, ElseConclusions),
    %test conditions
    (
       (   test_with_catch(Name, IfConditions, false),
           \+ member((if(Name), IfConditions, _),      PreviousFiredRules),
           perform_conclusions(Name,Conclusions),
           print_fired_rule(if(Name), IfConditions, Conclusions),
           NewFiredRule=(if(Name), IfConditions, Conclusions),
           !
       )
       ;
       (
           length(ElseIfConclusions, Len),
           Len>0,
           test_with_catch(Name, not(IfConditions),  true),
           test_with_catch(Name, ElseIfCond,        false),
           \+ member((elseif(Name), ElseIfCond, _),      PreviousFiredRules),
           perform_conclusions(Name,ElseIfConclusions),
           print_fired_rule(elseif(Name), ElseIfCond, ElseIfConclusions),
           NewFiredRule=(elseif(Name), ElseIfCond, ElseIfConclusions),
           !
       )
       ;
       (
           length(ElseConclusions, Len),
           Len>0,
           %catch(ElseConds, _Exception, false),
           test_with_catch(Name, not(IfConditions),  true),
           test_with_catch(Name, not(ElseIfCond),    true),
           \+ member((else(Name), true, _ ), PreviousFiredRules),
           perform_conclusions(Name, ElseConclusions),
           print_fired_rule(else(Name), true , ElseConclusions),
           NewFiredRule=(else(Name), true, ElseConclusions)
       )
    ).





print_fired_rule(Name, Conditions, Conclusions):-
    debug_info,
    log_format('Executed: ~w~n       conditions: ~w~n       conclusions: ~w~n',[Name, Conditions, Conclusions]).

print_fired_rule(_Name, _Conditions, _Conclusions):-
    \+ debug_info.



pick_a_rule(name:N, priority:P, description:D, IfCond, Conclusions, ElseIfCond, ElseIfConclusions, ElseConclusions):-
  (
     (defrule(Attributes, if IfCond then Concl elseif ElseIfCond then ElseIfConcl else ElseConcl));
     (defrule(Attributes, if IfCond then Concl elseif ElseIfCond then ElseIfConcl),  ElseConcl=[]);
     (defrule(Attributes, if IfCond then Concl else ElseConcl),    ElseIfCond=false, ElseIfConcl=[]  );
     (defrule(Attributes, if IfCond then Concl ),   ElseIfCond=false, ElseIfConcl=[], ElseConcl=[]  )
  ),

  (   (member(name:N, Attributes) -> true); (N=not_named,format(string(S),'rule with condition ~w must have name.',[IfCond]), throw_console(S))   ),
  %(   (member(name:N, Attributes) -> true); (N=not_named   ) ),
  (   member(priority:P, Attributes) -> true; P=0),
  (   member(description:D, Attributes) -> true; D=''),
  (    is_list(Concl)            -> Conclusions = Concl;           Conclusions = [Concl]),
  (    is_list(ElseConcl)        -> ElseConclusions = ElseConcl; ElseConclusions = [ElseConcl]),
  (    is_list(ElseIfConcl)        -> ElseIfConclusions = ElseIfConcl; ElseIfConclusions = [ElseIfConcl]).

/*
perform_conclusions(_,[]).

perform_conclusions(RuleName, [Conc|Conclusions]):-
    %dinamize_conclusion(Conc),
    %format('executing goal: ~w~n',[Conc]),
    (   ((Conc) -> true);
        format(string(S),'FATAL: rule: ~w failed in conclusion term: [~w]',[RuleName, Conc]),
        throw_console(S)
    ),
    perform_conclusions(RuleName,Conclusions).
*/

/*
perform_conclusions(RuleName, [C|Conclusions]):-
    perform_conclusions(RuleName, [C|Conclusions]),
    !.

perform_conclusions(RuleName, Conclusions):-
    catch( (Conclusions, Conclusions_result =true), Caught_exception, Conclusions_result =false),
    show_exception(Caught_exception),
    show_execution_result(RuleName,Conclusions, Conclusions_result).

show_exception(Exception):-
    ground(Exception),
    log_nl(Exception),
    !
    ;
    true.


show_execution_result(_RuleName,_Conclusions, true ).
show_execution_result( RuleName, Conclusions, false):-
    format(string(S),'FATAL: rule: ~w failed in conclusion term: [~w]',[RuleName,Conclusions]),
    throw_console(S).

*/

perform_conclusions(_,[]).

perform_conclusions(RuleName, [Conc|Conclusions]):-
    %dinamize_conclusion(Conc),
    %format('executing goal: ~w~n',[Conc]),
    (   (test_with_catch(RuleName, Conc,false) -> true);
        log_format('FATAL: rule ~w failed in conclusion term ~w~n',[RuleName, Conc])
    ),
    perform_conclusions(RuleName,Conclusions).






and(A,B):-
   A,B.


or(A,B):-
   A,!; B.


print_fired_rules( []).
print_fired_rules( [FiredRule|Rules]):-
    print_term(FiredRule,[]),nl,
    print_fired_rules( Rules).


%BACKWARD chaining inference

backward(Goal):-
    backward_2(Goal,_,_).

backward(Goal, Set):-
    backward_2(Goal,[],ListRules),
    list_to_set(ListRules, Set).


backward_2(Goal, PreviousRules, FiredRules):-
    %pick_a_rule(Name,  Conditions,  Conclusions, _Priority, _Description),
    %pick_a_rule(Name,  Conditions,  Conclusions,_ElseConc, _Priority, _Description),
    pick_a_rule(name:Name, priority:_P, description:_D, Conditions, Conclusions, ElseIfCond, ElseIfConclusions, ElseConclusions),
    Name\=sequence_not_empty,
    Name\=sequence_empty,
       (
           has_goal(Goal, Conclusions) -> RuleTerm= fired(if(Name), Goal, because_of(Conditions)), Cond = Conditions ;
           has_goal(Goal, ElseIfConclusions) -> RuleTerm= fired(elseif(Name), Goal, because_of(ElseIfCond)), Cond = ElseIfCond;
           has_goal(Goal, ElseConclusions) -> RuleTerm= fired(else(Name), Goal, because_of(not(Conditions) and not(ElseIfCond))), Cond= (not(Conditions) and not(ElseIfCond))
       ),
       %has_goal(Goal, Conclusions),
       % RuleTerm= fired(Name, Goal, because_of(Conditions)),
    backward_condition(Cond, [RuleTerm|PreviousRules], FiredRules).



backward_2(not(Goal),FiredRules,FiredRules):-
    !,
    catch(not(Goal), _Catcher, true).


backward_2(Goal,FiredRules,FiredRules):-
    !,
    catch(Goal, _Catcher, false).


has_goal(Goal, Conclusions):-
    member(assert(Goal), Conclusions).

has_goal(Goal, Conclusions):-
    member(assert_rtx(Goal), Conclusions).

has_goal(Goal, Conclusions):-
    member(asserta(Goal), Conclusions).

has_goal(Goal, Conclusions):-
    member(assertz(Goal), Conclusions).

has_goal(Goal, Conclusions):-
    member(assert_once(Goal), Conclusions).



backward_condition(Cond1 and Cond2,PreviousRules, FiredRules):-
    !,
    backward_2(Cond1,PreviousRules, FiredRules_11),
    backward_2(Cond2,FiredRules_11, FiredRules).


backward_condition(Cond1 or Cond2,PreviousRules, FiredRules):-
    !,
    (
       backward_2(Cond1,PreviousRules, FiredRules)
      ;
       backward_2(Cond2,PreviousRules, FiredRules)
    ).


backward_condition(Condition, PreviousRules, FiredRules):-
    backward_2(Condition, PreviousRules, FiredRules).



/***************** Utilities *********************/
/*
check_rules(Repetitions):-
        findall( Name,
             pick_a_rule(Name,  _Conditions,  _Conclusions,_ElseCon, _Priority,_Description),
             L),
        find_duplicates(L, Repetitions).

find_duplicates([],[]).

find_duplicates([X|Tail],[X|Duplicates]):-
    member(X, Tail),
    !,

    find_duplicates(Tail, Duplicates).

find_duplicates([X|Tail],Duplicates):-
    \+ member(X, Tail),
    find_duplicates(Tail, Duplicates).

*/


















