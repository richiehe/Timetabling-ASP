CREATE TABLE timetable.course
(
	code			VARCHAR(6)	NOT NULL,
    name			VARCHAR(20)	NOT NULL,
    hour			VARCHAR(3)	NOT NULL,
    class			VARCHAR(5)	NOT NULL,
    for_specialism	VARCHAR(10)	NOT NULL,
    number_students	VARCHAR(10)	NOT NULL,
    lectures		VARCHAR(30)	NOT NULL,
    CONSTRAINT	course_pk	PRIMARY KEY(name)
);