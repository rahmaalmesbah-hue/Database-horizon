CREATE TYPE "rank_enum" AS ENUM (
  'prof',
  'Assistant_prof',
  'Associated_prof',
  'Lecturer'
);

CREATE TYPE "level_enum" AS ENUM (
  'undergraduate',
  'Post_graduate'
);

CREATE TYPE "type_enum" AS ENUM (
  'Lecture Hall',
  'Lab',
  'seminar room'
);

CREATE TYPE "semester_enum" AS ENUM (
  'Fall',
  'Winter',
  'Summer'
);

CREATE TYPE "status_enum" AS ENUM (
  'Enrolled',
  'Dropped',
  'Completed',
  'Failed'
);

CREATE TABLE "Campus" (
  "ID" integer PRIMARY KEY,
  "Name" varchar NOT NULL,
  "Location" varchar
);

CREATE TABLE "Department" (
  "Code" varchar PRIMARY KEY,
  "Name" varchar NOT NULL,
  "name_of_head" varchar,
  "Campus_ID" integer NOT NULL
);

CREATE TABLE "Faculty" (
  "ID" integer PRIMARY KEY,
  "Name" varchar NOT NULL
);

CREATE TABLE "Faculty_member" (
  "ID" integer PRIMARY KEY,
  "name" varchar NOT NULL,
  "Department" varchar,
  "Email" varchar,
  "Phone" varchar,
  "rank" rank_enum,
  "Date_hired" date
);

CREATE TABLE "Student" (
  "ID" integer PRIMARY KEY,
  "Name" varchar NOT NULL,
  "phone_number" varchar,
  "Email" varchar,
  "Criedthours_completed" integer,
  "Campus" integer NOT NULL,
  "Program" varchar,
  "Faculty" integer NOT NULL,
  "Department" varchar NOT NULL,
  "Academic_Advisor" integer,
  "Dateofenrollment" date
);

CREATE TABLE "Student_Campus_History" (
  "ID" integer PRIMARY KEY,
  "Student_ID" integer NOT NULL,
  "From_Campus" integer NOT NULL,
  "To_Campus" integer NOT NULL,
  "Transfer_Date" date NOT NULL
);

CREATE TABLE "Program" (
  "ID" integer PRIMARY KEY,
  "name" varchar NOT NULL,
  "Department_code" varchar NOT NULL
);

CREATE TABLE "Course" (
  "Code" varchar PRIMARY KEY,
  "title" varchar NOT NULL,
  "Credit_hours" integer NOT NULL,
  "Level" level_enum
);

CREATE TABLE "Course_Prerequisite" (
  "Course_Code" varchar NOT NULL,
  "Prerequisite_Code" varchar NOT NULL
);

CREATE TABLE "Classroom" (
  "ID" integer PRIMARY KEY,
  "name" varchar NOT NULL,
  "Type" type_enum,
  "Capacity" integer,
  "Campus_ID" integer NOT NULL
);

CREATE TABLE "Course_offering" (
  "ID" integer PRIMARY KEY,
  "Course_ID" varchar NOT NULL,
  "Campus" integer NOT NULL,
  "semester" semester_enum,
  "Classroom_ID" integer,
  "Faculty_member_ID" integer,
  "day_of_week" varchar,
  "start_time" varchar,
  "end_time" varchar
);

CREATE TABLE "Enrollment" (
  "ID" integer PRIMARY KEY,
  "Student_ID" integer NOT NULL,
  "Course_offering_ID" integer NOT NULL,
  "Status" status_enum,
  "Final_grade" varchar,
  "Grade_Date" date
);

ALTER TABLE "Department" ADD FOREIGN KEY ("Campus_ID") REFERENCES "Campus" ("ID") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Student" ADD FOREIGN KEY ("Campus") REFERENCES "Campus" ("ID") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Student" ADD FOREIGN KEY ("Faculty") REFERENCES "Faculty" ("ID") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Student" ADD FOREIGN KEY ("Department") REFERENCES "Department" ("Code") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Student" ADD FOREIGN KEY ("Academic_Advisor") REFERENCES "Faculty_member" ("ID") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Student_Campus_History" ADD FOREIGN KEY ("Student_ID") REFERENCES "Student" ("ID") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Student_Campus_History" ADD FOREIGN KEY ("From_Campus") REFERENCES "Campus" ("ID") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Student_Campus_History" ADD FOREIGN KEY ("To_Campus") REFERENCES "Campus" ("ID") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Program" ADD FOREIGN KEY ("Department_code") REFERENCES "Department" ("Code") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Course_Prerequisite" ADD FOREIGN KEY ("Course_Code") REFERENCES "Course" ("Code") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Course_Prerequisite" ADD FOREIGN KEY ("Prerequisite_Code") REFERENCES "Course" ("Code") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Classroom" ADD FOREIGN KEY ("Campus_ID") REFERENCES "Campus" ("ID") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Course_offering" ADD FOREIGN KEY ("Course_ID") REFERENCES "Course" ("Code") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Course_offering" ADD FOREIGN KEY ("Campus") REFERENCES "Campus" ("ID") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Course_offering" ADD FOREIGN KEY ("Classroom_ID") REFERENCES "Classroom" ("ID") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Course_offering" ADD FOREIGN KEY ("Faculty_member_ID") REFERENCES "Faculty_member" ("ID") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Enrollment" ADD FOREIGN KEY ("Student_ID") REFERENCES "Student" ("ID") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Enrollment" ADD FOREIGN KEY ("Course_offering_ID") REFERENCES "Course_offering" ("ID") DEFERRABLE INITIALLY IMMEDIATE;
