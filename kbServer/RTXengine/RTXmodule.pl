:-ensure_loaded('RTXutil').


:-dynamic m121:the_states/1.

:-m121:assert(the_states([])).


create_module(Mod):-
    get_time(T),
    atom_concat(m, T, Mod).


create_states([],_).
create_states([State|States], Module):-
    assert(Module:State),
    %functor(State,Name, Arity),
    %Module:export(Name/Arity),
    add_to_module_states(State),
    create_states(States, Module).

reset_module_states:-
    retractall(m121:the_states(_)),
    assert(m121:the_states([])).

add_to_module_states(State):-
    m121:the_states(List),
    retractall(m121:the_states(_)),
    assert(m121:the_states([State|List])).




    /*
     *
create_states(States, Module):-
    findall(_,
            (
                member(S,States),
                assert(Module:S)
            ),_).
*/


delete_states_module:-
    m121:the_states(ListOfStates),
    delete_states(ListOfStates).

delete_states([]).
delete_states([State|States]):-
    retractall(m121:State),
    delete_states(States).

/*
delete_states(States, Module):-
    findall(_,
            (
                member(S,States),
                retractall(Module:S)
            ),_).
*/
evaluate_pre_condition(States, Prec_cond):-
    Module= m121,
    delete_states_module,
    reset_module_states,
    create_states(States, Module),
    testar(Prec_cond, Module).


verify_pre_conditions(States, Prec_cond):-
    evaluate_pre_condition(States, Prec_cond).

% zz:export(c/1).
%  module_property(zz,exports(E)),    findall(F,  (member( X, E), N/A=X, functor(F, N, A)) , L).
%


testar([], _).
testar([X|Tail], Module):-
    %%functor(X, Name, Arity),
    %%try_dynamize_it(Name, Arity),
    dynamize_testing_states(X, Module),
    testar_estado(X, Module),
    testar(Tail, Module).

testar_estado(not(Estado), Module):-
    testar_estado( (\+Estado), Module),
    !.

testar_estado(Estado, Module):-
    Module:Estado.
/*,
    ground_state_if_not(Estado, Module).

ground_state_if_not(Estado, Module):-
    functor(Estado, Nome, Arity),
    functor(Estado2, Nome, Arity),
    Module:Estado2,
    \+ground(Module:Estado2),
    retract(Module:Estado2),
    assert(Module:Estado),
    !.
ground_state_if_not(_,_).
*/



dynamize_testing_states(Conditions, Module):-
    %writeln(Conditions),
    findall( (Name, Arity),
            (
                sub_term(SubTerm, Conditions),
                (   compound(SubTerm); ground(SubTerm)),
                functor(SubTerm, Name, Arity),
                atom(Name)
             ),
           L),
    %format('Cond=~w,                     L=~w~n',[Conditions, L]),
    dyna_testing_states(L, Module).

dyna_testing_states([], _Module).
dyna_testing_states([(Name,Arity)|L], Module):-
    try_dynamize_testing_state(Name, Arity, Module),
    dyna_testing_states(L, Module).





try_dynamize_testing_state(Name, Arity, Module):-
    current_predicate(Module:Name/Arity),
    !.


try_dynamize_testing_state(Name, Arity, Module):-
    dynamic( Module:Name/Arity).











