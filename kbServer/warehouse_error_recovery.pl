:-ensure_loaded(warehouse_error_recovery).
:-ensure_loaded(warehouse_monitoring).

%Apply immediate action to immobilize the axis
%Create plan with recovery actions
%Grab all running plans in a list
%Stop all the running plans as subplans (we could delete/forget them instead) 
%Create a recovery plan composed by recovery  actions and subplans.
%=> Generate a failure  

%example of pre_determined recovery plan
find_recovery_plan(x_limit_10, Plan):-
    %immediate action
    assert(stop_x),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [move_x_left, wait_until(x_is_at(_)), stop_x],
    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_x10_failure, RecoveryPlan).

find_recovery_plan(x_limit_1, Plan):-
    %immediate action
    assert(stop_x),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [move_x_right, wait_until(x_is_at(_)), stop_x],
    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_x1_failure, RecoveryPlan).

find_recovery_plan(y_limit_3, Plan):-
    %immediate action
    assert(stop_y),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [move_y_out, wait_until(y_is_at(_)), stop_y],
    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_y3_failure, RecoveryPlan).

find_recovery_plan(y_limit_1, Plan):-
    %immediate action
    assert(stop_y),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [move_y_in, wait_until(y_is_at(_)), stop_y],
    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_y1_failure, RecoveryPlan).

find_recovery_plan(z_limit_5_5, Plan):-
    %immediate action
    assert(stop_z),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [move_z_down, wait_until(z_is_at(_)), stop_z],
    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_z5_5_failure, RecoveryPlan).

find_recovery_plan(z_limit_1, Plan):-
    %immediate action
    assert(stop_z),

    findall(subplan(Ref, List), plan(Ref, List), ListOfAllPlans),
    retractall(plan(_, _)), %suspend all running plans
    RecoveryActions = [move_z_up, wait_until(z_is_at(_)), stop_z],
    append(RecoveryActions, ListOfAllPlans, RecoveryPlan),
    Plan = plan(recover_z1_failure, RecoveryPlan).