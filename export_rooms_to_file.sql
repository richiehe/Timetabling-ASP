SELECT *
FROM timetable.room
INTO OUTFILE 'C:/tmp/roominfo.txt'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n';