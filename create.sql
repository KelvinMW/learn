CREATE DATABASE shop;
CREATE TABLE customers(
    user_id INT,
    firstName VARCHAR(25),
    lastName VARCHAR(25)
    );
CREATE TABLE products(
    product_id INT,
    productName VARCHAR(25),
    productCartegory VARCHAR(20),
    productPrice INT(5)
    );

--test insert--
INSERT products(productName,productCartegory,productPrice)
VALUES (1,"fire track","Toys",12);

--new employee table--
CREATE DATABASE factory;
CREATE TABLE employee(
    employee_id INT AUTO_INCREMENT,
    firstName VARCHAR(50) NOT NULL,
    middleName VARCHAR(50),
    lastName VARCHAR(50)NOT NULL,
    current_Status VARCHAR(20) DEFAULT('not employed') NOT NULL,
    PRIMARY KEY(employee_id)
    );

CREATE DATABASE shirts_db;

CREATE TABLE shirts(
    shirt_id INT PRIMARY KEY AUTO_INCREMENT,
    article VARCHAR(50),
    color VARCHAR(50),
    shirt_size VARCHAR (5),
    last_worn INT);

INSERT shirts(
    article,color,shirt_size,last_worn
    )
VALUES
    ('t-shirt', 'white', 'S', 10),
    ('t-shirt', 'green', 'S', 200),
    ('polo shirt', 'black', 'M', 10),
    ('tank top', 'blue', 'S', 50),
    ('t-shirt', 'pink', 'S', 0),
    ('polo shirt', 'red', 'M', 5),
    ('tank top', 'white', 'S', 200),
    ('tank top', 'blue', 'M', 15);

INSERT shirts(
    article,color,shirt_size,last_worn
    )
VALUES('polo shirt','purple', 'M', 50);