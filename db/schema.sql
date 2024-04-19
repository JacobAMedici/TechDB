CREATE DATABASE TechDB;

use TechDB;

CREATE TABLE IF NOT EXISTS Users (
    userID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(30) NOT NULL,
    lastName VARCHAR(30) NOT NULL,
    email VARCHAR(60) NOT NULL,
    username VARCHAR(30) NOT NULL UNIQUE,
    hash VARCHAR(255) NOT NULL
    );

CREATE TABLE IF NOT EXISTS Manufacturer (
    manufacturerID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(150),
    biography LONGTEXT,
    manufacturerName VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Switch (
    switchID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(100),
    actuationForce FLOAT,
    color VARCHAR(30),
    actuationDistance FLOAT,
    switchName VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS MakesSwitch (
    switchID INTEGER UNSIGNED,
    manufacturerID INTEGER UNSIGNED,
    PRIMARY KEY (switchID, manufacturerID),
    FOREIGN KEY (switchID) REFERENCES Switch(switchID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (manufacturerID) REFERENCES Manufacturer(manufacturerID)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Keyboard (
    KeyboardID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    backlight BOOLEAN,
    size VARCHAR(20),
    keyboardName VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS UsesSwitch (
    switchID INTEGER UNSIGNED,
    KeyboardID INTEGER UNSIGNED,
    PRIMARY KEY (switchID, KeyboardID),
    FOREIGN KEY (switchID) REFERENCES Switch(switchID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (KeyboardID) REFERENCES Keyboard(KeyboardID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS MakesKeyboard (
    manufacturerID INTEGER UNSIGNED,
    KeyboardID INTEGER UNSIGNED,
    PRIMARY KEY (KeyboardID, manufacturerID),
    FOREIGN KEY (manufacturerID) REFERENCES Manufacturer(manufacturerID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (KeyboardID) REFERENCES Keyboard(KeyboardID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS FavoriteKeyboard (
    userID INTEGER UNSIGNED,
    KeyboardID INTEGER UNSIGNED,
    PRIMARY KEY (KeyboardID, userID),
    FOREIGN KEY (userID) REFERENCES Users(userID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (KeyboardID) REFERENCES Keyboard(KeyboardID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Post (
    title VARCHAR(100) NOT NULL PRIMARY KEY,
    postDate DATETIME NOT NULL DEFAULT NOW(),
    contents LONGTEXT
);

CREATE TABLE IF NOT EXISTS UserPost (
    userID INTEGER UNSIGNED,
    title VARCHAR(100),
    PRIMARY KEY (title, userID),
    FOREIGN KEY (userID) REFERENCES Users(userID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (title) REFERENCES Post(title)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ManufacturerPost (
    manufacturerID INTEGER UNSIGNED,
    title VARCHAR(100),
    PRIMARY KEY (title, manufacturerID),
    FOREIGN KEY (manufacturerID) REFERENCES Manufacturer(manufacturerID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (title) REFERENCES Post(title)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Headphones (
    HeadphoneID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    numDrivers INTEGER,
    bluetooth BOOLEAN,
    microphone BOOLEAN,
    description LONGTEXT,
    headphoneName VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS MakesHeadphones (
    manufacturerID INTEGER UNSIGNED,
    HeadphoneID INTEGER UNSIGNED,
    PRIMARY KEY (HeadphoneID, manufacturerID),
    FOREIGN KEY (manufacturerID) REFERENCES Manufacturer(manufacturerID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (HeadphoneID) REFERENCES Headphones(HeadphoneID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS FavoritesHeadphones (
    userID INTEGER UNSIGNED,
    HeadphoneID INTEGER UNSIGNED,
    PRIMARY KEY (HeadphoneID, userID),
    FOREIGN KEY (userID) REFERENCES Users(userID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (HeadphoneID) REFERENCES Headphones(HeadphoneID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Tablet (
    tabletID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    length FLOAT,
    depth FLOAT,
    thickness FLOAT,
    horizontalResolution INTEGER,
    verticalResolution INTEGER,
    ram INTEGER,
    storage INTEGER,
    tabletName VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS MakesTablet (
    manufacturerID INTEGER UNSIGNED,
    tabletID INTEGER UNSIGNED,
    PRIMARY KEY (tabletID, manufacturerID),
    FOREIGN KEY (manufacturerID) REFERENCES Manufacturer(manufacturerID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (tabletID) REFERENCES Tablet(tabletID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS FavoriteTablet (
    userID INTEGER UNSIGNED,
    tabletID INTEGER UNSIGNED,
    PRIMARY KEY (tabletID, userID),
    FOREIGN KEY (userID) REFERENCES Users(userID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (tabletID) REFERENCES Tablet(tabletID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Phone (
    phoneID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    length FLOAT,
    depth FLOAT,
    thickness FLOAT,
    horizontalResolution INTEGER,
    verticalResolution INTEGER,
    ram INTEGER,
    storage INTEGER,
    refreshRate FLOAT,
    batteryLength FLOAT,
    weight FLOAT,
    interface VARCHAR(50),
    phoneName VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS MakesPhone (
    manufacturerID INTEGER UNSIGNED,
    phoneID INTEGER UNSIGNED,
    PRIMARY KEY (phoneID, manufacturerID),
    FOREIGN KEY (manufacturerID) REFERENCES Manufacturer(manufacturerID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (phoneID) REFERENCES Phone(phoneID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS FavoritePhone (
    userID INTEGER UNSIGNED,
    phoneID INTEGER UNSIGNED,
    PRIMARY KEY (phoneID, userID),
    FOREIGN KEY (userID) REFERENCES Users(userID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (phoneID) REFERENCES Phone(phoneID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Laptop (
    laptopID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    length FLOAT,
    depth FLOAT,
    thickness FLOAT,
    horizontalResolution INTEGER,
    verticalResolution INTEGER,
    ram INTEGER,
    storage INTEGER,
    refreshRate FLOAT,
    batterySize FLOAT,
    weight FLOAT,
    backlitKeyboard BOOLEAN,
    GPU VARCHAR(40),
    CPU VARCHAR(40),
    laptopName VARCHAR(50) NOT NULL,
    operatingSystem VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS LaptopPorts (
    laptopID INTEGER UNSIGNED,
    port VARCHAR(40) NOT NULL,
    PRIMARY KEY (laptopID, port),
    FOREIGN KEY (laptopID) REFERENCES Laptop(laptopID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS MakesLaptop (
    manufacturerID INTEGER UNSIGNED,
    laptopID INTEGER UNSIGNED,
    PRIMARY KEY (laptopID, manufacturerID),
    FOREIGN KEY (manufacturerID) REFERENCES Manufacturer(manufacturerID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (laptopID) REFERENCES Laptop(laptopID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS FavoriteLaptop (
    userID INTEGER UNSIGNED,
    laptopID INTEGER UNSIGNED,
    PRIMARY KEY (laptopID, userID),
    FOREIGN KEY (userID) REFERENCES Users(userID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (laptopID) REFERENCES Laptop(laptopID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Mouse (
    mouseID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    description LONGTEXT,
    sensorType VARCHAR(40),
    size VARCHAR(30),
    weight FLOAT,
    freeScrolling BOOLEAN,
    mouseName VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS MakesMouse (
    manufacturerID INTEGER UNSIGNED,
    mouseID INTEGER UNSIGNED,
    PRIMARY KEY (mouseID, manufacturerID),
    FOREIGN KEY (manufacturerID) REFERENCES Manufacturer(manufacturerID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (mouseID) REFERENCES Mouse(mouseID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS FavoriteMouse (
    userID INTEGER UNSIGNED,
    mouseID INTEGER UNSIGNED,
    PRIMARY KEY (mouseID, userID),
    FOREIGN KEY (userID) REFERENCES Users(userID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (mouseID) REFERENCES Mouse(mouseID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);