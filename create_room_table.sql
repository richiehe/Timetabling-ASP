CREATE TABLE timetable.room
(
	name			VARCHAR(10)	NOT NULL,
    type			VARCHAR(15)	NOT NULL,
    CONSTRAINT	room_pk	PRIMARY KEY(name)
);