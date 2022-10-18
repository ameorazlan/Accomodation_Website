create database courseworkfinal;

use courseworkfinal;

CREATE TABLE location (
	Loc_Name VARCHAR(50) NOT NULL,
	Loc_Postcode VARCHAR(50) NOT NULL,
	Loc_Manager VARCHAR(50) NOT NULL,
	Loc_Capacity INT(11) NOT NULL,
	Loc_Email VARCHAR(50) NOT NULL,
	PRIMARY KEY (Loc_Name)
);

CREATE TABLE location_phone (
	Loc_Name VARCHAR(50) NOT NULL,
	Loc_Phone VARCHAR(50) NOT NULL DEFAULT '',
	PRIMARY KEY (Loc_Name, Loc_Phone),
	FOREIGN KEY (Loc_Name) REFERENCES courseworkfinal.location (Loc_Name) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE room (
	room_number INT(10) UNSIGNED NOT NULL,
	room_band CHAR(50) NOT NULL DEFAULT '0',
	cost INT(11) NOT NULL,
	total_room_area DOUBLE UNSIGNED NOT NULL DEFAULT '0',
	loc_name VARCHAR(50) NOT NULL,
	PRIMARY KEY (room_number),
	FOREIGN KEY (loc_name) REFERENCES courseworkfinal.location (Loc_Name) ON UPDATE RESTRICT ON DELETE CASCADE
);

CREATE TABLE shared (
	Room_Number INT(10) UNSIGNED NOT NULL,
	Weekly_Cleanup_Day VARCHAR(50) NOT NULL,
	PRIMARY KEY (Room_Number),
	FOREIGN KEY (Room_Number) REFERENCES courseworkfinal.room (room_number) ON UPDATE RESTRICT ON DELETE RESTRICT
);


CREATE TABLE single (
	Room_number INT(10) UNSIGNED NOT NULL,
	Ensuite ENUM('T','F') NOT NULL,
	Includes_kitchen ENUM('T','F') NOT NULL,
	PRIMARY KEY (Room_number),
	FOREIGN KEY (Room_number) REFERENCES courseworkfinal.room (room_number) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE student (
	URN VARCHAR(50) NOT NULL,
	Stu_FName VARCHAR(50) NOT NULL,
	Stu_LName VARCHAR(50) NOT NULL,
	Stu_DOB DATE NOT NULL,
	Stu_Email VARCHAR(50) NOT NULL,
	Stu_Gender ENUM('M','F') NOT NULL,
	Stu_Faculty VARCHAR(50) NOT NULL,
	Loc_Name VARCHAR(50) NOT NULL,
	Room_Number INT(10) UNSIGNED NOT NULL,
	Roommate_URN VARCHAR(50) NULL DEFAULT NULL,
	PRIMARY KEY (URN),
	FOREIGN KEY (Loc_Name) REFERENCES courseworkfinal.location (Loc_Name) ON UPDATE RESTRICT ON DELETE RESTRICT,
	FOREIGN KEY (Room_Number) REFERENCES courseworkfinal.room (room_number) ON UPDATE RESTRICT ON DELETE RESTRICT,
	FOREIGN KEY (Roommate_URN) REFERENCES courseworkfinal.student (URN) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE emergency_contact (
	URN VARCHAR(50) NOT NULL,
	EC_FName VARCHAR(50) NOT NULL,
	EC_LName VARCHAR(50) NOT NULL,
	EC_Phone VARCHAR(50) NOT NULL,
	EC_Relationship VARCHAR(50) NOT NULL ,
	PRIMARY KEY (URN),
	FOREIGN KEY (URN) REFERENCES courseworkfinal.student (URN) ON UPDATE RESTRICT ON DELETE RESTRICT
);

INSERT INTO location (Loc_Name, Loc_Postcode, Loc_Manager, Loc_Capacity, Loc_Email) VALUES
('Battersea Court', 'GU2 7JQ', 'Robert Kramer', 500, 'hello@batterseacourt.com'),
('Cathedral Court', 'GU2 7AP', 'Alisha Field', 350, 'hello@cathedralcourt.com'),
('Hazel Farm', 'GU2 9PL', 'Minnie Hamilton', 300, 'frontdesk@hazelfarm.com'),
('Manor Park', 'GU2 7YW', 'Steven Kent', 2600, 'reception@manorpark.com'),
('Stag Hill Court', 'GU2 7JG', 'Faizah Hodge', 550, 'help@staghillcourt.com'),
('Surrey Court', 'GU2 7JW', 'Nick Grant', 300, 'welcome@surreycourt.com'),
('Twyford Court', 'GU2 7JP', 'August Murphy', 800, 'reception@twyfordcourt.com'),
('University Court', 'GU2 7JN', 'Zi Patel', 800, 'enquires@universitycourt.com');

INSERT INTO `location_phone` (`Loc_Name`, `Loc_Phone`) VALUES
('Battersea Court', '01483682473'),
('Cathedral Court', '01483682466'),
('Hazel Farm', '01154960543'),
('Hazel Farm', '01483682466'),
('Manor Park', '01483686993'),
('Manor Park', '02079460736'),
('Stag Hill Court', '01483400800'),
('Stag Hill Court', '07700900547'),
('Surrey Court', '01184960719'),
('Surrey Court', '01483300800'),
('Twyford Court', '01483300800'),
('University Court', '01314960863'),
('University Court', '01483683466');

INSERT INTO room (room_number, room_band, cost, total_room_area, loc_name) VALUES
(1, 'A', 72, 8.8, 'Stag Hill Court'),
(2, 'A', 75, 8.1, 'Hazel Farm'),
(3, 'B', 88, 8.4, 'Hazel Farm'),
(4, 'C', 110, 9.3, 'Cathedral Court'),
(5, 'D', 162, 13.5, 'Manor Park'),
(6, 'D', 150, 12.2, 'Twyford Court'),
(7, 'E', 194, 20, 'Manor Park'),
(8, 'F', 238, 28, 'Manor Park'),
(9, 'C', 110, 9.3, 'Battersea Court'),
(10, 'A', 72, 8.8, 'Stag Hill Court'),
(11, 'A', 72, 8.8, 'Stag Hill Court'),
(12, 'A', 72, 8.8, 'Stag Hill Court'),
(13, 'A', 72, 8.8, 'Stag Hill Court'),
(14, 'C', 110, 9.3, 'Battersea Court'),
(15, 'D', 150, 12.2, 'Twyford Court'),
(16, 'C', 110, 9.3, 'Cathedral Court');

INSERT INTO shared (Room_Number, Weekly_Cleanup_Day) VALUES
(1, 'Sunday'),
(10, 'Friday'),
(11, 'Monday'),
(12, 'Tuesday'),
(13, 'Saturday'),
(14, 'Sunday'),
(15, 'Sunday'),
(16, 'Sunday');

INSERT INTO single (Room_number, Ensuite, Includes_kitchen) VALUES
(2, 'F', 'F'),
(3, 'F', 'F'),
(4, 'F', 'F'),
(5, 'T', 'F'),
(6, 'T', 'F'),
(7, 'T', 'F'),
(8, 'T', 'T'),
(9, 'F', 'F');

INSERT INTO student (URN, Stu_FName, Stu_LName, Stu_DOB, Stu_Email, Stu_Gender, Stu_Faculty, Loc_Name, Room_Number, Roommate_URN) VALUES
('6699700', 'Mikey ', 'Cohen', '2002-08-30', 'mc56837@surrey.ac.uk', 'M', 'Faculty of Engineering and Physical Sciences', 'Stag Hill Court', 1, NULL),
('6699701', 'Darcey', 'Merritt', '2002-12-28', 'dm48762@surrey.ac.uk', 'M', 'Faculty of Health and Medical Sciences', 'Stag Hill Court', 1, NULL),
('6699702', 'Axel', 'Sullivan', '2003-06-09', 'as39759@surrey.ac.uk', 'M', 'Faculty of Engineering and Physical Sciences', 'Manor Park', 8, NULL),
('6699703', 'Grady', 'Howell', '2002-03-14', 'gh59432@surrey.ac.uk', 'M', 'Faculty of Arts and Social Sciences', 'Hazel Farm', 2, NULL),
('6699704', 'Colin', 'Holloway', '2001-02-10', 'ch08564@surrey.ac.uk', 'M', 'Faculty of Health and Medical Sciences', 'Battersea Court', 9, NULL),
('6699705', 'Danika', 'Wicks', '2003-07-05', 'dw05768@surrey.ac.uk', 'F', 'Faculty of Arts and Social Sciences', 'Stag Hill Court', 11, NULL),
('6699706', 'Marguerite', 'Levy', '2002-09-30', 'ml04758@surrey.ac.uk', 'F', 'Faculty of Engineering and Physical Sciences', 'Stag Hill Court', 11, NULL),
('6699707', 'Macy', 'Neville', '2003-08-24', 'mn05746@surrey.ac.uk', 'F', 'Faculty of Health and Medical Sciences', 'Twyford Court', 6, NULL),
('6699708', 'Aman', 'Graves', '2002-04-17', 'ag45927@surrey.ac.uk', 'F', 'Faculty of Arts and Social Sciences', 'Hazel Farm', 3, NULL),
('6699709', 'Aniyah', 'Webster', '2003-12-13', 'aw57493@surrey.ac.uk', 'F', 'Faculty of Engineering and Physical Sciences', 'Manor Park', 7, NULL);

UPDATE student
set Roommate_URN = '6699701'
where URN = '6699700';

UPDATE student
set Roommate_URN = '6699700'
where URN = '6699701';

UPDATE student
set Roommate_URN = '6699706'
where URN = '6699705';

UPDATE student
set Roommate_URN = '6699705'
where URN = '6699706';

INSERT INTO emergency_contact (URN, EC_FName, EC_LName, EC_Phone, EC_Relationship) VALUES
('6699700', 'Nola', 'Cohen', '07700900673', 'Mother'),
('6699701', 'Eugene', 'Merritt', '01180660347', 'Father'),
('6699702', 'Ella', 'Sullivan', '01415860156', 'Mother'),
('6699703', 'Atif', 'Howell', '01164960701', 'Grandfather'),
('6699704', 'Saba', 'Holloway', '01213260813', 'Mother'),
('6699705', 'Anderson', 'Wicks', '01514460712', 'Father'),
('6699706', 'Norma', 'Greenwood', '01414960603', 'Aunt'),
('6699707', 'Keeva', 'Monroe', '01154960636', 'Grandmother'),
('6699708', 'Freya', 'Graves', '01134960682', 'Mother'),
('6699709', 'Rui', 'Webster', '07394060704', 'Father');

/* Task 3.5 SELECT STATEMENT
The following query counts the amount of rooms in each location and sorts them in descending ORDER.
The query has two columns: the location name and the room count.
*/
SELECT loc_name AS 'Location Name', COUNT(room_number) AS 'Room Count' FROM room
GROUP BY loc_name
ORDER BY COUNT(room_number) DESC;

/* Task 3.6 SUBQUERY STATEMENT
The following query returns the list of student names that have a weekly cleanup day on sunday
*/
SELECT CONCAT(stu_fname, ' ', stu_lname) AS 'Student Name' FROM student
WHERE student.Room_Number IN
(SELECT shared.Room_Number FROM shared 
WHERE weekly_cleanup_day = 'Sunday');

/* Task 3.7 JOIN STATEMENT
The following query returns the list of student names who have their father listed as their emergency contact
*/
SELECT CONCAT(stu_fname, ' ', stu_lname) AS 'Student Name' FROM student
INNER JOIN emergency_contact
ON student.urn = emergency_contact.urn
WHERE emergency_contact.ec_relationship = "Father";

/* Task 3.8 COMPLICATED QUERIES */

/*The following query returns student names with their respective emergency contact number and their accomodation number through joining 3 tables together*/
SELECT CONCAT(stu_fname, ' ', stu_lname) AS 'Student Name', emergency_contact.EC_Phone AS 'Emergency Contact Phone Number', location_phone.Loc_Phone AS 'Accomodation Phone'
FROM student
INNER JOIN emergency_contact
ON student.urn = emergency_contact.urn
INNER JOIN location_phone
ON student.Loc_Name = location_phone.loc_name;

/* The following query returns each faculty's list of students' room numbers and students' emergency contact numbers by using GROUP_CONCAT*/
SELECT a.stu_faculty AS 'Faculty Name', a.room AS 'Room Numbers', b.phones AS 'Emergency Contact Phone Numbers'
FROM (SELECT student.Stu_Faculty, GROUP_CONCAT(student.Room_Number) AS 'room' FROM student GROUP BY stu_faculty) AS A
INNER JOIN (SELECT student.Stu_Faculty, GROUP_CONCAT(emergency_contact.EC_Phone) AS 'phones'
FROM student
INNER JOIN emergency_contact 
ON student.urn = emergency_contact.urn
GROUP BY stu_faculty) AS B
ON a.stu_faculty = b.stu_faculty;