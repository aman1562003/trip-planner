-- Active: 1673548856641@@127.0.0.1@3306@sql12373655
-- CREATE DATABASE sql12373655;
-- use sql12373655;
-- DROP TABLE trainreservation;
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);
CREATE TABLE city(city_name varchar(20));
-- ALTER TABLE city ADD primary key (City_name);
ALTER TABLE city ADD PRIMARY KEY (city_name);
CREATE TABLE Train(train_id int PRIMARY KEY,train_name varchar(30));
CREATE TABLE TrainDepartureTime(train_id int,source varchar(30),departure_time time,primary key(train_id,source), foreign key(train_id) references Train(train_id) );
CREATE TABLE TrainReservation(train_id int,class varchar(30),source varchar(30),destination varchar(30),departure_time time,fare int,train_status varchar(30),primary key(train_id,source,class,destination,departure_time), foreign key(train_id,source) references TrainDepartureTime(train_id,source) , foreign key (destination) references City(city_name));
CREATE TABLE TrainJourneyHours(train_id int,source varchar(30),destination varchar(30), journey_hours decimal (4,2),primary key(train_id,destination,source), foreign key (train_id,source) references TrainDepartureTime (train_id,source));
CREATE TABLE CabType(cab_type varchar(30),primary key(cab_type));
CREATE TABLE CabService(cab_service_id varchar(10),provider_name varchar(30),contact_no BIGINT,rating numeric(2,1), primary key(cab_service_id) );
CREATE TABLE CabServiceInACity(cab_service_id varchar(10),city_name varchar(20),primary key(cab_service_id,city_name),foreign key(Cab_service_id) references CabService(cab_service_id),foreign key(city_name) references City(city_name));
CREATE TABLE Cabs(cab_service_id varchar(10),city_name varchar(20),cab_type varchar(30),cost_per_day int,total_available_cabs int,primary key(cab_service_id,city_name,cab_type), foreign key(city_name) references City(city_name),foreign key(cab_type) references CabType(cab_type));
CREATE TABLE Bus(bus_id int not null,survice_provider varchar(50),is_ac char,rating float);
ALTER TABLE Bus  add primary key (Bus_id);
CREATE TABLE BusDepartureTime(bus_id int not null,source varchar(20),departure_date varchar(10),time_of_departure varchar(10),primary key(bus_id,source,departure_date),foreign key (bus_id) references Bus(Bus_id));
CREATE TABLE BusJourneyHour(bus_id int,source varchar(20),destination varchar(20),departure_date varchar(10),journey_hours int,primary key(bus_id,source,destination,departure_date),foreign key (bus_id,source,departure_date) references BusDepartureTime(bus_id,source,departure_date));
CREATE TABLE BusReservation(bus_id int,source varchar(20),destination varchar(20),departure_date varchar(10),seat_type varchar(10),cost int,total_available_seats int,primary key(bus_id,source,destination,departure_date,seat_type),foreign key (bus_id,source,departure_date) references BusDepartureTime(bus_id,source,departure_date));
CREATE TABLE MyBusReservation(bus_id int,total_seats int,primary key(bus_id),foreign key (bus_id) references BusDepartureTime(bus_id));
CREATE TABLE NearBycities( current_city varchar(20),nearby_city varchar(20),primary key (current_city,nearby_city));
-- CREATE TABLE Locality(locality_id int auto_increment not null,locality_name varchar(20),city_name varchar(20),  foreign key(city_name) references City(city_name));
-- ALTER TABLE Locality ADD PRIMARY KEY (locality_id);
CREATE TABLE Locality(locality_id CHAR(36) PRIMARY KEY,locality_name varchar(20),city_name varchar(20), foreign key(city_name) references City(city_name));
CREATE TABLE Restaurants(restaurant_name varchar(30),city_name varchar(20), locality_id CHAR(36),restaurant_type varchar(10),rating int,street_address varchar(200),avg_cost_per_person int,primary key(restaurant_name,locality_id,city_name),foreign key (locality_id) references locality(locality_id));
CREATE TABLE PlaceToVisit(place_name varchar(50),city_name varchar(20), link VARCHAR(255));
ALTER TABLE PlaceToVisit add primary key(place_name,city_name);
ALTER TABLE PlaceToVisit ADD FOREIGN KEY(city_name ) REFERENCES City(city_name);
CREATE TABLE TypeOfRoom(room_type varchar(20),max_accomdation int,primary key(room_type));
CREATE TABLE Hotel(hotel_name varchar(20),hotel_city_name varchar(20),locality_id CHAR(36), ratings numeric(2,1),street_address varchar(200), is_room_service char(20),contact_no BIGINT,primary key(hotel_name,locality_id,hotel_city_name),foreign key(locality_id) references Locality(locality_id)); 
CREATE TABLE HotelReservation(hotel_name varchar(20),locality_id CHAR(36),date_of_availability date,room_type varchar(20),total_available_rooms int,cost int,primary key(hotel_name,locality_id,date_of_availability,room_type),foreign key(hotel_name,locality_id) references Hotel(hotel_name,locality_id),foreign key (room_type) references TypeOfRoom(room_type));






Insert into city VALUES ('BANGALORE');
Insert into city VALUES ('MUMBAI');
Insert into city VALUES ('DELHI');
Insert into city VALUES ('HYDERABAD');




Insert into Locality VALUES ('560001','BANGALORE NORTH','BANGALORE');
Insert into Locality VALUES ('560002','BANGALORE CITY','BANGALORE');
Insert into Locality VALUES ('560003','Palace Guttahalli','BANGALORE');
Insert into Locality VALUES ('560004','Gandhi Nagar','BANGALORE');
Insert into Locality VALUES ('560005','Sampangi Rama','BANGALORE');
Insert into Locality VALUES ('560006','Ashok Nagar','BANGALORE');
Insert into Locality VALUES ('560007','Kalasipalya','BANGALORE');
Insert into Locality VALUES ('400708','THANE','MUMBAI');
Insert into Locality VALUES ('400002','South Mumbai','MUMBAI');
Insert into Locality VALUES ('400004','Girgaon','MUMBAI');
Insert into Locality VALUES ('400006','Malabar Hill','MUMBAI');
Insert into Locality VALUES ('110001','Parliament House','DELHI');
Insert into Locality VALUES ('110002','INDRAPRASTHA','DELHI');
Insert into Locality VALUES ('110003','C G O COMPLEX ','DELHI');


Insert into Hotel VALUES ('The Chancery','BANGALORE','560002',4,'10/6, Lavelle Road, Shanthala Nagar, Ashok Nagar, Bengaluru','y',8041188888);
Insert into Hotel VALUES ('Royal Orchid','BANGALORE','560003',4,'47, Manipal Centre, 1, Dickenson Rd, Yellappa Garden, Yellappa Chetty Layout, Sivanchetti Gardens','y',8041935566);
Insert into Hotel VALUES ('Grand Kalinga','BANGALORE','560004',5,'19 & 20, 3rd Main Rd, Gandhi Nagar, Bengaluru','y',9353076886);
Insert into Hotel VALUES ('Ramanashree','BANGALORE','560005',4,'16, Raja Ram Mohan Roy Rd, Sampangi Rama Nagara, Bengaluru','y',8041350000);
Insert into Hotel VALUES ('LoCul.Central','BANGALORE','560006',1,'46, Church St, Haridevpur, Shanthala Nagar, Ashok Nagar, Bengaluru','y',8073488380);
Insert into Hotel VALUES ('Octave Vels Grand','BANGALORE','560007',4,'125,NHK ROAD, Kalasipalya Main Rd, Bengaluru','y',8041288888);
Insert into Hotel VALUES ('Hotel Bawa Suites','MUMBAI','400002',5,'Plot No, 352, Linking Rd','y',2267397000);
Insert into Hotel VALUES ('Hotel Bawa Regency','MUMBAI','400004',5,'Plot No, 351, Linking Rd','y',2267397000);
Insert into Hotel VALUES ('Lemon tree ','MUMBAI','400006',5,'Andheri - Kurla Rd, opposite Mittal Industrial Estate','y',2267397000);


Insert into NearBycities VALUES ('BANGALORE', 'MYSORE');
Insert into NearBycities VALUES ('BANGALORE', 'TUMKUR');
Insert into NearBycities VALUES ('BANGALORE', 'ANANTAPUR');
Insert into NearBycities VALUES ('BANGALORE', 'TIRUPATI');
Insert into NearBycities VALUES ('BANGALORE', 'COIMBATORE');


Insert into NearBycities VALUES ('MUMBAI', 'Thana');
Insert into NearBycities VALUES ('MUMBAI', 'Pune');
Insert into NearBycities VALUES ('MUMBAI', 'Ahmadnagar');
Insert into NearBycities VALUES ('MUMBAI', 'Surat');
Insert into NearBycities VALUES ('MUMBAI', 'Pimpri');


Insert into NearBycities VALUES ('DELHI', 'Ghaziabad');
Insert into NearBycities VALUES ('DELHI', 'Faridabad');
Insert into NearBycities VALUES ('DELHI', 'Sonipat');
Insert into NearBycities VALUES ('DELHI', 'Rohtak');
Insert into NearBycities VALUES ('DELHI', 'Panipat');


Insert into NearBycities VALUES ('HYDERABAD', 'Warangal');
Insert into NearBycities VALUES ('HYDERABAD', 'Kurnool');
Insert into NearBycities VALUES ('HYDERABAD', 'Papikondalu');
Insert into NearBycities VALUES ('HYDERABAD', 'Bidar');
Insert into NearBycities VALUES ('HYDERABAD', 'Srisailam');



Insert into Restaurants VALUES('al-kabab','BANGALORE','560001','veg&nonveg',5,'cubbon road',500);
Insert into Restaurants VALUES('BBQ','BANGALORE','560002','veg&nonveg',5,'national college',500);
Insert into Restaurants VALUES('Tea-cafe','BANGALORE','560004','veg&nonveg',5,'palace',500);
Insert into Restaurants VALUES('resto','BANGALORE','560003','veg&nonveg',5,'uv city',500);
Insert into Restaurants VALUES('burger','BANGALORE','560002','veg&nonveg',5,'vv road',500);
Insert into Restaurants VALUES('go','BANGALORE','560005','veg&nonveg',5,'food street',500);
Insert into Restaurants VALUES('start','BANGALORE','560002','veg&nonveg',5,'lalbagh',500);


Insert into Bus VALUES(1000, 'BMTC', 'y', 4.5);
Insert into Bus VALUES(1001, 'BMTC', 'y', 4.5);
Insert into Bus VALUES(1002, 'BMTC', 'y', 4.5);
Insert into Bus VALUES(1003, 'BMTC', 'y', 4.0);
Insert into Bus VALUES(1004, 'BMTC', 'y', 4.5);
Insert into Bus VALUES(1005, 'BMTC', 'y', 4.5);
Insert into Bus VALUES(1006, 'BMTC', 'y', 4.0);
Insert into Bus VALUES(1007, 'BMTC', 'y', 4.5);
Insert into Bus VALUES(1008, 'BMTC', 'y', 4.0);
Insert into Bus VALUES(1009, 'BMTC', 'y', 3.5);
Insert into Bus VALUES(1010, 'BMTC', 'y', 5.0);



Insert into BusDepartureTime VALUES (1000, 'BANGALORE','14-05-2023','10:30 AM'); 
Insert into BusDepartureTime VALUES (1001, 'BANGALORE','14-05-2023','11:30 AM'); 
Insert into BusDepartureTime VALUES (1002, 'BANGALORE','14-05-2023','12:30 AM'); 
Insert into BusDepartureTime VALUES (1003, 'BANGALORE','14-05-2023','01:30 PM'); 
Insert into BusDepartureTime VALUES (1004, 'BANGALORE','14-05-2023','02:30 PM'); 
Insert into BusDepartureTime VALUES (1005, 'BANGALORE','14-05-2023','03:30 PM'); 
Insert into BusDepartureTime VALUES (1006, 'BANGALORE','14-05-2023','04:30 PM'); 
Insert into BusDepartureTime VALUES (1007, 'BANGALORE','14-05-2023','05:30 PM'); 
Insert into BusDepartureTime VALUES (1008, 'BANGALORE','14-05-2023','06:30 PM'); 
Insert into BusDepartureTime VALUES (1009, 'BANGALORE','14-05-2023','07:30 PM'); 
Insert into BusDepartureTime VALUES (1010, 'BANGALORE','14-05-2023','08:30 PM'); 


Insert into BusJourneyHour VALUES (1000, 'BANGALORE','MYSORE','14-05-2023',2);
Insert into BusJourneyHour VALUES (1001, 'BANGALORE','MYSORE','14-05-2023',3);
Insert into BusJourneyHour VALUES (1002, 'BANGALORE','MYSORE','14-05-2023',3);
Insert into BusJourneyHour VALUES (1003, 'BANGALORE','TUMKUR','14-05-2023',1);
Insert into BusJourneyHour VALUES (1004, 'BANGALORE','TUMKUR','14-05-2023',1);
Insert into BusJourneyHour VALUES (1005, 'BANGALORE','ANANTAPUR','14-05-2023',2);
Insert into BusJourneyHour VALUES (1006, 'BANGALORE','ANANTAPUR','14-05-2023',2);
Insert into BusJourneyHour VALUES (1007, 'BANGALORE','TIRUPATI','14-05-2023',3);
Insert into BusJourneyHour VALUES (1008, 'BANGALORE','TIRUPATI','14-05-2023',3);
Insert into BusJourneyHour VALUES (1009, 'BANGALORE','COIMBATORE','14-05-2023',4);
Insert into BusJourneyHour VALUES (1010, 'BANGALORE','COIMBATORE','14-05-2023',4);

Insert into BusReservation VALUES (1000,'BANGALORE','MYSORE','14-05-2023','SLEEPER',750,20); 
Insert into BusReservation VALUES (1001,'BANGALORE','MYSORE','14-05-2023','SLEEPER',650,20); 
Insert into BusReservation VALUES (1002,'BANGALORE','MYSORE','14-05-2023','SLEEPER',700,20); 
Insert into BusReservation VALUES (1003,'BANGALORE','TUMKUR','14-05-2023','SLEEPER',350,20); 
Insert into BusReservation VALUES (1004,'BANGALORE','TUMKUR','14-05-2023','SLEEPER',350,20);
Insert into BusReservation VALUES (1005,'BANGALORE','ANANTAPUR','14-05-2023','SLEEPER',450,20);
Insert into BusReservation VALUES (1006,'BANGALORE','ANANTAPUR','14-05-2023','SLEEPER',550,15); 
Insert into BusReservation VALUES (1007,'BANGALORE','TIRUPATI','14-05-2023','SLEEPER',850,20); 
Insert into BusReservation VALUES (1008,'BANGALORE','TIRUPATI','14-05-2023','SLEEPER',850,20); 
Insert into BusReservation VALUES (1009,'BANGALORE','COIMBATORE','14-05-2023','SLEEPER',1050,15); 
Insert into BusReservation VALUES (1010,'BANGALORE','COIMBATORE','14-05-2023','SLEEPER',950,20); 


Insert into CabType VALUES ('mini');



Insert into CabService VALUES ('4000','vashya',7898949311,4);



Insert into CabServiceInACity VALUES ('4000','BANGALORE');




Insert into Cabs VALUES ('4000','BANGALORE','mini',450,10);





Insert into users VALUES (1232, 'aman bhatt', 'bhattaman156@gmail.com', 'aman1234');


Insert into PlaceToVisit VALUES ('LALBUGH','BANGALORE','https://goo.gl/maps/b65u1aUytWdXTWJ39');
Insert into PlaceToVisit VALUES ('Bengaluru palace','BANGALORE','https://goo.gl/maps/omur6QHmwsiZ4C4aA');
Insert into PlaceToVisit VALUES ('UB City Mall','BANGALORE','https://goo.gl/maps/eNJj4Td7qreqTPaZ8');
Insert into PlaceToVisit VALUES ('Bengaluru Fort','BANGALORE','https://goo.gl/maps/mZ5UyxqqJeE2TJe88');
Insert into PlaceToVisit VALUES ('Planetarium','BANGALORE','https://goo.gl/maps/9vhTsGpq589nqsZm6');
Insert into PlaceToVisit VALUES ('Cubbon Park','BANGALORE','https://goo.gl/maps/URXSHiSXd6szCYj16');
Insert into PlaceToVisit VALUES ('ISKCON temple','BANGALORE','https://goo.gl/maps/5pmYcq8EG8G1hWpE6');
