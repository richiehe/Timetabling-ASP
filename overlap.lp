%##############################################Problem Presentation###################################
%---------Course-------------


course(advanced_databases).
course(advanced_databases_tutorial).

course(type_systems_for_programming_languages).
course(type_systems_for_programming_languages_tutorial).

course(computer_vision).
course(computer_complex).

%---------Working day---------
day(mon).


%---------Working Time--------
time(9..11).

%---------Class Room----------
room(219).
room(202).
room(144).



%##############################################Problem Encoding#########################################
%----------------------------------------------Generating Part------------------------------------------

1 {hold(Day, Time, Room, Course): day(Day): time(Time): room(Room)} 1 :- course(Course), Course == advanced_databases.

1 {hold(Day, Time, Room, Course): day(Day): time(Time): room(Room)} 1 :- course(Course), Course == type_systems_for_programming_languages.

1 {hold(Day, Time, Room, Course): day(Day): time(Time): room(Room)} 1 :- course(Course), Course == computer_vision.

1 {hold(Day, Time, Room, Course): day(Day): time(Time): room(Room)} 1 :- course(Course), Course == computer_complex.


%----------------------------------------------Defining Part--------------------------------------------

not_patten2(Course1, Course2):-
	hold(_, Time1, Room, Course1), 
	hold(_, Time2, Room, Course2), 
	Time2 - Time1 != 1.

not_patten2(Course1, Course2):-
	course(Course1),
	hold(Day, Time1, Room, Course2),
	not hold(Day, Time1 - 1, Room, Course1).


%Courses are overlapped
overlap:-
	%1{Course1 == advanced_databases, Course1 == computer_vision, Course1 == computer_complex}1,
	%1{Course2 == advanced_databases, Course2 == computer_vision, Course2 == computer_complex}1,
	hold(Day, Time, _, Course1),
	hold(Day, Time, _, Course2),
	Course1 != type_systems_for_programming_languages,	
	Course2 != type_systems_for_programming_languages,
	Course1 != Course2.
	

	

clash_course(Course1, Course2):-
	hold(Day, Time, Room1, Course1),
	hold(Day, Time, Room2, Course2).


%------------------------------------------------Testing Part-------------------------------------------

:-overlap.

:-not clash_course(advanced_databases, type_systems_for_programming_languages).




%----------------------------------------------Displaying Part--------------------------------------------
#hide.
#show hold/4.

