%##############################################Problem Presentation###################################
%---------Course-------------
course(cpp).
course(cpp_tutorial).

%---------Working day---------
day(mon).
day(tue).
day(wed).

%---------Working Time--------
time(9..10).









%##############################################Problem Encoding#########################################
%----------------------------------------------Generating Part------------------------------------------

2 {hold(Day, Time, Course): day(Day): time(Time)} 2 :- course(Course).


%----------------------------------------------Defining Part--------------------------------------------
not_patten2(Course1, Course2):-
	hold(_, Time1, Course1), 
	hold(_, Time2, Course2), 
	Time2 - Time1 != 1.

not_patten2(Course1, Course2):-
	course(Course1),
	hold(Day, Time1, Course2),
	not hold(Day, Time1 - 1, Course1).

%------------------------------------------------Testing Part-------------------------------------------
%:-hold(_, Time1, cpp), hold(_, Time2, cpp_tutorial), Time2 - Time1 != 1.
%:-hold(Day, Time1, cpp_tutorial), hold(Day, Time1 - 1, Course), Course != cpp.
%:-hold(Day, Time1, cpp_tutorial), not hold(Day, Time1 - 1, cpp).

:-not_patten2(cpp, cpp_tutorial).

%----------------------------------------------Displaying Part--------------------------------------------
#hide.
#show hold/3.
