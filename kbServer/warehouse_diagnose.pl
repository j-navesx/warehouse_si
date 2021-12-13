:-ensure_loaded(warehouse_error_recovery).
:-ensure_loaded(warehouse_monitoring).

%This alert maps directly to a failure, no additional info needed
%Failure not reported yet
%Create a recovery plan.
%=> Generate a failure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Warehouse stopped between two positions (actuator broken?)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

diagnose(alert(_, _, x_actuator_stopped_between, _, pending)):-
    alert(ID, TimeStamp, x_actuator_stopped_between, Description, pending),
    not(failure(_ID, _TS, x_actuator_stopped_between, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(ID, x_actuator_stopped_between, Plan),
    assert(failure(ID, TimeStamp, x_actuator_stopped_between, Explanation, Plan, pending)).

diagnose(alert(_, _, y_actuator_stopped_between, _, pending)):-
    alert(ID, TimeStamp, y_actuator_stopped_between, Description, pending),
    not(failure(_ID, _TS, y_actuator_stopped_between, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(ID, y_actuator_stopped_between, Plan),
    assert(failure(ID, TimeStamp, y_actuator_stopped_between, Explanation, Plan, pending)).

diagnose(alert(_, _, z_actuator_stopped_between, _, pending)):-
    alert(ID, TimeStamp, z_actuator_stopped_between, Description, pending),
    not(failure(_ID, _TS, z_actuator_stopped_between, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(ID, z_actuator_stopped_between, Plan),
    assert(failure(ID, TimeStamp, z_actuator_stopped_between, Explanation, Plan, pending)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Position sensor broken
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

diagnose(alert(_, _, x_sensor_broken_right, _, pending)):-
    alert(ID, TimeStamp, x_sensor_broken_right, Description, pending),
    not(failure(_ID, _TS, x_sensor_broken_right, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(ID, x_sensor_broken_right, Plan),
    assert(failure(ID, TimeStamp, x_sensor_broken_right, Explanation, Plan, pending)).

diagnose(alert(_, _, x_sensor_broken_left, _, pending)):-
    alert(ID, TimeStamp, x_sensor_broken_left, Description, pending),
    not(failure(_ID, _TS, x_sensor_broken_left, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(ID, x_sensor_broken_left, Plan),
    assert(failure(ID, TimeStamp, x_sensor_broken_left, Explanation, Plan, pending)).

/* diagnose(alert(ID, TimeStamp, y_sensor_alert_in, Description, pending)):-
    not(failure(_ID, _TS, y_broken_sensor_in, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(y_broken_sensor_in, Plan),
    assert(failure(ID, TimeStamp, y_broken_sensor_in, Explanation, Plan, pending)). */

diagnose(alert(_, _, y_sensor_broken_in, _, pending)):-
    alert(ID, TimeStamp, y_sensor_broken_in, Description, pending),
    not(failure(_ID, _TS, y_sensor_broken_in, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(ID, y_sensor_broken_in, Plan),
    assert(failure(ID, TimeStamp, y_sensor_broken_in, Explanation, Plan, pending)).

diagnose(alert(_, _, y_sensor_broken_out, _, pending)):-
    alert(ID, TimeStamp, y_sensor_broken_out, Description, pending),
    not(failure(_ID, _TS, y_sensor_broken_out, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(ID, y_sensor_broken_out, Plan),
    assert(failure(ID, TimeStamp, y_sensor_broken_out, Explanation, Plan, pending)).

diagnose(alert(_, _, z_sensor_broken_up, _, pending)):-
    alert(ID, TimeStamp, z_sensor_broken_up, Description, pending),
    not(failure(_ID, _TS, z_sensor_broken_up, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(ID, z_sensor_broken_up, Plan),
    assert(failure(ID, TimeStamp, z_sensor_broken_up, Explanation, Plan, pending)).

diagnose(alert(_, _, z_sensor_broken_down, _, pending)):-
    alert(ID, TimeStamp, z_sensor_broken_down, Description, pending),
    not(failure(_ID, _TS, z_sensor_broken_down, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(ID, z_sensor_broken_down, Plan),
    assert(failure(ID, TimeStamp, z_sensor_broken_down, Explanation, Plan, pending)).

%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Beyond limits
%%%%%%%%%%%%%%%%%%%%%%%%%%

diagnose(alert(_, _, x_limit_10, _, pending)):-
    alert(ID, TimeStamp, x_limit_10, Description, pending),
    not(failure(_ID, _TS, x_limit_10, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(ID,x_limit_10, Plan),
    assert(failure(ID, TimeStamp, x_limit_10, Explanation, Plan, pending)).

diagnose(alert(_, _, x_limit_1, _, pending)):-
    alert(ID, TimeStamp, x_limit_1, Description, pending),
    not(failure(_ID, _TS, x_limit_1, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(ID,x_limit_1, Plan),
    assert(failure(ID, TimeStamp, x_limit_1, Explanation, Plan, pending)).

diagnose(alert(_, _, y_limit_3, _, pending)):-
    alert(ID, TimeStamp, y_limit_3, Description, pending),
    not(failure(_ID, _TS, y_limit_3, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(ID, y_limit_3, Plan),
    assert(failure(ID, TimeStamp, y_limit_3, Explanation, Plan, pending)).

diagnose(alert(_, _, y_limit_1, _, pending)):-
    alert(ID, TimeStamp, y_limit_1, Description, pending),
    not(failure(_ID, _TS, y_limit_1, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(ID, y_limit_1, Plan),
    assert(failure(ID, TimeStamp, y_limit_1, Explanation, Plan, pending)).

diagnose(alert(_, _, z_limit_5_5, _, pending)):-
    alert(ID, TimeStamp, z_limit_5_5, Description, pending),
    not(failure(_ID, _TS, z_limit_5_5, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(ID, z_limit_5_5, Plan),
    assert(failure(ID, TimeStamp, z_limit_5_5, Explanation, Plan, pending)).

diagnose(alert(_, _, z_limit_1, _, pending)):-
    alert(ID, TimeStamp, z_limit_1, Description, pending),   
    not(failure(_ID, _TS, z_limit_1, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(ID, z_limit_1, Plan),
    assert(failure(ID, TimeStamp, z_limit_1, Explanation, Plan, pending)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Piece not in left station sensor when receiving it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

diagnose(alert(_, _, part_left_station_failure, _, pending)):-
    alert(ID, TimeStamp, part_left_station_failure, Description, pending),   
    not(failure(_ID, _TS, part_left_station_failure, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(ID, part_left_station_failure, Plan),
    assert(failure(ID, TimeStamp, part_left_station_failure, Explanation, Plan, pending)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Piece not detected in cage sensor when receiving it from left station
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/* diagnose(alert(_, _, part_in_cage_after_receive_failure, _, pending)):-
    alert(ID, TimeStamp, part_in_cage_after_receive_failure, Description, pending),   
    not(failure(_ID, _TS, part_in_cage_after_receive_failure, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(ID, part_in_cage_after_receive_failure, Plan),
    assert(failure(ID, TimeStamp, part_in_cage_after_receive_failure, Explanation, Plan, pending)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part not detected in cage sensor after removing it from cell
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

diagnose(alert(_, _, part_in_cage_after_removing_cell_failure, _, pending)):-
    alert(ID, TimeStamp, part_in_cage_after_removing_cell_failure, Description, pending),   
    not(failure(_ID, _TS, part_in_cage_after_removing_cell_failure, _Explanation, _Plan, pending)), %o stor tinha explantion, acho que foi gralha
    %just for illustration, could be other causes:
    DetailedDescription = 'Bad operation of the warehouse.',
    atom_concat(Description, DetailedDescription, Explanation),
    find_recovery_plan(ID, part_in_cage_after_removing_cell_failure, Plan),
    assert(failure(ID, TimeStamp, part_in_cage_after_removing_cell_failure, Explanation, Plan, pending)). */