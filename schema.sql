-- mysql -u root -p  < schema.sql

CREATE DATABASE IF NOT EXISTS onlinemarket;
USE onlinemarket;
DROP TABLE IF EXISTS Questions;
DROP TABLE IF EXISTS Alerts;
DROP TABLE IF EXISTS Bids;
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
  userName VARCHAR (128),
  userPassword VARCHAR (128),
  PRIMARY KEY (userName)
);

CREATE TABLE Items (
  itemID INT AUTO_INCREMENT,
  itemName VARCHAR (128),
  itemCategory VARCHAR (128),
  itemSoldBy VARCHAR (128),
  auctionReservePrice DECIMAL (10, 2),
  auctionBeganTimestamp TIMESTAMP,
  auctionCloseTimestamp TIMESTAMP,
  PRIMARY KEY (itemID),
  FOREIGN KEY (itemSoldBy) REFERENCES Users (userName)
);

CREATE TABLE Bids (
  bidID INT AUTO_INCREMENT,
  bidPlacedBy VARCHAR (128),
  bidAmount DECIMAL (10, 2),
  bidTimestamp TIMESTAMP,
  bidIsAuto BOOLEAN,
  bidAutoIncrement DECIMAL (10, 2),
  bidAutoMax DECIMAL (10, 2),
  bidPlacedOnItem INT,
  PRIMARY KEY (bidID),
  FOREIGN KEY (bidPlacedBy) REFERENCES Users (userName),
  FOREIGN KEY (bidPlacedOnItem) REFERENCES Items (itemID)
);

CREATE TABLE Alerts (
  alertID INT AUTO_INCREMENT,
  alertContent VARCHAR (256),
  alertTimestamp TIMESTAMP,
  alertSentTo VARCHAR (128),
  PRIMARY KEY (alertID),
  FOREIGN KEY (alertSentTo) REFERENCES Users (userName)
);

CREATE TABLE Questions (
  questionID INT AUTO_INCREMENT,
  questionContent VARCHAR (512),
  questionPostedBy VARCHAR (128),
  questionTimestamp TIMESTAMP,
  answerContent VARCHAR (512),
  answerPostedBy VARCHAR (128),
  answerTimestamp TIMESTAMP,
  PRIMARY KEY (questionID),
  FOREIGN KEY (questionPostedBy) REFERENCES Users (userName),
  FOREIGN KEY (answerPostedBy) REFERENCES Users (userName)
);

INSERT INTO Users (userName, userPassword)
VALUES
("admin", "password"),
("customerrep_sufiyan.gajra", "password"),
("diego.damian", "password"),
("steven.zamora", "password"),
("daniel.khrapko", "password"),
("matteus.coste", "password");

INSERT INTO Items (itemSoldBy, itemName, itemCategory, auctionReservePrice, auctionBeganTimestamp, auctionCloseTimestamp)
VALUES
('diego.damian', 'Classic Watch', 'Accessories', 180.00, '2024-04-20 15:00:00', '2024-05-20 15:00:00'),
('steven.zamora', 'Modern Art Print', 'Art', 300.00, '2024-05-15 12:00:00', '2024-06-15 12:00:00'),
('daniel.khrapko', 'Electric Guitar', 'Music', 250.00, '2024-06-30 18:00:00', '2024-07-30 18:00:00'),
('matteus.coste', 'Sports Bicycle', 'Sports', 490.00, '2024-07-22 09:00:00', '2024-08-22 09:00:00'),
('diego.damian', 'Designer Jeans', 'Clothing', 85.00, '2024-08-12 16:00:00', '2024-09-12 16:00:00'),
('steven.zamora', 'Antique Lamp', 'Furniture', 75.00, '2024-09-05 20:00:00', '2024-10-05 20:00:00'),
('daniel.khrapko', 'Leather Wallet', 'Accessories', 50.00, '2024-10-25 14:30:00', '2024-11-25 14:30:00'),
('matteus.coste', 'Adventure Novel Set', 'Books', 60.00, '2024-11-15 17:45:00', '2024-12-15 17:45:00'),
('diego.damian', 'Fitness Tracker', 'Electronics', 130.00, '2023-12-20 21:00:00', '2024-01-20 21:00:00'),
('steven.zamora', 'Pearl Earrings', 'Jewelry', 110.00, '2024-01-28 18:30:00', '2024-02-28 18:30:00'),
('daniel.khrapko', 'Camping Tent', 'Sports', 120.00, '2024-02-22 15:45:00', '2024-03-22 15:45:00'),
('matteus.coste', 'Luxury Car Model', 'Toys', 290.00, '2024-03-18 13:00:00', '2024-04-18 13:00:00'),
('diego.damian', 'Handmade Necklace', 'Jewelry', 160.00, '2024-04-29 19:00:00', '2024-05-29 19:00:00'),
('steven.zamora', 'Silk Scarf', 'Clothing', 40.00, '2024-05-21 22:00:00', '2024-06-21 22:00:00'),
('daniel.khrapko', 'Drone with Camera', 'Electronics', 350.00, '2024-06-13 16:15:00', '2024-07-13 16:15:00'),
('matteus.coste', 'Vintage Wine Set', 'Kitchen', 240.00, '2024-07-09 20:30:00', '2024-08-09 20:30:00'),
('diego.damian', 'Oil Painting Kit', 'Art', 65.00, '2024-08-05 11:00:00', '2024-09-05 11:00:00'),
('steven.zamora', 'Motorcycle Helmet', 'Automotive', 150.00, '2024-09-23 14:00:00', '2024-10-23 14:00:00'),
('daniel.khrapko', 'Designer Table', 'Furniture', 450.00, '2024-10-30 12:15:00', '2024-11-30 12:15:00'),
('matteus.coste', 'Smart Home Speaker', 'Electronics', 200.00, '2024-11-28 17:30:00', '2024-12-28 17:30:00'),
('diego.damian', 'Action Figures Set', 'Toys', 90.00, '2023-12-24 15:10:00', '2024-01-24 15:10:00'),
('steven.zamora', 'Professional Chess Set', 'Toys', 80.00, '2024-01-20 18:00:00', '2024-02-20 18:00:00'),
('daniel.khrapko', 'Racing Bike', 'Sports', 480.00, '2024-02-26 12:00:00', '2024-03-26 12:00:00'),
('matteus.coste', 'Cookware Set', 'Kitchen', 200.00, '2024-03-15 10:30:00', '2024-04-15 10:30:00'),
('diego.damian', 'Gourmet Coffee Beans', 'Kitchen', 35.00, '2024-04-08 09:45:00', '2024-05-08 09:45:00'),
('steven.zamora', 'Suede Boots', 'Clothing', 90.00, '2024-05-17 14:00:00', '2024-06-17 14:00:00'),
('daniel.khrapko', 'Sci-Fi Book Collection', 'Books', 70.00, '2024-06-11 13:00:00', '2024-07-11 13:00:00'),
('matteus.coste', 'Gaming Console', 'Electronics', 299.00, '2024-07-30 21:30:00', '2024-08-30 21:30:00'),
('diego.damian', 'Acoustic Guitar', 'Music', 150.00, '2024-08-19 16:00:00', '2024-09-19 16:00:00'),
('steven.zamora', 'Crystal Wine Glasses', 'Kitchen', 120.00, '2024-09-28 18:00:00', '2024-10-28 18:00:00'),
('daniel.khrapko', 'Yoga Mat', 'Sports', 25.00, '2024-10-16 11:30:00', '2024-11-16 11:30:00'),
('matteus.coste', 'Luxury Watch', 'Jewelry', 400.00, '2024-11-10 20:00:00', '2024-12-10 20:00:00'),
('diego.damian', 'Basketball Hoop', 'Sports', 200.00, '2024-01-22 17:00:00', '2024-02-22 17:00:00'),
('steven.zamora', 'Bluetooth Headphones', 'Electronics', 130.00, '2024-01-18 19:00:00', '2024-02-18 19:00:00'),
('daniel.khrapko', 'Vintage Chair', 'Furniture', 45.00, '2024-02-23 12:00:00', '2024-03-23 12:00:00'),
('matteus.coste', 'Wall Art', 'Art', 150.00, '2024-03-05 16:30:00', '2024-04-05 16:30:00'),
('diego.damian', 'Running Shoes', 'Sports', 75.00, '2024-04-12 14:00:00', '2024-05-12 14:00:00'),
('steven.zamora', 'Smartphone', 'Electronics', 200.00, '2024-05-15 09:30:00', '2024-06-15 09:30:00'),
('daniel.khrapko', 'Blender', 'Kitchen', 35.00, '2024-06-07 10:20:00', '2024-07-07 10:20:00'),
('matteus.coste', 'Novel Collection', 'Books', 60.00, '2024-07-30 20:00:00', '2024-08-30 20:00:00'),
('diego.damian', 'Acoustic Guitar', 'Music', 120.00, '2024-08-22 18:45:00', '2024-09-22 18:45:00'),
('steven.zamora', 'Earrings', 'Jewelry', 40.00, '2024-09-30 13:00:00', '2024-10-31 13:00:00'),
('daniel.khrapko', 'Oil Painting', 'Art', 300.00, '2024-10-20 17:00:00', '2024-11-20 17:00:00'),
('matteus.coste', 'Ceramic Vase', 'Accessories', 25.00, '2024-11-05 19:00:00', '2024-12-05 19:00:00'),
('diego.damian', 'Leather Jacket', 'Clothing', 90.00, '2023-12-01 12:00:00', '2024-01-01 12:00:00'),
('steven.zamora', 'Sports Cap', 'Sports', 15.00, '2024-01-29 11:00:00', '2024-02-29 11:00:00'),
('daniel.khrapko', 'Table Lamp', 'Furniture', 50.00, '2024-02-15 16:30:00', '2024-03-15 16:30:00'),
('matteus.coste', 'Kitchen Knives Set', 'Kitchen', 80.00, '2024-03-21 15:00:00', '2024-04-21 15:00:00'),
('diego.damian', 'Basketball', 'Sports', 30.00, '2024-04-11 21:00:00', '2024-05-11 21:00:00'),
('steven.zamora', 'Digital Camera', 'Electronics', 250.00, '2024-06-25 23:59:00', '2024-06-25 23:59:00'),
('daniel.khrapko', 'Desk Organizer', 'Accessories', 20.00, '2024-06-10 10:10:00', '2024-07-10 10:10:00'),
('matteus.coste', 'Bookshelf', 'Furniture', 150.00, '2024-07-03 14:15:00', '2024-08-03 14:15:00'),
('diego.damian', 'Yoga Mat', 'Sports', 25.00, '2024-08-27 17:45:00', '2024-09-27 17:45:00'),
('steven.zamora', 'Cycling Helmet', 'Sports', 50.00, '2024-09-10 20:20:00', '2024-10-10 20:20:00');

INSERT INTO Questions (questionPostedBy, answerPostedBy, questionContent, answerContent, questionTimestamp, answerTimestamp)
VALUES
('diego.damian', 'customerrep_sufiyan.gajra', REPEAT('Lorem ipsum dolor sit amet, consectetur adipiscing elit. ', 6), REPEAT('Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ', 4), '2024-01-01 10:00:00', '2024-01-02 12:00:00'),
('steven.zamora', 'customerrep_sufiyan.gajra', REPEAT('Quisque velit nisi, pretium ut lacinia in, elementum id enim. ', 6), REPEAT('Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. ', 4), '2024-01-03 10:00:00', '2024-01-04 12:00:00'),
('daniel.khrapko', 'customerrep_sufiyan.gajra', REPEAT('Pellentesque in ipsum id orci porta dapibus. ', 7), REPEAT('Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. ', 3), '2024-01-05 10:00:00', '2024-01-06 12:00:00'),
('matteus.coste', 'customerrep_sufiyan.gajra', REPEAT('Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. ', 5), REPEAT('Donec rutrum congue leo eget malesuada. ', 5), '2024-01-07 10:00:00', '2024-01-08 12:00:00'),
('diego.damian', 'customerrep_sufiyan.gajra', REPEAT('Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. ', 5), REPEAT('Pellentesque in ipsum id orci porta dapibus. ', 5), '2024-01-09 10:00:00', '2024-01-10 12:00:00'),
('steven.zamora', 'customerrep_sufiyan.gajra', REPEAT('Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. ', 4), REPEAT('Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. ', 4), '2024-01-11 10:00:00', '2024-01-12 12:00:00'),
('daniel.khrapko', 'customerrep_sufiyan.gajra', REPEAT('Luctus nec ullamcorper mattis, pulvinar dapibus leo. ', 6), REPEAT('Lorem ipsum dolor sit amet, consectetur adipiscing elit. ', 5), '2024-01-13 10:00:00', '2024-01-14 12:00:00'),
('matteus.coste', 'customerrep_sufiyan.gajra', REPEAT('Nulla quis lorem ut libero malesuada feugiat. ', 6), REPEAT('Sed porttitor lectus nibh. Vivamus suscipit tortor eget felis porttitor volutpat. ', 3), '2024-01-15 10:00:00', '2024-01-16 12:00:00'),
('diego.damian', 'customerrep_sufiyan.gajra', REPEAT('Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. ', 4), REPEAT('Nulla quis lorem ut libero malesuada feugiat. ', 5), '2024-01-17 10:00:00', '2024-01-18 12:00:00'),
('steven.zamora', 'customerrep_sufiyan.gajra', REPEAT('Donec sollicitudin molestie malesuada. Curabitur aliquet quam id dui posuere blandit. ', 2), REPEAT('Vivamus suscipit tortor eget felis porttitor volutpat. ', 3), '2024-01-19 10:00:00', '2024-01-20 12:00:00'),
('daniel.khrapko', 'customerrep_sufiyan.gajra', REPEAT('Quisque velit nisi, pretium ut lacinia in, elementum id enim. ', 4), REPEAT('Nulla quis lorem ut libero malesuada feugiat. ', 4), '2024-01-21 10:00:00', '2024-01-22 12:00:00'),
('matteus.coste', 'customerrep_sufiyan.gajra', REPEAT('Sed porttitor lectus nibh. Cras ultricies ligula sed magna dictum porta. ', 3), REPEAT('Luctus nec ullamcorper mattis, pulvinar dapibus leo. ', 4), '2024-01-23 10:00:00', '2024-01-24 12:00:00'),
('diego.damian', 'customerrep_sufiyan.gajra', REPEAT('Lorem ipsum dolor sit amet, consectetur adipiscing elit. ', 4), REPEAT('Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. ', 4), '2024-01-25 10:00:00', '2024-01-26 12:00:00'),
('steven.zamora', 'customerrep_sufiyan.gajra', REPEAT('Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. ', 4), REPEAT('Donec rutrum congue leo eget malesuada. ', 4), '2024-01-27 10:00:00', '2024-01-28 12:00:00'),
('daniel.khrapko', 'customerrep_sufiyan.gajra', REPEAT('Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. ', 4), REPEAT('Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. ', 4), '2024-01-29 10:00:00', '2024-01-30 12:00:00'),
('matteus.coste', 'customerrep_sufiyan.gajra', REPEAT('Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. ', 4), REPEAT('Pellentesque in ipsum id orci porta dapibus. ', 4), '2024-01-31 10:00:00', '2024-02-01 12:00:00'),
('diego.damian', 'customerrep_sufiyan.gajra', REPEAT('Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. ', 3), REPEAT('Nulla quis lorem ut libero malesuada feugiat. ', 4), '2024-02-02 10:00:00', '2024-02-03 12:00:00'),
('steven.zamora', 'customerrep_sufiyan.gajra', REPEAT('Donec sollicitudin molestie malesuada. Curabitur aliquet quam id dui posuere blandit. ', 2), REPEAT('Sed porttitor lectus nibh. Vivamus suscipit tortor eget felis porttitor volutpat. ', 2), '2024-02-04 10:00:00', '2024-02-05 12:00:00'),
('daniel.khrapko', 'customerrep_sufiyan.gajra', REPEAT('Quisque velit nisi, pretium ut lacinia in, elementum id enim. ', 3), REPEAT('Nulla quis lorem ut libero malesuada feugiat. ', 4), '2024-02-06 10:00:00', '2024-02-07 12:00:00'),
('matteus.coste', 'customerrep_sufiyan.gajra', REPEAT('Sed porttitor lectus nibh. Cras ultricies ligula sed magna dictum porta. ', 3), REPEAT('Luctus nec ullamcorper mattis, pulvinar dapibus leo. ', 3), '2024-02-08 10:00:00', '2024-02-09 12:00:00'),
('diego.damian', 'customerrep_sufiyan.gajra', REPEAT('Lorem ipsum dolor sit amet, consectetur adipiscing elit. ', 4), REPEAT('Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. ', 3), '2024-02-10 10:00:00', '2024-02-11 12:00:00');
