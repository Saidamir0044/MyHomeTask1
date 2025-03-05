--create database lesson_4
--flights
create table flights(
flight_id bigint primary key,
departing_gate varchar(20),
arriving_gate varchar(20),
created_at datetime,
updated_at datetime,
airline_id bigint,
departing_airport_id BIGINT,
arriving_airport_id BIGINT
);
--airport
create table airport(
airport_id bigint primary key,
airport_name varchar(50),
country varchar(50),
[state] varchar(50),
city varchar(50),
created_at datetime,
updated_at datetime
);
--airline
create table airline(
airline_id bigint primary key,
airline_code nvarchar(50),
airline_name nvarchar(50),
airline_country varchar(50),
created_at datetime,
updated_at datetime
);
--flight_manifest
create table flight_manifest(
flight_manifest_id bigint primary key,
created_at datetime,
updated_at datetime,
booking_id bigint,
flight_id bigint
);
--booking
create table booking(
booking_id bigint primary key,
flight_id bigint,
[status] varchar(20),
booking_platform varchar(20),
created_at datetime,
updated_at datetime,
passenger_id bigint
);
--baggage
create table baggage(
baggage_id bigint primary key,
weight_in_kg decimal(4,2),
created_at datetime,
updated_at datetime,
booking_id bigint
);
--boarding_pass
create table boarding_pass(
boarding_pass_id bigint primary key,
qr_code varchar(8000),
created_at datetime,
updated_at datetime,
booking_id bigint
);
--baggage_check
create table baggage_check(
baggage_check_id bigint primary key,
check_result varchar(50),
created_at datetime,
updated_at datetime,
booking_id bigint,
passenger_id bigint
);
--passengers
create table passengers(
passenger_id bigint primary key,
first_name VARCHAR(50),
last_name VARCHAR(50),
date_of_birth DATE,
country_of_citizenship VARCHAR(50),
country_of_residence VARCHAR(50),
passport_number VARCHAR(20),
created_at datetime,
updated_at datetime
);
--no_fly_list
create table no_fly_list(
no_fly_list_id bigint primary key,
active_from date,
active_to date,
no_fly_reason varchar(255),
created_at datetime,
updated_at datetime,
passenger_id bigint
);
--security_check
create table security_check(
security_check_id bigint primary key,
check_result varchar(20),
comments varchar(8000),
created_at datetime,
updated_at datetime,
passenger_id bigint
);

--foreign keys for flights

alter table flights
add constraint fk_airline_id foreign key (airline_id) references airline(airline_id);

alter table flights
add constraint fk_d_airport_id foreign key (departing_airport_id) references airport(airport_id);

alter table flights
add constraint fk_a_airport1_id foreign key (arriving_airport_id) references airport(airport_id);


--foreign keys for flight_manifest

alter table flight_manifest
add constraint fk_booking_id foreign key (booking_id) references booking(booking_id);

alter table flight_manifest
add constraint fk_flight1_id foreign key (flight_id) references flights(flight_id);

-- foreign key for boarding pass

alter table boarding_pass
add constraint fk_booking1_id foreign key (booking_id) references booking(booking_id);

--foreign key for baggage

alter table baggage
add constraint fk_booking2_id foreign key (booking_id) references booking(booking_id);

-- foreign key for booking

alter table booking 
add constraint fk_pass4_id foreign key (passenger_id) references passengers(passenger_id);

--foreign key for secur_check

alter table security_check
add constraint fk_pass3_id foreign key  (passenger_id) references passengers(passenger_id);

-- foreign key for bagge_check

alter table baggage_check
add constraint fk_book3_id foreign key (booking_id) references booking(booking_id);

alter table baggage_check
add constraint fk_pass2_id foreign key (passenger_id) references passengers(passenger_id);

--foreign key for nofly 

alter table no_fly_list
add constraint fk_pass1_id foreign key (passenger_id) references passengers(passenger_id);






