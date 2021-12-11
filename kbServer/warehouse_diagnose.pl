:-ensure_loaded(warehouse_error_recovery).
:-ensure_loaded(warehouse_monitoring).

%This alert maps directly to a failure, no additional info needed
%Failure not reported yet
%Create a recovery plan.
%=> Generate a failure

diagnose(alert(ID, TimeStamp, x_limit_10, Description, pending)):-
    not(failure(_ID, _TS, x_limit_10, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(x_limit_10, Plan),
    assert(failure(ID, TimeStamp, x_limit_10, Explanation, Plan, pending)).

diagnose(alert(ID, TimeStamp, x_limit_1, Description, pending)):-
    not(failure(_ID, _TS, x_limit_1, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(x_limit_1, Plan),
    assert(failure(ID, TimeStamp, x_limit_1, Explanation, Plan, pending)).

diagnose(alert(ID, TimeStamp, y_limit_3, Description, pending)):-
    not(failure(_ID, _TS, y_limit_3, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(y_limit_3, Plan),
    assert(failure(ID, TimeStamp, y_limit_3, Explanation, Plan, pending)).

diagnose(alert(ID, TimeStamp, y_limit_1, Description, pending)):-
    not(failure(_ID, _TS, y_limit_1, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(y_limit_1, Plan),
    assert(failure(ID, TimeStamp, y_limit_1, Explanation, Plan, pending)).

diagnose(alert(ID, TimeStamp, z_limit_5_5, Description, pending)):-
    not(failure(_ID, _TS, z_limit_5_5, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(z_limit_5_5, Plan),
    assert(failure(ID, TimeStamp, z_limit_5_5, Explanation, Plan, pending)).

diagnose(alert(ID, TimeStamp, z_limit_1, Description, pending)):-
    not(failure(_ID, _TS, z_limit_1, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(z_limit_1, Plan),
    assert(failure(ID, TimeStamp, z_limit_1, Explanation, Plan, pending)).
