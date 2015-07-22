%##############################################Problem Presentation###################################
%---------Course-------------
%course(m2).
%course(m2_tutorial).
%course(logic).
%course(logic_tutorial).
%course(oo_design).
course(lab).
%---------Working day---------
day(mon).
day(tue).
day(wed).
day(thu).
day(fri).

%---------Working Time--------
time(9..17).









%##############################################Problem Encoding#########################################
%----------------------------------------------Generating Part------------------------------------------

12 {hold(Day, Time, Course): day(Day): time(Time)} 12 :- course(Course), Course == lab.


%----------------------------------------------Defining Part--------------------------------------------

%------------------------------------------------Testing Part-------------------------------------------

%Lab should be forced to be arranged firstly.
%Monday
:- not hold(mon, 12, lab).
%Tuesday
:- not hold(tue, 9, lab).
:- not hold(tue, 10, lab).
:- not hold(tue, 11, lab).
%Wednesday
:- not hold(wed, 9, lab).
:- not hold(wed, 10, lab).
%Thursday
:- not hold(thu, 11, lab).
:- not hold(thu, 12, lab).
:- not hold(thu, 16, lab).
:- not hold(thu, 17, lab).
%Friday
:- not hold(fri, 11, lab).
:- not hold(fri, 12, lab).

%----------------------------------------------Displaying Part--------------------------------------------
#hide.
#show hold/3.











