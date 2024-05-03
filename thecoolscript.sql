CREATE DATABASE IF NOT EXISTS onlinemarket;
USE onlinemarket;
DROP TABLE IF EXISTS Questions;
DROP TABLE IF EXISTS CustomerReps;
DROP TABLE IF EXISTS Alerts;
DROP TABLE IF EXISTS Bids;
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
	userID INT AUTO_INCREMENT,
	username VARCHAR(128),
	userPassword VARCHAR(128),
  PRIMARY KEY (userID),
  UNIQUE (username, userPassword)
);

CREATE TABLE Items (
  itemID INT AUTO_INCREMENT,
  itemName VARCHAR(128),
  itemCategory VARCHAR(128),
  reservePrice DECIMAL(10, 2),
  bidIncrement DECIMAL(10, 2),
  openDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  closeDate TIMESTAMP,
  sellerID INT,
  PRIMARY KEY (itemID),
  FOREIGN KEY (sellerID) REFERENCES Users(userID)
);

CREATE TABLE Bids (
  bidID INT AUTO_INCREMENT,
  userID INT,
  itemID INT,
  bidAmount DECIMAL(10, 2),
  bidTime TIMESTAMP,
  autoBidEnabled BOOLEAN,
  maxBidLimit DECIMAL(10, 2),
  PRIMARY KEY (bidID),
  FOREIGN KEY (userID) REFERENCES Users(userID),
  FOREIGN KEY (itemID) REFERENCES Items(itemID)
);

CREATE TABLE Alerts (
  alertID INT AUTO_INCREMENT,
  userID INT,
  alertMessage VARCHAR(512),
  PRIMARY KEY (alertID),
  FOREIGN KEY (userID) REFERENCES Users(userID)
);

CREATE TABLE CustomerReps (
  customerRepID INT AUTO_INCREMENT,
  customerRepUsername VARCHAR(255),
  customerRepPassword VARCHAR(128),
  PRIMARY KEY (customerRepID)
);

CREATE TABLE Questions (
  questionID INT AUTO_INCREMENT,
  questionText VARCHAR(512),
  answerText VARCHAR(512),
  userID INT,
  customerRepID INT,
  postedOn DATETIME,
  answeredOn DATETIME,
  PRIMARY KEY (questionID),
  FOREIGN KEY (userID) REFERENCES Users(userID),
  FOREIGN KEY (customerRepID) REFERENCES CustomerReps(customerRepID)
);

INSERT INTO Users (username, userPassword) VALUES
("admin", "admin"),
("diego.damian02", "cheese"),
("steven.zamora", "password1"),
("dankiel", "temp123"),
("matteus.coste", "123456");

INSERT INTO Items (itemName, itemCategory, reservePrice, bidIncrement, closeDate, sellerID) VALUES
('Vintage Clock', 'Art', 150.00, 5.00, '2024-12-01 00:00:00', 1),
('Mountain Bike', 'Sports', 300.00, 10.00, '2024-11-01 00:00:00', 2),
('Acoustic Guitar', 'Music', 250.00, 15.00, '2024-12-15 00:00:00', 3),
('MacBook Pro', 'Electronics', 1200.00, 20.00, '2024-10-01 00:00:00', 4),
('Oil Painting', 'Art', 200.00, 10.00, '2024-12-20 00:00:00', 1),
('LED TV', 'Electronics', 500.00, 25.00, '2024-10-05 00:00:00', 2),
('Yoga Mat', 'Sports', 20.00, 2.00, '2024-10-25 00:00:00', 3),
('Leather Wallet', 'Accessories', 35.00, 3.00, '2024-11-15 00:00:00', 4),
('Bluetooth Speaker', 'Electronics', 60.00, 5.00, '2024-12-05 00:00:00', 1),
('Running Shoes', 'Sports', 100.00, 5.00, '2024-11-10 00:00:00', 2),
('Science Fiction Novel', 'Books', 15.00, 1.00, '2024-12-15 00:00:00', 3),
('Coffee Maker', 'Electronics', 80.00, 4.00, '2024-11-20 00:00:00', 4),
('Desk Lamp', 'Furniture', 45.00, 3.50, '2024-10-18 00:00:00', 1),
('Tennis Racket', 'Sports', 90.00, 6.00, '2024-12-30 00:00:00', 2),
('Electric Guitar', 'Music', 250.00, 10.00, '2024-11-05 00:00:00', 3),
('Mountain Bicycle', 'Sports', 480.00, 15.00, '2024-11-28 00:00:00', 4),
('Set of Cookware', 'Kitchen', 150.00, 7.00, '2024-12-12 00:00:00', 1),
('Android Smartphone', 'Electronics', 350.00, 20.00, '2024-11-23 00:00:00', 2),
('Wine Decanter', 'Kitchen', 45.00, 4.00, '2024-11-11 00:00:00', 3),
('Action Camera', 'Electronics', 300.00, 10.00, '2024-12-25 00:00:00', 4),
('Teddy Bear', 'Toys', 25.00, 2.00, '2024-12-25 00:00:00', 1),
('Model Car', 'Toys', 45.00, 5.00, '2024-12-20 00:00:00', 2),
('Diamond Ring', 'Jewelry', 2000.00, 50.00, '2024-12-15 00:00:00', 3),
('Gold Necklace', 'Jewelry', 1200.00, 25.00, '2024-12-10 00:00:00', 4),
('Leather Jacket', 'Clothing', 150.00, 10.00, '2024-12-05 00:00:00', 1),
('Silk Scarf', 'Clothing', 40.00, 5.00, '2024-12-01 00:00:00', 2),
('Mystery Novel', 'Books', 15.00, 1.00, '2024-11-25 00:00:00', 3),
('Science Textbook', 'Books', 60.00, 3.00, '2024-11-20 00:00:00', 4),
('Car Tires', 'Automotive', 100.00, 5.00, '2024-11-15 00:00:00', 1),
('Engine Oil', 'Automotive', 30.00, 2.00, '2024-11-10 00:00:00', 2),
('Landscape Painting', 'Art', 500.00, 20.00, '2024-11-05 00:00:00', 3),
('Sculpture', 'Art', 300.00, 15.00, '2024-10-31 00:00:00', 4),
('Blender', 'Kitchen', 70.00, 4.00, '2024-10-26 00:00:00', 1),
('Knife Set', 'Kitchen', 120.00, 5.00, '2024-10-21 00:00:00', 2),
('Dining Chair', 'Furniture', 85.00, 5.00, '2024-10-16 00:00:00', 3),
('Coffee Table', 'Furniture', 200.00, 10.00, '2024-10-11 00:00:00', 4),
('Sunglasses', 'Accessories', 50.00, 3.00, '2024-10-06 00:00:00', 1),
('Watch', 'Accessories', 250.00, 10.00, '2024-10-01 00:00:00', 2),
('Guitar', 'Music', 300.00, 15.00, '2024-09-26 00:00:00', 3),
('Drum Set', 'Music', 600.00, 20.00, '2024-09-21 00:00:00', 4),
('Chess Set', 'Toys', 30.00, 2.00, '2024-09-16 00:00:00', 1),
('Building Blocks', 'Toys', 25.00, 2.50, '2024-09-11 00:00:00', 2),
('Earrings', 'Jewelry', 400.00, 10.00, '2024-09-06 00:00:00', 3),
('Bracelet', 'Jewelry', 150.00, 5.00, '2024-09-01 00:00:00', 4),
('T-shirt', 'Clothing', 20.00, 1.00, '2024-08-27 00:00:00', 1),
('Jeans', 'Clothing', 60.00, 3.00, '2024-08-22 00:00:00', 2),
('Thriller Novel', 'Books', 18.00, 1.50, '2024-08-17 00:00:00', 3),
('Biography Book', 'Books', 35.00, 2.00, '2024-08-12 00:00:00', 4),
('Sports Car Model', 'Automotive', 300.00, 15.00, '2024-08-07 00:00:00', 1),
('Oil Filter', 'Automotive', 22.00, 2.00, '2024-08-02 00:00:00', 2),
('Abstract Art', 'Art', 800.00, 30.00, '2024-07-28 00:00:00', 3),
('Pottery Vase', 'Art', 120.00, 6.00, '2024-07-23 00:00:00', 4),
('Microwave Oven', 'Kitchen', 90.00, 4.50, '2024-07-18 00:00:00', 1),
('Toaster', 'Kitchen', 25.00, 2.00, '2024-07-13 00:00:00', 2),
('Bookshelf', 'Furniture', 100.00, 5.00, '2024-07-08 00:00:00', 3),
('Desk', 'Furniture', 150.00, 7.00, '2024-07-03 00:00:00', 4),
('Handbag', 'Accessories', 80.00, 4.00, '2024-06-28 00:00:00', 1),
('Belt', 'Accessories', 35.00, 2.00, '2024-06-23 00:00:00', 2),
('Violin', 'Music', 250.00, 10.00, '2024-06-18 00:00:00', 3),
('Flute', 'Music', 100.00, 5.00, '2024-06-13 00:00:00', 4);

INSERT INTO CustomerReps (customerRepUsername, customerRepPassword) VALUES
('customerRep1', "123"),
('customerRep2', "234"),
('customerRep3', "345");

INSERT INTO Questions (questionText, answerText, userID, customerRepID, postedOn, answeredOn) VALUES
('How do I reset my password if I forget it?', 'You can reset your password by clicking on "Forgot Password?" at the login page and following the instructions to receive a reset link.', 1, 1, '2000-07-01 09:00:00', '2024-07-01 09:15:00'),
('What are the fees associated with selling an item?', 'Our platform charges a 5% commission on the final sale price of each item sold. There are no upfront listing fees.', 2, 1, '2024-07-02 10:00:00', '2024-07-02 10:30:00'),
('Can I change my shipping address after placing an order?', 'Yes, you can change your shipping address anytime before the item is dispatched by going to your account settings.', 3, 2, '2024-07-03 11:15:00', '2024-07-03 11:45:00'),
('Is international shipping available for all items?', 'International shipping is available but limited to certain items due to legal and logistic constraints. Please check the item details page for specific shipping options.', 4, 2, '2024-07-04 12:00:00', '2024-07-04 12:25:00'),
('How can I verify the authenticity of an item before purchasing?', 'Our platform offers a verification service for select items which can be requested from the item detail page. A certificate of authenticity will be provided upon verification.', 5, 3, '2024-07-05 13:30:00', '2024-07-05 14:00:00'),
('What should I do if I receive a damaged item?', 'Please report the issue through our support center within 48 hours of receiving the item along with photo evidence, and we will guide you through the return process.', 1, 3, '2024-07-06 15:15:00', '2024-07-06 15:45:00'),
('How do I make a bid?', 'To place a bid, go to the item’s page, enter your bid amount in the bidding box, and click "Place Bid". Ensure your bid meets the minimum bid increment.', 2, 1, '2012-01-07 16:20:00', '2024-07-07 16:50:00'),
('Is there a way to retract a bid?', 'Once placed, bids are generally binding. In exceptional circumstances, you may contact customer support to discuss potential bid retraction.', 3, 2, '2024-02-08 17:35:00', '2024-07-08 18:05:00'),
('What are the options if I win an auction but cannot pay immediately?', 'If you encounter payment issues, contact us immediately. We may extend the payment deadline, but this is assessed on a case-by-case basis.', 4, 2, '2024-07-09 19:00:00', '2024-07-09 19:30:00'),
('How long do I have to return an item?', 'You have 14 days from the receipt date to return an item in its original condition. Please review our return policy for detailed instructions.', 5, 3, '2014-07-10 20:45:00', '2024-07-10 21:15:00'),
('Can I list multiple items at once?', 'Yes, sellers can list multiple items through our bulk listing tool accessible from your seller dashboard.', 1, 1, '2024-07-11 08:00:00', '2024-07-11 08:30:00'),
('How do I cancel my account?', 'To cancel your account, please contact customer support with your account details, and we will assist you with the process.', 2, 1, '2024-07-12 09:15:00', '2024-07-12 09:45:00'),
('What types of payment do you accept?', 'We accept major credit cards, PayPal, and certain cryptocurrency payments. Check the payment options on the checkout page.', 3, 2, '2024-07-13 10:30:00', '2021-07-13 11:00:00'),
('How can I contact a seller directly?', 'You can contact a seller directly via the "Contact Seller" button on the item page. Please note that all communications should adhere to our platform policies.', 4, 2, '2024-07-14 12:15:00', '2024-07-14 12:45:00'),
('What do I do if I forgot my username?', 'If you forget your username, you can retrieve it by providing the email address associated with your account through the "Forgot Username?" link on the login page.', 5, 3, '2024-07-15 13:50:00', '2024-07-15 14:20:00'),
('How do I update my payment information?', 'You can update your payment information under the "Payment Options" section in your account settings.', 1, 3, '2024-07-16 15:25:00', '2024-07-16 15:55:00'),
('Are there any discounts for new users?', 'New users receive a 10% discount on their first purchase. Register and the discount will automatically apply at checkout.', 2, 1, '2024-07-17 16:40:00', '2024-07-17 17:10:00'),
('How are shipping costs calculated?', 'Shipping costs are based on the weight, dimensions, and destination of the item. Costs are calculated at checkout.', 3, 1, '2024-07-18 18:05:00', '2024-07-18 18:35:00'),
('Can I change the reserve price of an item after listing it?', 'Once set, the reserve price cannot be changed. However, you can end the listing and relist the item with a new reserve price.', 4, 2, '2024-07-19 19:20:00', '2024-07-19 19:50:00'),
('What is the process for verifying high-value items?', 'High-value items undergo a rigorous verification process by our specialists to ensure their authenticity and condition before listing.', 5, 2, '2024-07-20 20:35:00', '2024-07-20 21:05:00'),
('How do I report a suspicious listing?', 'Please use the "Report" button on the item’s page to notify us of suspicious listings. Our team will investigate promptly.', 1, 3, '2024-07-21 21:50:00', '2024-07-21 22:20:00'),
('What happens if an item does not reach its reserve price?', 'If an item does not reach its reserve price, it will not be sold. Sellers may choose to relist the item with a lower reserve.', 2, 3, '2024-07-22 23:15:00', '2024-07-22 23:45:00'),
('Can buyers leave feedback for sellers?', 'Yes, buyers are encouraged to leave feedback for sellers after the completion of a transaction to help inform future buyers.', 3, 1, '2024-07-23 08:00:00', '2024-07-23 08:30:00'),
('Is there a buyer protection program?', 'Yes, our buyer protection program covers your purchase from checkout to delivery against fraud and misrepresentation.', 4, 1, '2024-07-24 09:45:00', '2024-07-24 10:15:00'),
('How often can I update my listing?', 'You can update your listing at any time during the auction period. Changes will reflect immediately on the site.', 5, 2, '2024-07-25 11:30:00', '2024-07-25 12:00:00'),
('Do you provide technical support for account issues?', 'Yes, our technical support team is available to assist with any account-related issues. Contact us via our support page.', 1, 2, '1999-07-26 13:15:00', '2024-07-26 13:45:00'),
('What are the rules for posting a comment on a listing?', 'Comments must be respectful and relevant to the listing. Inappropriate comments will be removed and may lead to account restrictions.', 2, 3, '2024-07-27 14:50:00', '2024-07-27 15:20:00'),
('Can I see all the items I have bid on?', 'Yes, all your bids are displayed in the "My Bids" section of your account dashboard.', 3, 3, '2024-07-28 16:25:00', '2024-07-28 16:55:00'),
('How do I unsubscribe from email notifications?', 'You can unsubscribe from emails by updating your notification settings in your account or by clicking the unsubscribe link at the bottom of our emails.', 4, 1, '2024-07-29 17:40:00', '2024-07-29 18:10:00'),
('What to do if I encounter payment issues during checkout?', 'If you encounter any payment issues during checkout, please contact our customer support immediately for assistance.', 5, 1, '2024-07-30 19:55:00', '2024-07-30 20:25:00');
