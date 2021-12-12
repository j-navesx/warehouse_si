:-ensure_loaded(warehouse_error_recovery).
:-ensure_loaded(warehouse_monitoring).

%Apply immediate action to immobilize the axis
%Create plan with recovery actions
%Grab all running plans in a list
%Stop all the running plans as subplans (we could delete/forget them instead) 
%Create a recovery plan composed by recovery  actions and subplans.
%=> Generate a failure  

%example of pre_determined recovery plan

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Warehouse stopped between two positions (actuator broken?)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/* find_recovery_plan(ID, x_actuator_alert_stopped_between, Plan):-
    %immediate action
    assert(stop_x),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [move_x_left, wait_until(x_is_at(_)), stop_x],
    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_x_actuator_alert_stopped_between_failure, RecoveryPlan).
 */
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Position sensor broken
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

find_recovery_plan(ID, x_sensor_broken_right, Plan):-
    %immediate action
    assert(stop_x),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [
        wait_until(not(recovering_mutex)), 
        ex( assert(recovering_mutex)),
        move_x_left, 
        wait_until(x_between(_,_,_)), 
        wait_until(x_is_at(_)), 
        stop_x,
        ex(retract(recovering_mutex)), 
        ex(change_failure_status(ID, resolved))
    ], %usar aqui timers faz com que não funcione devidamente
    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_x_sensor_broken_right_failure, RecoveryPlan).

find_recovery_plan(ID, x_sensor_broken_left, Plan):-
    %immediate action
    assert(stop_x),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [
        wait_until(not(recovering_mutex)), 
        ex( assert(recovering_mutex)),
        move_x_right, 
        wait_until(x_between(_,_,_)), 
        wait_until(x_is_at(_)), 
        stop_x,
        ex(retract(recovering_mutex)), 
        ex(change_failure_status(ID, resolved))
    ], %usar aqui timers faz com que não funcione devidamente
    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_x_sensor_broken_left_failure, RecoveryPlan).

find_recovery_plan(ID, y_sensor_broken_in, Plan):-
    %immediate action
    assert(stop_y),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [
        wait_until(not(recovering_mutex)), 
        execute( assert(recovering_mutex)),
        move_y_out, 
        wait_until(y_between(_,_,_)), 
        wait_until(y_is_at(_)), 
        stop_y,
        execute(retract(recovering_mutex)), 
        execute(change_failure_status(ID, resolved))
    ], %usar aqui timers faz com que não funcione devidamente
    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_y_sensor_broken_in_failure, RecoveryPlan).

find_recovery_plan(ID, y_sensor_broken_out, Plan):-
    %immediate action
    assert(stop_y),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [
        wait_until(not(recovering_mutex)), 
        execute( assert(recovering_mutex)),
        move_y_in, 
        wait_until(y_between(_,_,_)), 
        wait_until(y_is_at(_)), 
        stop_y,
        execute(retract(recovering_mutex)), 
        execute(change_failure_status(ID, resolved))
        ], %usar aqui timers faz com que não funcione devidamente
    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_y_sensor_broken_out_failure, RecoveryPlan).

find_recovery_plan(ID, z_sensor_broken_up, Plan):-
    %immediate action
    assert(stop_z),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [
        wait_until(not(recovering_mutex)), 
        execute( assert(recovering_mutex)),
        move_z_down, 
        wait_until(z_between(_,_,_)), 
        wait_until(z_is_at(_)), 
        stop_z,
        execute(retract(recovering_mutex)), 
        execute(change_failure_status(ID, resolved))
        ], %usar aqui timers faz com que não funcione devidamente
    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_z_sensor_broken_up_failure, RecoveryPlan).

find_recovery_plan(ID, z_sensor_broken_down, Plan):-
    %immediate action
    assert(stop_z),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [
        wait_until(not(recovering_mutex)), 
        execute( assert(recovering_mutex)),
        move_z_up, 
        wait_until(z_between(_,_,_)), 
        wait_until(z_is_at(_)), 
        stop_z,
        execute(retract(recovering_mutex)), 
        execute(change_failure_status(ID, resolved))
    ], %usar aqui timers faz com que não funcione devidamente
    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_z_sensor_broken_down_failure, RecoveryPlan).

%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Beyond limits
%%%%%%%%%%%%%%%%%%%%%%%%%%

find_recovery_plan(ID,x_limit_10, Plan):-
    %immediate action
    assert(stop_x),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [
        wait_until(not(recovering_mutex)), 
        execute( assert(recovering_mutex)), 
        move_x_left, 
        wait_until(x_is_at(_)), 
        stop_x, 
        execute(retract(recovering_mutex)), 
        execute(change_failure_status(ID, resolved))
    ],
    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_x10_failure, RecoveryPlan).

find_recovery_plan(ID,x_limit_1, Plan):-
    %immediate action
    assert(stop_x),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [
        wait_until(not(recovering_mutex)), 
        execute( assert(recovering_mutex)), 
        move_x_right, 
        wait_until(x_is_at(_)), 
        stop_x, 
        execute(retract(recovering_mutex)), 
        execute(change_failure_status(ID, resolved)) 
    ],

    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_x1_failure, RecoveryPlan).

find_recovery_plan(ID, y_limit_3, Plan):-
    %immediate action
    assert(stop_y),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [
        wait_until(not(recovering_mutex)), 
        execute( assert(recovering_mutex)), 
        move_y_out, 
        wait_until(y_is_at(_)), 
        stop_y,
        execute(retract(recovering_mutex)), 
        execute(change_failure_status(ID, resolved)) 
    ],
    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_y3_failure, RecoveryPlan).

find_recovery_plan(ID, y_limit_1, Plan):-
    %immediate action
    assert(stop_y),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [
        wait_until(not(recovering_mutex)), 
        execute( assert(recovering_mutex)),
        move_y_in, 
        wait_until(y_is_at(_)), 
        stop_y,
        execute(retract(recovering_mutex)), 
        execute(change_failure_status(ID, resolved)) 
    ],
    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_y1_failure, RecoveryPlan).

find_recovery_plan(ID, z_limit_5_5, Plan):-
    %immediate action
    assert(stop_z),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [
        wait_until(not(recovering_mutex)), 
        execute( assert(recovering_mutex)),
        move_z_down, 
        wait_until(z_is_at(_)), 
        stop_z,
        execute(retract(recovering_mutex)), 
        execute(change_failure_status(ID, resolved)) 
    ],
    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_z5_5_failure, RecoveryPlan).

find_recovery_plan(ID, z_limit_1, Plan):-
    %immediate action
    assert(stop_z),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [
        wait_until(not(recovering_mutex)), 
        execute( assert(recovering_mutex)),
        move_z_up, 
        wait_until(z_is_at(_)), 
        stop_z,
        execute(retract(recovering_mutex)), 
        execute(change_failure_status(ID, resolved)) 
    ],
    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_z1_failure, RecoveryPlan).

%%%%%%%%%%
% Aula 8
%%%%%%%%%%

change_failure_status(ID, Status):-
    findall(_, (
        failure(ID, TimeStampFailure, ReferenceFailure, ExplanationFailure, Plan, _),
        retractall(failure(ID,_,_,_,_,_)),
        assert(failure(ID, TimeStampFailure, ReferenceFailure, ExplanationFailure, Plan, Status))
       ),
    _),
    findall(_, (
        alert(ID, TimeStampFailure, ReferenceFailure, ExplanationFailure, _),
        retractall(alert(ID,_,_,_,_)),
        assert(alert(ID, TimeStampFailure, ReferenceFailure, ExplanationFailure, Status))
       ),
    _).
