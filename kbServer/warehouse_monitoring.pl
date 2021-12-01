%mekie Naves
:-ensure_loaded('RTXengine/RTXengine.pl').

:-ensure_loaded(warehouse_config).

defrule([name:start_rule, priority:1000],
    if    true     then (
        % reset warehouse states
        % retractall(x_is_at(_)),
        % retractall(z_is_at(_)),
        % ....
        all_storage_states(L),
        forall(member(State, L), retractall(State))
     )
).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      X POSITION                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% we can make a single rule for all the positions
defrule([name: x_position],
    if  x_axis_spec(X_position,Port, Bit_pos, Bit_val)     and
        port_value(Port, Byte_val)                            and
        (  Bit_val is getbit(Byte_val, Bit_pos) )
    then (
       assert(x_is_at(X_position))
    )
 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Y POSITION                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% or set a rule per position like in yy_position
% yy=1, port =1, bit=2, value= 0
defrule([name: y_position1],
    if port_value(1, Byte_val)  and (  0 is getbit(Byte_val, 2) )
    then (
       assert(y_is_at(1))
    )
 ).

% yy=2, port =1, bit=3, value= 0
defrule([name: y_position2],
    if port_value(1, Byte_val)  and (  Val is getbit(Byte_val, 3) ) and (Val==0)
    then (
       assert(y_is_at(2))
    )
 ).

% yy=3, port =1, bit=4, value= 0
defrule([name: y_position3],
    if port_value(1, Byte_val)  and (  0 is getbit(Byte_val, 4) )
    then (
       assert(y_is_at(3))
    )
 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Z POSITION                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

defrule([name: z_position],
    if  z_axis_spec(Z_position,Port, Bit_pos, Bit_val)      and
        port_value(Port, Byte_val)                            and
        (  Bit_val is getbit(Byte_val, Bit_pos) )
    then (
       assert(z_is_at(Z_position))
    )
 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      X MOVEMENT                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

defrule([name: x_moving0],
    if port_value(4, Byte_val)  and (  1 is getbit(Byte_val, 0) )
    then (
       assert(x_moving(1))
    )
 ).

defrule([name: x_moving1],
    if port_value(4, Byte_val)  and (  1 is getbit(Byte_val, 1) )
    then (
       assert(x_moving(-1))
    )
 ).

defrule([name: x_moving2],
    if port_value(4, Byte_val)  and (  0 is getbit(Byte_val, 0) ) and (  0 is getbit(Byte_val, 1) )
    then (
       assert(x_moving(0))
    )
 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Y MOVEMENT                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

defrule([name: y_moving0],
    if port_value(4, Byte_val)  and (  1 is getbit(Byte_val, 4) )
    then (
       assert(y_moving(1))
    )
 ).

defrule([name: y_moving1],
    if port_value(4, Byte_val)  and (  1 is getbit(Byte_val, 3) )
    then (
       assert(y_moving(-1))
    )
 ).

defrule([name: y_moving2],
    if port_value(4, Byte_val)  and (  0 is getbit(Byte_val, 4) ) and (  0 is getbit(Byte_val, 3) )
    then (
       assert(y_moving(0))
    )
 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Z MOVEMENT                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

defrule([name: z_moving0],
    if port_value(4, Byte_val)  and (  1 is getbit(Byte_val, 5) )
    then (
       assert(z_moving(1))
    )
 ).

defrule([name: z_moving1],
    if port_value(4, Byte_val)  and (  1 is getbit(Byte_val, 6) )
    then (
       assert(z_moving(-1))
    )
 ).

defrule([name: z_moving2],
    if port_value(4, Byte_val)  and (  0 is getbit(Byte_val, 5) ) and (  0 is getbit(Byte_val, 6) )
    then (
       assert(z_moving(0))
    )
 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      CAGE RULE                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

defrule([name: part_in_cage_rule],
    if port_value(2, Byte_val)  and (  1 is getbit(Byte_val, 7) )
    then (
       assert(part_in_cage)
    )
 ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    LEFT STATION                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

defrule([name: left_station_moving_in_rule],
    if port_value(4, Byte_val)  and (  1 is getbit(Byte_val, 7) )
    then (
       assert(left_station_moving(1))
    )
 ).

defrule([name: left_station_moving_out_rule],
    if port_value(5, Byte_val)  and (  1 is getbit(Byte_val, 0) )
    then (
       assert(left_station_moving(-1))
    )
 ).


defrule([name: left_station_stopped_rule],
    if (port_value(4, Byte_val) and (  0 is getbit(Byte_val, 7) ) and  port_value(5, Byte_val2) and (  0 is getbit(Byte_val2, 0) ))
    then (
        assert(left_station_moving(0))
    )
 ).

defrule([name: part_left_station_rule],
    if port_value(3, Byte_val)  and (  1 is getbit(Byte_val, 0) )
    then (
       assert(part_at_left_station)
    )
 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   RIGHT STATION                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

defrule([name: right_station_moving_in_rule],
    if port_value(5, Byte_val)  and (  1 is getbit(Byte_val, 1) )
    then (
       assert(right_station_moving(1))
    )
 ).

defrule([name: right_station_moving_out_rule],
    if port_value(5, Byte_val)  and (  1 is getbit(Byte_val, 2) )
    then (
       assert(right_station_moving(-1))
    )
 ).

defrule([name: right_station_stopped_rule],
    if port_value(5, Byte_val)  and (  0 is getbit(Byte_val, 1) ) and (  0 is getbit(Byte_val, 2) )
    then (
       assert(right_station_moving(0))
    )
 ).

defrule([name: part_right_station_rule],
    if port_value(3, Byte_val)  and (  1 is getbit(Byte_val, 1) )
    then (
       assert(part_at_right_station)
    )
 ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aula 23/11
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

make_most_generic_term(Term, GenericTerm):-
   functor(Term, Name, Arity),
   findall(_, between(1, Arity, _), L),
   TermAsList = [Name | L],
   GenericTerm =.. TermAsList.

% TIME ON
defrule([name: timing_events_rule_on],
   if all_storage_states(States) and
     member(State, States)       and
     State                       and
     not(time_on(_, State))
     then [
        make_most_generic_term(State, GenericState),
        retractall(time_on(_, GenericState)),
        get_time(Time),
        assert(time_on(Time, State))
]).

% TIME_OFF
defrule([name: timing_events_rule_off],
   if time_on(_,State)           and
     not(State)                  and
     not(time_off(_, State))
     then [
        make_most_generic_term(State, GenericState),
        retractall(time_off(_, GenericState)),
        get_time(Time),
        assert(time_off(Time, State))
]).

%X-BETWEEN ON
defrule([name: x_between_rule_on],
if    not(x_between(_,_, _))          and
      not(x_is_at(_))                 and
      time_off(_, x_is_at(Xi))        and
      x_moving(MovDirection)
      and (MovDirection \= 0)         then
      [
          Xf is Xi + MovDirection,
          get_time(Tstamp),
          assert(x_between(Tstamp,Xi, Xf))
      ]).

%X-BETWEEN OFF
defrule([name: x_between_rule_off],
if    x_between(_,_,_) and x_is_at(_) then [
         retract(x_between(_,_, _))
]).

% //TODO Between para o Z e Y tbm ඞඞඞඞඞඞඞඞඞඞඞඞඞඞඞඞඞඞඞ

%PREVIOUS_STATE -> mimics TIME_OFF (usar caso n�o queiramos trabalhar com o TIME_OFF)
defrule([name: previous_state_rule],
if
     time_off(Toff,State)          and
     not(previous_state(_, State))
       then [
          make_most_generic_term(State, GenericState),
          retractall(previous_state(_, GenericState)),
          assert(previous_state(Toff,State))
]).

:- dynamic user_pressed_yellow_button/0. % set it dynamic to avoid an Rule error�

%YELLOW ALERT RULE
defrule([name: alert_x_rule],
   if  user_pressed_yellow_button and                              % relevant event/state
       % put here other relevant conditions
       not(alert(_ID, _TS, yellow_alert, _Descr, pending)) % avoid repetitions
   then [
        generate_unique_id(ID),
        get_time(TimeStamp),
        assert(alert(ID, TimeStamp, yellow_alert, 'user pressed yellow button', pending)  ) %,
        %log_nl(alert(ID, TimeStamp, yellow_alert, 'user pressed yellow button', pending) )
]).

%generate json array of the current alerts.
get_alerts_json(Status):-
   % output as JSON object
   findall( StringJSON,
    (
       alert(ID, TimeStamp, Reference, Explanation,  Status),
       format_time(string(Time),"%T",TimeStamp),
       format(atom(StringJSON), '{"id":"~w", "time":"~w", "reference":"~w", "explanation":"~w",  "status":"~w"}',
                              [ID, Time, Reference, Explanation,  Status])

    ),List),
   write_term(List,[]).

resolve_selected_alert(ID):-
   alert(ID, TimeStamp, Reference, Explanation, _Status),
   retractall(alert(ID,_,_,_,_)),
   assert(alert(ID, TimeStamp, Reference, Explanation, resolved)).

defrule([name: machine_hvac_failure_rule],
   if  sensor_temperature(Temp) and                              % relevant event/state
       (Temp > 50)                              and
       % put here other relevant conditions
       not( failure(_, _, machine_failure(hvac), _, _, pending)  ) % avoid repetitions
   then[
        generate_unique_id(ID),
        get_time(TimeStamp),
        assert(  failure(ID, TimeStamp, machine_failure(hvac), 'hvac is overheating', plan(aaa,[a1,a2,a3]), pending) )
   ]).


:- dynamic sensor_temperature /1. % set it dynamic to avoid an �Rule error�


%generate json array of the current failures.
get_failures_json(Status):-
   % output as JSON object

   findall( Failure,
     (
       failure(ID, TimeStamp, Reference, Explanation, Plan, Status),
       format_time(string(Time),"%T",TimeStamp),
       format(atom(Failure),'{"id":"~w", "time":"~w", "reference":"~w", "explanation":"~w", "plan":"~w", "status":"~w"}',
                                    [ID, Time, Reference, Explanation, Plan, Status])
     ),List),
   write_term(List,[]).

resolve_selected_failure(ID):-

   failure(ID, TimeStampFailure, ReferenceFailure, ExplanationFailure, Plan, pending),
   retractall(failure(ID,_,_,_,_,_)),
   assert(failure(ID, TimeStampFailure, ReferenceFailure, ExplanationFailure, Plan, resolved)),

   % the alert might have been gone before before...
   % and findall always returns true, even if there is no alerts.
   findall(_, (
               alert(ID, TimeStampAlert, ReferenceAlert, ExplanationAlert, _StatusAlert),
               retractall(alert(ID,_,_,_,_)),
               assert(alert(ID, TimeStampAlert, ReferenceAlert, ExplanationAlert, resolved))
   ), _),
   assert(Plan).

% X_LIMIT_10 alert
% alert not reported yet
% X is between 10 and 11
% Is moving to the right
% => Generate an alert

defrule([name: x_past_position_10_rule],
   if not(alert(_ID, _TStamp, x_limit_10, _Description, pending)) and
      x_between(_TS, 10, 11)  and
      x_moving(1)
      then  [
         generate_unique_id(ID),
         get_time(TS),
         assert(alert(ID, TS, x_limit_10, 'xx actuator moving beyond position x=10 to the right', pending))
      ]).

