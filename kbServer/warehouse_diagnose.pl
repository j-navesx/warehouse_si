:-ensure_loaded(warehouse_error_recovery).
:-ensure_loaded(warehouse_monitoring).

%This alert maps directly to a failure, no additional info needed
%Failure not reported yet
%Create a recovery plan.
%=> Generate a failure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Warehouse stopped between two positions (actuator broken?)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/* diagnose(alert(ID, TimeStamp, x_actuator_alert_stopped_between, Description, pending)):-
    not(failure(_ID, _TS, x_actuator_alert_stopped_between, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(x_actuator_alert_stopped_between, Plan),
    assert(failure(ID, TimeStamp, x_actuator_alert_stopped_between, Explanation, Plan, pending)).
 */
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Position sensor broken
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

diagnose(alert(ID, TimeStamp, x_sensor_alert_right, Description, pending)):-
    not(failure(_ID, _TS, x_broken_sensor_right, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(x_broken_sensor_right, Plan),
    assert(failure(ID, TimeStamp, x_broken_sensor_right, Explanation, Plan, pending)).

diagnose(alert(ID, TimeStamp, x_sensor_alert_left, Description, pending)):-
    not(failure(_ID, _TS, x_broken_sensor_left, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(x_broken_sensor_left, Plan),
    assert(failure(ID, TimeStamp, x_broken_sensor_left, Explanation, Plan, pending)).

diagnose(alert(ID, TimeStamp, y_sensor_alert_in, Description, pending)):-
    not(failure(_ID, _TS, y_broken_sensor_in, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(y_broken_sensor_in, Plan),
    assert(failure(ID, TimeStamp, y_broken_sensor_in, Explanation, Plan, pending)).

diagnose(alert(ID, TimeStamp, y_sensor_alert_in, Description, pending)):-
    not(failure(_ID, _TS, y_broken_sensor_in, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(y_broken_sensor_in, Plan),
    assert(failure(ID, TimeStamp, y_broken_sensor_in, Explanation, Plan, pending)).

diagnose(alert(ID, TimeStamp, y_sensor_alert_out, Description, pending)):-
    not(failure(_ID, _TS, y_broken_sensor_out, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(y_broken_sensor_out, Plan),
    assert(failure(ID, TimeStamp, y_broken_sensor_out, Explanation, Plan, pending)).

diagnose(alert(ID, TimeStamp, z_sensor_alert_up, Description, pending)):-
    not(failure(_ID, _TS, z_broken_sensor_up, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(z_broken_sensor_up, Plan),
    assert(failure(ID, TimeStamp, z_broken_sensor_up, Explanation, Plan, pending)).

diagnose(alert(ID, TimeStamp, z_sensor_alert_down, Description, pending)):-
    not(failure(_ID, _TS, z_broken_sensor_down, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(z_broken_sensor_down, Plan),
    assert(failure(ID, TimeStamp, z_broken_sensor_down, Explanation, Plan, pending)).

%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Beyond limits
%%%%%%%%%%%%%%%%%%%%%%%%%%

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