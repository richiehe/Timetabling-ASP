%##############################################Problem Presentation###################################
%---------Course-------------
course(cpp).
course(cpp_tutorial).

%---------Working day---------
day(mon).
day(tue).
%day(wed).

%---------Working Time--------
time(9..10).




%##############################################Problem Encoding#########################################
%----------------------------------------------Generating Part------------------------------------------

1 {hold(Day, Time, Course): day(Day): time(Time)} 1 :- course(Course).


%----------------------------------------------Defining Part--------------------------------------------
empty(Day):-
	day(Day),
	not hold(Day, 9, cpp), 
	not hold(Day, 10, cpp), 
	not hold(Day, 9, cpp_tutorial), 
	not hold(Day, 10, cpp_tutorial).	

%------------------------------------------------Testing Part-------------------------------------------
%Method1
%:-not hold(mon, 9, cpp), not hold(mon, 10, cpp), not hold(mon, 9, cpp_tutorial), not hold(mon, 10, cpp_tutorial).
%:-not hold(tue, 9, cpp), not hold(tue, 10, cpp), not hold(tue, 9, cpp_tutorial), not hold(tue, 10, cpp_tutorial).

:-empty(mon).
:-empty(tue).


%Method2
%not_empty:-hold(mon, Time, Course), 1{Time == 9, Time == 10}1, 1{Course == cpp, Course == cpp_tutorial}1.
%not_empty:-hold(tue, Time, Course), 1{Time == 9, Time == 10}1, 1{Course == cpp, Course == cpp_tutorial}1.
%:- not not_empty.





%----------------------------------------------Displaying Part--------------------------------------------
#hide.
#show hold/3.
