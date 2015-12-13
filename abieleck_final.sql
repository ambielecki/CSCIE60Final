-- ******************************************************
--  abieeck_final.sql
--
-- Loader for Final Project Database
--
-- Description:	This script contains the DDL to load
--              the tables of the
--              my final project
--
-- Student:  Andrew Bielecki
--
-- Date:   December, 2015
--
-- ******************************************************

-- ******************************************************
--    SPOOL SESSION
-- ******************************************************

SET ECHO ON;
spool abieleck_final.lst

-- ******************************************************
--    DROP TABLES AND VIEWS
-- Note:  Issue the appropiate commands to drop tables
-- ******************************************************

DROP table tbPrimary purge;
DROP table tbEmergency purge;
DROP table tbPlayerAssignment purge;
DROP table tbGameRole purge;
DROP table tbGame purge;
DROP table tbCoachRole purge;
DROP table tbCori purge;
DROP table tbLocation purge;
DROP table tbTeam purge;
DROP table tbAdult purge;
DROP table tbPlayer purge;
DROP table tbLogin purge;

-- ******************************************************
--    CREATE TABLES
-- ******************************************************

CREATE table tbLogin (
  uname         varchar2(20)        not null,
  pwd           varchar2(20)        not null, 
  fname         varchar2(35)        not null,
  lname         varchar2(35)        not null, 
  userview      varchar2(10)        not null, 
  CONSTRAINT pk_login PRIMARY KEY (uname)
);

CREATE table tbPlayer (
  playerid NUMBER GENERATED AS IDENTITY,
  lastName      varchar2(35)        not null,
  firstName     varchar2(35)        not null,
  dob           date                not null,
  sex           char(1)             not null,
  CONSTRAINT pk_player PRIMARY KEY (playerid), 
  CONSTRAINT sex_player CHECK (UPPER(sex)='M' or UPPER(sex)='F') 
);

CREATE table tbAdult (
  adultid NUMBER GENERATED AS IDENTITY,
  lastName      varchar2(35)        not null,
  firstName     varchar2(35)        not null,
  address       varchar2(255)       null,
  phone         varchar2(20)        not null,
  email         varchar2(255)       null,
  CONSTRAINT pk_adult PRIMARY KEY (adultid)
);

CREATE table tbTeam (
  teamid NUMBER GENERATED AS IDENTITY,
  teamName      varchar2(35)        not null,
  division      varchar2(10)        not null,
  status        varchar2(10)        not null,
  CONSTRAINT pk_team PRIMARY KEY (teamid)
);

CREATE table tbLocation (
  locationid NUMBER GENERATED AS IDENTITY,
  fieldName     varchar2(35)        not null,
  address       varchar2(255)       not null,
  CONSTRAINT pk_location PRIMARY KEY (locationid)
);

CREATE table tbCori (
  corinum NUMBER GENERATED AS IDENTITY,
  adultid       number              not null,
  year          number(4,0)         not null,
  constraint pk_cori PRIMARY KEY (corinum),
  CONSTRAINT fk_cori_adultid FOREIGN KEY (adultid)
    REFERENCES tbAdult(adultid)
);

CREATE table tbCoachRole (
  roleid NUMBER GENERATED AS IDENTITY,
  adultid       number              not null,
  teamid        number              not null,
  role          varchar2(20)        not null,
  year          number(4,0)         not null,
  constraint pk_role PRIMARY KEY (roleid),
  constraint fk_role_adultid FOREIGN KEY (adultid) REFERENCES tbAdult(adultid),
  constraint fk_role_teamid FOREIGN KEY (teamid) REFERENCES tbTeam(teamid)
);

CREATE table tbGame (
  gameid NUMBER GENERATED AS IDENTITY,
  locationid    number              not null,
  gameDate      date                not null,
  gameTime      varchar2(10)        not null,
  constraint pk_game PRIMARY KEY (gameid),
  constraint fk_game_field FOREIGN KEY (locationid) REFERENCES tbLocation(locationid)
);

CREATE table tbGameRole (
  gameid        number              not null,
  role          varchar2(4)         not null,
  teamid        number              not null,
  runs          number(2,0)         null,
  constraint pk_gamerole PRIMARY KEY (gameid, role),
  constraint fk_gamerole_gameid FOREIGN KEY (gameid) REFERENCES tbGame(gameid),
  constraint fk_gamerole_team FOREIGN KEY (teamid) REFERENCES tbTeam(teamid)
);


-- Allowing null on teamid to also use this as registration
CREATE table tbPlayerAssignment (
  assignid NUMBER GENERATED AS IDENTITY,
  playerid      number              not null,
  teamid        number              null,
  year          number(4,0)         not null,
  constraint pk_assignment PRIMARY KEY (assignid),
  constraint fk_assignment_player FOREIGN KEY (playerid)
    REFERENCES tbPlayer(playerid),
  constraint fk_assignment_team FOREIGN KEY (teamid) REFERENCES tbTeam(teamid)
);

CREATE table tbPrimary (
  adultid       number              not null,
  playerid      number              not null,
  relationship  varchar2(25)        not null,
  constraint pk_primary PRIMARY KEY (adultid, playerid),
  constraint fk_primary_adultid FOREIGN KEY (adultid) REFERENCES tbAdult(adultid),
  constraint fk_primary_playerid FOREIGN KEY (playerid) REFERENCES tbPlayer(playerid)
);

CREATE table tbEmergency (
  playerid      number              not null,
  adultid       number              not null,
  constraint pk_emergency PRIMARY KEY (playerid, adultid),
  constraint fk_emergency_adultid FOREIGN KEY (adultid) REFERENCES tbAdult(adultid),
  constraint fk_emergency_playerid FOREIGN KEY (playerid) REFERENCES tbPlayer(playerid)
);

INSERT INTO tbLogin (uname, pwd, fname, lname, userview) 
  VALUES ('user', '60user', 'Guest', 'User', 'all');

INSERT INTO tbLogin (uname, pwd, fname, lname, userview) 
  VALUES ('ambielecki', 'foobarfizzbuzz', 'Andrew', 'Bieleck', 'all');

INSERT INTO tbPlayer (lastName, firstName, dob, sex)
  VALUES ('Bielecki', 'Nathan', to_date('02-16-2011','mm-dd-yyyy'), 'M');

INSERT INTO tbPlayer (lastName, firstName, dob, sex)
  VALUES ('Santillo', 'Isaac', to_date('11-15-2010','mm-dd-yyyy'), 'M');

INSERT INTO tbPlayer (lastName, firstName, dob, sex)
  VALUES ('Smith', 'Carter', to_date('10-31-2010','mm-dd-yyyy'), 'M');

INSERT INTO tbPlayer (lastName, firstName, dob, sex)
  VALUES ('Carew', 'Hendrick', to_date('02-16-2010','mm-dd-yyyy'), 'M');

INSERT INTO tbAdult (lastName, firstName, address, phone, email)
  VALUES ('Bielecki', 'Andrew', '5 Island Hill Ave, Malden, MA 02148', '555-555-5555', 'a@b.c');

INSERT INTO tbAdult (lastName, firstName, address, phone, email)
  VALUES ('Santillo', 'Chris', '5 Underhill, Malden, MA 02148', '555-555-5556', 'b@b.c');

INSERT INTO tbAdult (lastName, firstName, address, phone, email)
  VALUES ('Bielecki', 'Gillian', '5 Island Hill Ave, Malden, MA 02148', '555-555-5557', 'c@b.c');

INSERT INTO tbAdult (lastName, firstName, address, phone, email)
  VALUES ('Smith', 'Michael', '5 OverHill Ave, Malden, MA 02148', '555-555-5558', 'd@b.c');

INSERT INTO tbAdult (lastName, firstName, address, phone, email)
  VALUES ('Carew', 'Dan', '5 PasttheHill Ave, Malden, MA 02148', '555-555-5559', 'e@b.c');

INSERT INTO tbAdult (lastName, firstName, address, phone, email)
  VALUES ('Delaney', 'Robert', '5 WayFarPast Ave, Malden, MA 02148', '555-555-5560', 'f@b.c');

INSERT INTO tbTeam (teamName, division, status)
  VALUES ('SeaDogs', 'Tball', 'active');

INSERT INTO tbTeam (teamName, division, status)
  VALUES ('MuckDogs', 'Tball', 'active');

INSERT INTO tbTeam (teamName, division, status)
  VALUES ('IronPigs', 'Tball', 'active');

INSERT INTO tbTeam (teamName, division, status)
  VALUES ('Mudhens', 'Tball', 'active');

INSERT INTO tbTeam (teamName, division, status)
  VALUES ('Knights', 'Tball', 'inactive');

INSERT INTO tbLocation (fieldName, address)
  VALUES ('Trafton Field', 'Trafton Ave, Malden, MA');

INSERT INTO tbLocation (fieldName, address)
  VALUES ('Bruce Field', 'Bruce Ave, Malden, MA');

INSERT INTO tbLocation (fieldName, address)
  VALUES ('Linden Field', 'Linden Ave, Malden, MA');

INSERT INTO tbLocation (fieldName, address)
  VALUES ('Kierstead Field', 'Kierstead Ave, Malden, MA');

INSERT INTO tbCori (adultid, year)
  VALUES (1, '2015');

INSERT INTO tbCori (adultid, year)
  VALUES (2, '2015');

INSERT INTO tbCori (adultid, year)
  VALUES (3, '2015');

INSERT INTO tbCori (adultid, year)
  VALUES (4, '2015');

INSERT INTO tbCori (adultid, year)
  VALUES (5, '2015');

INSERT INTO tbCori (adultid, year)
  VALUES (1, '2016');

INSERT INTO tbCori (adultid, year)
  VALUES (2, '2016');

INSERT INTO tbCori (adultid, year)
  VALUES (3, '2016');

INSERT INTO tbCori (adultid, year)
  VALUES (6, '2016'); 

INSERT INTO tbCoachRole (adultid, teamid, role, year)
  VALUES (1, 1, 'manager', '2016');

INSERT INTO tbCoachRole (adultid, teamid, role, year)
  VALUES (2, 1, 'assistant', '2016');

INSERT INTO tbCoachRole (adultid, teamid, role, year)
  VALUES (3, 4, 'manager', '2015');

INSERT INTO tbCoachRole (adultid, teamid, role, year)
  VALUES (5, 3, 'manager', '2016');

INSERT INTO tbGame (locationid, gameDate, gameTime)
  VALUES (1, to_date('04-16-2015','mm-dd-yyyy'), '7PM');

INSERT INTO tbGame (locationid, gameDate, gameTime)
  VALUES (2, to_date('04-16-2015','mm-dd-yyyy'), '7PM');

INSERT INTO tbGame (locationid, gameDate, gameTime)
  VALUES (3, to_date('04-18-2015','mm-dd-yyyy'), '7PM');

INSERT INTO tbGameRole (gameid, role, teamid, runs)
  VALUES (1, 'home', 1, 7);

INSERT INTO tbGameRole (gameid, role, teamid, runs)
  VALUES (1, 'away', 2, 4);

INSERT INTO tbGameRole (gameid, role, teamid)
  VALUES (2, 'home', 3);

INSERT INTO tbGameRole (gameid, role, teamid)
  VALUES (2, 'away', 4);

INSERT INTO tbPlayerAssignment (playerid, teamid, year)
  VALUES (1, 1, '2015');

INSERT INTO tbPlayerAssignment (playerid, teamid, year)
  VALUES (2, 1, '2015');

INSERT INTO tbPlayerAssignment (playerid, teamid, year)
  VALUES (3, 1, '2015');

INSERT INTO tbPlayerAssignment (playerid, teamid, year)
  VALUES (4, 1, '2015');

INSERT INTO tbPlayerAssignment (playerid, year)
  VALUES (1, '2016');

INSERT INTO tbPlayerAssignment (playerid, year)
  VALUES (2, '2016');

INSERT INTO tbPrimary (adultid, playerid, relationship)
  VALUES (1,1,'father');

INSERT INTO tbPrimary (adultid, playerid, relationship)
  VALUES (2,2,'father');

INSERT INTO tbEmergency (adultid, playerid)
  VALUES (3,1);

COMMIT;
-- ******************************************************
--    VIEW TABLES
-- ******************************************************

SELECT * from tbPlayer;
SELECT * from tbAdult;
SELECT * from tbTeam;
SELECT * from tbLocation;
SELECT * from tbCori;
SELECT * from tbCoachRole;
SELECT * from tbGame;
SELECT * from tbGameRole;
SELECT * from tbPlayerAssignment;
SELECT * from tbEmergency;
SELECT * from tbPrimary;
SELECT * from tbLogin;

spool off
