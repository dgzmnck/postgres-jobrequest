CREATE DATABASE job_request;

CREATE TABLE users (
 id SERIAL PRIMARY KEY,
 username varchar(100) UNIQUE NOT NULL,
 email varchar(255) UNIQUE NOT NULL,
 password varchar(255),
 verified boolean,
 pin_challenge varchar(6),
 pin_expiration TIMESTAMP
);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    first_name varchar(255),
    last_name varchar(255),
    assignatory_name varchar(255)
)
	
CREATE TABLE offices (
    id SERIAL PRIMARY KEY,
    office_code varchar(255),
    office_name text,
    office_head INTEGER REFERENCES employees(id),
	office_head_immediate INTEGER REFERENCES employees(id)
);

ALTER TABLE employees 
ADD column office_id INTEGER REFERENCES offices(id)
	
	


CREATE TABLE office_employees (
    id SERIAL PRIMARY KEY,
    employee_id INTEGER REFERENCES employees(id),
    office_id INTEGER REFERENCES offices(id),
    is_head boolean,
    designation varchar(255) default 'Staff',
    immediate_head INTEGER REFERENCES employees(id),
    is_accepted boolean
);

CREATE TABLE requests (
    id SERIAL PRIMARY KEY,
    nature text,
    office_id INTEGER REFERENCES offices(id),
    employee_id INTEGER REFERENCES employees(id),
    date_created TIMESTAMP,
    date_received TIMESTAMP,
    date_completed TIMESTAMP,
    date_rated TIMESTAMP,
    date_archived TIMESTAMP,
    status varchar(255),
    control_number varchar(10) UNIQUE NOT NULL,
    action_taken text,
    rating int
);

CREATE TABLE assigned_personnels (
    request_id INTEGER REFERENCES requests(id),
    employee_id INTEGER REFERENCES employees(id),
    PRIMARY KEY (request_id,employee_id)
);