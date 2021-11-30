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