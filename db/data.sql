use TechDB;

INSERT INTO Users (firstname, lastname, email, username, hash)
VALUES ('Jacob', 'Medici', 'jacobmedici@gmail.com', 'JacobMedici', '!HAhjksa!@#1230alj!@#HJl'),
    ('Alec', 'Borer', 'alecborer@gmail.com', 'AlecBorer', '!)*(@JKlsao1930salk!@4320'),
    ('Owen ', 'Marshal', 'omarsh@gmail.com', 'OMarsh123', 'ahskjdfhk!@(&*17923981'),
    ('Eleanor  ', 'Dean', 'EloBello93@yahoo.com', 'EDean', '12390-9-1230ALKSJasdfD'),
    ('Sarah', 'Johnson', 'sarahhhhhjson@aol.com', 'SaJson', '!@*)(#012123JHKSDAKJFsdf'),
    ('Michael', 'Anderson', 'Mike.Anderson@kdp.org', 'MikeA', 'asdf!@#123asdfARF'),
    ('Mike ', 'Loung', 'milkymikey@cookies.com', 'CookieMike', 'adslfla!&@)*#09ahlksdf123'),
    ('Emily  ', 'Rodriguez', 'emifelli@jadslf.gov', 'EmmaBemma', 'ljkdfjlkfds!@30sdaljk!)@#098');

INSERT INTO Manufacturer (address, biography, manufacturerName)
VALUES ('1 Apple Park Way, Cupertino, CA 95014', 'Apple Bio', 'Apple'),
    ('13809 Research Blvd, Suite 500 PMB 93206, Austin, Texas 78750', 'Glorious Gaming Bio', 'Glorious Gaming'),
    ('Huion Science and Technology Park, Keji 1st Road, Bao''an District, Shenzhen, China.', 'Huion Bio', 'Huion'),
    ('1, Samsung-ro, Giheung-gu, Yongin-si, Gyeonggi-do 17113, Korea', 'Samsung Bio', 'Samsung'),
    ('1 Dell Way, Round Rock, Texas United States', 'Dell Bio', 'Dell'),
    ('15613F-3, No. 508, Sec. 7, Zhongxiao E. Rd., Nangang Dist., Taipei City 115011, Taiwan (R.O.C.)', 'Ducky Bio', 'Ducky'),
    ('Cherrystrasse 2 91275 Auerbach/OPf. Germany', 'Cherry Bio', 'Cherry'),
    ('1221 Commerce Drive. Stow, Ohio 44224', 'Audio Technica Bio', 'Audio Technica'),
    ('Havneholmen 8, DK-2450 Copenhagen SV, Denmark', 'Steelseries Bio', 'Steelseries');

INSERT INTO Keyboard (backlight, size, keyboardName)
VALUES (true, '60%', 'Ducky One-Two Mini'),
       (true, 'tkl', 'Apex Pro TKL'),
       (false, '100%', 'Dell Multimedia Keyboard-KB216');

INSERT INTO Switch (description, actuationForce, color, actuationDistance, switchName)
VALUES ('Linear', 2, 'Red', 2, 'CherryMX Red'),
       ('Tactile', 2, 'Brown', 2, 'CherryMX Brown'),
       ('Clicky', 2, 'Blue', 2, 'CherryMX Blue'),
        ('Linear', 2, 'White', 0.2, 'OmniPoint 2.0 Adjustable HyperMagnetic');

INSERT INTO Laptop (length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, refreshRate, batterySize, weight, backlitKeyboard, GPU, CPU, laptopName, operatingSystem)
VALUES  (344, 230, 18, 3456, 2160, 16, 1024, 60, 86, 1.86, true, 'RTX 4070', 'i9-13900H', 'Dell XPS 15', 'Windows 11'),
        (280, 214, 6.4, 2388, 1668, 8, 1024, 120, 41, 0.685, false, 'implicit', 'Apple M2', 'iPad Pro 12.9 Inch', 'Apple iOS'),
        (356, 248, 17, 3456, 2234, 32, 1024, 120, 100, 2.16, true, 'implicit', 'Apple M3 Max', 'Macbook Pro 2024 16in', 'MacOS');

INSERT INTO Headphones(numDrivers, bluetooth, microphone, description, headphoneName)
VALUES (8, true, false, 'Comfortable, padded, and open-backed headphones.', 'Expensive headphones'),
(1, false, true, 'Affordable option suited for gaming and home listening.', 'Cheap headphones'),
(3, true, true, 'A strong option at a reasonable price point. Good value.', 'Mid-range headphones');


INSERT INTO Tablet(length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, tabletName)
VALUES (280, 216, 6, 2400, 1080, 16, 512, 'Paper sized'),
      (346, 195, 10, 3840, 2160, 16, 1000, 'Studio drawing tablet'),
      (280, 214, 6, 2388, 1668, 32, 512, 'Iphone');


INSERT INTO Mouse(description, sensorType, size, weight, freeScrolling, mouseName)
VALUES ('Comfortable, ergonomic mouse fit for the office.', 'Optical', '4.72 x 3.11 x 3.09 inches',
       130.408, false, 'Logitech MX Vertical Wireless Mouse'),
      ('High-end gaming mouse to last a lifetime.', 'Optical', '4.47 x 2.38 x 1.47 inches',
       98.65634, false, 'Tt eSPORTS Ventus R'),
   ('Lightweight and ergonomic wired mouse.', 'Optical', '4.72 x 2.48 x 0.04 inches', 69, false,
    'Model O- (Minus) Compact Wired Gaming Mouse');


INSERT INTO Phone(length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, refreshRate,
                 batteryLength, weight, interface, phoneName)
VALUES (149.6, 71.45, 8.25, 1179, 2556, 6, 1000, 60, 16, 171, 'USB-C', 'Iphone 15'),
      (146.3, 70.9, 7.6, 2340, 1080, 8, 512, 120, 10, 168.1127, 'USB-C', 'Samsung Galaxy s23'),
      (146.7, 71.5, 7.65, 2532, 1170, 4, 128, 60, 17, 174, 'Lighting connector', 'Iphone 13');


INSERT INTO Post(title, contents)
VALUES ('Cheap headphones cord breaks', 'I bought the cheap headphones 2 weeks ago. They were working great until
last night when the cord snapped out of nowhere.'),
   ('Tt Ventus R review', 'I bought the Tt Ventus R mouse in order to review them on my YouTube channel.
It arrived 3 days ago and I cannot believe I am saying it but it is worth the money.'),
   ('Looking for new phone', 'I am in the market for a new phone to replace my Iphone 10.
Does anyone have any good information on some of the newer editions?');

INSERT INTO LaptopPorts (laptopID, port)
    VALUES (1, 'USB-C'), (1, 'Dell Charger'), (1, 'USB-A'), (1, 'HDMI');

INSERT INTO MakesKeyboard (manufacturerID, KeyboardID)
    VALUES (6, 1), (9, 2), (5, 3);

INSERT INTO MakesHeadphones (manufacturerID, HeadphoneID)
    VALUES (5,1), (1, 2), (6, 3);

INSERT INTO MakesLaptop (manufacturerID, laptopID)
    VALUES (5,1), (1, 2), (6, 3);

INSERT INTO MakesMouse (manufacturerID, mouseID)
    VALUES (5,1), (1, 2), (6, 3);

INSERT INTO MakesPhone (manufacturerID, phoneID)
    VALUES (5,1), (1, 2), (6, 3);

INSERT INTO MakesSwitch (switchID, manufacturerID)
    VALUES (1,5), (2, 1), (3, 6);

INSERT INTO MakesTablet (manufacturerID, tabletID)
    VALUES (5,1), (1, 2), (6, 3);

INSERT INTO UserPost (userID, title)
    VALUES (1, 'Cheap headphones cord breaks'), (2, 'Tt Ventus R review');

INSERT INTO ManufacturerPost (manufacturerID, title)
    VALUES (3, 'Looking for new phone');

INSERT INTO FavoriteKeyboard(userID, KeyboardID)
VALUES (3, 1), (4, 2), (5, 3);

INSERT INTO FavoriteLaptop(userID, laptopID)
VALUES (3, 1), (4, 2), (5, 3);

INSERT INTO FavoriteMouse(userID, mouseID)
VALUES (3, 1), (4, 2), (5, 3);

INSERT INTO FavoritePhone(userID, phoneID)
VALUES (3, 1), (4, 2), (5, 3);

INSERT INTO FavoriteTablet(userID, tabletID)
VALUES (3, 1), (4, 2), (5, 3);

INSERT INTO FavoritesHeadphones(userID, HeadphoneID)
VALUES (3, 1), (4, 2), (5, 3);