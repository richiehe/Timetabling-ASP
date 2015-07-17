%##############################################Problem Presentation###################################
%---------Course-------------
course(m2).
course(m2_tutorial).

course(logic).
course(logic_tutorial).

course(oo_design).
course(lab).
%---------Working day---------
day(mon).
day(tue).
day(wed).
day(thu).
day(fri).

%---------Working Time--------
time(9..17).

%---------Class Room----------
room(219).
room(202).
room(144).
room(145).
room(308).
room(311).
room(341).
room(342).


%##############################################Problem Encoding#########################################
%----------------------------------------------Generating Part------------------------------------------

12 {hold(Day, Time, Room, Course): day(Day): time(Time): room(Room)} 12 :- course(Course), Course == lab.
3 {hold(Day, Time, Room, Course): day(Day): time(Time): room(Room)} 3 :- course(Course), Course == m2.
3 {hold(Day, Time, Room, Course): day(Day): time(Time): room(Room)} 3 :- course(Course), Course == m2_tutorial.
2 {hold(Day, Time, Room, Course): day(Day): time(Time): room(Room)} 2 :- course(Course), Course == logic.
2 {hold(Day, Time, Room, Course): day(Day): time(Time): room(Room)} 2 :- course(Course), Course == logic_tutorial.
3 {hold(Day, Time, Room, Course): day(Day): time(Time): room(Room)} 3 :- course(Course), Course == oo_design.

%----------------------------------------------Defining Part--------------------------------------------
%Patten2
%mon, 9am, 145, logic 
%mon, 10am, 145, logic tutorial
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
	hold(Day, Time, _, Course1),
	hold(Day, Time, _, Course2),
	Course1 != Course2.

overlap:-
	hold(Day, Time, Location1, Course1),
	hold(Day, Time, Location2, Course2),
	Course1 == Course2,
	Location1 != Location2.

%The day does not have any courses
empty(Day):-
	day(Day),
	room(Room),
	not hold(Day, 9, Room, m2), not hold(Day, 10, Room, m2), not hold(Day, 11, Room, m2), not hold(Day, 12, Room, m2), not hold(Day, 13, Room, m2), 
	not hold(Day, 14, Room, m2),not hold(Day, 15, Room, m2), not hold(Day, 16, Room, m2), not hold(Day, 17, Room, m2), not hold(Day, 9, Room, logic),
	not hold(Day, 10, Room, logic), not hold(Day, 11, Room, logic), not hold(Day, 12, Room, logic), not hold(Day, 13, Room, logic),
	not hold(Day, 14, Room, logic), not hold(Day, 15, Room, logic), not hold(Day, 16, Room, logic), not hold(Day, 17, Room, logic),
	not hold(Day, 9, Room, oo_design),not hold(Day, 10, Room, oo_design), not hold(Day, 11, Room, oo_design), not hold(Day, 12, Room, oo_design),
	not hold(Day, 13, Room, oo_design), not hold(Day, 14, Room, oo_design), not hold(Day, 15, Room, oo_design),
	not hold(Day, 16, Room, oo_design), not hold(Day, 17, Room, oo_design).

%normal courses use lab
course_use_lab:-
	hold(_, _, 219, m2).
course_use_lab:-
	hold(_, _, 202, m2).
course_use_lab:-
	hold(_, _, 219, logic).
course_use_lab:-
	hold(_, _, 202, logic).
course_use_lab:-
	hold(_, _, 219, oo_design).
course_use_lab:-
	hold(_, _, 202, oo_design).

%Same course in the same day
same_course_same_day:-
	hold(Day, Time1, _, Course), 
	hold(Day, Time2, _, Course),
	Course != lab, 
	Time1 != Time2.

%class on wednesday afternoon
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

%OPTIMIZATION
%Smaller gap
gap(Time):-
	hold(Day, Time1, _, Course1),
	hold(Day, Time2, _, Course2),
	Course1 != Course2,
	Time = #abs(Time1 - Time2).

%Courses are at 9am
days9(Day):-
	hold(Day, 9, _, _).
%Courses are at 5pm
days17(Day):-
	hold(Day, 17, _, _).

%The number of courses in one day is smaller
number_courses_in_day(Course):-
	hold(mon, _, _, Course).

number_courses_in_day(Course):-
	hold(tue, _, _, Course).

number_courses_in_day(Course):-
	hold(wed, _, _, Course).

number_courses_in_day(Course):-
	hold(thu, _, _, Course).

number_courses_in_day(Course):-
	hold(fri, _, _, Course).


%------------------------------------------------Testing Part-------------------------------------------

%Lab should be forced to be arranged firstly.
%Monday
:- not hold(mon, 12, 219, lab).
%Tuesday
:- not hold(tue, 9, 202, lab).
:- not hold(tue, 10, 202, lab).
:- not hold(tue, 11, 202, lab).
%Wednesday
:- not hold(wed, 9, 219, lab).
:- not hold(wed, 10, 219, lab).
%Thursday
:- not hold(thu, 11, 202, lab).
:- not hold(thu, 12, 202, lab).
:- not hold(thu, 16, 202, lab).
:- not hold(thu, 17, 202, lab).
%Friday
:- not hold(fri, 11, 219, lab).
:- not hold(fri, 12, 219, lab).

:-not_patten2(m2, m2_tutorial).
:-not_patten2(logic, logic_tutorial).

%All working day should have course
%REAL SLOOOOOOOOOOOOOOOOOOOW
%:-empty(mon).
%:-empty(tue).
%:-empty(wed).
%:-empty(thu).
%:-empty(fri).

%Courses cannot be overlapped
:-overlap.

%normal courses cannot use lab room
:-course_use_lab.

%Same courses cannot be held in the same day
:-same_course_same_day.

%courses cannot be at afternoon on Wednesday
:-class_wednesday_afternoon.

%----------------------------------------------Optimization Part------------------------------------------
#minimize{gap(Time)}.
#minimize{days9(Day)}.
#minimize{days17(Day)}.
#minimize{number_courses_in_day(Course)}.

%----------------------------------------------Displaying Part--------------------------------------------
#hide.
#show hold/4.










