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


%cenas novas wow

defrule([name: wait_until_rule],
    if plan(Ref,[wait_until(Condition)|ListOfActions]) and Condition  then[
       retract(plan(Ref,[wait_until(Condition)|ListOfActions])),
       assert(plan(Ref,ListOfActions)),
       log_format('wait_for: ~w, plan: ~w~n',[Condition, Ref])
    ]
).

defrule([name: wait_for_all_rule],
    if plan(Ref,[wait_for_all([Cond|Conditions])|ListOfActions]) and Cond  then[
       retract( plan(Ref,[wait_for_all([Cond|Conditions])|ListOfActions])  ),
       assert(  plan(Ref,[wait_for_all(      Conditions )|ListOfActions])  ),
       log_format('wait_for: ~w, plan: ~w~n',[Cond, Ref])                                                        ]
).

defrule([name: wait_for_all_rule_empty_cond],
    if plan(Ref,[wait_for_all([])|ListOfActions])   then[
       retract( plan(Ref,[wait_for_all([])|ListOfActions])  ),
       assert(  plan(Ref,ListOfActions)  )
    ]
).


defrule([name: run_plan_for_actions],
    if plan(Ref,[Action|ListOfActions]) and (Action\=wait_until(_))
        and (Action\=wait_for_all(_)) and (Action\=subplan(_,_)) then [
       retract(plan(Ref,[Action|ListOfActions])),
       assert(plan(Ref,ListOfActions)),
       assert(Action),
       log_format('action: ~w, plan: ~w~n',[Action, Ref])
    ]
).

defrule([name: empty_plan_rule],
    if plan(Ref,[])  then [                          %retract finished/empty
       retract(plan(Ref,[])),                        %plans
       log_format('finished_plan:  ~w~n',[Ref])
    ]
).

defrule([name:subplan_rule],
    if plan(Ref_parent,[subplan(Ref_child,List_action) | Plan]) then [
       retract( plan(Ref_parent,[subplan(Ref_child,List_action) | Plan]) ),
       assert(plan(Ref_parent,Plan)),
       assert(plan(Ref_child,List_action)),
       log_format('new_plan: ~w of plan: ~w~n',[Ref_child, Ref_parent])
    ]
).

/*
defrule([name: plan_with_actions_rule],
    if plan(Ref,[Action|ListOfActions])
           and (Action\=wait_until(_)) then [       %get an action
       retract(plan(Ref,[Action|ListOfActions])),    %retract and assert
       assert(plan(Ref,ListOfActions)),              %remaining plan
       assert(Action),
       log_format('action: ~w, plan: ~w~n',[Action, Ref])
    ]
).

defrule([name: empty_plan_rule],
    if plan(Ref,[])  then [                          %retract finished/empty
       retract(plan(Ref,[])),                        %plans
       log_format('finished_plan:  ~w~n',[Ref])
    ]
).

defrule([name: wait_until_rule],
    if plan(Ref,[wait_until(Condition)|ListOfActions])
         and Condition  then[
       retract(plan(Ref,[wait_until(Condition)|ListOfActions])),
       assert(plan(Ref,ListOfActions)),
       log_format('wait_for: ~w, plan: ~w~n',[Condition, Ref])
    ]
).
*/


%%%%%%%%%%%%%
%Aula 23/11
%%%%%%%%%%%%%

% while executing a plan, we need a way to execute actions (already defined as prolog predicates)

defrule([name: run_execute_action_1],
   if execute(Action)  then [
      retract(execute(Action)),
      do_execute(Action)
   ]
).

 defrule([name: run_execute_action_2],       %este dá Error in rule named run_execute_action_2 -> error(existence_error(procedure,ex/1),context(system:catch/3,_8086))
   if ex(Action) then [
      retract(ex(Action)),
      do_execute(Action)
   ]
).

do_execute(Action):-
    log_nl(executing____action(Action)),
    Action,
    log_nl(finished_____action(Action)),
    !.

do_execute(Action):-
    log_format('action ex(~w) should always yield true',[Action]).


%%%%%%%%%%%%%%%%%%
%Não sei se isto é suposto estar no dispatcher
%                    |
%                    V

% timer -> fire rules with a delay or implement periodic behavior.

start_timer(ID):-
   time_register(ID, _),
   !.

start_timer(ID):-
  timer_creation(ID).

timer_creation(ID):-
  get_time(TimeStamp),
  assert(time_register( ID, TimeStamp)).

dispose_timer(ID):-
  retractall( time_register(ID,_)).

reset_timer(ID):-
   \+ time_register(ID, _),
   log_nl(non_existing_timer(ID)),
   fail.

reset_timer(ID):-
   time_register(ID, _),
   dispose_timer(ID),
   timer_creation(ID).


timer(ID, DelayInSeconds):- %Seconds: float
  time_register(ID, TimeBegin),
  get_time(TNow),
  (  TNow - TimeBegin) >= DelayInSeconds.

% To prevent the rule from firing again, we discard the button

:-dynamic button_start/0.

% firing periodically
% If you want the rule to fire at beginning of the system, and fire forever,
% remove the start_button clause from the rule condition.

defrule([name: periodic_timer_rule_example_1],
  if button_start and start_timer(timer1) and timer(timer1, 3.0) then [
     log_nl('rule fired after 3 seconds.'),
     dispose_timer(timer1),
     retract(button_start)
]).

