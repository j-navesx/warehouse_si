
%This alert maps directly to a failure, no additional info needed
%Failure not reported yet
%Create a recovery plan.
%=> Generate a failure  

diagnose(alert(ID, TimeStamp, x_limit_10, Description, pending)):-
    not(failure(_ID, _TS, x_limit_10, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = "Bad operation of the warehouse.",
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(x_limit_10, Plan),
    assert(failure(ID, TimeStamp, x_limit_10, Explanation, Plan, pending)).

