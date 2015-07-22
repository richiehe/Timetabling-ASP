%##############################################Problem Presentation###################################
%hold(Day, Time, Course)

%---------Course-------------
course(cpp).
course(cpp_tutorial).
course(logic).
%course(os).
%---------Working day---------
day(mon).
%day(tue).
%day(wed).

%---------Working Time--------
time(9; 10; 16; 17).




%##############################################Problem Encoding#########################################
%----------------------------------------------Generating Part------------------------------------------

1 {hold(Day, Time, Course): day(Day): time(Time)} 1 :- course(Course).


%----------------------------------------------Defining Part--------------------------------------------
big_gap:-
	course(Course1),
	hold(mon, Time, _),
	hold(mon, Time - 1, _),
	not hold(mon, Time + 1, Course1),
	course(Course2),
	hold(mon, Time1, _),
	hold(mon, Time1 + 1, _),
	not hold(mon, Time1 - 1, Course2),
	Time1 - Time > 0,	
	Time1 - Time > 5.



%------------------------------------------------Testing Part-------------------------------------------
:-hold(mon, Time, cpp), Time != 9.
:-hold(mon, Time, cpp_tutorial), Time != 10.
:-hold(mon, Time, logic), Time != 16.
%:-hold(mon, Time, os), Time != 17.

:-big_gap.

%----------------------------------------------Displaying Part--------------------------------------------
#hide.
#show hold/3.
