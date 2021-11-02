
:-dynamic id_holder____1/1.
:-dynamic rtx/1.


is_undefined(Term):-
    not(is_defined(Term)).

is_defined(Term):-
    catch(Term, _Exception, false).


new_id(NewID):-
    id_holder____1(OldID),
    NewID is OldID +1,
    retractall(id_holder____1(OldID)),
    assert(id_holder____1(NewID)),
    !.

new_id(1):-
    \+ id_holder____1(_),
    assert(id_holder____1(1)).



/*
retract_old_diagnoses:-
    forall( done(Goal), retract_safe(diagnose(Goal)) ).

assert_new_diagnoses:-
    forall(goal(Goal), assert_once(diagnose(Goal))).
*/


write_list([]).
write_list([X|L]):-
    log_nl(X),
    write_list(L).


/*
assert_rtx(Fact):-
    catch(Fact,_Cather, false),
    rtx(Fact),
    !.
*/

assert_rtx(Fact):-
    assert(Fact),
    assert(rtx(Fact)).

retract_rtx(Fact):-
    retract(Fact),
    retract(rtx(Fact)).

retractall_rtx:-
    forall(rtx(Fact), retract(Fact)),
    retractall(rtx(_)).


assert_single(NewFact):-
    catch( retractall(NewFact),
           _Catcher,
           true),
    assert(NewFact).



assert_all(NewFact):-
    functor(NewFact, Name, Arity),
    findall(_, between(1,Arity,_Ignore), List),
    ExistingFacts =.. [Name | List],
    catch(retractall(ExistingFacts), _Catcher, true),
    assert(NewFact).


assert_once(NewFact):-  /* destrois all previous facts with the same pattern as NewFact */
    functor(NewFact, Name, Arity),
    findall(_, between(1,Arity,_Ignore), List),
    OldFact =..[Name|List],
    dynamic(Name/Arity),
    assert_once_2(OldFact, NewFact).


assert_once_2(OldFact, NewFact):-
    OldFact,
    retractall(OldFact),
    assert(NewFact),
    !.


assert_once_2(_, NewFact):-
    assert(NewFact).


retract_safe(Fact):-
    functor(Fact, Name, Arity),
    current_predicate(Name/Arity),
    retract_safe_2(Fact),
    !.

retract_safe(Fact):-
    functor(Fact, Name, Arity),
    dynamic(Name/Arity),
    retract_safe_2(Fact),
    !.

retract_safe_2(Fact):-
    \+ Fact,
    !.

retract_safe_2(Fact):-
    retract(Fact),
    !.


is_bit_event(OldBit, NewBit, 0):-
    OldBit\==0,
    NewBit ==0,
    !.

is_bit_event(OldBit, NewBit, 1):-
    OldBit ==0,
    NewBit\==0.

is_event(OldValue, NewValue, BASE_STATE):-
    OldValue ==BASE_STATE,
    NewValue\==BASE_STATE.


/*
value_of_prolog_functor(Name, Value):-
    current_predicate(Name/N),
    value_of_prolog_functor(N, Name, Value),
    !.

value_of_prolog_functor(_Name, false).



value_of_prolog_functor(0, Name, Value):-
    try_dynamize_it(Name, 1),
    Term =.. [Name],
    (   ((Term) -> Value=true); Value=false ).


value_of_prolog_functor(1, Name, Value):-
    try_dynamize_it(Name, 1),
    Term =.. [Name, Value],
    Term.
*/



/*
system_has_states(StatesList):-
    forall( member(State, StatesList),
            (   functor(State, Name, Arity),
                try_dynamize_it(Name, Arity),
                State
            )).

*/

system_has_states(States, SystemStates):-
    forall( member(State, States), member(State, SystemStates)).


list_to_string(List, String):-
   with_output_to(atom(String_temp), write_list_term(List)),
   atom_concat('[',String_temp, S2),
     atom_concat(S2,']', String).

write_list_term([]).
write_list_term([X | [] ]):-
    log(X).
write_list_term([X | XL ]):-
    log(X),
    log(','),
    write_list_term(XL).




sublist([], []).

sublist([A|T], [A|L]):-
    sublist(T, L).

sublist(T, [_|L]):-
    sublist(T, L).


sublist(Sub,List,MinLen,MaxLen) :-
    between(MinLen,MaxLen,Len),
    length(Sub,Len),
    sublist(Sub,List).

choose(Sub,List) :-
    sublist(Sub,List,1,2),
    member(f,Sub).









throw_console(Message):-
   current_output(Curr),
   set_output(user_output),
   % throw(Message),
   writeln(Message),
   set_output(Curr).


log(Sentence):-
   current_output(Curr),
   set_output(user_output),
   write(Sentence),
   set_output(Curr).

log_nl(Sentence):-
   current_output(Curr),
   set_output(user_output),
   writeln(Sentence),
   set_output(Curr).


log_format(String, Arguments):-
   current_output(Curr),
   set_output(user_output),
   format(String, Arguments),
   set_output(Curr).
