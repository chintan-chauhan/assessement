create database ola;

use ola;

create table users (
user_id int auto_increment primary key,
name varchar(100) not null,
email varchar(100) unique not null,
phone varchar(12) unique not null,
password varchar(35) not null,
role enum('rider', 'driver') not null,
created_at timestamp default current_timestamp
);

create table vehicles (
vehicle_id int auto_increment primary key,
driver_id int not null,
vehicle_nuumber varchar(20) unique not null,
vehicle_model varchar(50) not null,
vehicle_type enum('sedan','suv','hatchback','bike') not null,
foreign key (driver_id) references Users(user_id) 
);

create table rides (
ride_id int auto_increment primary key,
rider_id int not null,
driver_id int not null,
pickup_location varchar(125) not null,
drop_location varchar(125) not null,
ride_status enum('pending', 'ongoing' , 'completed', 'cancelled') default 'pending',
fare decimal(10.2),
ride_date timestamp default current_timestamp,
foreign key (rider_id) references users(user_id),
foreign key (driver_id) references Users(user_id)
);

create table locations (
location_id int auto_increment primary key,
user_id int not null,
location_name varchar(125) not null,
foreign key (user_id) references Users(user_id) 
);

create table payments (
payment_id int auto_increment primary key,
ride_id int not null,
amount decimal(10,2) not null,
payment_method enum('cash', 'card', 'upi') not null, 
payment_status enum('success', 'failed', 'pending') default 'pending',
payment_date timestamp default current_timestamp,
foreign key (ride_id) references Rides(ride_id)
);

insert into Users(name, email, phone, password, role)
values ('vevek', 'vevek32@gmail.com','9865746165','vevek@123', 'rider'),
('rajat', 'rajat98@outlook.com','9865432864', 'rajat@321', 'driver'),
('dhruv', 'lordoreo@gmail.com', '7801865465', 'Lordoreo1', 'driver'),
('dhruvin', 'dhruvin89@gmail.com', '8320383560', 'dhruvin98', 'rider'),
('chintan', 'chintan50@gmail.com', '9104998836', 'chintan987', 'rider');

insert into vehicles (driver_id, vehicle_number, vehicle_model, vehicle_type)
values (2, 'GJ18AB1234', 'toyota camry', 'sedan'),
(3, 'GJ27DC1684', 'maruti sizuki swift', 'hatchback');

insert into rides (rider_id, driver_id, pickup_location, drop_location, fare)
values 
(1, 2, 'maninagar', 'bhopal', 300.00),
(4, 3, 'memco', 'arvind mill', 189.00);

update rides set ride_status = 'completed' , fare = 300.00 where rider_id = 1;

select sum(fare) as total_revenue from rides where driver_id = 2 and ride_status = 'completed';

insert into locations (user_id, location_name)
values (1, 'maninagar');

insert into payments (ride_id, amount, payment_method, payment_status, payment_date)
values (1, 300.00, 'cash', 'success', now());



