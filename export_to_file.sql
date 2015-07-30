SELECT *
FROM timetable.course
INTO OUTFILE 'C:/tmp/course.txt'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n';