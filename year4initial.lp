%##############################################Problem Presentation###################################
%---------Course-------------

%-------Half Course----------
course(concurrent_processes).
course(computing_in_space_with_openSPL).
course(medical_image_computing).
course(privacy_enhancing_techniques).


course(computing_for_optimal_decisions).
course(knowledge_representation).


%---------Working day---------
day(mon).
day(tue).
%day(wed).
%day(thu).
%day(fri).


%---------Working Time--------
time(9..12).

%---------Class Room----------
room(219).


clash(computing_for_optimal_decisions, knowledge_representation).



%##############################################Problem Encoding#########################################
%----------------------------------------------Generating Part------------------------------------------

2 {hold(Day, Time, Room, concurrent_processes): day(Day): time(Time): room(Room)} 2.

2 {hold(Day, Time, Room, computing_in_space_with_openSPL): day(Day): time(Time): room(Room)} 2.

2 {hold(Day, Time, Room, medical_image_computing): day(Day): time(Time): room(Room)} 2.

2 {hold(Day, Time, Room, privacy_enhancing_techniques): day(Day): time(Time): room(Room)} 2.

4 {hold(Day, Time, Room, computing_for_optimal_decisions): day(Day): time(Time): room(Room)} 4.

4 {hold(Day, Time, Room, knowledge_representation): day(Day): time(Time): room(Room)} 4.

%----------------------------------------------Defining Part--------------------------------------------
patten2(Course):-
	hold(Day, Time, Room, Course),
	hold(Day, Time + 1, Room, Course).


patten2_constraint:-
	hold(Day, Time, Room, Course),
	not hold(Day, Time + 1, Room, Course),
	not hold(Day, Time - 1, Room, Course).



bad_patten2(Course):-
	hold(Day, Time, Room, Course),
	not hold(Day, Time + 1, Room, Course),
	not hold(Day, Time - 1, Room, Course).


same_course_same_day:-
	hold(Day, Time, _, Course),
	hold(Day, Time1, _, Course),
	Course != machine_learning_lab,
	#abs(Time - Time1) > 1.


clash_course(Course1, Course2):-
	hold(Day, Time, Room1, Course1),
	hold(Day, Time, Room2, Course2),
	Course1 != Course2.

bad_clash(Course1, Course2):-
	clash(Course1, Course2),
	room(Room),
	hold(Day, Time, _, Course1),
	not hold(Day, Time, Room, Course2).

%clash course must be at the same time
clash_course_constraint(Course1, Course2):-
	clash_course(Course1, Course2),
	%clash(Course1, Course2),
	hold(Day, Time1, Room1, Course1),
	hold(Day, Time2, Room1, Course2),
	#abs(Time1 - Time2) > 1.

overlap_room:-
	hold(Day, Time, Room1, Course1),
	hold(Day, Time, Room2, Course2),
	Course1 == Course2,
	Room1 != Room2.

overlap:-
	hold(Day, Time, _, Course1),
	hold(Day, Time, _, Course2),
	Course1 != computing_in_space_with_openSPL,
	Course2 != computing_in_space_with_openSPL,
	Course1 != privacy_enhancing_techniques,
	Course2 != privacy_enhancing_techniques,
	Course1 != knowledge_representation,
	Course2 != knowledge_representation,
	Course1 != Course2.




class_wednesday_afternoon:-
	hold(wed, 13, _, _).
class_wednesday_afternoon:-
	hold(wed, 14, _, _).
class_wednesday_afternoon:-
	hold(wed, 15, _, _).
class_wednesday_afternoon:-
	hold(wed, 16, _, _).
class_wednesday_afternoon:-
	hold(wed, 17, _, _).

lunch_time:-
	hold(_, 13, _, _).




%----------------------------------------------Testing Part--------------------------------------------

:-bad_patten2(Course), course(Course).

%:-not patten2(concurrent_processes).
%:-not patten2(computing_in_space_with_openSPL).


:-hold(Day,Time, _, concurrent_processes), room(Room), not hold(Day,Time, Room, computing_in_space_with_openSPL).

:-hold(Day,Time, _, medical_image_computing), room(Room), not hold(Day,Time, Room, privacy_enhancing_techniques).

:-hold(Day,Time, _, computing_for_optimal_decisions), room(Room), not hold(Day,Time, Room, knowledge_representation).

%:-not clash_course(computing_for_optimal_decisions, knowledge_representation).
%:-clash_course_constraint(computing_for_optimal_decisions, knowledge_representation).


%:-same_course_same_day.

%:-class_wednesday_afternoon.

:-overlap.
%:-overlap_room.

%:-lunch_time.




%----------------------------------------------Displaying Part--------------------------------------------
#hide.
#show hold/4.
