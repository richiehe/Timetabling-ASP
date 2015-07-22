%##############################################Problem Presentation###################################
%---------Course-------------

%-------Half Course----------
course(concurrent_processes, half, small).
course(computing_in_space_with_openSPL, half, small).

%course(medical_image_computing, half, small).
%course(privacy_enhancing_techniques, half, small).
%course(separation_logic, half, small).
%course(modal_logic, half, small).

%course(imperial_horizons_courses, half, large).




%-------Full Course----------
%course(computing_for_optimal_decisions, full, small).
%course(knowledge_representation, full, small).

%course(advanced_issues_in_object_oriented_programming, full, large).
%course(complexity, full, large).
%course(software_reliability, full, large).
%course(computational_neurodynamics, full, small).
%course(machine_learning_and_neural_computation, full, medium).


%---------Working day---------
day(mon).
day(tue).
%day(wed).
%day(thu).
%day(fri).


%---------Working Time--------
time(9..10).

%---------Class Room----------
room(144, medium).
room(145, medium).
%room(308, large).
%room(311, large).
%room(341, small).
%room(342, small).




%clash(computing_for_optimal_decisions, knowledge_representation).



%##############################################Problem Encoding#########################################
%----------------------------------------------Generating Part------------------------------------------


%2 {hold(Day, Time, Room, Course): day(Day): time(Time): room(Room, _)} 2:- course(Course, half, _).

2 {hold(Day, Time, Room, Course): day(Day): time(Time): room(Room, _)} 2:- course(Course, half, _).


%----------------------------------------------Defining Part--------------------------------------------

bad_patten2(Course):-
	hold(Day, Time, Room, Course),
	not hold(Day, Time + 1, Room, Course),
	not hold(Day, Time - 1, Room, Course).



%clash_course(Course1, Course2):-
%	hold(Day, Time, Room1, Course1),
%	hold(Day, Time, Room2, Course2),
%	Course1 != Course2.

%bad_clash(Course1, Course2):-
%	clash(Course1, Course2),
%	room(Room),
%	hold(Day, Time, _, Course1),
%	not hold(Day, Time, Room, Course2).

%clash course must be at the same time
%clash_course_constraint(Course1, Course2):-
%	clash_course(Course1, Course2),
	%clash(Course1, Course2),
%	hold(Day, Time1, Room1, Course1),
%	hold(Day, Time2, Room1, Course2),
%	#abs(Time1 - Time2) > 1.





%----------------------------------------------Testing Part--------------------------------------------

:-course(Course, _, _), bad_patten2(Course).




%:-hold(Day, Time, Room, concurrent_processes), hold(Day1, Time1, Room1, computing_in_space_with_openSPL), Day != Day1.
%:-hold(Day, Time, Room, concurrent_processes), hold(Day, Time, Room1, computing_in_space_with_openSPL).

:-hold(Day, Time, _, concurrent_processes), not hold(Day, Time, 144, computing_in_space_with_openSPL), not hold(Day, Time, 145, computing_in_space_with_openSPL).

:-hold(Day, Time, Room, Course1), hold(Day, Time, Room, Course2), Course1 != Course2.


%----------------------------------------------Displaying Part--------------------------------------------
#hide.
#show hold/4.

