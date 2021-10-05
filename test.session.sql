-- "--@block" allows us to crete blocks that can be executed separately
-- @block
-- 
CREATE TABLE Users(
    id INT PRIMARY KEY AUTO_INCREMENT, 
    -- integer type, 
    -- constraint for data validation:
    -- column "PRIMARY KEY" that tells SQL that ID must be unique and not null
    -- AUTO_INCREMENT creates IDs automatically 1, 2, 3...
    email VARCHAR(255) NOT NULL UNIQUE, 
    -- variable character, max length 255 (8 bits)
    -- every email must be unique and not null
    bio TEXT,
    -- TEXT to store string value of unspecified size
    country VARCHAR(2)
    -- country code can be at most 2 characters
);-- 

-- @block
-- inserting data
-- order of the columns is important
INSERT INTO Users (email, bio, country)
VALUES 
    ('hello@world.com','i love strangers','US'),
    ('hola@munda.com','bar hopping','MX'),
    ('bonjour@monde.com','bazooga','FR');
-- @block
-- select the entire Users table
SELECT * FROM Users;
-- @block
-- select email and id columns from Users
-- ordered by id in ascending order
-- limit to 2 rows
SELECT email,id FROM Users
ORDER BY id ASC
LIMIT 2;
-- @block
-- only return entries where country = 'US'
-- and email starts with an h
-- od id>1
-- this method gets slow when the database grows too big
-- we need an index
SELECT id, country, email FROM Users
WHERE country = 'US'
AND email LIKE 'h%'
ORDER BY id DESC
;

-- @block
-- index is useful for retrieving data from larger datasets
-- slower write
-- needs more memory
-- creating an index names "email_index" 
-- pointed towards to Users email column
CREATE INDEX email_index ON Users (email);

--@block
-- creating our first relationship
-- because a user can have many rooms available
-- we need a one-to-many relationship between Users and Rooms
CREATE TABLE Rooms(
    -- room ID, primary key
    id INT AUTO_INCREMENT, 
    street VARCHAR(255),

    -- owner ID, foreign key
    
    owner_id INT NOT NULL,

    -- setting up the primary key by 
    -- pointing it towards the id field

    PRIMARY KEY (id),

    -- setting up the foreign key
    -- Which table and column to reference.
    -- Setting up the FOREIGN KEY constraint tells
    -- the database not to delete anything that
    -- holds data about thet relationship.
    -- Will be impossible to delete users who have
    -- an associated room at the same time - 
    -- Guaranteed to have data integrity.

    FOREIGN KEY (owner_id) REFERENCES Users(id)
);

--@block
INSERT INTO Rooms (owner_id,street)
VALUES 
    (1,'san diego sailboat'),
    (1,'nantucket cottage'),
    (1, 'Prague castle');

--@block
DROP TABLE Rooms;

--@block
SELECT * FROM Users
-- Rooms where to owner ID equals the user ID
INNER JOIN Rooms
ON rooms.owner_id = users.id;

--@block
-- All the users whether they have a room or not
SELECT * FROM Users
LEFT JOIN Rooms
ON rooms.owner_id = users.id;