DROP TABLE bookings;
DROP TABLE schedules;
DROP TABLE members;
DROP TABLE gymclasses;

CREATE TABLE members (
  id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100) NOT NULL,
  premium BOOLEAN,
  telephone VARCHAR(50),
  email VARCHAR(100),
  address_line_1 VARCHAR(100),
  address_line_2 VARCHAR(100),
  town VARCHAR(100),
  district VARCHAR(100),
  post_code VARCHAR(30)
);

CREATE TABLE gymclasses (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(500)
);

CREATE TABLE schedules (
  id SERIAL8 PRIMARY KEY,
  gymclass_id INT8 REFERENCES gymclasses(id) ON DELETE CASCADE,
  start_date DATE NOT NULL DEFAULT CURRENT_DATE,
  start_time TIME NOT NULL DEFAULT CURRENT_TIME,
  duration TIME NOT NULL,
  max_attendees INT NOT NULL
);

CREATE TABLE bookings(
  id SERIAL8 PRIMARY KEY,
  member_id INT8 REFERENCES members(id) ON DELETE CASCADE,
  schedule_id INT8 REFERENCES schedules(id) ON DELETE CASCADE
);
