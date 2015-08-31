SELECT *
FROM timetable.room
INTO OUTFILE '/home/***/tmp/roominfo.txt'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n';