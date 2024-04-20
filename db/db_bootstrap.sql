-- This file is to bootstrap a database for the CS3200 project. 

-- Create a new database.  You can change the name later.  You'll
-- need this name in the FLASK API file(s),  the AppSmith 
-- data source creation.
create database TechDB;

-- Via the Docker Compose file, a special user called webapp will 
-- be created in MySQL. We are going to grant that user 
-- all privilages to the new database we just created. 
-- TODO: If you changed the name of the database above, you need 
-- to change it here too.
grant all privileges on TechDB.* to 'webapp'@'%';
flush privileges;

-- Move into the database we just created.
-- TODO: If you changed the name of the database above, you need to
-- change it here too. 
use TechDB;

-- DDL
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

-- Data
INSERT INTO Users (firstname, lastname, email, username, hash)
VALUES ('Jacob', 'Medici', 'jacobmedici@gmail.com', 'JacobMedici', '!HAhjksa!@#1230alj!@#HJl'),
('Alec', 'Borer', 'alecborer@gmail.com', 'AlecBorer', '!)*(@JKlsao1930salk!@4320'),
('Owen ', 'Marshal', 'omarsh@gmail.com', 'OMarsh123', 'ahskjdfhk!@(&*17923981'),
('Eleanor  ', 'Dean', 'EloBello93@yahoo.com', 'EDean', '12390-9-1230ALKSJasdfD'),
('Sarah', 'Johnson', 'sarahhhhhjson@aol.com', 'SaJson', '!@*)(#012123JHKSDAKJFsdf'),
('Michael', 'Anderson', 'Mike.Anderson@kdp.org', 'MikeA', 'asdf!@#123asdfARF'),
('Mike ', 'Loung', 'milkymikey@cookies.com', 'CookieMike', 'adslfla!&@)*#09ahlksdf123'),
('Emily  ', 'Rodriguez', 'emifelli@jadslf.gov', 'EmmaBemma', 'ljkdfjlkfds!@30sdaljk!)@#098'),
('Breanne', 'Elies', 'belies0@examiner.com', 'belies0'),
('Melantha', 'Yokley', 'myokley1@github.com', 'myokley1'),
('Noby', 'Peert', 'npeert2@drupal.org', 'npeert2'),
('Cameron', 'Warstall', 'cwarstall3@webs.com', 'cwarstall3'),
('Konstantin', 'Corkan', 'kcorkan4@theglobeandmail.com', 'kcorkan4'),
('Tish', 'Plampin', 'tplampin5@bing.com', 'tplampin5'),
('Jourdan', 'Geldeford', 'jgeldeford6@europa.eu', 'jgeldeford6'),
('Rockey', 'Conachie', 'rconachie7@un.org', 'rconachie7'),
('Aldin', 'Norledge', 'anorledge8@over-blog.com', 'anorledge8'),
('Coralie', 'Higounet', 'chigounet9@home.pl', 'chigounet9'),
('Averyl', 'Blinkhorn', 'ablinkhorna@pcworld.com', 'ablinkhorna'),
('Marjie', 'Grishmanov', 'mgrishmanovb@goo.ne.jp', 'mgrishmanovb'),
('Dasya', 'Bagniuk', 'dbagniukc@joomla.org', 'dbagniukc'),
('Patti', 'Cudbird', 'pcudbirdd@si.edu', 'pcudbirdd'),
('Marne', 'Cardero', 'mcarderoe@studiopress.com', 'mcarderoe'),
('Oswald', 'Banke', 'obankef@yelp.com', 'obankef'),
('Rozalin', 'M''Chirrie', 'rmchirrieg@archive.org', 'rmchirrieg'),
('Octavius', 'Fryd', 'ofrydh@mlb.com', 'ofrydh'),
('Deidre', 'Kensit', 'dkensiti@4shared.com', 'dkensiti'),
('Hyacintha', 'Ebertz', 'hebertzj@fema.gov', 'hebertzj'),
('Aubrette', 'Warbeys', 'awarbeysk@nature.com', 'awarbeysk'),
('Chiarra', 'Lugard', 'clugardl@biglobe.ne.jp', 'clugardl'),
('Maura', 'Sames', 'msamesm@oakley.com', 'msamesm'),
('Saundra', 'Picot', 'spicotn@livejournal.com', 'spicotn'),
('Tera', 'O''Sheils', 'tosheilso@tamu.edu', 'tosheilso'),
('Obediah', 'Drohan', 'odrohanp@stumbleupon.com', 'odrohanp'),
('Erika', 'Fruen', 'efruenq@yale.edu', 'efruenq'),
('Jacquie', 'Sysland', 'jsyslandr@geocities.jp', 'jsyslandr'),
('Chev', 'Trank', 'ctranks@virginia.edu', 'ctranks'),
('Starlin', 'Wigley', 'swigleyt@wunderground.com', 'swigleyt'),
('Adore', 'Sweetsur', 'asweetsuru@bandcamp.com', 'asweetsuru'),
('Ethelda', 'Cozby', 'ecozbyv@washington.edu', 'ecozbyv'),
('Emerson', 'Colly', 'ecollyw@amazon.de', 'ecollyw'),
('Percy', 'Clancy', 'pclancyx@odnoklassniki.ru', 'pclancyx'),
('Philip', 'Ferbrache', 'pferbrachey@aol.com', 'pferbrachey'),
('Susie', 'Finby', 'sfinbyz@theglobeandmail.com', 'sfinbyz'),
('Jeremiah', 'Currell', 'jcurrell10@soup.io', 'jcurrell10'),
('Samson', 'Mansion', 'smansion11@arstechnica.com', 'smansion11'),
('Shay', 'Terbeck', 'sterbeck12@a8.net', 'sterbeck12'),
('Nikoletta', 'Wilmut', 'nwilmut13@creativecommons.org', 'nwilmut13'),
('Godiva', 'Fidoe', 'gfidoe14@github.io', 'gfidoe14'),
('Carmine', 'Simmonett', 'csimmonett15@tinyurl.com', 'csimmonett15'),
('Eldon', 'Dearman', 'edearman16@123-reg.co.uk', 'edearman16'),
('Ailbert', 'Trippett', 'atrippett17@wsj.com', 'atrippett17'),
('Bernhard', 'Eckley', 'beckley18@seattletimes.com', 'beckley18'),
('Danyette', 'Glede', 'dglede19@hibu.com', 'dglede19'),
('Bondie', 'Titman', 'btitman1a@blogtalkradio.com', 'btitman1a'),
('Hildegaard', 'Hayle', 'hhayle1b@earthlink.net', 'hhayle1b'),
('Gayle', 'Beckers', 'gbeckers1c@nba.com', 'gbeckers1c'),
('Lambert', 'Satcher', 'lsatcher1d@columbia.edu', 'lsatcher1d'),
('Carlye', 'Finnes', 'cfinnes1e@vk.com', 'cfinnes1e'),
('Philippa', 'Scotchmur', 'pscotchmur1f@cdc.gov', 'pscotchmur1f'),
('Waldemar', 'Lindenstrauss', 'wlindenstrauss1g@princeton.edu', 'wlindenstrauss1g'),
('Immanuel', 'Alred', 'ialred1h@ed.gov', 'ialred1h'),
('Ardelle', 'Asey', 'aasey1i@canalblog.com', 'aasey1i'),
('Jordana', 'Dougill', 'jdougill1j@imageshack.us', 'jdougill1j'),
('Shirley', 'O''Harney', 'soharney1k@ox.ac.uk', 'soharney1k'),
('Winnah', 'Batiste', 'wbatiste1l@spotify.com', 'wbatiste1l'),
('Tyne', 'Gilham', 'tgilham1m@51.la', 'tgilham1m'),
('Andra', 'Marin', 'amarin1n@shutterfly.com', 'amarin1n');


INSERT INTO Manufacturer (address, biography, manufacturerName)
VALUES ('1 Apple Park Way, Cupertino, CA 95014', 'Apple Bio', 'Apple'),
('13809 Research Blvd, Suite 500 PMB 93206, Austin, Texas 78750', 'Glorious Gaming Bio', 'Glorious Gaming'),
('Huion Science and Technology Park, Keji 1st Road, Bao''an District, Shenzhen, China.', 'Huion Bio', 'Huion'),
('1, Samsung-ro, Giheung-gu, Yongin-si, Gyeonggi-do 17113, Korea', 'Samsung Bio', 'Samsung'),
('1 Dell Way, Round Rock, Texas United States', 'Dell Bio', 'Dell'),
('15613F-3, No. 508, Sec. 7, Zhongxiao E. Rd., Nangang Dist., Taipei City 115011, Taiwan (R.O.C.)', 'Ducky Bio', 'Ducky'),
('Cherrystrasse 2 91275 Auerbach/OPf. Germany', 'Cherry Bio', 'Cherry'),
('1221 Commerce Drive. Stow, Ohio 44224', 'Audio Technica Bio', 'Audio Technica'),
('Havneholmen 8, DK-2450 Copenhagen SV, Denmark', 'Steelseries Bio', 'Steelseries'),
('200 Digital Way, San Jose, CA 95113', 'Specializes in developing AI solutions for logistics and supply chain management.', 'LogiTech AI'),
('202 Circuit Ln, Seattle, WA 98101', 'A pioneer in cloud computing services offering scalable solutions worldwide.', 'CloudServ Technologies'),
('203 Quantum Rd, Cambridge, MA 02139', 'Focuses on quantum computing advancements to solve complex data problems.', 'QuantumCore Inc.'),
('204 Silicon Ave, Austin, TX 78701', 'Leading developer of cutting-edge semiconductor chips.', 'NanoChips LLC'),
('205 Code St, San Francisco, CA 94102', 'Offers innovative software solutions to enhance business productivity.', 'CodeCrafters Tech'),
('206 Data Dr, New York, NY 10013', 'Provides big data analytics services that transform enterprise decision-making.', 'DataWise Analytics'),
('207 Pixel Way, Orlando, FL 32801', 'Develops state-of-the-art graphics processors for gaming and professional markets.', 'PixelRender Graphics'),
('208 Crypto Blvd, Boulder, CO 80302', 'Specializes in secure blockchain technology solutions for various industries.', 'BlockSecure Tech'),
('209 Cloud Ct, Salt Lake City, UT 84101', 'Delivers reliable and secure cloud storage solutions.', 'CloudSafe Storage'),
('210 Algorithm Ln, Raleigh, NC 27601', 'Creates AI-driven algorithms to improve healthcare diagnostics.', 'HealthAI Solutions'),
('211 Tech Park Dr, Boston, MA 02215', 'Innovates in wearable technology for fitness and health monitoring.', 'LifeSync Wearables'),
('212 Virtual Rd, San Diego, CA 92121', 'Designs and develops virtual reality platforms for immersive educational experiences.', 'EduVirtual Labs'),
('213 Innovation Way, Atlanta, GA 30308', 'Provides cybersecurity solutions to protect against evolving digital threats.', 'Guardian CyberTech'),
('214 Server St, Dallas, TX 75201', 'Offers dedicated server hosting and managed IT services for small businesses.', 'ServerPlus Hosting'),
('215 Network Blvd, Denver, CO 80202', 'Specializes in building high-speed networks for telecommunication firms.', 'NetFast Communications'),
('216 Software Ave, Portland, OR 97209', 'Develops custom software applications tailored to client needs.', 'CustomSoft Providers'),
('217 Robotics Ln, Pittsburgh, PA 15213', 'Leads in the design and manufacture of industrial robots for automation.', 'RoboTech Manufacturing'),
('218 Drone Dr, Las Vegas, NV 89101', 'Manufactures commercial drones for photography and surveying.', 'SkyHigh Drones'),
('219 Machine Ln, Detroit, MI 48201', 'Focuses on machine learning platforms to optimize e-commerce transactions.', 'EcomML Tech'),
('220 Innovation Rd, Minneapolis, MN 55415', 'Develops bioinformatics software for research and development in genetics.', 'Genome Explorer Inc.'),
('221 Data Way, Charlotte, NC 28202', 'Provides data visualization tools that help businesses gain insights from complex datasets.', 'VisualData Insights'),
('222 Tech Dr, Omaha, NE 68102', 'Specializes in developing IoT devices for smart home automation.', 'HomeSmart IoT'),
('223 Electron Ave, Albuquerque, NM 87102', 'Manufactures microprocessors and other electronic components.', 'ElectronHaus Inc.'),
('224 AI Blvd, Hartford, CT 06103', 'Develops artificial intelligence systems to streamline insurance processing.', 'InsureAI Tech'),
('225 Cloud Circle, Tampa, FL 33602', 'Provides secure and efficient cloud services tailored for startups.', 'StartupCloud Solutions'),
('226 Binary St, Kansas City, MO 64106', 'Develops software for binary analysis and security.', 'BinaryDefense Technologies'),
('227 Web Rd, Richmond, VA 23219', 'Offers web development and digital marketing services.', 'WebInnovate Services'),
('228 Pixel Path, Madison, WI 53703', 'Creates advanced imaging software and photo enhancement technologies.', 'PixelPerfect Imaging'),
('229 Code Way, Boise, ID 83702', 'Specializes in coding bootcamps and tech education platforms.', 'CodeAcademy Tech'),
('230 AI Lane, Charleston, WV 25301', 'Focuses on AI-driven solutions for the financial sector.', 'Fintech AI Innovations'),
('261 Quantum View, Fresno, CA 93721', 'Leads innovation in personal quantum computing interfaces.', 'QuantumPersonal Inc.'),
('262 Tech Trail, Columbus, OH 43215', 'Develops mobile apps that integrate augmented reality for educational purposes.', 'ARLearn Apps'),
('263 Silicon Street, Baton Rouge, LA 70801', 'Specializes in silicon wafer manufacturing for microelectronics.', 'SiliconCrafters Ltd.'),
('264 Cloud Road, Columbia, SC 29201', 'Provides enterprise-grade SaaS solutions for the healthcare industry.', 'HealthCloud Services'),
('265 Data Drive, Providence, RI 02903', 'Offers data management and analytics for the retail sector.', 'RetailData Analytics'),
('266 Innovation Blvd, Harrisburg, PA 17101', 'Develops environmental monitoring systems using IoT technologies.', 'EcoMonitors Tech'),
('267 VR Lane, Sacramento, CA 95814', 'Creates virtual reality software for immersive therapy sessions.', 'TheraVR Solutions'),
('268 AI Avenue, Honolulu, HI 96813', 'Builds AI platforms that automate customer service for hospitality businesses.', 'HostAI Systems'),
('269 Tech Parkway, Indianapolis, IN 46204', 'Specializes in cybersecurity solutions for financial institutions.', 'FinanceSecure Tech'),
('270 Binary Blvd, Phoenix, AZ 85004', 'Develops binary translation tools for legacy software integration.', 'LegacyBinary Solutions'),
('271 Drone Drive, Salt Lake City, UT 84111', 'Manufactures and distributes high-performance drones for agricultural use.', 'AgriDrones Co.'),
('272 Server Street, Montgomery, AL 36104', 'Provides robust server solutions for large-scale data centers.', 'DataCenterPlus'),
('273 Network Road, Little Rock, AR 72201', 'Builds secure network infrastructure for corporate clients.', 'NetCorp Engineering'),
('274 Software Circle, Des Moines, IA 50309', 'Creates open-source software tools for developers.', 'OpenSource Hub'),
('275 Robotics Row, Jefferson City, MO 65101', 'Manufactures personal assistant robots for home use.', 'HomeHelper Robots'),
('276 Data Lane, Concord, NH 03301', 'Offers big data consulting services to optimize marketing strategies.', 'BigData Consulting'),
('277 Tech Trail, Dover, DE 19901', 'Develops educational software focusing on interactive learning.', 'EduTech Interactive'),
('278 Quantum Quay, Juneau, AK 99801', 'Pioneers in developing secure communication systems based on quantum technology.', 'QuantumComm Solutions'),
('279 AI Alley, Frankfort, KY 40601', 'Provides AI analysis tools for sports team performance enhancement.', 'SportAI Analytics'),
('280 Cloud Court, Topeka, KS 66603', 'Specializes in cloud-based project management solutions.', 'ProjectCloud Solutions'),
('281 Pixel Place, Augusta, ME 04330', 'Offers high-end digital marketing services using AI-driven analytics.', 'PixelMarketing AI'),
('282 Tech Terrace, Lansing, MI 48933', 'Develops software for autonomous vehicles.', 'AutoDrive Technologies'),
('283 Innovation Isle, Bismarck, ND 58501', 'Creates wearable health devices to monitor chronic conditions.', 'HealthWear Tech'),
('284 Server Sector, Carson City, NV 89701', 'Offers environmentally friendly hosting solutions.', 'GreenHost Solutions'),
('285 Binary Bend, Albany, NY 12207', 'Specializes in encryption software for secure communications.', 'Encryptech Innovations'),
('286 Drone Drive, Harrisburg, PA 17120', 'Designs surveillance drones for security purposes.', 'WatchDrones Security'),
('287 Data Way, Providence, RI 02903', 'Develops real-time traffic analysis tools for urban planning.', 'TrafficData Solutions'),
('288 AI Avenue, Columbia, SC 29201', 'Builds machine learning models for predictive maintenance in manufacturing.', 'MaintainML Tech'),
('289 Tech Parkway, Montpelier, VT 05602', 'Offers cloud-based solutions for managing nonprofit organizations.', 'Nonprofit Cloud Services'),
('290 Quantum Road, Charleston, WV 25301', 'Develops next-generation battery technology using quantum mechanics.', 'QuantumBattery Tech');

INSERT INTO Keyboard (backlight, size, keyboardName)
VALUES (true, '60%', 'Ducky One-Two Mini'),
(true, 'tkl', 'Apex Pro TKL'),
(false, '100%', 'Dell Multimedia Keyboard-KB216'),
(False, '100%', 'Apex Pro TKL'),
(False, '60%', 'Apex Pro TKL'),
(True, 'tkl', 'HyperX Alloy FPS Pro'),
(False, '60%', 'Filco Majestouch 2'),
(True, '100%', 'Dell Multimedia Keyboard-KB216'),
(True, '60%', 'Keychron K2'),
(True, 'tkl', 'SteelSeries Apex 7 TKL'),
(True, 'tkl', 'Apex Pro TKL'),
(False, '60%', 'HyperX Alloy FPS Pro'),
(False, '100%', 'HyperX Alloy FPS Pro'),
(True, '60%', 'Das Keyboard 4 Professional'),
(False, 'tkl', 'Logitech G Pro'),
(False, '60%', 'SteelSeries Apex 7 TKL'),
(True, 'tkl', 'Dell Multimedia Keyboard-KB216'),
(True, '60%', 'Anne Pro 2'),
(False, '100%', 'Apex Pro TKL'),
(True, '60%', 'Apex Pro TKL'),
(False, '100%', 'Razer Huntsman Elite'),
(True, 'tkl', 'Filco Majestouch 2'),
(False, 'tkl', 'Anne Pro 2'),
(True, '60%', 'Razer Huntsman Elite'),
(True, 'tkl', 'Razer Huntsman Elite'),
(False, '100%', 'SteelSeries Apex 7 TKL'),
(True, '100%', 'Keychron K2'),
(False, '60%', 'Anne Pro 2'),
(False, '100%', 'Dell Multimedia Keyboard-KB216'),
(False, '100%', 'Filco Majestouch 2'),
(True, '100%', 'Filco Majestouch 2'),
(False, 'tkl', 'Anne Pro 2'),
(False, 'tkl', 'Apex Pro TKL'),
(True, 'tkl', 'Apex Pro TKL'),
(False, '60%', 'Corsair K95'),
(True, '100%', 'Razer Huntsman Elite'),
(False, '60%', 'Das Keyboard 4 Professional'),
(True, '100%', 'Apex Pro TKL'),
(False, '60%', 'HyperX Alloy FPS Pro'),
(True, '100%', 'Filco Majestouch 2'),
(False, 'tkl', 'Das Keyboard 4 Professional'),
(False, '60%', 'Ducky One-Two Mini'),
(True, 'tkl', 'Filco Majestouch 2'),
(True, '100%', 'Keychron K2'),
(False, '60%', 'HyperX Alloy FPS Pro'),
(False, '60%', 'Ducky One-Two Mini'),
(True, '100%', 'Das Keyboard 4 Professional'),
(True, '100%', 'Dell Multimedia Keyboard-KB216'),
(False, 'tkl', 'SteelSeries Apex 7 TKL'),
(True, '60%', 'Filco Majestouch 2'),
(True, 'tkl', 'Filco Majestouch 2'),
(False, '100%', 'SteelSeries Apex 7 TKL'),
(True, '60%', 'Ducky One-Two Mini'),
(True, '100%', 'Das Keyboard 4 Professional'),
(True, '100%', 'Apex Pro TKL'),
(False, '100%', 'Dell Multimedia Keyboard-KB216'),
(False, '60%', 'Corsair K95'),
(False, '60%', 'Apex Pro TKL'),
(False, '60%', 'Dell Multimedia Keyboard-KB216'),
(True, '60%', 'Ducky One-Two Mini'),
(False, '100%', 'Logitech G Pro'),
(True, 'tkl', 'Logitech G Pro'),
(True, '60%', 'Razer Huntsman Elite');

INSERT INTO Switch (description, actuationForce, color, actuationDistance, switchName)
VALUES ('Linear', 2, 'Red', 2, 'CherryMX Red'),
('Tactile', 2, 'Brown', 2, 'CherryMX Brown'),
('Clicky', 2, 'Blue', 2, 'CherryMX Blue'),
('Linear', 2, 'White', 0.2, 'OmniPoint 2.0 Adjustable HyperMagnetic'),
('tactile', 45, 'red', 2.0, 'CherryMX Tactile'),
('speed', 50, 'silver', 1.2, 'Steelseries Speed'),
('linear', 60, 'black', 2.0, 'Razer Linear'),
('clicky', 55, 'blue', 2.2, 'Logitech Clicky'),
('tactile', 45, 'brown', 2.0, 'Corsair Tactile'),
('speed', 50, 'green', 1.2, 'HyperX Speed'),
('linear', 60, 'red', 2.0, 'CherryMX Linear'),
('clicky', 55, 'silver', 2.2, 'Steelseries Clicky'),
('tactile', 45, 'black', 2.0, 'Razer Tactile'),
('speed', 50, 'blue', 1.2, 'Logitech Speed'),
('linear', 60, 'brown', 2.0, 'Corsair Linear'),
('clicky', 55, 'green', 2.2, 'HyperX Clicky'),
('tactile', 45, 'red', 2.0, 'CherryMX Tactile'),
('speed', 50, 'silver', 1.2, 'Steelseries Speed'),
('linear', 60, 'black', 2.0, 'Razer Linear'),
('clicky', 55, 'blue', 2.2, 'Logitech Clicky'),
('tactile', 45, 'brown', 2.0, 'Corsair Tactile'),
('speed', 50, 'green', 1.2, 'HyperX Speed'),
('linear', 60, 'red', 2.0, 'CherryMX Linear'),
('clicky', 55, 'silver', 2.2, 'Steelseries Clicky'),
('tactile', 45, 'black', 2.0, 'Razer Tactile'),
('speed', 50, 'blue', 1.2, 'Logitech Speed'),
('linear', 60, 'brown', 2.0, 'Corsair Linear'),
('clicky', 55, 'green', 2.2, 'HyperX Clicky'),
('tactile', 45, 'red', 2.0, 'CherryMX Tactile'),
('speed', 50, 'silver', 1.2, 'Steelseries Speed'),
('linear', 60, 'black', 2.0, 'Razer Linear'),
('clicky', 55, 'blue', 2.2, 'Logitech Clicky'),
('tactile', 45, 'brown', 2.0, 'Corsair Tactile'),
('speed', 50, 'green', 1.2, 'HyperX Speed'),
('linear', 60, 'red', 2.0, 'CherryMX Linear'),
('clicky', 55, 'silver', 2.2, 'Steelseries Clicky'),
('tactile', 45, 'black', 2.0, 'Razer Tactile'),
('speed', 50, 'blue', 1.2, 'Logitech Speed'),
('linear', 60, 'brown', 2.0, 'Corsair Linear'),
('clicky', 55, 'green', 2.2, 'HyperX Clicky'),
('tactile', 45, 'red', 2.0, 'CherryMX Tactile'),
('speed', 50, 'silver', 1.2, 'Steelseries Speed'),
('linear', 60, 'black', 2.0, 'Razer Linear'),
('clicky', 55, 'blue', 2.2, 'Logitech Clicky'),
('tactile', 45, 'brown', 2.0, 'Corsair Tactile'),
('speed', 50, 'green', 1.2, 'HyperX Speed'),
('linear', 60, 'red', 2.0, 'CherryMX Linear'),
('clicky', 55, 'silver', 2.2, 'Steelseries Clicky'),
('tactile', 45, 'black', 2.0, 'Razer Tactile'),
('speed', 50, 'blue', 1.2, 'Logitech Speed'),
('linear', 60, 'brown', 2.0, 'Corsair Linear'),
('clicky', 55, 'green', 2.2, 'HyperX Clicky'),
('tactile', 45, 'red', 2.0, 'CherryMX Tactile'),
('speed', 50, 'silver', 1.2, 'Steelseries Speed'),
('linear', 60, 'black', 2.0, 'Razer Linear'),
('clicky', 55, 'blue', 2.2, 'Logitech Clicky'),
('tactile', 45, 'brown', 2.0, 'Corsair Tactile'),
('speed', 50, 'green', 1.2, 'HyperX Speed'),
('linear', 60, 'red', 2.0, 'CherryMX Linear'),
('clicky', 55, 'silver', 2.2, 'Steelseries Clicky'),
('tactile', 45, 'black', 2.0, 'Razer Tactile'),
('speed', 50, 'blue', 1.2, 'Logitech Speed'),
('linear', 60, 'brown', 2.0, 'Corsair Linear'),
('clicky', 55, 'green', 2.2, 'HyperX Clicky');

INSERT INTO Laptop (length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, refreshRate, batterySize, weight, backlitKeyboard, GPU, CPU, laptopName, operatingSystem)
VALUES  (344, 230, 18, 3456, 2160, 16, 1024, 60, 86, 1.86, true, 'RTX 4070', 'i9-13900H', 'Dell XPS 15', 'Windows 11'),
(280, 214, 6.4, 2388, 1668, 8, 1024, 120, 41, 0.685, false, 'implicit', 'Apple M2', 'iPad Pro 12.9 Inch', 'Apple iOS'),
(356, 248, 17, 3456, 2234, 32, 1024, 120, 100, 2.16, true, 'implicit', 'Apple M3 Max', 'Macbook Pro 2024 16in', 'MacOS'),
(310, 215, 14, 3200, 1800, 16, 512, 90, 0.50, 1340, true, 'NVIDIA GeForce GTX 1060', 'Intel Core i7-8750H', 'Horizon Ultra', 'Windows 10'),
(340, 240, 19, 1920, 1080, 8, 256, 60, 0.55, 1700, false, 'AMD Radeon RX Vega 8', 'AMD Ryzen 5 3500U', 'Explorer 15', 'Windows 10'),
(325, 210, 13, 2880, 1800, 16, 1024, 60, 0.70, 1800, true, 'AMD Radeon Pro 560X', 'Intel Core i9-8950HK', 'ProBook X', 'MacOS Catalina'),
(350, 235, 20, 2560, 1440, 32, 1000, 120, 0.80, 2000, true, 'NVIDIA GeForce RTX 2080', 'AMD Ryzen 9 3900X', 'BeastMaster 64', 'Windows 10'),
(320, 220, 17, 1600, 900, 4, 500, 60, 0.40, 1500, false, 'Intel UHD Graphics 620', 'Intel Core i3-8130U', 'BudgetEase 13', 'Windows 10'),
(325, 218, 15, 1920, 1080, 8, 256, 144, 0.50, 1400, true, 'NVIDIA GeForce MX130', 'Intel Core i5-8250U', 'Swift 3', 'Windows 10'),
(330, 225, 16, 2560, 1600, 16, 512, 60, 0.65, 1300, true, 'AMD Radeon Pro 5300M', 'Intel Core i7-1068NG7', 'PixelBook Go', 'MacOS Mojave'),
(340, 230, 19, 1920, 1080, 32, 2000, 144, 0.90, 2200, true, 'NVIDIA GeForce RTX 2080 Ti', 'AMD Ryzen 9 5950X', 'Elite Dragon', 'Windows 10'),
(305, 200, 14, 1366, 768, 8, 256, 60, 0.35, 1200, false, 'Intel HD Graphics 500', 'Intel Celeron N4000', 'TravelMate B1', 'Windows 10'),
(320, 220, 18, 1920, 1080, 8, 256, 60, 0.55, 1550, true, 'NVIDIA GeForce GTX 1050', 'Intel Core i5-8300H', 'Nitro 5', 'Windows 10'),
(310, 210, 18, 2560, 1440, 16, 512, 120, 0.60, 1400, true, 'NVIDIA GeForce GTX 1650 Ti', 'Intel Core i7-10750H', 'Stealth 15M', 'Windows 10'),
(350, 245, 21, 3840, 2160, 32, 2048, 144, 0.99, 2400, true, 'AMD Radeon RX 6900XT', 'AMD Ryzen Threadripper 3990X', 'Overlord X', 'Windows 10'),
(330, 230, 20, 1920, 1080, 4, 128, 60, 0.42, 1350, false, 'Intel HD Graphics 520', 'Intel Core i3-6100U', 'Aspire 1', 'Windows 10'),
(340, 235, 19, 1920, 1080, 8, 256, 60, 0.49, 1490, true, 'NVIDIA GeForce MX250', 'Intel Core i5-10210U', 'Flex 5', 'Windows 10'),
(320, 215, 16, 1920, 1080, 16, 1000, 144, 0.75, 1750, true, 'NVIDIA GeForce RTX 2060', 'Intel Core i7-9750H', 'Blade 15', 'Windows 10'),
(305, 205, 17, 2256, 1504, 8, 256, 60, 0.58, 1290, true, 'Integrated Intel Iris Plus Graphics', 'Intel Core i5-1035G4', 'Surface Laptop 3', 'Windows 10'),
(360, 250, 21, 1920, 1080, 32, 2048, 144, 0.95, 2100, true, 'AMD Radeon Pro 5500M', 'Intel Core i9-10980HK', 'Titan Pro', 'Windows 10'),
(320, 215, 18, 3840, 2160, 16, 512, 60, 0.65, 1600, true, 'NVIDIA GeForce MX350', 'Intel Core i7-10510U', 'Vision Pro', 'Windows 10'),
(345, 225, 17, 3000, 2000, 16, 1024, 90, 0.75, 1900, true, 'NVIDIA GeForce RTX 2070', 'AMD Ryzen 9 4900HS', 'Zenith 14 Pro', 'Windows 10'),
(330, 220, 16, 2560, 1600, 8, 256, 120, 0.50, 1370, true, 'Integrated AMD Radeon Graphics', 'AMD Ryzen 5 3500U', 'Flex Pro', 'Windows 10'),
(310, 215, 14, 3200, 1800, 16, 512, 90, 0.50, 1340, true, 'NVIDIA GeForce GTX 1060', 'Intel Core i7-8750H', 'Horizon Ultra', 'Windows 10'),
(340, 240, 19, 1920, 1080, 8, 256, 60, 0.55, 1700, false, 'AMD Radeon RX Vega 8', 'AMD Ryzen 5 3500U', 'Explorer 15', 'Windows 10'),
(320, 220, 18, 1920, 1080, 8, 256, 60, 0.55, 1500, true, 'NVIDIA GeForce MX250', 'Intel Core i5-1035G1', 'Voyager 1', 'Windows 10'),
(350, 240, 15, 2560, 1440, 16, 512, 120, 0.70, 1700, true, 'AMD Radeon RX 5600M', 'AMD Ryzen 7 4800H', 'Spartan 7', 'Windows 10'),
(330, 230, 20, 1366, 768, 4, 128, 60, 0.45, 1400, false, 'Intel HD Graphics 600', 'Intel Core i3-10110U', 'StreamBook', 'Windows 10'),
(340, 235, 19, 1920, 1080, 8, 256, 60, 0.50, 1450, true, 'NVIDIA GeForce GTX 1650', 'Intel Core i5-9300H', 'Gamma Pro', 'Windows 10'),
(310, 210, 16, 1920, 1080, 16, 1000, 144, 0.80, 1800, true, 'NVIDIA GeForce RTX 2070', 'Intel Core i7-9750H', 'Apex 15X', 'Windows 10'),
(305, 205, 17, 2256, 1504, 8, 256, 60, 0.60, 1250, true, 'Integrated Intel Iris Plus Graphics', 'Intel Core i5-1035G7', 'Surface Laptop 3', 'Windows 10'),
(360, 250, 21, 1920, 1080, 32, 2048, 144, 0.99, 2000, true, 'AMD Radeon Pro 5500M', 'Intel Core i9-9980HK', 'Titan V2', 'Windows 10'),
(320, 215, 18, 3840, 2160, 16, 512, 60, 0.65, 1600, true, 'NVIDIA GeForce MX350', 'Intel Core i7-10510U', 'Vision X', 'Windows 10'),
(345, 225, 17, 3000, 2000, 16, 1024, 90, 0.75, 1900, true, 'NVIDIA GeForce RTX 2060', 'AMD Ryzen 9 4900HS', 'Zenith 14', 'Windows 10'),

INSERT INTO Headphones(numDrivers, bluetooth, microphone, description, headphoneName)
VALUES (8, true, false, 'Comfortable, padded, and open-backed headphones.', 'Expensive headphones'),
(1, false, true, 'Affordable option suited for gaming and home listening.', 'Cheap headphones'),
(3, true, true, 'A strong option at a reasonable price point. Good value.', 'Mid-range headphones'),
(2, True, False, 'Wireless, On-Ear', 'Sony WH-1000XM4'),
(3, True, True, 'Gaming Headset, Surround Sound', 'Jabra Elite 65t'),
(1, True, True, 'Studio Monitor, Over-Ear', 'Sennheiser HD 650'),
(2, False, False, 'Sports Earbuds, Water Resistant', 'Jabra Elite 65t'),
(3, True, False, 'Studio Monitor, Over-Ear', 'HyperX Cloud II'),
(1, True, True, 'Wireless, On-Ear', 'SteelSeries Arctis Pro'),
(3, False, True, 'Sports Earbuds, Water Resistant', 'SteelSeries Arctis Pro'),
(2, True, True, 'Gaming Headset, Surround Sound', 'Philips Fidelio X2HR'),
(2, False, False, 'Noise Cancelling, Over-Ear', 'HyperX Cloud II'),
(2, True, False, 'Wireless, On-Ear', 'HyperX Cloud II'),
(3, False, False, 'Gaming Headset, Surround Sound', 'Philips Fidelio X2HR'),
(1, True, True, 'Sports Earbuds, Water Resistant', 'Shure SE215'),
(3, True, True, 'Noise Cancelling, Over-Ear', 'Bose QuietComfort 35 II'),
(3, True, True, 'Studio Monitor, Over-Ear', 'Beyerdynamic DT 770 PRO'),
(1, False, False, 'Gaming Headset, Surround Sound', 'HyperX Cloud II'),
(1, True, True, 'Studio Monitor, Over-Ear', 'Beats Powerbeats Pro'),
(2, True, True, 'Studio Monitor, Over-Ear', 'Shure SE215'),
(1, True, True, 'Noise Cancelling, Over-Ear', 'Beats Powerbeats Pro'),
(2, False, False, 'Wireless, On-Ear', 'Sennheiser HD 650'),
(1, False, False, 'Gaming Headset, Surround Sound', 'Bose QuietComfort 35 II'),
(2, False, False, 'Sports Earbuds, Water Resistant', 'Audio-Technica ATH-M50x'),
(3, True, False, 'Gaming Headset, Surround Sound', 'Audio-Technica ATH-M50x'),
(3, False, True, 'Noise Cancelling, Over-Ear', 'Jabra Elite 65t'),
(3, True, True, 'In-Ear Monitors, High Fidelity', 'Shure SE215'),
(1, True, False, 'Wireless, On-Ear', 'Sony WH-1000XM4'),
(2, False, True, 'Wireless, On-Ear', 'Philips Fidelio X2HR'),
(3, True, False, 'Studio Monitor, Over-Ear', 'Philips Fidelio X2HR'),
(2, False, True, 'Gaming Headset, Surround Sound', 'SteelSeries Arctis Pro'),
(2, False, True, 'Gaming Headset, Surround Sound', 'Sony WH-1000XM4'),
(1, False, False, 'In-Ear Monitors, High Fidelity', 'SteelSeries Arctis Pro'),
(2, False, False, 'In-Ear Monitors, High Fidelity', 'Sennheiser HD 650'),
(1, True, True, 'Sports Earbuds, Water Resistant', 'Sony WH-1000XM4'),
(2, False, False, 'Studio Monitor, Over-Ear', 'SteelSeries Arctis Pro'),
(1, False, False, 'Sports Earbuds, Water Resistant', 'Beats Powerbeats Pro'),
(2, False, True, 'Wireless, On-Ear', 'Beyerdynamic DT 770 PRO'),
(3, False, False, 'Noise Cancelling, Over-Ear', 'Bose QuietComfort 35 II'),
(2, True, False, 'Sports Earbuds, Water Resistant', 'Beats Powerbeats Pro'),
(2, True, False, 'Sports Earbuds, Water Resistant', 'Bose QuietComfort 35 II'),
(1, False, True, 'Noise Cancelling, Over-Ear', 'Jabra Elite 65t'),
(2, False, False, 'Wireless, On-Ear', 'Logitech G Pro X'),
(2, False, True, 'Noise Cancelling, Over-Ear', 'Beats Powerbeats Pro'),
(1, False, False, 'Sports Earbuds, Water Resistant', 'HyperX Cloud II'),
(3, True, True, 'Noise Cancelling, Over-Ear', 'Beyerdynamic DT 770 PRO'),
(2, True, False, 'Wireless, On-Ear', 'Philips Fidelio X2HR'),
(1, False, True, 'Studio Monitor, Over-Ear', 'Shure SE215'),
(1, False, False, 'Wireless, On-Ear', 'Sony WH-1000XM4'),
(2, True, False, 'Sports Earbuds, Water Resistant', 'HyperX Cloud II'),
(1, False, True, 'Gaming Headset, Surround Sound', 'Sennheiser HD 650'),
(1, True, True, 'Gaming Headset, Surround Sound', 'Jabra Elite 65t'),
(1, False, True, 'Sports Earbuds, Water Resistant', 'Shure SE215'),
(3, False, True, 'Studio Monitor, Over-Ear', 'Beyerdynamic DT 770 PRO'),
(2, False, False, 'In-Ear Monitors, High Fidelity', 'Jabra Elite 65t'),
(2, True, False, 'Sports Earbuds, Water Resistant', 'Sony WH-1000XM4'),
(3, False, False, 'Studio Monitor, Over-Ear', 'HyperX Cloud II'),
(3, True, False, 'Gaming Headset, Surround Sound', 'SteelSeries Arctis Pro'),
(3, True, False, 'In-Ear Monitors, High Fidelity', 'HyperX Cloud II'),
(1, False, False, 'In-Ear Monitors, High Fidelity', 'SteelSeries Arctis Pro'),
(2, True, False, 'Wireless, On-Ear', 'Bose QuietComfort 35 II'),
(2, True, False, 'In-Ear Monitors, High Fidelity', 'HyperX Cloud II'),
(2, True, True, 'Studio Monitor, Over-Ear', 'Bose QuietComfort 35 II');


INSERT INTO Tablet(length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, tabletName)
VALUES (280, 216, 6, 2400, 1080, 16, 512, 'Paper sized'),
(346, 195, 10, 3840, 2160, 16, 1000, 'Studio drawing tablet'),
(280, 214, 6, 2388, 1668, 32, 512, 'Iphone'),
(17.85, 0.7, 0.33, 1280, 1200, 8, 32, 'Google Pixel Slate'),
(24.0, 0.8, 0.29, 1920, 1600, 4, 128, 'Amazon Fire HD'),
(25.7, 0.8, 0.29, 2560, 800, 2, 32, 'Xiaomi Mi Pad'),
(24.0, 0.9, 0.29, 1920, 1600, 8, 32, 'Amazon Fire HD'),
(25.7, 0.8, 0.33, 1280, 800, 8, 32, 'Lenovo Tab'),
(24.0, 0.7, 0.37, 1280, 1600, 4, 32, 'Amazon Fire HD'),
(17.85, 0.7, 0.33, 1280, 1600, 2, 128, 'Amazon Fire HD'),
(24.0, 0.9, 0.37, 1280, 1200, 2, 32, 'Huawei MediaPad'),
(25.7, 0.8, 0.37, 2560, 800, 4, 32, 'Apple iPad'),
(17.85, 0.7, 0.37, 1920, 800, 4, 32, 'Microsoft Surface Pro'),
(25.7, 0.7, 0.33, 1920, 800, 8, 128, 'Apple iPad'),
(25.7, 0.9, 0.33, 2560, 1200, 4, 32, 'Acer Iconia Tab'),
(25.7, 0.7, 0.29, 1920, 800, 4, 128, 'Microsoft Surface Pro'),
(17.85, 0.8, 0.37, 1920, 800, 8, 32, 'Samsung Galaxy Tab'),
(24.0, 0.9, 0.29, 1280, 800, 2, 32, 'Sony Xperia Tablet'),
(17.85, 0.8, 0.29, 1280, 1200, 2, 32, 'Sony Xperia Tablet'),
(25.7, 0.8, 0.29, 1280, 1600, 4, 64, 'Microsoft Surface Pro'),
(17.85, 0.8, 0.33, 1280, 800, 8, 128, 'LG G Pad'),
(25.7, 0.7, 0.33, 1920, 1200, 4, 64, 'Lenovo Tab'),
(17.85, 0.7, 0.37, 1920, 800, 8, 64, 'Amazon Fire HD'),
(25.7, 0.9, 0.33, 1920, 800, 8, 32, 'Xiaomi Mi Pad'),
(17.85, 0.9, 0.29, 2560, 1200, 4, 128, 'Huawei MediaPad'),
(17.85, 0.8, 0.29, 1280, 1600, 4, 64, 'Xiaomi Mi Pad'),
(24.0, 0.9, 0.37, 1920, 1200, 4, 128, 'Huawei MediaPad'),
(25.7, 0.7, 0.37, 1280, 800, 2, 128, 'Asus ZenPad'),
(24.0, 0.9, 0.33, 1280, 800, 4, 32, 'Xiaomi Mi Pad'),
(17.85, 0.8, 0.37, 1280, 1200, 8, 64, 'Apple iPad'),
(25.7, 0.9, 0.29, 2560, 800, 8, 128, 'Huawei MediaPad'),
(24.0, 0.8, 0.37, 2560, 1200, 4, 128, 'Apple iPad'),
(17.85, 0.9, 0.29, 2560, 1600, 2, 64, 'Amazon Fire HD'),
(17.85, 0.9, 0.29, 2560, 800, 2, 32, 'Samsung Galaxy Tab'),
(24.0, 0.8, 0.29, 1280, 800, 2, 64, 'LG G Pad'),
(17.85, 0.9, 0.29, 2560, 800, 8, 32, 'Samsung Galaxy Tab'),
(24.0, 0.9, 0.33, 1280, 1200, 2, 64, 'Amazon Fire HD'),
(24.0, 0.9, 0.29, 1920, 1200, 2, 128, 'Asus ZenPad'),
(25.7, 0.9, 0.33, 1280, 1600, 8, 64, 'Xiaomi Mi Pad'),
(24.0, 0.9, 0.37, 1920, 800, 4, 64, 'Asus ZenPad'),
(25.7, 0.8, 0.29, 1280, 1600, 4, 64, 'LG G Pad'),
(24.0, 0.8, 0.29, 1280, 800, 2, 128, 'Sony Xperia Tablet'),
(25.7, 0.9, 0.37, 1920, 800, 4, 128, 'Microsoft Surface Pro'),
(25.7, 0.8, 0.29, 2560, 800, 4, 32, 'Xiaomi Mi Pad'),
(25.7, 0.7, 0.29, 1920, 1600, 4, 64, 'Asus ZenPad'),
(24.0, 0.7, 0.33, 1280, 1200, 2, 32, 'Google Pixel Slate'),
(24.0, 0.8, 0.37, 1920, 800, 8, 128, 'Samsung Galaxy Tab'),
(25.7, 0.7, 0.29, 1920, 1600, 4, 64, 'Amazon Fire HD'),
(25.7, 0.9, 0.29, 1280, 1600, 2, 128, 'Acer Iconia Tab'),
(17.85, 0.8, 0.29, 1280, 1200, 4, 128, 'Lenovo Tab'),
(25.7, 0.9, 0.37, 1920, 1600, 8, 32, 'Sony Xperia Tablet'),
(17.85, 0.8, 0.33, 1280, 1200, 4, 32, 'Amazon Fire HD'),
(17.85, 0.8, 0.33, 2560, 800, 2, 32, 'LG G Pad'),
(24.0, 0.8, 0.37, 1920, 800, 8, 32, 'Sony Xperia Tablet'),
(24.0, 0.8, 0.29, 2560, 1600, 4, 32, 'Huawei MediaPad'),
(25.7, 0.8, 0.37, 1280, 1200, 8, 128, 'Apple iPad'),
(17.85, 0.9, 0.37, 1280, 1200, 2, 64, 'Asus ZenPad'),
(25.7, 0.9, 0.33, 2560, 1600, 4, 64, 'Amazon Fire HD'),
(24.0, 0.7, 0.29, 1920, 1200, 8, 32, 'Sony Xperia Tablet'),
(24.0, 0.7, 0.33, 1920, 1200, 2, 128, 'Amazon Fire HD'),
(24.0, 0.9, 0.37, 1280, 800, 4, 64, 'Asus ZenPad'),
(25.7, 0.7, 0.37, 1920, 1600, 4, 32, 'Acer Iconia Tab'),
(24.0, 0.8, 0.33, 2560, 800, 2, 128, 'Acer Iconia Tab');


INSERT INTO Mouse(description, sensorType, size, weight, freeScrolling, mouseName)
VALUES ('Comfortable, ergonomic mouse fit for the office.', 'Optical', '120x79x78', 130.408, false, 'Logitech MX Vertical Wireless Mouse'),
('High-end gaming mouse to last a lifetime.', 'Optical', '114x60x37', 98.65634, false, 'Tt eSPORTS Ventus R'),
('Lightweight and ergonomic wired mouse.', 'Optical', '120x63x42', 69, false, 'Model O- (Minus) Compact Wired Gaming Mouse'),
('Ergonomically designed for comfort, with customizable buttons.', 'Optical', '120x75x40', 105, false, 'ErgoComfort'),
('Built for precision gaming, with high DPI sensitivity.', 'Laser', '130x80x45', 99, true, 'GamerPro X'),
('Compact and portable, perfect for travel.', 'Optical', '100x60x35', 85, false, 'TravelLight'),
('Features a high-accuracy sensor and RGB lighting.', 'Laser', '125x70x42', 95, true, 'Spectrum RGB'),
('Designed for professional eSports with ultra-fast response.', 'Optical', '128x73x41', 88, true, 'StrikeMaster IV'),
('Lightweight design with a focus on minimal drag.', 'Optical', '130x75x38', 90, false, 'FeatherLite'),
('Sturdy build with high durability and precise control.', 'Laser', '135x85x45', 110, false, 'TitanGrip'),
('Elegant and functional with silent click features.', 'Optical', '115x65x39', 78, false, 'SilentClicker'),
('Advanced sensor for detailed CAD and graphic design work.', 'Laser', '140x90x50', 120, true, 'DesignMaster'),
('Budget-friendly with reliable performance for everyday use.', 'Optical', '110x70x36', 92, false, 'DailyDriver'),
('Optimized for MMO games with multiple programmable buttons.', 'Laser', '135x80x48', 115, true, 'MMOMaster'),
('Ultra-slim and stylish, blending with modern desk setups.', 'Optical', '105x55x30', 75, false, 'SleekStyle'),
('Heavy-duty design with additional grips for better control.', 'Laser', '130x80x44', 130, true, 'GripPlus'),
('Simple, effective, and straightforward without extra frills.', 'Optical', '120x72x40', 100, false, 'BasicPro'),
('Sporting vibrant colors and patterns, attractive for kids.', 'Laser', '115x70x37', 80, false, 'KidsColorFun'),
('Built for longevity with a five-year guarantee.', 'Optical', '125x78x43', 105, true, 'LongLast'),
('Compact with a retractable cord, great for laptop users.', 'Laser', '110x65x38', 83, false, 'RetractaCord'),
('High-end gaming mouse with adjustable DPI settings.', 'Optical', '132x76x42', 97, true, 'DPIFlex'),
('Simple plug-and-play mouse, no software needed.', 'Optical', '120x70x40', 90, false, 'PlugNPlay'),
('Robust for office environments, with a three-year warranty.', 'Laser', '130x80x45', 100, true, 'OfficePro'),
('Designed specifically for left-handed users.', 'Optical', '125x70x40', 85, false, 'LeftyAdvantage'),
('Lightweight for quick movements and better reflexes.', 'Laser', '128x74x39', 87, true, 'QuickMove'),
('Classic design with modern sensor upgrades.', 'Optical', '130x78x42', 103, false, 'ClassicTech'),
('Wireless with a long-lasting battery, up to 18 months.', 'Laser', '140x85x45', 110, true, 'EnduroWireless'),
('Sleek and stylish with silent click features.', 'Optical', '115x65x35', 80, false, 'SilentClicker'),
('Offers a balance of comfort and functionality for office use.', 'Laser', '120x70x40', 100, true, 'OfficePro Elite'),
('Engineered for precision with adjustable DPI settings.', 'Optical', '130x80x43', 92, true, 'Precise Navigator'),
('Robust for everyday use with a comfortable grip.', 'Optical', '125x75x39', 105, false, 'Daily Driver'),
('Multi-device connectivity with high-end performance.', 'Laser', '135x85x45', 120, true, 'MultiTasker'),
('Ultra-fast wireless performance for gaming enthusiasts.', 'Optical', '128x70x40', 98, true, 'Speed Demon'),
('Affordable and reliable with a basic, functional design.', 'Optical', '110x65x36', 90, false, 'Budget Basics'),
('Advanced tracking with a luxurious matte finish.', 'Laser', '123x78x42', 103, true, 'MatteMaster'),
('Light and compact, ideal for users on the go.', 'Optical', '105x60x34', 70, false, 'Mobile Mini'),
('Heavy-duty performance with extra programmable buttons.', 'Laser', '140x90x50', 125, true, 'Commander Xtreme'),
('Tailored for designers with high precision and ergonomics.', 'Optical', '130x82x44', 110, false, 'DesignerPro'),
('Combines high speed with a striking aesthetic.', 'Laser', '135x85x48', 115, true, 'FlashStrike'),
('Optimized for silent operation and smooth scrolling.', 'Optical', '120x70x40', 85, true, 'QuietScroll'),
('Compact design with durable construction for daily use.', 'Optical', '118x66x37', 95, false, 'CompactPro'),
('Ergonomic with vertical design to reduce wrist strain.', 'Laser', '130x80x50', 102, true, 'ErgoVertical'),
('Lightweight for eSports with customizable RGB lighting.', 'Optical', '127x71x40', 88, true, 'RGB Elite'),
('Robust construction with a tactile grip for secure handling.', 'Laser', '133x76x45', 110, false, 'GripMaster'),
('Versatile for multi-platform use with seamless switching.', 'Optical', '125x70x42', 100, true, 'VersaLink'),
('Ultra-portable design for professionals on the move.', 'Optical', '110x68x36', 78, false, 'ProTraveler'),
('Designed for high-stakes gaming with zero lag.', 'Laser', '135x80x44', 97, true, 'ZeroLag Pro'),
('Simple, reliable, and affordable with a classic design.', 'Optical', '115x65x38', 83, false, 'ClassicClick'),
('High-performance sensor with a durable, smooth surface.', 'Laser', '128x74x43', 103, true, 'Smooth Operator'),
('Ultra-light with a breathable design for extended use.', 'Optical', '125x70x39', 85, false, 'AirTouch'),
('Focus on productivity with hyper-fast scrolling.', 'Laser', '132x78x40', 110, true, 'HyperScroll Pro'),
('Compact and ergonomic for comfort during long sessions.', 'Optical', '120x72x41', 95, false, 'ComfortCraft'),
('Built with precision for graphic designers and artists.', 'Laser', '134x80x46', 100, true, 'Artisan Pro'),
('Rugged and ready for any environment, with a tough build.', 'Optical', '138x85x47', 120, false, 'ToughTrack'),
('Slick design with cutting-edge sensor technology.', 'Laser', '127x73x40', 92, true, 'EdgeGlider'),
('Perfect for gamers, with high response rates and accuracy.', 'Optical', '130x75x42', 98, true, 'GameMaster X'),
('Ideal for office environments, quiet and efficient.', 'Optical', '120x68x38', 87, false, 'OfficeQuiet'),
('Gaming optimized with high DPI and customizable weights.', 'Laser', '135x85x45', 120, true, 'WeightMaster'),
('Simple design, effective and easy to use for all.', 'Optical', '117x70x39', 86, false, 'EasyClick'),
('Built for endurance with a comfortable contoured shape.', 'Laser', '132x76x42', 105, true, 'EnduroComfort'),
('Light as a feather, ideal for fast-paced gaming action.', 'Optical', '125x68x36', 80, true, 'FeatherFast'),
('Versatile and robust for serious business users.', 'Laser', '130x75x40', 110, false, 'Business Elite'),
('High-speed tracking with minimal latency for gamers.', 'Optical', '128x74x43', 90, true, 'LatencyZero'),
('Durable, long-lasting, and designed for everyday computing.', 'Optical', '123x71x38', 95, false, 'Daily Essential');


INSERT INTO Phone(length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, refreshRate,batteryLength, weight, interface, phoneName)
VALUES (149.6, 71.45, 8.25, 1179, 2556, 6, 1000, 60, 16, 171, 'USB-C', 'Iphone 15'),
(146.3, 70.9, 7.6, 2340, 1080, 8, 512, 120, 10, 168.1127, 'USB-C', 'Samsung Galaxy s23'),
(146.7, 71.5, 7.65, 2532, 1170, 4, 128, 60, 17, 174, 'Lighting connector', 'Iphone 13'),
(15.0, 0.9, 0.9, 1080, 1080, 6, 512, 90, 12, 180, 'iOS', 'iPhone 12'),
(15.0, 0.9, 1.0, 1080, 2400, 6, 64, 90, 15, 200, 'iOS', 'Xiaomi Mi 11'),
(15.0, 0.7, 0.8, 1080, 1440, 12, 256, 90, 10, 200, 'Android', 'Samsung Galaxy S20'),
(14.0, 0.8, 0.8, 1080, 1080, 6, 128, 60, 12, 180, 'Custom Android', 'LG Velvet'),
(16.4, 0.9, 0.8, 2340, 1440, 12, 64, 90, 12, 150, 'Custom Android', 'Nokia 9.3 PureView'),
(15.0, 0.7, 1.0, 3200, 2400, 4, 256, 120, 15, 150, 'Android', 'Oppo Find X2'),
(15.0, 0.9, 1.0, 1080, 2400, 4, 64, 60, 10, 180, 'Custom Android', 'Nokia 9.3 PureView'),
(16.4, 0.7, 0.8, 2340, 1080, 4, 256, 120, 10, 200, 'iOS', 'iPhone 12'),
(15.0, 0.8, 1.0, 3200, 1080, 4, 512, 60, 10, 180, 'Custom Android', 'Xiaomi Mi 11'),
(15.0, 0.7, 1.0, 3200, 1080, 12, 512, 120, 10, 180, 'iOS', 'Google Pixel 5'),
(14.0, 0.8, 0.9, 2340, 2400, 8, 512, 120, 12, 150, 'Android', 'Asus Zenfone 7'),
(14.0, 0.8, 1.0, 1080, 1440, 4, 128, 60, 15, 200, 'Custom Android', 'Oppo Find X2'),
(16.4, 0.7, 0.9, 3200, 2400, 8, 512, 120, 12, 180, 'Custom Android', 'Xiaomi Mi 11'),
(16.4, 0.8, 1.0, 2340, 2400, 6, 512, 90, 15, 180, 'Custom Android', 'Xiaomi Mi 11'),
(15.0, 0.9, 0.9, 2340, 1080, 4, 128, 90, 12, 200, 'Custom Android', 'Google Pixel 5'),
(16.4, 0.8, 0.8, 1080, 2400, 6, 512, 60, 12, 150, 'iOS', 'Samsung Galaxy S20'),
(14.0, 0.8, 0.8, 2340, 2400, 12, 64, 90, 12, 150, 'Custom Android', 'Samsung Galaxy S20'),
(15.0, 0.7, 0.9, 1080, 1440, 6, 256, 60, 15, 180, 'iOS', 'Huawei P40'),
(15.0, 0.9, 0.8, 1080, 2400, 4, 256, 120, 12, 180, 'Custom Android', 'Samsung Galaxy S20'),
(16.4, 0.8, 1.0, 1080, 2400, 6, 512, 60, 12, 200, 'iOS', 'Google Pixel 5'),
(14.0, 0.7, 0.8, 1080, 1440, 6, 512, 120, 15, 200, 'iOS', 'OnePlus 8T'),
(16.4, 0.8, 1.0, 1080, 2400, 4, 64, 120, 15, 150, 'iOS', 'Samsung Galaxy S20'),
(16.4, 0.7, 1.0, 2340, 1440, 12, 64, 90, 12, 200, 'Custom Android', 'Samsung Galaxy S20'),
(16.4, 0.9, 0.9, 2340, 1440, 12, 64, 60, 10, 180, 'Android', 'Xiaomi Mi 11'),
(16.4, 0.9, 1.0, 1080, 1080, 12, 256, 120, 12, 200, 'Android', 'Motorola Edge Plus'),
(16.4, 0.9, 1.0, 1080, 1440, 8, 128, 120, 10, 200, 'Android', 'iPhone 12'),
(15.0, 0.7, 0.8, 2340, 2400, 4, 128, 60, 12, 200, 'iOS', 'Sony Xperia 1'),
(15.0, 0.9, 0.9, 1080, 1080, 4, 256, 60, 12, 200, 'Custom Android', 'Motorola Edge Plus'),
(16.4, 0.8, 0.8, 3200, 2400, 8, 64, 90, 12, 150, 'iOS', 'Huawei P40'),
(15.0, 0.7, 0.9, 1080, 2400, 6, 512, 60, 10, 150, 'iOS', 'LG Velvet'),
(16.4, 0.7, 0.8, 3200, 1440, 4, 64, 60, 10, 180, 'iOS', 'Huawei P40'),
(16.4, 0.9, 1.0, 3200, 1080, 8, 512, 60, 12, 150, 'Android', 'Sony Xperia 1'),
(15.0, 0.7, 0.8, 1080, 2400, 4, 64, 120, 12, 150, 'iOS', 'Sony Xperia 1'),
(16.4, 0.9, 0.9, 2340, 1080, 12, 128, 60, 10, 150, 'iOS', 'LG Velvet'),
(16.4, 0.7, 0.8, 3200, 2400, 6, 256, 120, 12, 200, 'Android', 'LG Velvet'),
(14.0, 0.8, 0.8, 1080, 2400, 8, 512, 120, 12, 180, 'Android', 'Asus Zenfone 7'),
(16.4, 0.9, 1.0, 1080, 2400, 12, 512, 60, 10, 200, 'Android', 'OnePlus 8T'),
(14.0, 0.9, 0.8, 1080, 2400, 6, 512, 60, 10, 200, 'Custom Android', 'Samsung Galaxy S20'),
(16.4, 0.9, 1.0, 2340, 1440, 4, 256, 90, 12, 150, 'iOS', 'Motorola Edge Plus'),
(14.0, 0.8, 1.0, 1080, 1440, 8, 64, 90, 15, 200, 'Android', 'Sony Xperia 1'),
(14.0, 0.7, 1.0, 2340, 1080, 12, 256, 120, 15, 200, 'iOS', 'LG Velvet'),
(15.0, 0.7, 0.9, 3200, 2400, 8, 64, 120, 12, 180, 'Custom Android', 'Asus Zenfone 7'),
(16.4, 0.8, 0.9, 1080, 1080, 12, 256, 60, 12, 180, 'Android', 'LG Velvet'),
(16.4, 0.9, 1.0, 3200, 1440, 4, 256, 90, 12, 150, 'Android', 'iPhone 12'),
(16.4, 0.8, 0.8, 1080, 1440, 4, 256, 120, 12, 150, 'Custom Android', 'Xiaomi Mi 11'),
(16.4, 0.8, 0.8, 3200, 2400, 12, 128, 60, 10, 200, 'Android', 'Xiaomi Mi 11'),
(14.0, 0.9, 0.9, 3200, 1440, 8, 256, 120, 12, 200, 'iOS', 'Motorola Edge Plus'),
(16.4, 0.9, 1.0, 1080, 2400, 8, 64, 60, 10, 150, 'iOS', 'Google Pixel 5'),
(16.4, 0.8, 0.8, 3200, 1080, 12, 128, 120, 12, 150, 'iOS', 'Asus Zenfone 7'),
(16.4, 0.9, 0.8, 1080, 2400, 4, 512, 60, 10, 180, 'iOS', 'OnePlus 8T'),
(14.0, 0.9, 0.9, 1080, 1080, 12, 256, 90, 12, 200, 'iOS', 'Xiaomi Mi 11'),
(15.0, 0.7, 0.9, 3200, 1080, 4, 128, 90, 12, 180, 'iOS', 'OnePlus 8T'),
(14.0, 0.7, 0.9, 1080, 1080, 6, 512, 60, 12, 150, 'Android', 'Google Pixel 5'),
(14.0, 0.8, 0.9, 2340, 2400, 4, 256, 90, 15, 180, 'iOS', 'Xiaomi Mi 11'),
(14.0, 0.7, 1.0, 3200, 2400, 8, 64, 60, 15, 150, 'Android', 'Oppo Find X2'),
(16.4, 0.9, 1.0, 3200, 1440, 4, 512, 60, 12, 200, 'iOS', 'Xiaomi Mi 11'),
(14.0, 0.7, 0.9, 1080, 2400, 6, 64, 60, 15, 180, 'Custom Android', 'Nokia 9.3 PureView'),
(14.0, 0.8, 0.8, 2340, 2400, 4, 512, 120, 10, 200, 'iOS', 'Nokia 9.3 PureView'),
(15.0, 0.7, 0.8, 2340, 1440, 12, 512, 120, 10, 150, 'Android', 'iPhone 12'),
(16.4, 0.8, 0.8, 1080, 1080, 6, 512, 90, 12, 180, 'iOS', 'Oppo Find X2');

INSERT INTO Post(title, contents)
VALUES ('Cheap headphones cord breaks', 'I bought the cheap headphones 2 weeks ago. They were working great until last night when the cord snapped out of nowhere.'),
('Tt Ventus R review', 'I bought the Tt Ventus R mouse in order to review them on my YouTube channel. It arrived 3 days ago and I cannot believe I am saying it but it is worth the money.'),
('Looking for new phone', 'I am in the market for a new phone to replace my Iphone 10. Does anyone have any good information on some of the newer editions?'),
INSERT INTO Post (title, postDate, contents) VALUES ('"Looking for new phone"', NOW(), 'Delving into the topic of "Looking for new phone", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Blockchain Beyond Cryptocurrency"', NOW(), 'Delving into the topic of "Blockchain Beyond Cryptocurrency", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cybersecurity in a Connected World"', NOW(), 'Delving into the topic of "Cybersecurity in a Connected World", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Delving into the topic of "Personal Assistants and Smart Homes", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancing Education with E-Learning"', NOW(), 'Delving into the topic of "Advancing Education with E-Learning", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Tech in Art and Creative Industries"', NOW(), 'Delving into the topic of "Tech in Art and Creative Industries", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Autonomous Vehicles and Transportation"', NOW(), 'Delving into the topic of "Autonomous Vehicles and Transportation", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Delving into the topic of "Developing Tech for Disaster Response", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Delving into the topic of "Mobile Technology and App Development", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Growth of E-commerce Platforms"', NOW(), 'Delving into the topic of "The Growth of E-commerce Platforms", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Impact of 5G on Communication"', NOW(), 'Delving into the topic of "The Impact of 5G on Communication", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancing Education with E-Learning"', NOW(), 'Delving into the topic of "Advancing Education with E-Learning", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Impact of 5G on Communication"', NOW(), 'Delving into the topic of "The Impact of 5G on Communication", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Growth of E-commerce Platforms"', NOW(), 'Delving into the topic of "The Growth of E-commerce Platforms", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cloud Computing and Data Storage"', NOW(), 'Delving into the topic of "Cloud Computing and Data Storage", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Revolutionizing Agriculture with Tech"', NOW(), 'Delving into the topic of "Revolutionizing Agriculture with Tech", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Wearable Tech and Digital Health"', NOW(), 'Delving into the topic of "Wearable Tech and Digital Health", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancing Education with E-Learning"', NOW(), 'Delving into the topic of "Advancing Education with E-Learning", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Delving into the topic of "Personal Assistants and Smart Homes", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Gaming Technology and Interactive Media"', NOW(), 'Delving into the topic of "Gaming Technology and Interactive Media", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Tech in Art and Creative Industries"', NOW(), 'Delving into the topic of "Tech in Art and Creative Industries", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"3D Printing Changing Production"', NOW(), 'Delving into the topic of "3D Printing Changing Production", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancing Education with E-Learning"', NOW(), 'Delving into the topic of "Advancing Education with E-Learning", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Delving into the topic of "Mobile Technology and App Development", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Exploring the Capabilities of AI"', NOW(), 'Delving into the topic of "Exploring the Capabilities of AI", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Delving into the topic of "The Role of IoT in Smart Cities", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Autonomous Vehicles and Transportation"', NOW(), 'Delving into the topic of "Autonomous Vehicles and Transportation", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Robotic Automation in Manufacturing"', NOW(), 'Delving into the topic of "Robotic Automation in Manufacturing", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Social Media Trends and Data Privacy"', NOW(), 'Delving into the topic of "Social Media Trends and Data Privacy", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Delving into the topic of "Developing Tech for Disaster Response", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Big Data and Predictive Analytics"', NOW(), 'Delving into the topic of "Big Data and Predictive Analytics", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Delving into the topic of "The Role of IoT in Smart Cities", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Delving into the topic of "Developing Tech for Disaster Response", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Delving into the topic of "Developing Tech for Disaster Response", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Rise of Renewable Energy Tech"', NOW(), 'Delving into the topic of "The Rise of Renewable Energy Tech", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Delving into the topic of "Innovations in Drone Technology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancing Education with E-Learning"', NOW(), 'Delving into the topic of "Advancing Education with E-Learning", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Autonomous Vehicles and Transportation"', NOW(), 'Delving into the topic of "Autonomous Vehicles and Transportation", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Delving into the topic of "The Role of IoT in Smart Cities", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"3D Printing Changing Production"', NOW(), 'Delving into the topic of "3D Printing Changing Production", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Delving into the topic of "Innovations in Drone Technology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Delving into the topic of "Personal Assistants and Smart Homes", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Rise of Renewable Energy Tech"', NOW(), 'Delving into the topic of "The Rise of Renewable Energy Tech", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Gaming Technology and Interactive Media"', NOW(), 'Delving into the topic of "Gaming Technology and Interactive Media", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Delving into the topic of "Innovations in Drone Technology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Impact of 5G on Communication"', NOW(), 'Delving into the topic of "The Impact of 5G on Communication", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Delving into the topic of "Personal Assistants and Smart Homes", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Delving into the topic of "Innovations in Drone Technology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Breakthroughs in Nanotechnology"', NOW(), 'Delving into the topic of "Breakthroughs in Nanotechnology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Delving into the topic of "The Role of IoT in Smart Cities", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Growth of E-commerce Platforms"', NOW(), 'Delving into the topic of "The Growth of E-commerce Platforms", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Delving into the topic of "Personal Assistants and Smart Homes", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cybersecurity in a Connected World"', NOW(), 'Delving into the topic of "Cybersecurity in a Connected World", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Delving into the topic of "Personal Assistants and Smart Homes", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Delving into the topic of "The Role of IoT in Smart Cities", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Revolutionizing Agriculture with Tech"', NOW(), 'Delving into the topic of "Revolutionizing Agriculture with Tech", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancing Education with E-Learning"', NOW(), 'Delving into the topic of "Advancing Education with E-Learning", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Delving into the topic of "Innovations in Drone Technology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Expansion of Augmented Reality"', NOW(), 'Delving into the topic of "The Expansion of Augmented Reality", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Delving into the topic of "Innovations in Drone Technology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Breakthroughs in Nanotechnology"', NOW(), 'Delving into the topic of "Breakthroughs in Nanotechnology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Delving into the topic of "Developing Tech for Disaster Response", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Evolution of Virtual Reality"', NOW(), 'Delving into the topic of "The Evolution of Virtual Reality", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Growth of E-commerce Platforms"', NOW(), 'Delving into the topic of "The Growth of E-commerce Platforms", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Delving into the topic of "The Role of IoT in Smart Cities", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Delving into the topic of "Mobile Technology and App Development", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancements in Biotechnology"', NOW(), 'Delving into the topic of "Advancements in Biotechnology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cloud Computing and Data Storage"', NOW(), 'Delving into the topic of "Cloud Computing and Data Storage", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Gaming Technology and Interactive Media"', NOW(), 'Delving into the topic of "Gaming Technology and Interactive Media", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Robotic Automation in Manufacturing"', NOW(), 'Delving into the topic of "Robotic Automation in Manufacturing", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Delving into the topic of "Developing Tech for Disaster Response", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Blockchain Beyond Cryptocurrency"', NOW(), 'Delving into the topic of "Blockchain Beyond Cryptocurrency", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Blockchain Beyond Cryptocurrency"', NOW(), 'Delving into the topic of "Blockchain Beyond Cryptocurrency", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Wearable Tech and Digital Health"', NOW(), 'Delving into the topic of "Wearable Tech and Digital Health", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancements in Biotechnology"', NOW(), 'Delving into the topic of "Advancements in Biotechnology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Delving into the topic of "Personal Assistants and Smart Homes", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Delving into the topic of "Personal Assistants and Smart Homes", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Delving into the topic of "Developing Tech for Disaster Response", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Autonomous Vehicles and Transportation"', NOW(), 'Delving into the topic of "Autonomous Vehicles and Transportation", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Future of Quantum Computing"', NOW(), 'Delving into the topic of "The Future of Quantum Computing", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Autonomous Vehicles and Transportation"', NOW(), 'Delving into the topic of "Autonomous Vehicles and Transportation", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Revolutionizing Agriculture with Tech"', NOW(), 'Delving into the topic of "Revolutionizing Agriculture with Tech", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"3D Printing Changing Production"', NOW(), 'Delving into the topic of "3D Printing Changing Production", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Delving into the topic of "The Role of IoT in Smart Cities", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Delving into the topic of "Developing Tech for Disaster Response", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Impact of 5G on Communication"', NOW(), 'Delving into the topic of "The Impact of 5G on Communication", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cloud Computing and Data Storage"', NOW(), 'Delving into the topic of "Cloud Computing and Data Storage", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Wearable Tech and Digital Health"', NOW(), 'Delving into the topic of "Wearable Tech and Digital Health", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Breakthroughs in Nanotechnology"', NOW(), 'Delving into the topic of "Breakthroughs in Nanotechnology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Autonomous Vehicles and Transportation"', NOW(), 'Delving into the topic of "Autonomous Vehicles and Transportation", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Blockchain Beyond Cryptocurrency"', NOW(), 'Delving into the topic of "Blockchain Beyond Cryptocurrency", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Delving into the topic of "Mobile Technology and App Development", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Tech in Art and Creative Industries"', NOW(), 'Delving into the topic of "Tech in Art and Creative Industries", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancing Education with E-Learning"', NOW(), 'Delving into the topic of "Advancing Education with E-Learning", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Rise of Renewable Energy Tech"', NOW(), 'Delving into the topic of "The Rise of Renewable Energy Tech", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cybersecurity in a Connected World"', NOW(), 'Delving into the topic of "Cybersecurity in a Connected World", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Growth of E-commerce Platforms"', NOW(), 'Delving into the topic of "The Growth of E-commerce Platforms", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"3D Printing Changing Production"', NOW(), 'Delving into the topic of "3D Printing Changing Production", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Blockchain Beyond Cryptocurrency"', NOW(), 'Delving into the topic of "Blockchain Beyond Cryptocurrency", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cloud Computing and Data Storage"', NOW(), 'Delving into the topic of "Cloud Computing and Data Storage", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Expansion of Augmented Reality"', NOW(), 'Delving into the topic of "The Expansion of Augmented Reality", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Expansion of Augmented Reality"', NOW(), 'Delving into the topic of "The Expansion of Augmented Reality", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cybersecurity in a Connected World"', NOW(), 'Delving into the topic of "Cybersecurity in a Connected World", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cybersecurity in a Connected World"', NOW(), 'Delving into the topic of "Cybersecurity in a Connected World", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Wearable Tech and Digital Health"', NOW(), 'Delving into the topic of "Wearable Tech and Digital Health", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancements in Biotechnology"', NOW(), 'Delving into the topic of "Advancements in Biotechnology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"3D Printing Changing Production"', NOW(), 'Delving into the topic of "3D Printing Changing Production", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Delving into the topic of "Developing Tech for Disaster Response", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancements in Biotechnology"', NOW(), 'Delving into the topic of "Advancements in Biotechnology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Social Media Trends and Data Privacy"', NOW(), 'Delving into the topic of "Social Media Trends and Data Privacy", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Growth of E-commerce Platforms"', NOW(), 'Delving into the topic of "The Growth of E-commerce Platforms", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Delving into the topic of "Developing Tech for Disaster Response", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"3D Printing Changing Production"', NOW(), 'Delving into the topic of "3D Printing Changing Production", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Evolution of Virtual Reality"', NOW(), 'Delving into the topic of "The Evolution of Virtual Reality", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"3D Printing Changing Production"', NOW(), 'Delving into the topic of "3D Printing Changing Production", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Delving into the topic of "Mobile Technology and App Development", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Rise of Renewable Energy Tech"', NOW(), 'Delving into the topic of "The Rise of Renewable Energy Tech", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Evolution of Virtual Reality"', NOW(), 'Delving into the topic of "The Evolution of Virtual Reality", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Blockchain Beyond Cryptocurrency"', NOW(), 'Delving into the topic of "Blockchain Beyond Cryptocurrency", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Autonomous Vehicles and Transportation"', NOW(), 'Delving into the topic of "Autonomous Vehicles and Transportation", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancements in Biotechnology"', NOW(), 'Delving into the topic of "Advancements in Biotechnology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Delving into the topic of "The Role of IoT in Smart Cities", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Delving into the topic of "The Role of IoT in Smart Cities", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Evolution of Virtual Reality"', NOW(), 'Delving into the topic of "The Evolution of Virtual Reality", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cloud Computing and Data Storage"', NOW(), 'Delving into the topic of "Cloud Computing and Data Storage", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Wearable Tech and Digital Health"', NOW(), 'Delving into the topic of "Wearable Tech and Digital Health", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Gaming Technology and Interactive Media"', NOW(), 'Delving into the topic of "Gaming Technology and Interactive Media", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Growth of E-commerce Platforms"', NOW(), 'Delving into the topic of "The Growth of E-commerce Platforms", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Social Media Trends and Data Privacy"', NOW(), 'Delving into the topic of "Social Media Trends and Data Privacy", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Delving into the topic of "Mobile Technology and App Development", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Impact of 5G on Communication"', NOW(), 'Delving into the topic of "The Impact of 5G on Communication", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Gaming Technology and Interactive Media"', NOW(), 'Delving into the topic of "Gaming Technology and Interactive Media", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Future of Quantum Computing"', NOW(), 'Delving into the topic of "The Future of Quantum Computing", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Delving into the topic of "Innovations in Drone Technology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Gaming Technology and Interactive Media"', NOW(), 'Delving into the topic of "Gaming Technology and Interactive Media", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Delving into the topic of "Innovations in Drone Technology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Autonomous Vehicles and Transportation"', NOW(), 'Delving into the topic of "Autonomous Vehicles and Transportation", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Delving into the topic of "Mobile Technology and App Development", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"3D Printing Changing Production"', NOW(), 'Delving into the topic of "3D Printing Changing Production", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Blockchain Beyond Cryptocurrency"', NOW(), 'Delving into the topic of "Blockchain Beyond Cryptocurrency", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Future of Quantum Computing"', NOW(), 'Delving into the topic of "The Future of Quantum Computing", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cybersecurity in a Connected World"', NOW(), 'Delving into the topic of "Cybersecurity in a Connected World", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Delving into the topic of "Innovations in Drone Technology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Exploring the Capabilities of AI"', NOW(), 'Delving into the topic of "Exploring the Capabilities of AI", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Delving into the topic of "Personal Assistants and Smart Homes", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Breakthroughs in Nanotechnology"', NOW(), 'Delving into the topic of "Breakthroughs in Nanotechnology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Delving into the topic of "Mobile Technology and App Development", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Delving into the topic of "Personal Assistants and Smart Homes", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Robotic Automation in Manufacturing"', NOW(), 'Delving into the topic of "Robotic Automation in Manufacturing", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Delving into the topic of "Innovations in Drone Technology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Delving into the topic of "Innovations in Drone Technology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cybersecurity in a Connected World"', NOW(), 'Delving into the topic of "Cybersecurity in a Connected World", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Wearable Tech and Digital Health"', NOW(), 'Delving into the topic of "Wearable Tech and Digital Health", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancements in Biotechnology"', NOW(), 'Delving into the topic of "Advancements in Biotechnology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Gaming Technology and Interactive Media"', NOW(), 'Delving into the topic of "Gaming Technology and Interactive Media", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Delving into the topic of "Personal Assistants and Smart Homes", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cybersecurity in a Connected World"', NOW(), 'Delving into the topic of "Cybersecurity in a Connected World", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Impact of 5G on Communication"', NOW(), 'Delving into the topic of "The Impact of 5G on Communication", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Wearable Tech and Digital Health"', NOW(), 'Delving into the topic of "Wearable Tech and Digital Health", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Delving into the topic of "Mobile Technology and App Development", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Rise of Renewable Energy Tech"', NOW(), 'Delving into the topic of "The Rise of Renewable Energy Tech", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Robotic Automation in Manufacturing"', NOW(), 'Delving into the topic of "Robotic Automation in Manufacturing", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Delving into the topic of "Innovations in Drone Technology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Delving into the topic of "Developing Tech for Disaster Response", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Exploring the Capabilities of AI"', NOW(), 'Delving into the topic of "Exploring the Capabilities of AI", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Expansion of Augmented Reality"', NOW(), 'Delving into the topic of "The Expansion of Augmented Reality", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Delving into the topic of "Mobile Technology and App Development", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Delving into the topic of "The Role of IoT in Smart Cities", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The New Era of Space Exploration"', NOW(), 'Delving into the topic of "The New Era of Space Exploration", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Breakthroughs in Nanotechnology"', NOW(), 'Delving into the topic of "Breakthroughs in Nanotechnology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cybersecurity in a Connected World"', NOW(), 'Delving into the topic of "Cybersecurity in a Connected World", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Wearable Tech and Digital Health"', NOW(), 'Delving into the topic of "Wearable Tech and Digital Health", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Delving into the topic of "The Role of IoT in Smart Cities", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Gaming Technology and Interactive Media"', NOW(), 'Delving into the topic of "Gaming Technology and Interactive Media", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancements in Biotechnology"', NOW(), 'Delving into the topic of "Advancements in Biotechnology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Delving into the topic of "Mobile Technology and App Development", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Big Data and Predictive Analytics"', NOW(), 'Delving into the topic of "Big Data and Predictive Analytics", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cloud Computing and Data Storage"', NOW(), 'Delving into the topic of "Cloud Computing and Data Storage", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Breakthroughs in Nanotechnology"', NOW(), 'Delving into the topic of "Breakthroughs in Nanotechnology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Social Media Trends and Data Privacy"', NOW(), 'Delving into the topic of "Social Media Trends and Data Privacy", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Social Media Trends and Data Privacy"', NOW(), 'Delving into the topic of "Social Media Trends and Data Privacy", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Big Data and Predictive Analytics"', NOW(), 'Delving into the topic of "Big Data and Predictive Analytics", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Rise of Renewable Energy Tech"', NOW(), 'Delving into the topic of "The Rise of Renewable Energy Tech", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cloud Computing and Data Storage"', NOW(), 'Delving into the topic of "Cloud Computing and Data Storage", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Expansion of Augmented Reality"', NOW(), 'Delving into the topic of "The Expansion of Augmented Reality", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Delving into the topic of "Innovations in Drone Technology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cloud Computing and Data Storage"', NOW(), 'Delving into the topic of "Cloud Computing and Data Storage", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Tech in Art and Creative Industries"', NOW(), 'Delving into the topic of "Tech in Art and Creative Industries", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Expansion of Augmented Reality"', NOW(), 'Delving into the topic of "The Expansion of Augmented Reality", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Revolutionizing Agriculture with Tech"', NOW(), 'Delving into the topic of "Revolutionizing Agriculture with Tech", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Blockchain Beyond Cryptocurrency"', NOW(), 'Delving into the topic of "Blockchain Beyond Cryptocurrency", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Robotic Automation in Manufacturing"', NOW(), 'Delving into the topic of "Robotic Automation in Manufacturing", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Delving into the topic of "Innovations in Drone Technology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Impact of 5G on Communication"', NOW(), 'Delving into the topic of "The Impact of 5G on Communication", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cloud Computing and Data Storage"', NOW(), 'Delving into the topic of "Cloud Computing and Data Storage", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Exploring the Capabilities of AI"', NOW(), 'Delving into the topic of "Exploring the Capabilities of AI", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Delving into the topic of "Innovations in Drone Technology", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Delving into the topic of "Mobile Technology and App Development", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Autonomous Vehicles and Transportation"', NOW(), 'Delving into the topic of "Autonomous Vehicles and Transportation", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Evolution of Virtual Reality"', NOW(), 'Delving into the topic of "The Evolution of Virtual Reality", this article discusses the latest insights and developments.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Looking for new phone"', NOW(), 'Discussion and insights on "Looking for new phone", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Blockchain Beyond Cryptocurrency"', NOW(), 'Discussion and insights on "Blockchain Beyond Cryptocurrency", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cybersecurity in a Connected World"', NOW(), 'Discussion and insights on "Cybersecurity in a Connected World", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Discussion and insights on "Personal Assistants and Smart Homes", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancing Education with E-Learning"', NOW(), 'Discussion and insights on "Advancing Education with E-Learning", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Tech in Art and Creative Industries"', NOW(), 'Discussion and insights on "Tech in Art and Creative Industries", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Autonomous Vehicles and Transportation"', NOW(), 'Discussion and insights on "Autonomous Vehicles and Transportation", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Discussion and insights on "Developing Tech for Disaster Response", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Discussion and insights on "Mobile Technology and App Development", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Growth of E-commerce Platforms"', NOW(), 'Discussion and insights on "The Growth of E-commerce Platforms", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Impact of 5G on Communication"', NOW(), 'Discussion and insights on "The Impact of 5G on Communication", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancing Education with E-Learning"', NOW(), 'Discussion and insights on "Advancing Education with E-Learning", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Impact of 5G on Communication"', NOW(), 'Discussion and insights on "The Impact of 5G on Communication", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Growth of E-commerce Platforms"', NOW(), 'Discussion and insights on "The Growth of E-commerce Platforms", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cloud Computing and Data Storage"', NOW(), 'Discussion and insights on "Cloud Computing and Data Storage", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Revolutionizing Agriculture with Tech"', NOW(), 'Discussion and insights on "Revolutionizing Agriculture with Tech", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Wearable Tech and Digital Health"', NOW(), 'Discussion and insights on "Wearable Tech and Digital Health", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancing Education with E-Learning"', NOW(), 'Discussion and insights on "Advancing Education with E-Learning", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Discussion and insights on "Personal Assistants and Smart Homes", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Gaming Technology and Interactive Media"', NOW(), 'Discussion and insights on "Gaming Technology and Interactive Media", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Tech in Art and Creative Industries"', NOW(), 'Discussion and insights on "Tech in Art and Creative Industries", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"3D Printing Changing Production"', NOW(), 'Discussion and insights on "3D Printing Changing Production", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancing Education with E-Learning"', NOW(), 'Discussion and insights on "Advancing Education with E-Learning", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Discussion and insights on "Mobile Technology and App Development", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Exploring the Capabilities of AI"', NOW(), 'Discussion and insights on "Exploring the Capabilities of AI", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Discussion and insights on "The Role of IoT in Smart Cities", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Autonomous Vehicles and Transportation"', NOW(), 'Discussion and insights on "Autonomous Vehicles and Transportation", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Robotic Automation in Manufacturing"', NOW(), 'Discussion and insights on "Robotic Automation in Manufacturing", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Social Media Trends and Data Privacy"', NOW(), 'Discussion and insights on "Social Media Trends and Data Privacy", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Discussion and insights on "Developing Tech for Disaster Response", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Big Data and Predictive Analytics"', NOW(), 'Discussion and insights on "Big Data and Predictive Analytics", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Discussion and insights on "The Role of IoT in Smart Cities", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Discussion and insights on "Developing Tech for Disaster Response", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Discussion and insights on "Developing Tech for Disaster Response", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Rise of Renewable Energy Tech"', NOW(), 'Discussion and insights on "The Rise of Renewable Energy Tech", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Discussion and insights on "Innovations in Drone Technology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancing Education with E-Learning"', NOW(), 'Discussion and insights on "Advancing Education with E-Learning", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Autonomous Vehicles and Transportation"', NOW(), 'Discussion and insights on "Autonomous Vehicles and Transportation", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Discussion and insights on "The Role of IoT in Smart Cities", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"3D Printing Changing Production"', NOW(), 'Discussion and insights on "3D Printing Changing Production", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Discussion and insights on "Innovations in Drone Technology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Discussion and insights on "Personal Assistants and Smart Homes", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Rise of Renewable Energy Tech"', NOW(), 'Discussion and insights on "The Rise of Renewable Energy Tech", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Gaming Technology and Interactive Media"', NOW(), 'Discussion and insights on "Gaming Technology and Interactive Media", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Discussion and insights on "Innovations in Drone Technology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Impact of 5G on Communication"', NOW(), 'Discussion and insights on "The Impact of 5G on Communication", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Discussion and insights on "Personal Assistants and Smart Homes", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Discussion and insights on "Innovations in Drone Technology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Breakthroughs in Nanotechnology"', NOW(), 'Discussion and insights on "Breakthroughs in Nanotechnology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Discussion and insights on "The Role of IoT in Smart Cities", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Growth of E-commerce Platforms"', NOW(), 'Discussion and insights on "The Growth of E-commerce Platforms", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Discussion and insights on "Personal Assistants and Smart Homes", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cybersecurity in a Connected World"', NOW(), 'Discussion and insights on "Cybersecurity in a Connected World", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Discussion and insights on "Personal Assistants and Smart Homes", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Discussion and insights on "The Role of IoT in Smart Cities", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Revolutionizing Agriculture with Tech"', NOW(), 'Discussion and insights on "Revolutionizing Agriculture with Tech", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancing Education with E-Learning"', NOW(), 'Discussion and insights on "Advancing Education with E-Learning", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Discussion and insights on "Innovations in Drone Technology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Expansion of Augmented Reality"', NOW(), 'Discussion and insights on "The Expansion of Augmented Reality", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Discussion and insights on "Innovations in Drone Technology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Breakthroughs in Nanotechnology"', NOW(), 'Discussion and insights on "Breakthroughs in Nanotechnology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Discussion and insights on "Developing Tech for Disaster Response", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Evolution of Virtual Reality"', NOW(), 'Discussion and insights on "The Evolution of Virtual Reality", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Growth of E-commerce Platforms"', NOW(), 'Discussion and insights on "The Growth of E-commerce Platforms", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Discussion and insights on "The Role of IoT in Smart Cities", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Discussion and insights on "Mobile Technology and App Development", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancements in Biotechnology"', NOW(), 'Discussion and insights on "Advancements in Biotechnology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cloud Computing and Data Storage"', NOW(), 'Discussion and insights on "Cloud Computing and Data Storage", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Gaming Technology and Interactive Media"', NOW(), 'Discussion and insights on "Gaming Technology and Interactive Media", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Robotic Automation in Manufacturing"', NOW(), 'Discussion and insights on "Robotic Automation in Manufacturing", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Discussion and insights on "Developing Tech for Disaster Response", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Blockchain Beyond Cryptocurrency"', NOW(), 'Discussion and insights on "Blockchain Beyond Cryptocurrency", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Blockchain Beyond Cryptocurrency"', NOW(), 'Discussion and insights on "Blockchain Beyond Cryptocurrency", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Wearable Tech and Digital Health"', NOW(), 'Discussion and insights on "Wearable Tech and Digital Health", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancements in Biotechnology"', NOW(), 'Discussion and insights on "Advancements in Biotechnology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Discussion and insights on "Personal Assistants and Smart Homes", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Discussion and insights on "Personal Assistants and Smart Homes", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Discussion and insights on "Developing Tech for Disaster Response", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Autonomous Vehicles and Transportation"', NOW(), 'Discussion and insights on "Autonomous Vehicles and Transportation", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Future of Quantum Computing"', NOW(), 'Discussion and insights on "The Future of Quantum Computing", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Autonomous Vehicles and Transportation"', NOW(), 'Discussion and insights on "Autonomous Vehicles and Transportation", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Revolutionizing Agriculture with Tech"', NOW(), 'Discussion and insights on "Revolutionizing Agriculture with Tech", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"3D Printing Changing Production"', NOW(), 'Discussion and insights on "3D Printing Changing Production", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Discussion and insights on "The Role of IoT in Smart Cities", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Discussion and insights on "Developing Tech for Disaster Response", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Impact of 5G on Communication"', NOW(), 'Discussion and insights on "The Impact of 5G on Communication", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cloud Computing and Data Storage"', NOW(), 'Discussion and insights on "Cloud Computing and Data Storage", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Wearable Tech and Digital Health"', NOW(), 'Discussion and insights on "Wearable Tech and Digital Health", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Breakthroughs in Nanotechnology"', NOW(), 'Discussion and insights on "Breakthroughs in Nanotechnology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Autonomous Vehicles and Transportation"', NOW(), 'Discussion and insights on "Autonomous Vehicles and Transportation", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Blockchain Beyond Cryptocurrency"', NOW(), 'Discussion and insights on "Blockchain Beyond Cryptocurrency", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Discussion and insights on "Mobile Technology and App Development", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Tech in Art and Creative Industries"', NOW(), 'Discussion and insights on "Tech in Art and Creative Industries", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancing Education with E-Learning"', NOW(), 'Discussion and insights on "Advancing Education with E-Learning", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Rise of Renewable Energy Tech"', NOW(), 'Discussion and insights on "The Rise of Renewable Energy Tech", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cybersecurity in a Connected World"', NOW(), 'Discussion and insights on "Cybersecurity in a Connected World", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Growth of E-commerce Platforms"', NOW(), 'Discussion and insights on "The Growth of E-commerce Platforms", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"3D Printing Changing Production"', NOW(), 'Discussion and insights on "3D Printing Changing Production", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Blockchain Beyond Cryptocurrency"', NOW(), 'Discussion and insights on "Blockchain Beyond Cryptocurrency", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cloud Computing and Data Storage"', NOW(), 'Discussion and insights on "Cloud Computing and Data Storage", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Expansion of Augmented Reality"', NOW(), 'Discussion and insights on "The Expansion of Augmented Reality", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Expansion of Augmented Reality"', NOW(), 'Discussion and insights on "The Expansion of Augmented Reality", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cybersecurity in a Connected World"', NOW(), 'Discussion and insights on "Cybersecurity in a Connected World", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cybersecurity in a Connected World"', NOW(), 'Discussion and insights on "Cybersecurity in a Connected World", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Wearable Tech and Digital Health"', NOW(), 'Discussion and insights on "Wearable Tech and Digital Health", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancements in Biotechnology"', NOW(), 'Discussion and insights on "Advancements in Biotechnology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"3D Printing Changing Production"', NOW(), 'Discussion and insights on "3D Printing Changing Production", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Discussion and insights on "Developing Tech for Disaster Response", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancements in Biotechnology"', NOW(), 'Discussion and insights on "Advancements in Biotechnology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Social Media Trends and Data Privacy"', NOW(), 'Discussion and insights on "Social Media Trends and Data Privacy", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Growth of E-commerce Platforms"', NOW(), 'Discussion and insights on "The Growth of E-commerce Platforms", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Discussion and insights on "Developing Tech for Disaster Response", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"3D Printing Changing Production"', NOW(), 'Discussion and insights on "3D Printing Changing Production", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Evolution of Virtual Reality"', NOW(), 'Discussion and insights on "The Evolution of Virtual Reality", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"3D Printing Changing Production"', NOW(), 'Discussion and insights on "3D Printing Changing Production", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Discussion and insights on "Mobile Technology and App Development", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Rise of Renewable Energy Tech"', NOW(), 'Discussion and insights on "The Rise of Renewable Energy Tech", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Evolution of Virtual Reality"', NOW(), 'Discussion and insights on "The Evolution of Virtual Reality", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Blockchain Beyond Cryptocurrency"', NOW(), 'Discussion and insights on "Blockchain Beyond Cryptocurrency", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Autonomous Vehicles and Transportation"', NOW(), 'Discussion and insights on "Autonomous Vehicles and Transportation", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancements in Biotechnology"', NOW(), 'Discussion and insights on "Advancements in Biotechnology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Discussion and insights on "The Role of IoT in Smart Cities", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Discussion and insights on "The Role of IoT in Smart Cities", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Evolution of Virtual Reality"', NOW(), 'Discussion and insights on "The Evolution of Virtual Reality", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cloud Computing and Data Storage"', NOW(), 'Discussion and insights on "Cloud Computing and Data Storage", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Wearable Tech and Digital Health"', NOW(), 'Discussion and insights on "Wearable Tech and Digital Health", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Gaming Technology and Interactive Media"', NOW(), 'Discussion and insights on "Gaming Technology and Interactive Media", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Growth of E-commerce Platforms"', NOW(), 'Discussion and insights on "The Growth of E-commerce Platforms", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Social Media Trends and Data Privacy"', NOW(), 'Discussion and insights on "Social Media Trends and Data Privacy", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Discussion and insights on "Mobile Technology and App Development", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Impact of 5G on Communication"', NOW(), 'Discussion and insights on "The Impact of 5G on Communication", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Gaming Technology and Interactive Media"', NOW(), 'Discussion and insights on "Gaming Technology and Interactive Media", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Future of Quantum Computing"', NOW(), 'Discussion and insights on "The Future of Quantum Computing", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Discussion and insights on "Innovations in Drone Technology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Gaming Technology and Interactive Media"', NOW(), 'Discussion and insights on "Gaming Technology and Interactive Media", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Discussion and insights on "Innovations in Drone Technology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Autonomous Vehicles and Transportation"', NOW(), 'Discussion and insights on "Autonomous Vehicles and Transportation", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Discussion and insights on "Mobile Technology and App Development", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"3D Printing Changing Production"', NOW(), 'Discussion and insights on "3D Printing Changing Production", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Blockchain Beyond Cryptocurrency"', NOW(), 'Discussion and insights on "Blockchain Beyond Cryptocurrency", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Future of Quantum Computing"', NOW(), 'Discussion and insights on "The Future of Quantum Computing", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cybersecurity in a Connected World"', NOW(), 'Discussion and insights on "Cybersecurity in a Connected World", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Discussion and insights on "Innovations in Drone Technology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Exploring the Capabilities of AI"', NOW(), 'Discussion and insights on "Exploring the Capabilities of AI", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Discussion and insights on "Personal Assistants and Smart Homes", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Breakthroughs in Nanotechnology"', NOW(), 'Discussion and insights on "Breakthroughs in Nanotechnology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Discussion and insights on "Mobile Technology and App Development", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Discussion and insights on "Personal Assistants and Smart Homes", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Robotic Automation in Manufacturing"', NOW(), 'Discussion and insights on "Robotic Automation in Manufacturing", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Discussion and insights on "Innovations in Drone Technology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Discussion and insights on "Innovations in Drone Technology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cybersecurity in a Connected World"', NOW(), 'Discussion and insights on "Cybersecurity in a Connected World", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Wearable Tech and Digital Health"', NOW(), 'Discussion and insights on "Wearable Tech and Digital Health", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancements in Biotechnology"', NOW(), 'Discussion and insights on "Advancements in Biotechnology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Gaming Technology and Interactive Media"', NOW(), 'Discussion and insights on "Gaming Technology and Interactive Media", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Personal Assistants and Smart Homes"', NOW(), 'Discussion and insights on "Personal Assistants and Smart Homes", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cybersecurity in a Connected World"', NOW(), 'Discussion and insights on "Cybersecurity in a Connected World", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Impact of 5G on Communication"', NOW(), 'Discussion and insights on "The Impact of 5G on Communication", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Wearable Tech and Digital Health"', NOW(), 'Discussion and insights on "Wearable Tech and Digital Health", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Discussion and insights on "Mobile Technology and App Development", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Rise of Renewable Energy Tech"', NOW(), 'Discussion and insights on "The Rise of Renewable Energy Tech", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Robotic Automation in Manufacturing"', NOW(), 'Discussion and insights on "Robotic Automation in Manufacturing", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Discussion and insights on "Innovations in Drone Technology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Developing Tech for Disaster Response"', NOW(), 'Discussion and insights on "Developing Tech for Disaster Response", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Exploring the Capabilities of AI"', NOW(), 'Discussion and insights on "Exploring the Capabilities of AI", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Expansion of Augmented Reality"', NOW(), 'Discussion and insights on "The Expansion of Augmented Reality", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Discussion and insights on "Mobile Technology and App Development", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Discussion and insights on "The Role of IoT in Smart Cities", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The New Era of Space Exploration"', NOW(), 'Discussion and insights on "The New Era of Space Exploration", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Breakthroughs in Nanotechnology"', NOW(), 'Discussion and insights on "Breakthroughs in Nanotechnology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cybersecurity in a Connected World"', NOW(), 'Discussion and insights on "Cybersecurity in a Connected World", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Wearable Tech and Digital Health"', NOW(), 'Discussion and insights on "Wearable Tech and Digital Health", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Role of IoT in Smart Cities"', NOW(), 'Discussion and insights on "The Role of IoT in Smart Cities", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Gaming Technology and Interactive Media"', NOW(), 'Discussion and insights on "Gaming Technology and Interactive Media", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Advancements in Biotechnology"', NOW(), 'Discussion and insights on "Advancements in Biotechnology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Discussion and insights on "Mobile Technology and App Development", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Big Data and Predictive Analytics"', NOW(), 'Discussion and insights on "Big Data and Predictive Analytics", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cloud Computing and Data Storage"', NOW(), 'Discussion and insights on "Cloud Computing and Data Storage", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Breakthroughs in Nanotechnology"', NOW(), 'Discussion and insights on "Breakthroughs in Nanotechnology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Social Media Trends and Data Privacy"', NOW(), 'Discussion and insights on "Social Media Trends and Data Privacy", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Social Media Trends and Data Privacy"', NOW(), 'Discussion and insights on "Social Media Trends and Data Privacy", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Big Data and Predictive Analytics"', NOW(), 'Discussion and insights on "Big Data and Predictive Analytics", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Rise of Renewable Energy Tech"', NOW(), 'Discussion and insights on "The Rise of Renewable Energy Tech", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cloud Computing and Data Storage"', NOW(), 'Discussion and insights on "Cloud Computing and Data Storage", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Expansion of Augmented Reality"', NOW(), 'Discussion and insights on "The Expansion of Augmented Reality", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Discussion and insights on "Innovations in Drone Technology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cloud Computing and Data Storage"', NOW(), 'Discussion and insights on "Cloud Computing and Data Storage", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Tech in Art and Creative Industries"', NOW(), 'Discussion and insights on "Tech in Art and Creative Industries", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Expansion of Augmented Reality"', NOW(), 'Discussion and insights on "The Expansion of Augmented Reality", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Revolutionizing Agriculture with Tech"', NOW(), 'Discussion and insights on "Revolutionizing Agriculture with Tech", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Blockchain Beyond Cryptocurrency"', NOW(), 'Discussion and insights on "Blockchain Beyond Cryptocurrency", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Robotic Automation in Manufacturing"', NOW(), 'Discussion and insights on "Robotic Automation in Manufacturing", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Discussion and insights on "Innovations in Drone Technology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Impact of 5G on Communication"', NOW(), 'Discussion and insights on "The Impact of 5G on Communication", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Cloud Computing and Data Storage"', NOW(), 'Discussion and insights on "Cloud Computing and Data Storage", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Exploring the Capabilities of AI"', NOW(), 'Discussion and insights on "Exploring the Capabilities of AI", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Innovations in Drone Technology"', NOW(), 'Discussion and insights on "Innovations in Drone Technology", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Mobile Technology and App Development"', NOW(), 'Discussion and insights on "Mobile Technology and App Development", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"Autonomous Vehicles and Transportation"', NOW(), 'Discussion and insights on "Autonomous Vehicles and Transportation", reflecting the current state and future possibilities in technology.');
INSERT INTO Post (title, postDate, contents) VALUES ('"The Evolution of Virtual Reality"', NOW(), 'Discussion and insights on "The Evolution of Virtual Reality", reflecting the current state and future possibilities in technology.');


INSERT INTO LaptopPorts (laptopID, port)
VALUES (1, 'USB-C'),
(1, 'Dell Charger'),
(1, 'USB-A'),
(1, 'HDMI'),
(2, 'USB Type-C'),
(2, 'USB-A 3.1'),
(2, 'HDMI 2.0'),
(2, 'Headphone Jack'),
(2, 'MicroSD Card Slot'),
(2, 'Mini DisplayPort'),
(2, 'Ethernet'),
(3, 'USB Type-C'),
(3, 'USB-A 3.0'),
(3, 'HDMI'),
(3, 'Headphone Jack'),
(3, 'SD Card Reader'),
(3, 'Ethernet'),
(3, 'Thunderbolt 4'),
(4, 'USB Type-C'),
(4, 'USB-A 3.1'),
(4, 'HDMI 2.1'),
(4, 'Headphone Jack'),
(4, 'SD Card Reader'),
(4, 'Ethernet'),
(4, 'Thunderbolt 4'),
(4, 'Kensington Lock Slot'),
(5, 'USB Type-C'),
(5, 'USB-A 3.0'),
(5, 'HDMI'),
(5, 'Headphone Jack'),
(5, 'SD Card Reader'),
(5, 'Ethernet'),
(5, 'Thunderbolt 3'),
(6, 'USB Type-C'),
(6, 'USB-A 3.1'),
(6, 'HDMI 2.0'),
(6, 'Headphone Jack'),
(6, 'MicroSD Card Slot'),
(6, 'Mini DisplayPort'),
(6, 'Ethernet'),
(7, 'USB Type-C'),
(7, 'USB-A 3.0'),
(7, 'HDMI'),
(7, 'Headphone Jack'),
(7, 'SD Card Reader'),
(7, 'Ethernet'),
(7, 'Thunderbolt 4'),
(8, 'USB Type-C'),
(8, 'USB-A 3.1'),
(8, 'HDMI 2.1'),
(8, 'Headphone Jack'),
(8, 'SD Card Reader'),
(8, 'Ethernet'),
(8, 'Thunderbolt 4'),
(8, 'Kensington Lock Slot'),
(9, 'USB Type-C'),
(9, 'USB-A 3.0'),
(9, 'HDMI'),
(9, 'Headphone Jack'),
(9, 'SD Card Reader'),
(9, 'Ethernet'),
(9, 'Thunderbolt 3'),
(10, 'USB Type-C'),
(10, 'USB-A 3.1'),
(10, 'HDMI 2.0'),
(10, 'Headphone Jack'),
(10, 'MicroSD Card Slot'),
(10, 'Mini DisplayPort'),
(10, 'Ethernet'),
(11, 'USB Type-C'),
(11, 'USB-A 3.0'),
(11, 'HDMI'),
(11, 'Headphone Jack'),
(11, 'SD Card Reader'),
(11, 'Ethernet'),
(11, 'Thunderbolt 4'),
(12, 'USB Type-C'),
(12, 'USB-A 3.1'),
(12, 'HDMI 2.1'),
(12, 'Headphone Jack'),
(12, 'SD Card Reader'),
(12, 'Ethernet'),
(12, 'Thunderbolt 4'),
(12, 'Kensington Lock Slot'),
(13, 'USB Type-C'),
(13, 'USB-A 3.0'),
(13, 'HDMI'),
(13, 'Headphone Jack'),
(13, 'SD Card Reader'),
(13, 'Ethernet'),
(13, 'Thunderbolt 3'),
(14, 'USB Type-C'),
(14, 'USB-A 3.1'),
(14, 'HDMI 2.0'),
(14, 'Headphone Jack'),
(14, 'MicroSD Card Slot'),
(14, 'Mini DisplayPort'),
(14, 'Ethernet'),
(15, 'USB Type-C'),
(15, 'USB-A 3.0'),
(15, 'HDMI'),
(15, 'Headphone Jack'),
(15, 'SD Card Reader'),
(15, 'Ethernet'),
(15, 'Thunderbolt 4'),
(16, 'USB Type-C'),
(16, 'USB-A 3.1'),
(16, 'HDMI 2.1'),
(16, 'Headphone Jack'),
(16, 'SD Card Reader'),
(16, 'Ethernet'),
(16, 'Thunderbolt 4'),
(16, 'Kensington Lock Slot'),
(17, 'USB Type-C'),
(17, 'USB-A 3.0'),
(17, 'HDMI'),
(17, 'Headphone Jack'),
(17, 'SD Card Reader'),
(17, 'Ethernet'),
(17, 'Thunderbolt 3'),
(18, 'USB Type-C'),
(18, 'USB-A 3.1'),
(18, 'HDMI 2.0'),
(18, 'Headphone Jack'),
(18, 'MicroSD Card Slot'),
(18, 'Mini DisplayPort'),
(18, 'Ethernet'),
(19, 'USB Type-C'),
(19, 'USB-A 3.0'),
(19, 'HDMI'),
(19, 'Headphone Jack'),
(19, 'SD Card Reader'),
(19, 'Ethernet'),
(19, 'Thunderbolt 4'),
(20, 'USB Type-C'),
(20, 'USB-A 3.1'),
(20, 'HDMI 2.1'),
(20, 'Headphone Jack'),
(20, 'SD Card Reader'),
(20, 'Ethernet'),
(20, 'Thunderbolt 4'),
(20, 'Kensington Lock Slot'),
(21, 'USB Type-C'),
(21, 'USB-A 3.0'),
(21, 'HDMI'),
(21, 'Headphone Jack'),
(21, 'SD Card Reader'),
(21, 'Ethernet'),
(21, 'Thunderbolt 3'),
(22, 'USB Type-C'),
(22, 'USB-A 3.1'),
(22, 'HDMI 2.0'),
(22, 'Headphone Jack'),
(22, 'MicroSD Card Slot'),
(22, 'Mini DisplayPort'),
(22, 'Ethernet'),
(23, 'USB Type-C'),
(23, 'USB-A 3.0'),
(23, 'HDMI'),
(23, 'Headphone Jack'),
(23, 'SD Card Reader'),
(23, 'Ethernet'),
(23, 'Thunderbolt 4'),
(24, 'USB Type-C'),
(24, 'USB-A 3.1'),
(24, 'HDMI 2.1'),
(24, 'Headphone Jack'),
(24, 'SD Card Reader'),
(24, 'Ethernet'),
(24, 'Thunderbolt 4'),
(24, 'Kensington Lock Slot'),
(25, 'USB Type-C'),
(25, 'USB-A 3.0'),
(25, 'HDMI'),
(25, 'Headphone Jack'),
(25, 'SD Card Reader'),
(25, 'Ethernet'),
(25, 'Thunderbolt 3'),
(26, 'USB Type-C'),
(26, 'USB-A 3.1'),
(26, 'HDMI 2.0'),
(26, 'Headphone Jack'),
(26, 'MicroSD Card Slot'),
(26, 'Mini DisplayPort'),
(26, 'Ethernet'),
(27, 'USB Type-C'),
(27, 'USB-A 3.0'),
(27, 'HDMI'),
(27, 'Headphone Jack'),
(27, 'SD Card Reader'),
(27, 'Ethernet'),
(27, 'Thunderbolt 4'),
(28, 'USB Type-C'),
(28, 'USB-A 3.1'),
(28, 'HDMI 2.1'),
(28, 'Headphone Jack'),
(28, 'SD Card Reader'),
(28, 'Ethernet'),
(28, 'Thunderbolt 4'),
(28, 'Kensington Lock Slot'),
(29, 'USB Type-C'),
(29, 'USB-A 3.0'),
(29, 'HDMI'),
(29, 'Headphone Jack'),
(29, 'SD Card Reader'),
(29, 'Ethernet'),
(29, 'Thunderbolt 3'),
(30, 'USB Type-C'),
(30, 'USB-A 3.1'),
(30, 'HDMI 2.0'),
(30, 'Headphone Jack'),
(30, 'MicroSD Card Slot'),
(30, 'Mini DisplayPort'),
(30, 'Ethernet'),
(31, 'USB Type-C'),
(31, 'USB-A 3.0'),
(31, 'HDMI'),
(31, 'Headphone Jack'),
(31, 'SD Card Reader'),
(31, 'Ethernet'),
(31, 'Thunderbolt 4'),
(32, 'USB Type-C'),
(32, 'USB-A 3.1'),
(32, 'HDMI 2.1'),
(32, 'Headphone Jack'),
(32, 'SD Card Reader'),
(32, 'Ethernet'),
(32, 'Thunderbolt 4'),
(32, 'Kensington Lock Slot'),
(33, 'USB Type-C'),
(33, 'USB-A 3.0'),
(33, 'HDMI'),
(33, 'Headphone Jack'),
(33, 'SD Card Reader'),
(33, 'Ethernet'),
(33, 'Thunderbolt 3');

INSERT INTO MakesKeyboard (manufacturerID, KeyboardID)
VALUES (6, 1),
(9, 2),
(5, 3),
(4, 15),
(27, 26),
(27, 6),
(15, 22),
(15, 16),
(18, 26),
(23, 17),
(17, 24),
(19, 14),
(17, 14),
(4, 16),
(4, 24),
(18, 18),
(22, 27),
(7, 6),
(23, 2),
(18, 7),
(1, 19),
(7, 24),
(22, 27),
(14, 4),
(5, 3),
(7, 25),
(22, 8),
(9, 11),
(5, 18),
(4, 16),
(15, 17),
(26, 18),
(4, 24),
(17, 5),
(16, 20),
(25, 14),
(8, 2),
(28, 25),
(2, 5),
(20, 9),
(26, 11),
(3, 9),
(5, 10),
(18, 19),
(4, 26),
(19, 12),
(5, 2),
(5, 25),
(4, 20),
(15, 7),
(17, 27),
(1, 3),
(4, 4),
(7, 5),
(15, 5),
(11, 7),
(12, 23),
(1, 5),
(21, 6),
(23, 9),
(5, 27),
(3, 13),
(25, 5),
(17, 24),
(5, 13),
(1, 18),
(10, 17),
(15, 3),
(7, 1),
(27, 20),
(24, 1),
(20, 23),
(11, 14),
(9, 5),
(23, 8),
(14, 1),
(20, 24),
(5, 15),
(13, 4),
(17, 18),
(28, 12),
(21, 19),
(15, 8),
(25, 16),
(7, 16),
(21, 18),
(10, 15),
(23, 20),
(12, 21),
(8, 17),
(24, 8),
(12, 7),
(18, 26),
(28, 6),
(19, 22),
(8, 3),
(11, 4),
(24, 19),
(3, 23),
(8, 1),
(7, 26),
(1, 3),
(13, 2),
(4, 6),
(14, 20),
(14, 8),
(5, 2),
(22, 17),
(5, 17),
(17, 1),
(24, 27),
(4, 12),
(21, 6),
(25, 24),
(3, 10),
(13, 15),
(4, 15),
(26, 19),
(21, 2),
(28, 22),
(9, 10),
(10, 28),
(17, 19),
(18, 12),
(15, 5),
(15, 2),
(23, 27),
(28, 8),
(18, 26),
(17, 23),
(19, 17),
(14, 21),
(21, 18),
(8, 21),
(10, 8),
(25, 20),
(13, 20),
(28, 15),
(22, 26),
(6, 10),
(28, 13),
(16, 24),
(22, 22),
(8, 24),
(3, 4),
(11, 24),
(27, 12),
(25, 20),
(14, 16),
(13, 7),
(15, 18),
(28, 7),
(27, 6),
(13, 27),
(1, 26),
(8, 18),
(19, 22),
(16, 2),
(27, 5),
(11, 11),
(19, 19),
(5, 27),
(2, 19),
(28, 11),
(7, 28),
(10, 15),
(1, 26),
(18, 23),
(2, 12),
(17, 26),
(22, 9),
(26, 13),
(27, 7),
(24, 25),
(27, 19),
(27, 1),
(6, 23),
(11, 11),
(22, 27),
(1, 2),
(5, 16),
(21, 27),
(12, 18),
(17, 12),
(18, 17),
(15, 5),
(25, 3),
(18, 14),
(15, 25),
(7, 6),
(2, 23),
(27, 7),
(20, 2),
(14, 10),
(25, 19),
(14, 2),
(6, 22),
(18, 9),
(20, 20),
(14, 20),
(4, 5),
(4, 16),
(14, 26),
(26, 21),
(20, 24),
(18, 19),
(3, 11),
(11, 20),
(26, 10),
(22, 11),
(4, 7),
(5, 14),
(9, 14),
(12, 22),
(20, 11),
(18, 20),
(7, 10),
(7, 27),
(16, 11),
(28, 15),
(28, 27),
(21, 17),
(16, 7),
(27, 17),
(3, 20),
(18, 1),
(18, 15),
(12, 3);

INSERT INTO MakesHeadphones (manufacturerID, HeadphoneID)
VALUES (5,1),
(1, 2),
(6, 3),
(13, 24),
(25, 4),
(14, 3),
(25, 1),
(7, 15),
(6, 27),
(23, 26),
(15, 10),
(16, 23),
(28, 14),
(26, 12),
(10, 4),
(15, 15),
(25, 11),
(21, 11),
(28, 9),
(20, 24),
(3, 24),
(24, 25),
(5, 3),
(14, 23),
(14, 11),
(7, 3),
(24, 21),
(26, 11),
(1, 18),
(23, 13),
(15, 10),
(10, 21),
(4, 20),
(10, 26),
(7, 7),
(2, 9),
(20, 23),
(1, 27),
(25, 27),
(18, 25),
(13, 12),
(13, 25),
(17, 6),
(9, 6),
(27, 14),
(22, 8),
(6, 12),
(7, 3),
(9, 20),
(17, 20),
(12, 17),
(16, 20),
(16, 13),
(7, 4),
(8, 24),
(2, 24),
(8, 28),
(7, 27),
(10, 10),
(18, 20),
(25, 20),
(24, 1),
(14, 14),
(23, 17),
(15, 18),
(15, 16),
(6, 20),
(21, 23),
(7, 3),
(13, 13),
(2, 8),
(19, 2),
(19, 16),
(10, 1),
(8, 5),
(24, 13),
(13, 26),
(7, 18),
(23, 20),
(18, 27),
(19, 18),
(12, 6),
(20, 27),
(18, 15),
(8, 12),
(26, 17),
(27, 12),
(4, 5),
(14, 9),
(14, 20),
(18, 26),
(4, 21),
(13, 6),
(16, 18),
(22, 5),
(27, 9),
(22, 28),
(1, 3),
(15, 15),
(10, 23),
(12, 20),
(28, 16),
(4, 15),
(10, 2),
(4, 6),
(12, 20),
(28, 6),
(10, 8),
(18, 27),
(19, 18),
(6, 17),
(18, 19),
(21, 21),
(20, 6),
(17, 16),
(22, 21),
(19, 7),
(10, 23),
(4, 27),
(24, 21),
(22, 15),
(22, 23),
(15, 5),
(5, 22),
(16, 9),
(9, 12),
(11, 2),
(28, 16),
(15, 23),
(18, 15),
(1, 14),
(21, 20),
(9, 13),
(24, 1),
(11, 13),
(27, 10),
(8, 16),
(6, 20),
(25, 6),
(6, 6),
(10, 4),
(16, 16),
(13, 10),
(5, 10),
(26, 4),
(24, 23),
(20, 8),
(24, 24),
(21, 14),
(5, 19),
(18, 4),
(2, 25),
(22, 13),
(26, 16),
(20, 18),
(8, 26),
(22, 25),
(17, 16),
(9, 10),
(20, 15),
(19, 23),
(28, 5),
(28, 15),
(10, 16),
(16, 23),
(15, 8),
(4, 25),
(22, 22),
(27, 27),
(16, 25),
(28, 8),
(27, 28),
(2, 2),
(13, 19),
(2, 17),
(6, 24),
(14, 12),
(4, 2),
(23, 10),
(8, 5),
(2, 10),
(25, 24),
(13, 16),
(19, 9),
(13, 20),
(2, 3),
(3, 18),
(21, 10),
(19, 13),
(14, 14),
(12, 4),
(22, 6),
(23, 7),
(10, 17),
(8, 2),
(1, 16),
(27, 25),
(3, 12),
(5, 16),
(28, 17),
(18, 10),
(10, 28),
(11, 10),
(11, 2),
(24, 9),
(1, 23),
(8, 11),
(1, 7),
(22, 28),
(8, 7),
(24, 15),
(26, 7),
(15, 15),
(9, 27),
(13, 10),
(5, 28),
(15, 28),
(2, 23),
(27, 16),
(7, 17),
(3, 14),
(23, 14),
(21, 21),
(6, 8),
(26, 4),
(17, 27),
(26, 16),
(15, 27);

INSERT INTO MakesLaptop (manufacturerID, laptopID)
VALUES (5,1),
(1, 2),
(6, 3),
(17, 28),
(16, 3),
(22, 24),
(7, 17),
(19, 23),
(16, 5),
(11, 5),
(18, 14),
(14, 22),
(26, 10),
(1, 12),
(28, 14),
(1, 6),
(17, 7),
(19, 18),
(5, 11),
(7, 8),
(22, 13),
(4, 5),
(27, 21),
(9, 28),
(7, 1),
(15, 6),
(22, 1),
(25, 21),
(3, 10),
(10, 19),
(8, 2),
(21, 13),
(19, 7),
(2, 8),
(18, 3),
(2, 27),
(5, 24),
(17, 19),
(17, 17),
(21, 20),
(9, 14),
(6, 14),
(17, 12),
(25, 25),
(18, 5),
(14, 5),
(16, 23),
(2, 1),
(16, 3),
(27, 22),
(23, 18),
(10, 1),
(5, 8),
(3, 23),
(27, 21),
(3, 21),
(7, 9),
(1, 8),
(26, 16),
(27, 17),
(12, 7),
(11, 19),
(27, 6),
(3, 19),
(6, 23),
(8, 21),
(1, 20),
(16, 25),
(22, 25),
(15, 4),
(12, 1),
(4, 26),
(28, 19),
(10, 4),
(13, 28),
(14, 15),
(16, 12),
(4, 20),
(9, 7),
(1, 11),
(3, 27),
(27, 20),
(6, 4),
(28, 25),
(12, 23),
(26, 26),
(5, 4),
(24, 18),
(22, 26),
(6, 15),
(6, 17),
(20, 6),
(12, 1),
(9, 8),
(3, 5),
(27, 17),
(3, 3),
(22, 16),
(24, 27),
(13, 4),
(22, 15),
(2, 14),
(24, 2),
(22, 10),
(14, 20),
(14, 17),
(6, 11),
(5, 5),
(26, 12),
(26, 1),
(16, 13),
(14, 17),
(20, 28),
(22, 12),
(23, 20),
(4, 1),
(9, 3),
(8, 27),
(24, 13),
(19, 11),
(28, 8),
(4, 20),
(20, 25),
(2, 6),
(3, 19),
(18, 4),
(24, 3),
(1, 7),
(28, 4),
(12, 28),
(21, 25),
(20, 25),
(1, 5),
(1, 14),
(9, 11),
(18, 15),
(12, 18),
(14, 6),
(12, 1),
(10, 23),
(23, 25),
(23, 27),
(11, 27),
(5, 22),
(8, 5),
(11, 1),
(24, 20),
(14, 17),
(18, 16),
(3, 22),
(12, 1),
(20, 23),
(22, 15),
(14, 27),
(26, 12),
(10, 5),
(14, 26),
(8, 25),
(10, 28),
(26, 8),
(16, 26),
(14, 26),
(23, 13),
(17, 19),
(19, 4),
(24, 27),
(23, 18),
(16, 3),
(17, 1),
(18, 26),
(19, 5),
(10, 4),
(7, 18),
(21, 23),
(4, 6),
(23, 15),
(28, 11),
(27, 20),
(19, 25),
(18, 12),
(5, 9),
(26, 18),
(25, 3),
(15, 11),
(14, 2),
(9, 27),
(10, 6),
(13, 28),
(15, 9),
(18, 8),
(21, 3),
(20, 5),
(19, 8),
(12, 22),
(2, 28),
(20, 28),
(28, 20),
(15, 26),
(15, 8),
(4, 19),
(5, 1),
(6, 27),
(24, 11),
(23, 21),
(18, 3),
(19, 8),
(6, 13),
(6, 12),
(19, 18),
(3, 16),
(14, 14),
(4, 7),
(24, 27),
(25, 20),
(27, 28),
(8, 23),
(21, 2),
(11, 25),
(7, 6),
(21, 23),
(16, 13),
(28, 24),
(14, 24),
(9, 21),
(14, 27),
(23, 11),
(23, 10),
(9, 24);

INSERT INTO MakesMouse (manufacturerID, mouseID)
VALUES (5,1),
(1, 2),
(6, 3),
(24, 8),
(12, 13),
(23, 4),
(10, 7),
(24, 1),
(19, 9),
(26, 1),
(18, 13),
(22, 21),
(3, 4),
(13, 12),
(20, 23),
(7, 1),
(6, 2),
(8, 19),
(28, 25),
(21, 18),
(13, 8),
(20, 22),
(10, 19),
(26, 22),
(15, 11),
(25, 11),
(15, 21),
(26, 24),
(23, 16),
(17, 4),
(4, 17),
(16, 22),
(17, 8),
(3, 12),
(23, 17),
(21, 19),
(20, 27),
(24, 3),
(19, 4),
(27, 16),
(23, 13),
(16, 5),
(24, 10),
(18, 8),
(18, 1),
(18, 15),
(28, 6),
(14, 27),
(21, 14),
(15, 3),
(23, 21),
(15, 28),
(21, 19),
(19, 27),
(15, 26),
(27, 11),
(12, 14),
(8, 10),
(28, 25),
(11, 23),
(22, 14),
(8, 27),
(25, 17),
(14, 2),
(2, 22),
(18, 27),
(16, 20),
(15, 1),
(16, 5),
(17, 4),
(9, 24),
(3, 23),
(13, 26),
(27, 10),
(7, 1),
(20, 3),
(1, 27),
(3, 8),
(22, 20),
(19, 7),
(15, 11),
(7, 9),
(22, 23),
(10, 21),
(28, 18),
(2, 13),
(14, 19),
(26, 12),
(25, 13),
(3, 26),
(10, 4),
(26, 22),
(8, 4),
(19, 21),
(3, 24),
(13, 24),
(6, 14),
(18, 4),
(6, 10),
(24, 18),
(23, 8),
(10, 27),
(5, 6),
(17, 18),
(15, 23),
(6, 14),
(8, 28),
(17, 22),
(2, 25),
(20, 2),
(16, 4),
(6, 20),
(17, 13),
(27, 9),
(7, 12),
(28, 15),
(19, 1),
(9, 12),
(14, 27),
(20, 5),
(24, 9),
(25, 16),
(9, 9),
(8, 16),
(9, 19),
(18, 4),
(26, 26),
(23, 15),
(5, 6),
(10, 7),
(22, 6),
(23, 23),
(12, 4),
(15, 12),
(5, 28),
(6, 12),
(24, 14),
(21, 18),
(2, 12),
(15, 24),
(19, 20),
(1, 6),
(28, 27),
(7, 20),
(10, 11),
(19, 18),
(13, 27),
(20, 12),
(4, 13),
(12, 17),
(6, 21),
(7, 13),
(11, 9),
(24, 8),
(13, 1),
(11, 6),
(1, 26),
(17, 16),
(22, 10),
(23, 21),
(3, 10),
(14, 7),
(14, 4),
(4, 20),
(17, 1),
(8, 2),
(14, 27),
(16, 2),
(12, 12),
(12, 5),
(8, 4),
(8, 21),
(14, 20),
(18, 11),
(20, 24),
(14, 24),
(26, 6),
(3, 1),
(16, 13),
(11, 16),
(16, 26),
(23, 28),
(20, 6),
(17, 1),
(24, 3),
(19, 25),
(15, 24),
(1, 23),
(28, 10),
(8, 3),
(3, 13),
(10, 22),
(17, 16),
(10, 28),
(12, 2),
(27, 28),
(1, 2),
(26, 25),
(1, 6),
(17, 16),
(7, 20),
(3, 13),
(28, 10),
(11, 3),
(25, 16),
(16, 18),
(22, 16),
(23, 4),
(8, 14),
(7, 13),
(1, 14),
(15, 24),
(12, 15),
(7, 17),
(24, 6),
(13, 28),
(9, 28),
(7, 28),
(25, 1),
(5, 28),
(2, 14),
(28, 27),
(26, 6),
(2, 16),
(5, 17),
(18, 4),
(7, 2),
(5, 16);

INSERT INTO MakesPhone (manufacturerID, phoneID)
VALUES (5,1),
(1, 2),
(6, 3),
(26, 5),
(4, 4),
(17, 8),
(28, 11),
(24, 9),
(17, 12),
(6, 6),
(9, 21),
(28, 26),
(25, 12),
(8, 2),
(8, 19),
(6, 13),
(18, 25),
(8, 13),
(3, 25),
(19, 4),
(12, 2),
(21, 27),
(1, 1),
(26, 3),
(14, 20),
(4, 17),
(4, 28),
(6, 24),
(19, 2),
(10, 19),
(13, 6),
(18, 8),
(10, 12),
(12, 1),
(20, 4),
(3, 10),
(14, 2),
(26, 4),
(4, 19),
(1, 8),
(18, 3),
(23, 3),
(7, 8),
(21, 23),
(14, 23),
(17, 3),
(19, 15),
(8, 25),
(24, 11),
(23, 17),
(26, 17),
(18, 10),
(27, 22),
(14, 1),
(7, 16),
(3, 9),
(26, 7),
(6, 11),
(13, 15),
(9, 1),
(25, 23),
(23, 14),
(18, 28),
(3, 7),
(15, 26),
(24, 5),
(2, 5),
(24, 12),
(22, 2),
(25, 11),
(24, 20),
(1, 21),
(25, 13),
(10, 12),
(3, 27),
(18, 12),
(17, 22),
(5, 16),
(26, 19),
(25, 26),
(27, 24),
(28, 25),
(27, 18),
(9, 21),
(23, 16),
(16, 2),
(3, 11),
(16, 17),
(12, 13),
(6, 11),
(21, 7),
(28, 8),
(1, 15),
(1, 9),
(11, 11),
(5, 27),
(16, 26),
(22, 25),
(7, 5),
(9, 16),
(27, 18),
(6, 22),
(22, 21),
(26, 20),
(5, 26),
(3, 13),
(7, 11),
(11, 20),
(9, 18),
(23, 5),
(4, 1),
(7, 1),
(27, 28),
(7, 13),
(20, 7),
(8, 18),
(16, 16),
(24, 2),
(15, 22),
(8, 22),
(10, 5),
(9, 16),
(17, 15),
(27, 24),
(9, 25),
(6, 16),
(10, 27),
(27, 25),
(15, 17),
(14, 4),
(7, 11),
(26, 14),
(16, 23),
(6, 28),
(7, 27),
(3, 8),
(14, 21),
(23, 9),
(22, 12),
(16, 21),
(18, 6),
(7, 26),
(13, 15),
(25, 25),
(17, 26),
(19, 20),
(28, 5),
(3, 28),
(23, 27),
(11, 3),
(26, 18),
(21, 5),
(6, 8),
(13, 28),
(7, 8),
(2, 6),
(11, 26),
(1, 22),
(25, 19),
(25, 24),
(11, 26),
(8, 15),
(18, 9),
(7, 9),
(11, 28),
(23, 18),
(12, 13),
(24, 25),
(1, 4),
(24, 9),
(4, 1),
(21, 7),
(8, 4),
(21, 18),
(6, 9),
(27, 12),
(19, 2),
(27, 11),
(27, 3),
(6, 12),
(10, 1),
(15, 27),
(16, 19),
(26, 25),
(11, 1),
(4, 15),
(5, 6),
(5, 5),
(21, 25),
(18, 16),
(23, 16),
(23, 1),
(16, 2),
(16, 6),
(1, 8),
(8, 14),
(11, 7),
(7, 4),
(11, 24),
(9, 25),
(16, 8),
(8, 12),
(26, 27),
(3, 12),
(7, 9),
(1, 1),
(9, 1),
(13, 27),
(15, 6),
(4, 9),
(21, 26),
(21, 26),
(15, 25),
(6, 18),
(1, 20),
(12, 23),
(17, 21),
(16, 23),
(14, 28),
(13, 22),
(17, 27),
(26, 10),
(24, 6),
(1, 23),
(26, 21),
(2, 28),
(10, 15),
(2, 4);

INSERT INTO MakesSwitch (switchID, manufacturerID)
VALUES (1,5),
(2, 1),
(3, 6),
(27, 4),
(8, 7),
(3, 18),
(16, 4),
(25, 21),
(17, 25),
(18, 4),
(1, 27),
(13, 21),
(21, 6),
(17, 28),
(21, 28),
(20, 3),
(27, 15),
(13, 7),
(6, 6),
(19, 9),
(24, 15),
(15, 14),
(26, 1),
(7, 13),
(28, 9),
(14, 19),
(28, 21),
(8, 5),
(3, 16),
(7, 11),
(3, 14),
(1, 20),
(1, 3),
(20, 19),
(18, 14),
(5, 17),
(18, 16),
(16, 8),
(9, 15),
(16, 8),
(5, 7),
(25, 21),
(26, 12),
(6, 22),
(13, 10),
(26, 17),
(8, 4),
(14, 27),
(14, 19),
(12, 20),
(11, 24),
(8, 27),
(28, 27),
(24, 24),
(13, 4),
(11, 8),
(28, 10),
(23, 21),
(18, 23),
(15, 12),
(25, 18),
(8, 7),
(12, 1),
(16, 20),
(4, 27),
(14, 24),
(3, 5),
(12, 1),
(7, 6),
(6, 9),
(10, 21),
(5, 19),
(17, 4),
(20, 19),
(16, 19),
(16, 6),
(19, 6),
(3, 12),
(7, 27),
(15, 3),
(1, 8),
(16, 1),
(16, 13),
(11, 14),
(11, 15),
(22, 27),
(21, 10),
(9, 7),
(16, 17),
(24, 20),
(21, 7),
(13, 2),
(21, 8),
(1, 13),
(22, 23),
(26, 4),
(10, 13),
(3, 19),
(6, 4),
(19, 21),
(19, 13),
(8, 23),
(9, 6),
(20, 2),
(28, 23),
(8, 28),
(23, 21),
(17, 2),
(14, 22),
(12, 25),
(28, 17),
(1, 7),
(7, 10),
(11, 1),
(11, 21),
(20, 20),
(21, 8),
(16, 20),
(26, 6),
(21, 17),
(18, 27),
(2, 25),
(5, 22),
(16, 20),
(1, 12),
(10, 24),
(26, 24),
(5, 24),
(23, 15),
(8, 23),
(25, 8),
(3, 17),
(23, 20),
(22, 7),
(16, 1),
(21, 12),
(22, 6),
(19, 21),
(20, 1),
(19, 10),
(3, 28),
(9, 7),
(10, 17),
(6, 18),
(3, 16),
(6, 10),
(27, 19),
(19, 21),
(18, 25),
(11, 23),
(24, 16),
(4, 15),
(28, 15),
(15, 8),
(10, 4),
(14, 9),
(11, 19),
(12, 25),
(14, 23),
(7, 7),
(12, 25),
(14, 25),
(17, 4),
(17, 12),
(21, 8),
(25, 12),
(21, 15),
(9, 2),
(3, 14),
(22, 4),
(14, 28),
(20, 21),
(27, 10),
(6, 19),
(21, 23),
(9, 13),
(19, 15),
(6, 13),
(16, 23),
(24, 22),
(18, 12),
(25, 15),
(19, 22),
(24, 9),
(13, 3),
(1, 24),
(8, 17),
(18, 6),
(17, 4),
(9, 12),
(20, 17),
(3, 13),
(11, 8),
(11, 5),
(7, 6),
(21, 15),
(19, 8),
(3, 3),
(19, 8),
(2, 20),
(4, 18),
(18, 25),
(24, 22),
(15, 20),
(6, 24),
(16, 16),
(17, 24),
(2, 8),
(15, 18),
(18, 13),
(22, 19),
(8, 3),
(21, 6),
(23, 21),
(24, 2),
(7, 27),
(16, 7),
(18, 25),
(7, 7),
(4, 15),
(22, 25),
(26, 12),
(26, 26),
(1, 8),
(26, 24),
(1, 14),
(5, 10),
(12, 2);

INSERT INTO MakesTablet (manufacturerID, tabletID)
VALUES (5,1),
(1, 2),
(6, 3),
(14, 6),
(6, 11),
(20, 22),
(1, 20),
(10, 17),
(6, 21),
(23, 23),
(8, 6),
(9, 20),
(11, 3),
(22, 5),
(4, 3),
(10, 22),
(25, 24),
(25, 22),
(27, 22),
(21, 24),
(4, 14),
(17, 15),
(1, 15),
(6, 14),
(28, 18),
(27, 27),
(11, 15),
(20, 13),
(13, 8),
(23, 27),
(14, 13),
(26, 8),
(15, 1),
(5, 6),
(4, 28),
(17, 9),
(2, 10),
(20, 21),
(5, 5),
(19, 14),
(3, 23),
(25, 7),
(28, 12),
(9, 6),
(24, 3),
(3, 5),
(11, 15),
(22, 19),
(15, 28),
(26, 9),
(25, 4),
(25, 27),
(8, 26),
(15, 19),
(26, 17),
(26, 9),
(10, 18),
(25, 14),
(17, 8),
(5, 15),
(21, 12),
(11, 16),
(21, 10),
(13, 19),
(2, 11),
(3, 11),
(9, 6),
(22, 11),
(5, 1),
(3, 17),
(12, 20),
(27, 27),
(22, 10),
(27, 25),
(16, 4),
(4, 11),
(4, 8),
(17, 18),
(10, 6),
(28, 4),
(4, 9),
(20, 21),
(4, 13),
(27, 14),
(26, 5),
(25, 16),
(17, 14),
(5, 20),
(27, 23),
(20, 22),
(16, 23),
(1, 12),
(16, 1),
(22, 15),
(13, 23),
(2, 18),
(21, 23),
(28, 10),
(26, 5),
(13, 2),
(19, 26),
(11, 27),
(3, 26),
(28, 19),
(8, 6),
(22, 21),
(6, 22),
(1, 13),
(15, 1),
(15, 22),
(26, 8),
(4, 16),
(20, 3),
(13, 27),
(8, 4),
(20, 20),
(28, 10),
(6, 18),
(17, 21),
(22, 6),
(26, 1),
(6, 4),
(4, 25),
(23, 25),
(15, 27),
(2, 11),
(6, 18),
(13, 12),
(23, 7),
(18, 27),
(20, 8),
(22, 15),
(12, 2),
(19, 26),
(7, 27),
(16, 7),
(2, 22),
(1, 18),
(20, 3),
(27, 17),
(5, 23),
(5, 3),
(4, 24),
(2, 12),
(28, 9),
(11, 18),
(21, 6),
(18, 13),
(1, 7),
(4, 7),
(26, 11),
(28, 8),
(9, 11),
(5, 12),
(22, 17),
(10, 9),
(25, 17),
(22, 13),
(16, 19),
(23, 13),
(23, 19),
(28, 21),
(24, 5),
(18, 25),
(1, 8),
(15, 8),
(21, 18),
(22, 23),
(26, 26),
(12, 12),
(20, 3),
(8, 26),
(22, 17),
(11, 25),
(11, 7),
(23, 12),
(10, 8),
(13, 11),
(11, 18),
(10, 2),
(5, 13),
(19, 25),
(16, 24),
(5, 17),
(20, 10),
(4, 6),
(20, 20),
(4, 26),
(1, 4),
(27, 28),
(24, 15),
(6, 23),
(23, 16),
(18, 25),
(9, 25),
(15, 6),
(28, 22),
(7, 2),
(11, 8),
(6, 10),
(26, 16),
(14, 20),
(13, 25),
(23, 17),
(7, 24),
(21, 2),
(19, 8),
(1, 15),
(4, 27),
(3, 26),
(18, 1),
(1, 19),
(28, 11),
(5, 12),
(23, 27),
(20, 14),
(5, 6),
(23, 1),
(20, 6),
(1, 25),
(9, 27),
(27, 25),
(16, 22),
(4, 12),
(18, 26),
(8, 11),
(22, 3),
(11, 6);

INSERT INTO UserPost (userID, title)
VALUES (1, 'Cheap headphones cord breaks'),
(2, 'Tt Ventus R review'),
(14, "The Expansion of Augmented Reality")
(12, "The Growth of E-commerce Platforms")
(7, "The New Era of Space Exploration")
(21, "The Future of Quantum Computing")
(20, "The Impact of 5G on Communication")
(24, "The New Era of Space Exploration")
(9, "Exploring the Capabilities of AI")
(11, "Exploring the Capabilities of AI")
(8, "Cloud Computing and Data Storage")
(23, "Mobile Technology and App Development")
(15, "Advancing Education with E-Learning")
(24, "The Growth of E-commerce Platforms")
(19, "3D Printing Changing Production")
(11, "Autonomous Vehicles and Transportation")
(10, "The Impact of 5G on Communication")
(1, "The Growth of E-commerce Platforms")
(1, "Social Media Trends and Data Privacy")
(9, "Developing Tech for Disaster Response")
(4, "The Expansion of Augmented Reality")
(10, "The Impact of 5G on Communication")
(22, "Social Media Trends and Data Privacy")
(4, "Breakthroughs in Nanotechnology")
(16, "Wearable Tech and Digital Health")
(21, "The Growth of E-commerce Platforms")
(17, "The Evolution of Virtual Reality")
(19, "The Impact of 5G on Communication")
(8, "Tech in Art and Creative Industries")
(28, "Blockchain Beyond Cryptocurrency")
(11, "Innovations in Drone Technology")
(15, "The Rise of Renewable Energy Tech")
(25, "3D Printing Changing Production")
(8, "Breakthroughs in Nanotechnology")
(10, "Cybersecurity in a Connected World")
(15, "Cybersecurity in a Connected World")
(18, "Advancements in Biotechnology")
(20, "Autonomous Vehicles and Transportation")
(28, "The Role of IoT in Smart Cities")
(23, "The Future of Quantum Computing")
(28, "Wearable Tech and Digital Health")
(1, "Mobile Technology and App Development")
(20, "The Impact of 5G on Communication")
(27, "The Impact of 5G on Communication")
(10, "Robotic Automation in Manufacturing")
(13, "Exploring the Capabilities of AI")
(7, "Developing Tech for Disaster Response")
(28, "The Future of Quantum Computing")
(23, "The Growth of E-commerce Platforms")
(26, "Cloud Computing and Data Storage")
(3, "The Expansion of Augmented Reality")
(3, "Innovations in Drone Technology")
(8, "Robotic Automation in Manufacturing")
(26, "Robotic Automation in Manufacturing")
(3, "Big Data and Predictive Analytics")
(12, "Blockchain Beyond Cryptocurrency")
(14, "Social Media Trends and Data Privacy")
(21, "Breakthroughs in Nanotechnology")
(15, "The Rise of Renewable Energy Tech")
(3, "Breakthroughs in Nanotechnology")
(22, "Exploring the Capabilities of AI")
(17, "Gaming Technology and Interactive Media")
(28, "Innovations in Drone Technology")
(23, "Mobile Technology and App Development")
(2, "The Role of IoT in Smart Cities")
(2, "The Future of Quantum Computing")
(16, "Advancing Education with E-Learning")
(22, "The New Era of Space Exploration")
(10, "Revolutionizing Agriculture with Tech")
(23, "Innovations in Drone Technology")
(25, "3D Printing Changing Production")
(7, "The Impact of 5G on Communication")
(4, "Advancements in Biotechnology")
(8, "The Rise of Renewable Energy Tech")
(24, "Blockchain Beyond Cryptocurrency")
(3, "Personal Assistants and Smart Homes")
(11, "Advancing Education with E-Learning")
(13, "Exploring the Capabilities of AI")
(26, "Revolutionizing Agriculture with Tech")
(23, "Cloud Computing and Data Storage")
(15, "The Role of IoT in Smart Cities")
(21, "Cloud Computing and Data Storage")
(13, "The Expansion of Augmented Reality")
(9, "Tech in Art and Creative Industries")
(21, "Cybersecurity in a Connected World")
(16, "Developing Tech for Disaster Response")
(12, "Mobile Technology and App Development")
(18, "3D Printing Changing Production")
(16, "The New Era of Space Exploration")
(5, "The Role of IoT in Smart Cities")
(15, "Cloud Computing and Data Storage")
(22, "Advancements in Biotechnology")
(12, "The Role of IoT in Smart Cities")
(3, "The Evolution of Virtual Reality")
(16, "Big Data and Predictive Analytics")
(6, "The Growth of E-commerce Platforms")
(13, "Autonomous Vehicles and Transportation")
(5, "Mobile Technology and App Development")
(11, "The Expansion of Augmented Reality")
(8, "The New Era of Space Exploration")
(2, "Innovations in Drone Technology")
(15, "The New Era of Space Exploration")
(17, "Innovations in Drone Technology")
(1, "Big Data and Predictive Analytics")
(17, "The New Era of Space Exploration")
(19, "The Expansion of Augmented Reality")
(22, "Cybersecurity in a Connected World")
(26, "Autonomous Vehicles and Transportation")
(24, "The Impact of 5G on Communication")
(23, "Blockchain Beyond Cryptocurrency")
(15, "Cybersecurity in a Connected World")
(3, "Cybersecurity in a Connected World")
(11, "The Expansion of Augmented Reality")
(17, "The Rise of Renewable Energy Tech")
(21, "Tech in Art and Creative Industries")
(23, "Mobile Technology and App Development")
(17, "Breakthroughs in Nanotechnology")
(8, "Cloud Computing and Data Storage")
(4, "The Role of IoT in Smart Cities")
(10, "The Evolution of Virtual Reality")
(12, "The Growth of E-commerce Platforms")
(20, "Advancing Education with E-Learning")
(15, "The Rise of Renewable Energy Tech")
(24, "The Growth of E-commerce Platforms")
(16, "The New Era of Space Exploration")
(20, "The Role of IoT in Smart Cities")
(28, "The Role of IoT in Smart Cities")
(5, "Cybersecurity in a Connected World")
(8, "The Growth of E-commerce Platforms")
(19, "Advancing Education with E-Learning")
(26, "Big Data and Predictive Analytics")
(12, "Advancing Education with E-Learning")
(16, "The Rise of Renewable Energy Tech")
(8, "Breakthroughs in Nanotechnology")
(28, "Personal Assistants and Smart Homes")
(11, "Personal Assistants and Smart Homes")
(18, "Mobile Technology and App Development")
(18, "Breakthroughs in Nanotechnology")
(9, "Cybersecurity in a Connected World")
(5, "Personal Assistants and Smart Homes")
(22, "Advancements in Biotechnology")
(27, "Advancements in Biotechnology")
(15, "Cloud Computing and Data Storage")
(4, "Gaming Technology and Interactive Media")
(10, "3D Printing Changing Production")
(5, "Mobile Technology and App Development")
(24, "Social Media Trends and Data Privacy")
(15, "Personal Assistants and Smart Homes")
(25, "3D Printing Changing Production")
(12, "Mobile Technology and App Development")
(18, "Exploring the Capabilities of AI")
(28, "Cybersecurity in a Connected World")
(22, "Autonomous Vehicles and Transportation")
(9, "Personal Assistants and Smart Homes")
(27, "Mobile Technology and App Development")
(2, "Personal Assistants and Smart Homes")
(28, "The Evolution of Virtual Reality")
(28, "The Evolution of Virtual Reality")
(6, "Wearable Tech and Digital Health")
(7, "Robotic Automation in Manufacturing")
(28, "Cybersecurity in a Connected World")
(13, "Autonomous Vehicles and Transportation")
(14, "Exploring the Capabilities of AI")
(15, "Developing Tech for Disaster Response")
(18, "Wearable Tech and Digital Health")
(14, "Exploring the Capabilities of AI")
(2, "The Growth of E-commerce Platforms")
(6, "Autonomous Vehicles and Transportation")
(11, "Blockchain Beyond Cryptocurrency")
(28, "Gaming Technology and Interactive Media")
(16, "Exploring the Capabilities of AI")
(25, "The Growth of E-commerce Platforms")
(10, "Breakthroughs in Nanotechnology")
(6, "Autonomous Vehicles and Transportation")
(14, "The Growth of E-commerce Platforms")
(20, "Revolutionizing Agriculture with Tech")
(11, "The Growth of E-commerce Platforms")
(6, "Breakthroughs in Nanotechnology")
(5, "The Impact of 5G on Communication")
(12, "Robotic Automation in Manufacturing")
(19, "3D Printing Changing Production")
(15, "Gaming Technology and Interactive Media")
(11, "Cloud Computing and Data Storage")
(9, "Exploring the Capabilities of AI")
(27, "Developing Tech for Disaster Response")
(27, "Exploring the Capabilities of AI")
(27, "The Rise of Renewable Energy Tech")
(9, "Wearable Tech and Digital Health")
(20, "The Expansion of Augmented Reality")
(2, "Cybersecurity in a Connected World")
(9, "Blockchain Beyond Cryptocurrency")
(13, "Robotic Automation in Manufacturing")
(2, "Cybersecurity in a Connected World")
(26, "The Impact of 5G on Communication")
(25, "Blockchain Beyond Cryptocurrency")
(14, "The Evolution of Virtual Reality")
(25, "The Growth of E-commerce Platforms")
(27, "Personal Assistants and Smart Homes")
(5, "The New Era of Space Exploration")
(10, "Cybersecurity in a Connected World")
(24, "Gaming Technology and Interactive Media")
(23, "The Future of Quantum Computing");

INSERT INTO ManufacturerPost (manufacturerID, title)
VALUES (3, 'Looking for new phone'),
(11, "Blockchain Beyond Cryptocurrency")
(4, "Cybersecurity in a Connected World")
(24, "Personal Assistants and Smart Homes")
(19, "Robotic Automation in Manufacturing")
(26, "3D Printing Changing Production")
(6, "Advancements in Biotechnology")
(8, "Cybersecurity in a Connected World")
(26, "Autonomous Vehicles and Transportation")
(8, "Exploring the Capabilities of AI")
(11, "Blockchain Beyond Cryptocurrency")
(3, "Advancing Education with E-Learning")
(12, "3D Printing Changing Production")
(24, "The Role of IoT in Smart Cities")
(28, "Robotic Automation in Manufacturing")
(13, "The New Era of Space Exploration")
(8, "The Future of Quantum Computing")
(17, "Wearable Tech and Digital Health")
(20, "Exploring the Capabilities of AI")
(10, "Gaming Technology and Interactive Media")
(23, "Autonomous Vehicles and Transportation")
(5, "Innovations in Drone Technology")
(13, "Advancements in Biotechnology")
(12, "Breakthroughs in Nanotechnology")
(6, "Innovations in Drone Technology")
(12, "Social Media Trends and Data Privacy")
(11, "Breakthroughs in Nanotechnology")
(8, "The Future of Quantum Computing")
(1, "Cloud Computing and Data Storage")
(28, "Advancing Education with E-Learning")
(27, "The Expansion of Augmented Reality")
(3, "Autonomous Vehicles and Transportation")
(28, "Advancing Education with E-Learning")
(5, "Robotic Automation in Manufacturing")
(3, "Autonomous Vehicles and Transportation")
(22, "Cloud Computing and Data Storage")
(24, "Tech in Art and Creative Industries")
(18, "Big Data and Predictive Analytics")
(26, "Tech in Art and Creative Industries")
(23, "Personal Assistants and Smart Homes")
(6, "Advancements in Biotechnology")
(10, "3D Printing Changing Production")
(23, "Advancing Education with E-Learning")
(4, "Wearable Tech and Digital Health")
(5, "Gaming Technology and Interactive Media")
(4, "Personal Assistants and Smart Homes")
(16, "The New Era of Space Exploration")
(24, "The Growth of E-commerce Platforms")
(20, "Gaming Technology and Interactive Media")
(1, "Gaming Technology and Interactive Media")
(17, "Cybersecurity in a Connected World")
(27, "The Role of IoT in Smart Cities")
(9, "The Rise of Renewable Energy Tech")
(2, "Big Data and Predictive Analytics")
(13, "Cybersecurity in a Connected World")
(2, "Innovations in Drone Technology")
(26, "The Growth of E-commerce Platforms")
(11, "Developing Tech for Disaster Response")
(15, "The Impact of 5G on Communication")
(18, "Social Media Trends and Data Privacy")
(14, "Robotic Automation in Manufacturing")
(2, "Social Media Trends and Data Privacy")
(14, "The Impact of 5G on Communication")
(3, "Advancements in Biotechnology")
(6, "Cybersecurity in a Connected World")
(14, "Robotic Automation in Manufacturing")
(12, "Exploring the Capabilities of AI")
(23, "Advancements in Biotechnology")
(15, "The Expansion of Augmented Reality")
(6, "Tech in Art and Creative Industries")
(2, "3D Printing Changing Production")
(22, "Blockchain Beyond Cryptocurrency")
(8, "Personal Assistants and Smart Homes")
(17, "Innovations in Drone Technology")
(1, "Exploring the Capabilities of AI")
(15, "Gaming Technology and Interactive Media")
(18, "Blockchain Beyond Cryptocurrency")
(2, "Exploring the Capabilities of AI")
(27, "Cloud Computing and Data Storage")
(24, "The Growth of E-commerce Platforms")
(17, "The Rise of Renewable Energy Tech")
(2, "Cybersecurity in a Connected World")
(16, "Tech in Art and Creative Industries")
(16, "The Growth of E-commerce Platforms")
(13, "Big Data and Predictive Analytics")
(25, "Innovations in Drone Technology")
(7, "The Expansion of Augmented Reality")
(13, "Personal Assistants and Smart Homes")
(8, "Advancements in Biotechnology")
(17, "Robotic Automation in Manufacturing")
(11, "Developing Tech for Disaster Response")
(6, "Exploring the Capabilities of AI")
(24, "Big Data and Predictive Analytics")
(7, "Personal Assistants and Smart Homes")
(15, "3D Printing Changing Production")
(7, "Gaming Technology and Interactive Media")
(7, "Revolutionizing Agriculture with Tech")
(28, "Robotic Automation in Manufacturing")
(7, "Developing Tech for Disaster Response")
(25, "Robotic Automation in Manufacturing")
(24, "Cybersecurity in a Connected World")
(2, "Cybersecurity in a Connected World")
(13, "The Rise of Renewable Energy Tech")
(7, "Blockchain Beyond Cryptocurrency")
(16, "Mobile Technology and App Development")
(20, "The Impact of 5G on Communication")
(24, "Big Data and Predictive Analytics")
(2, "3D Printing Changing Production")
(1, "Advancements in Biotechnology")
(20, "The New Era of Space Exploration")
(7, "Innovations in Drone Technology")
(19, "Revolutionizing Agriculture with Tech")
(27, "Revolutionizing Agriculture with Tech")
(15, "Autonomous Vehicles and Transportation")
(6, "Big Data and Predictive Analytics")
(21, "Revolutionizing Agriculture with Tech")
(2, "Cloud Computing and Data Storage")
(18, "Advancing Education with E-Learning")
(25, "Big Data and Predictive Analytics")
(11, "Mobile Technology and App Development")
(16, "Innovations in Drone Technology")
(23, "Advancements in Biotechnology")
(12, "Blockchain Beyond Cryptocurrency")
(27, "Tech in Art and Creative Industries")
(26, "Exploring the Capabilities of AI")
(19, "The Impact of 5G on Communication")
(21, "Blockchain Beyond Cryptocurrency")
(4, "Robotic Automation in Manufacturing")
(11, "The New Era of Space Exploration")
(20, "The Impact of 5G on Communication")
(12, "Gaming Technology and Interactive Media")
(20, "Cybersecurity in a Connected World")
(12, "The New Era of Space Exploration")
(9, "Revolutionizing Agriculture with Tech")
(10, "Gaming Technology and Interactive Media")
(25, "Developing Tech for Disaster Response")
(15, "Big Data and Predictive Analytics")
(22, "Blockchain Beyond Cryptocurrency")
(17, "Autonomous Vehicles and Transportation")
(11, "Advancing Education with E-Learning")
(23, "Tech in Art and Creative Industries")
(24, "The Future of Quantum Computing")
(4, "Cloud Computing and Data Storage")
(19, "Big Data and Predictive Analytics")
(26, "Innovations in Drone Technology")
(9, "Developing Tech for Disaster Response")
(24, "Cybersecurity in a Connected World")
(13, "Tech in Art and Creative Industries")
(27, "The Role of IoT in Smart Cities")
(8, "Mobile Technology and App Development")
(23, "Gaming Technology and Interactive Media")
(5, "3D Printing Changing Production")
(4, "Blockchain Beyond Cryptocurrency")
(25, "Breakthroughs in Nanotechnology")
(16, "The Growth of E-commerce Platforms")
(27, "The Growth of E-commerce Platforms")
(22, "Big Data and Predictive Analytics")
(16, "The Future of Quantum Computing")
(5, "Cybersecurity in a Connected World")
(10, "The Role of IoT in Smart Cities")
(22, "Personal Assistants and Smart Homes")
(8, "Autonomous Vehicles and Transportation")
(10, "Cloud Computing and Data Storage")
(18, "The Expansion of Augmented Reality")
(12, "The New Era of Space Exploration")
(8, "Tech in Art and Creative Industries")
(28, "Robotic Automation in Manufacturing")
(9, "Social Media Trends and Data Privacy")
(27, "The Future of Quantum Computing")
(23, "The Role of IoT in Smart Cities")
(1, "Robotic Automation in Manufacturing")
(9, "Cybersecurity in a Connected World")
(21, "The New Era of Space Exploration")
(2, "Tech in Art and Creative Industries")
(19, "Mobile Technology and App Development")
(1, "The Expansion of Augmented Reality")
(18, "Autonomous Vehicles and Transportation")
(14, "The Impact of 5G on Communication")
(26, "The New Era of Space Exploration")
(10, "The Rise of Renewable Energy Tech")
(26, "The Evolution of Virtual Reality")
(24, "3D Printing Changing Production")
(4, "Blockchain Beyond Cryptocurrency")
(21, "The Evolution of Virtual Reality")
(14, "The Impact of 5G on Communication")
(20, "The Role of IoT in Smart Cities")
(4, "The Future of Quantum Computing")
(28, "The Rise of Renewable Energy Tech")
(28, "Cybersecurity in a Connected World")
(7, "The New Era of Space Exploration")
(4, "Robotic Automation in Manufacturing")
(5, "Advancements in Biotechnology")
(13, "Tech in Art and Creative Industries")
(22, "Exploring the Capabilities of AI")
(24, "The Evolution of Virtual Reality")
(26, "Wearable Tech and Digital Health")
(5, "Advancements in Biotechnology")
(24, "The Growth of E-commerce Platforms")
(1, "Advancements in Biotechnology")
(20, "Tech in Art and Creative Industries")
(24, "Advancing Education with E-Learning");

INSERT INTO FavoriteKeyboard(userID, KeyboardID)
VALUES (3, 1),
(4, 2),
(5, 3),
(9, 4),
(10, 11),
(21, 6),
(19, 17),
(8, 25),
(12, 10),
(1, 17),
(23, 6),
(17, 28),
(8, 7),
(10, 6),
(14, 16),
(6, 10),
(18, 24),
(7, 15),
(21, 1),
(12, 9),
(3, 28),
(13, 19),
(28, 1),
(24, 25),
(24, 20),
(26, 18),
(16, 17),
(28, 21),
(11, 25),
(19, 14),
(16, 18),
(20, 5),
(28, 19),
(26, 14),
(20, 13),
(5, 19),
(21, 21),
(15, 27),
(28, 2),
(19, 15),
(18, 27),
(7, 20),
(16, 12),
(20, 14),
(13, 21),
(16, 12),
(9, 20),
(26, 24),
(11, 11),
(18, 4),
(15, 23),
(16, 7),
(16, 25),
(8, 23),
(25, 2),
(1, 12),
(11, 26),
(7, 24),
(19, 25),
(19, 9),
(15, 27),
(1, 7),
(6, 26),
(17, 28),
(14, 3),
(19, 9),
(23, 17),
(26, 4),
(17, 17),
(4, 27),
(15, 23),
(2, 24),
(1, 3),
(22, 4),
(13, 25),
(7, 16),
(12, 19),
(4, 25),
(7, 16),
(1, 4),
(5, 13),
(6, 22),
(7, 12),
(17, 2),
(23, 5),
(26, 19),
(8, 7),
(11, 22),
(26, 19),
(6, 9),
(2, 13),
(7, 23),
(16, 4),
(6, 24),
(12, 19),
(19, 8),
(13, 17),
(10, 13),
(1, 9),
(18, 10),
(15, 21),
(18, 7),
(22, 25),
(26, 6),
(17, 5),
(20, 7),
(9, 20),
(14, 1),
(27, 19),
(2, 10),
(25, 5),
(9, 1),
(25, 21),
(28, 10),
(3, 23),
(25, 23),
(7, 28),
(5, 3),
(6, 2),
(24, 1),
(15, 3),
(15, 14),
(3, 17),
(26, 18),
(26, 23),
(25, 9),
(9, 8),
(8, 11),
(25, 7),
(8, 11),
(14, 2),
(14, 2),
(9, 23),
(15, 14),
(28, 28),
(18, 6),
(23, 22),
(20, 10),
(16, 3),
(22, 23),
(28, 17),
(22, 22),
(2, 11),
(13, 24),
(21, 15),
(1, 19),
(14, 18),
(22, 22),
(28, 5),
(3, 14),
(27, 1),
(26, 25),
(17, 21),
(10, 26),
(24, 23),
(22, 3),
(26, 13),
(26, 9),
(26, 2),
(6, 11),
(6, 7),
(27, 10),
(22, 3),
(11, 27),
(9, 3),
(21, 25),
(25, 27),
(9, 11),
(25, 21),
(11, 16),
(22, 26),
(10, 3),
(22, 26),
(12, 2),
(13, 14),
(17, 13),
(7, 16),
(24, 3),
(24, 22),
(18, 2),
(10, 5),
(18, 21),
(20, 28),
(28, 11),
(20, 10),
(23, 26),
(27, 9),
(21, 14),
(18, 25),
(14, 9),
(13, 1),
(8, 24),
(16, 5),
(17, 4),
(2, 5),
(12, 14),
(1, 26),
(22, 20),
(9, 7),
(5, 14),
(17, 4),
(3, 26),
(15, 14),
(25, 24),
(1, 2),
(4, 9),
(16, 25),
(1, 4),
(22, 28),
(8, 15),
(25, 6),
(23, 24),
(14, 27),
(8, 15),
(20, 8),
(10, 19),
(8, 10),
(26, 6),
(14, 23),
(1, 14),
(28, 16),
(7, 20),
(3, 28),
(18, 3),
(16, 2),
(13, 9),
(24, 8),
(4, 3);

INSERT INTO FavoriteLaptop(userID, laptopID)
VALUES (3, 1),
(4, 2),
(5, 3),
(27, 15),
(6, 6),
(4, 6),
(14, 28),
(15, 9),
(14, 21),
(15, 19),
(10, 25),
(12, 3),
(8, 4),
(25, 26),
(28, 21),
(3, 28),
(16, 15),
(11, 26),
(9, 5),
(26, 16),
(9, 8),
(15, 14),
(2, 4),
(27, 23),
(21, 4),
(2, 2),
(5, 6),
(11, 9),
(3, 7),
(20, 9),
(21, 7),
(23, 16),
(15, 26),
(5, 10),
(21, 12),
(26, 14),
(16, 26),
(4, 12),
(6, 14),
(21, 1),
(9, 12),
(2, 23),
(28, 7),
(28, 4),
(23, 25),
(6, 6),
(12, 10),
(15, 9),
(20, 8),
(4, 8),
(1, 8),
(10, 26),
(27, 13),
(17, 25),
(14, 7),
(12, 6),
(1, 14),
(24, 25),
(13, 16),
(24, 10),
(25, 1),
(8, 21),
(14, 2),
(7, 6),
(12, 18),
(3, 10),
(16, 6),
(15, 15),
(26, 11),
(15, 7),
(22, 3),
(4, 21),
(2, 8),
(1, 4),
(23, 28),
(11, 4),
(5, 23),
(8, 3),
(26, 3),
(2, 1),
(3, 15),
(22, 12),
(10, 6),
(1, 7),
(4, 26),
(7, 2),
(19, 13),
(23, 15),
(20, 4),
(3, 8),
(10, 17),
(8, 18),
(11, 15),
(24, 3),
(12, 12),
(24, 8),
(17, 14),
(25, 9),
(23, 11),
(3, 25),
(6, 25),
(20, 24),
(3, 22),
(22, 5),
(23, 9),
(24, 22),
(15, 4),
(24, 5),
(26, 5),
(6, 13),
(21, 13),
(26, 4),
(26, 25),
(8, 17),
(8, 14),
(25, 16),
(4, 15),
(9, 16),
(17, 13),
(16, 25),
(22, 3),
(10, 22),
(16, 4),
(22, 11),
(12, 18),
(8, 22),
(15, 20),
(7, 5),
(21, 28),
(19, 12),
(16, 27),
(28, 22),
(2, 22),
(8, 15),
(18, 12),
(26, 8),
(26, 10),
(18, 19),
(19, 19),
(27, 17),
(15, 28),
(1, 21),
(1, 11),
(21, 15),
(15, 17),
(22, 11),
(11, 9),
(8, 5),
(7, 14),
(11, 23),
(24, 12),
(15, 6),
(11, 3),
(13, 25),
(8, 21),
(10, 22),
(23, 21),
(24, 7),
(16, 11),
(17, 2),
(8, 5),
(13, 2),
(10, 13),
(20, 14),
(12, 13),
(16, 4),
(22, 8),
(12, 7),
(9, 16),
(2, 17),
(14, 16),
(16, 16),
(22, 16),
(15, 7),
(6, 27),
(25, 26),
(28, 5),
(12, 24),
(20, 11),
(28, 22),
(5, 25),
(14, 24),
(16, 18),
(20, 2),
(20, 3),
(16, 22),
(5, 10),
(12, 2),
(6, 1),
(13, 18),
(21, 8),
(5, 3),
(26, 16),
(15, 21),
(25, 26),
(5, 7),
(22, 24),
(24, 22),
(7, 11),
(25, 25),
(7, 15),
(13, 16),
(21, 3),
(23, 23),
(21, 12),
(21, 19),
(16, 10),
(28, 28),
(27, 6),
(2, 10),
(25, 3),
(7, 2),
(3, 12),
(8, 7),
(1, 11),
(19, 3),
(27, 8),
(23, 28),
(14, 25),
(13, 17),
(9, 22),
(5, 22),
(8, 28),
(11, 23),
(28, 15),
(9, 26),
(25, 6),
(1, 11);

INSERT INTO FavoriteMouse(userID, mouseID)
VALUES (3, 1),
(4, 2),
(5, 3),
(6, 4),
(26, 6),
(14, 15),
(25, 25),
(8, 28),
(3, 8),
(5, 20),
(12, 28),
(21, 1),
(20, 4),
(6, 9),
(5, 16),
(1, 9),
(26, 11),
(1, 13),
(24, 16),
(20, 2),
(19, 25),
(2, 9),
(19, 21),
(25, 28),
(25, 9),
(20, 6),
(5, 26),
(4, 10),
(4, 5),
(16, 24),
(26, 15),
(1, 2),
(22, 4),
(10, 15),
(18, 28),
(23, 15),
(26, 1),
(8, 15),
(1, 17),
(1, 23),
(13, 27),
(5, 6),
(21, 12),
(23, 4),
(10, 1),
(7, 3),
(23, 12),
(26, 13),
(18, 5),
(8, 26),
(20, 22),
(3, 19),
(20, 11),
(4, 7),
(13, 4),
(16, 10),
(11, 28),
(9, 24),
(27, 8),
(6, 19),
(14, 13),
(26, 25),
(11, 2),
(27, 25),
(14, 2),
(28, 1),
(10, 11),
(25, 22),
(4, 5),
(7, 12),
(6, 19),
(16, 17),
(26, 11),
(16, 21),
(7, 11),
(4, 11),
(10, 19),
(4, 3),
(14, 27),
(13, 28),
(10, 16),
(4, 25),
(25, 7),
(8, 9),
(24, 21),
(3, 27),
(28, 5),
(28, 28),
(19, 16),
(23, 24),
(1, 12),
(22, 12),
(4, 13),
(7, 16),
(17, 4),
(19, 8),
(10, 14),
(21, 1),
(20, 5),
(17, 21),
(14, 10),
(17, 27),
(16, 11),
(26, 6),
(14, 15),
(12, 26),
(25, 17),
(23, 18),
(5, 2),
(14, 4),
(10, 20),
(6, 22),
(21, 19),
(24, 25),
(3, 6),
(24, 21),
(24, 28),
(21, 25),
(9, 13),
(10, 25),
(7, 1),
(8, 14),
(28, 11),
(20, 9),
(13, 2),
(20, 12),
(3, 13),
(21, 2),
(1, 25),
(7, 2),
(22, 10),
(20, 28),
(18, 11),
(20, 12),
(27, 18),
(1, 24),
(14, 20),
(24, 8),
(9, 25),
(16, 17),
(20, 13),
(27, 11),
(20, 24),
(13, 16),
(16, 8),
(27, 15),
(22, 4),
(17, 14),
(2, 3),
(8, 16),
(22, 15),
(15, 18),
(10, 10),
(10, 5),
(9, 8),
(20, 25),
(13, 28),
(2, 6),
(15, 20),
(13, 24),
(6, 22),
(25, 1),
(6, 21),
(5, 2),
(22, 21),
(2, 6),
(3, 20),
(3, 17),
(8, 18),
(8, 28),
(18, 12),
(11, 19),
(14, 5),
(21, 28),
(26, 26),
(6, 18),
(21, 4),
(15, 11),
(18, 9),
(9, 26),
(19, 23),
(11, 5),
(9, 9),
(18, 27),
(20, 4),
(24, 6),
(10, 17),
(26, 13),
(13, 22),
(16, 21),
(28, 6),
(27, 6),
(19, 7),
(15, 13),
(3, 23),
(7, 12),
(1, 23),
(21, 2),
(12, 25),
(3, 21),
(6, 4),
(20, 18),
(20, 10),
(1, 28),
(22, 26),
(11, 2),
(10, 3),
(1, 27),
(17, 2),
(15, 28),
(8, 4),
(7, 21),
(12, 12),
(13, 12),
(5, 8),
(15, 3),
(22, 26),
(14, 13),
(21, 8),
(19, 5),
(11, 17),
(6, 2),
(26, 22),
(20, 7),
(19, 8),
(21, 7),
(17, 7),
(4, 5);

INSERT INTO FavoritePhone(userID, phoneID)
VALUES (3, 1),
(4, 2),
(5, 3),
(17, 4),
(2, 18),
(18, 12),
(12, 5),
(8, 3),
(14, 6),
(20, 2),
(8, 3),
(23, 12),
(26, 21),
(4, 27),
(25, 3),
(15, 17),
(22, 14),
(26, 21),
(27, 23),
(6, 12),
(11, 7),
(27, 13),
(27, 26),
(23, 21),
(10, 23),
(4, 19),
(7, 20),
(13, 20),
(27, 9),
(6, 18),
(26, 4),
(15, 1),
(27, 1),
(20, 7),
(28, 27),
(22, 9),
(5, 19),
(24, 3),
(4, 11),
(21, 27),
(22, 20),
(5, 24),
(20, 22),
(27, 14),
(20, 10),
(1, 14),
(1, 19),
(4, 7),
(2, 4),
(8, 15),
(15, 25),
(4, 5),
(13, 25),
(27, 9),
(8, 5),
(22, 3),
(4, 19),
(18, 4),
(21, 10),
(18, 21),
(1, 26),
(22, 26),
(11, 20),
(19, 1),
(25, 13),
(27, 20),
(19, 28),
(5, 13),
(23, 13),
(22, 28),
(2, 11),
(11, 15),
(25, 14),
(23, 7),
(9, 20),
(17, 3),
(1, 3),
(15, 10),
(25, 25),
(11, 9),
(1, 22),
(19, 15),
(16, 2),
(28, 14),
(11, 23),
(23, 26),
(2, 22),
(11, 12),
(17, 28),
(16, 18),
(13, 19),
(13, 15),
(9, 7),
(18, 11),
(8, 15),
(17, 28),
(9, 1),
(18, 11),
(15, 11),
(2, 2),
(8, 19),
(16, 23),
(17, 6),
(23, 19),
(23, 1),
(25, 8),
(7, 24),
(14, 8),
(1, 4),
(2, 12),
(27, 13),
(16, 26),
(23, 17),
(6, 16),
(11, 17),
(22, 2),
(16, 6),
(23, 2),
(5, 15),
(11, 10),
(21, 17),
(14, 26),
(13, 3),
(15, 12),
(21, 9),
(2, 22),
(7, 17),
(5, 23),
(5, 19),
(28, 27),
(8, 14),
(17, 18),
(21, 18),
(26, 19),
(24, 4),
(26, 6),
(25, 4),
(7, 27),
(11, 19),
(16, 1),
(28, 23),
(24, 24),
(15, 16),
(27, 11),
(24, 25),
(5, 27),
(14, 7),
(22, 5),
(4, 21),
(12, 15),
(26, 25),
(12, 15),
(24, 11),
(8, 23),
(15, 5),
(18, 25),
(23, 4),
(2, 6),
(19, 18),
(15, 26),
(24, 4),
(12, 9),
(18, 15),
(26, 1),
(4, 22),
(12, 9),
(13, 12),
(22, 17),
(25, 4),
(5, 27),
(15, 9),
(25, 2),
(14, 6),
(22, 9),
(15, 2),
(28, 4),
(12, 9),
(24, 16),
(27, 23),
(4, 1),
(3, 1),
(16, 26),
(23, 3),
(20, 15),
(26, 25),
(18, 14),
(26, 22),
(4, 1),
(25, 23),
(7, 28),
(27, 9),
(27, 13),
(14, 27),
(19, 12),
(17, 6),
(13, 20),
(7, 10),
(11, 13),
(4, 10),
(5, 19),
(25, 1),
(23, 1),
(1, 9),
(8, 18),
(4, 17),
(17, 8),
(24, 6),
(11, 4),
(4, 14),
(23, 2),
(17, 18),
(13, 16),
(1, 18),
(5, 26),
(6, 19),
(26, 27),
(3, 28),
(12, 15),
(22, 10),
(12, 5),
(18, 19),
(19, 20),
(5, 18),
(5, 3),
(7, 18),
(18, 26),
(25, 5),
(3, 15);

INSERT INTO FavoriteTablet(userID, tabletID)
VALUES (3, 1),
(4, 2),
(5, 3),
(8, 18),
(4, 12),
(19, 11),
(14, 18),
(2, 24),
(20, 23),
(23, 25),
(22, 22),
(11, 22),
(4, 10),
(24, 3),
(12, 6),
(28, 7),
(26, 27),
(11, 19),
(9, 3),
(3, 15),
(27, 8),
(21, 4),
(1, 2),
(8, 13),
(13, 10),
(4, 23),
(15, 28),
(25, 3),
(27, 7),
(18, 12),
(21, 25),
(5, 11),
(1, 18),
(23, 20),
(9, 15),
(26, 14),
(17, 24),
(15, 6),
(21, 21),
(10, 24),
(17, 14),
(1, 12),
(16, 14),
(17, 9),
(23, 7),
(28, 21),
(22, 25),
(12, 28),
(24, 17),
(2, 25),
(8, 12),
(27, 11),
(28, 4),
(24, 10),
(25, 27),
(12, 16),
(21, 12),
(14, 15),
(13, 8),
(21, 11),
(15, 18),
(21, 4),
(9, 6),
(22, 22),
(25, 11),
(3, 26),
(8, 15),
(20, 11),
(26, 18),
(8, 2),
(27, 16),
(18, 14),
(8, 20),
(12, 3),
(22, 22),
(23, 10),
(12, 23),
(2, 10),
(4, 28),
(25, 14),
(23, 25),
(23, 3),
(14, 25),
(3, 13),
(2, 20),
(20, 19),
(28, 20),
(24, 24),
(18, 17),
(3, 13),
(6, 12),
(22, 13),
(17, 3),
(22, 7),
(4, 15),
(15, 23),
(7, 19),
(1, 12),
(10, 21),
(26, 18),
(8, 7),
(4, 13),
(12, 24),
(26, 26),
(12, 4),
(22, 14),
(10, 14),
(17, 12),
(26, 14),
(18, 11),
(9, 4),
(2, 10),
(7, 8),
(26, 9),
(12, 27),
(4, 5),
(9, 18),
(15, 3),
(19, 6),
(4, 23),
(17, 1),
(18, 8),
(6, 25),
(18, 4),
(3, 27),
(17, 17),
(23, 26),
(20, 26),
(13, 13),
(13, 5),
(23, 3),
(16, 27),
(24, 10),
(1, 23),
(28, 16),
(2, 15),
(13, 11),
(6, 8),
(6, 19),
(8, 20),
(8, 7),
(25, 11),
(9, 20),
(8, 11),
(4, 26),
(11, 18),
(12, 9),
(8, 3),
(25, 3),
(24, 12),
(5, 25),
(25, 11),
(28, 23),
(6, 18),
(14, 26),
(2, 9),
(26, 1),
(10, 8),
(20, 20),
(13, 10),
(9, 2),
(8, 2),
(11, 14),
(3, 5),
(16, 4),
(25, 17),
(12, 1),
(19, 22),
(23, 5),
(16, 22),
(1, 21),
(14, 26),
(28, 6),
(13, 15),
(8, 2),
(25, 3),
(27, 6),
(15, 3),
(8, 16),
(17, 26),
(14, 2),
(18, 24),
(14, 28),
(9, 4),
(25, 24),
(17, 28),
(24, 12),
(27, 11),
(3, 6),
(10, 26),
(17, 16),
(11, 4),
(6, 21),
(20, 7),
(10, 1),
(14, 25),
(14, 1),
(27, 23),
(14, 19),
(27, 6),
(14, 17),
(12, 15),
(19, 16),
(9, 9),
(5, 13),
(20, 7),
(18, 23),
(18, 15),
(26, 9),
(8, 15),
(19, 12),
(9, 23),
(17, 28),
(7, 23),
(14, 24),
(13, 3),
(27, 4),
(26, 25),
(22, 27),
(8, 8),
(8, 2),
(23, 15),
(5, 12),
(20, 16),
(24, 4),
(11, 11),
(17, 5),
(16, 27);

INSERT INTO FavoritesHeadphones(userID, HeadphoneID)
VALUES (3, 1),
(4, 2),
(5, 3),
(21, 27),
(27, 8),
(15, 3),
(26, 5),
(16, 27),
(1, 25),
(7, 9),
(22, 27),
(17, 25),
(10, 11),
(3, 9),
(22, 15),
(8, 22),
(11, 18),
(12, 15),
(8, 9),
(19, 23),
(13, 24),
(11, 15),
(21, 23),
(16, 26),
(22, 15),
(18, 14),
(22, 13),
(11, 8),
(14, 6),
(28, 18),
(25, 28),
(17, 25),
(2, 25),
(20, 15),
(8, 2),
(1, 28),
(20, 23),
(25, 26),
(18, 6),
(15, 26),
(17, 25),
(28, 10),
(3, 14),
(27, 4),
(8, 22),
(16, 17),
(24, 17),
(18, 7),
(9, 6),
(24, 8),
(16, 11),
(13, 13),
(23, 1),
(20, 28),
(8, 6),
(23, 27),
(1, 14),
(28, 2),
(6, 16),
(23, 27),
(13, 10),
(15, 4),
(9, 2),
(11, 1),
(3, 9),
(21, 16),
(24, 12),
(13, 11),
(7, 5),
(21, 17),
(2, 19),
(2, 26),
(26, 15),
(19, 6),
(12, 21),
(25, 4),
(28, 27),
(10, 28),
(2, 25),
(8, 6),
(4, 9),
(19, 21),
(19, 5),
(23, 5),
(6, 12),
(3, 1),
(17, 5),
(22, 2),
(24, 8),
(24, 9),
(18, 8),
(19, 4),
(22, 13),
(21, 25),
(8, 27),
(9, 18),
(21, 3),
(25, 9),
(6, 15),
(26, 7),
(22, 5),
(27, 28),
(5, 25),
(17, 24),
(4, 16),
(16, 25),
(15, 9),
(4, 2),
(25, 27),
(3, 19),
(6, 5),
(18, 6),
(5, 23),
(15, 6),
(13, 24),
(22, 2),
(15, 5),
(4, 18),
(17, 2),
(25, 27),
(21, 12),
(3, 25),
(13, 28),
(3, 23),
(11, 2),
(12, 13),
(15, 26),
(11, 17),
(24, 16),
(6, 13),
(28, 18),
(10, 18),
(19, 4),
(23, 11),
(3, 4),
(8, 16),
(27, 8),
(27, 8),
(14, 1),
(14, 6),
(23, 14),
(18, 21),
(18, 26),
(16, 16),
(10, 19),
(18, 22),
(19, 12),
(28, 9),
(24, 18),
(24, 14),
(1, 11),
(21, 9),
(2, 15),
(23, 12),
(12, 16),
(24, 7),
(22, 18),
(14, 2),
(28, 5),
(18, 10),
(4, 20),
(18, 5),
(9, 18),
(15, 17),
(9, 26),
(6, 17),
(12, 3),
(27, 5),
(15, 18),
(5, 15),
(23, 18),
(25, 3),
(11, 19),
(18, 3),
(9, 23),
(23, 24),
(21, 26),
(15, 2),
(27, 4),
(11, 10),
(15, 13),
(17, 14),
(15, 4),
(24, 1),
(25, 21),
(9, 10),
(25, 22),
(5, 9),
(22, 5),
(6, 5),
(4, 16),
(20, 8),
(17, 26),
(12, 16),
(25, 22),
(3, 3),
(28, 14),
(26, 27),
(8, 15),
(27, 23),
(5, 27),
(20, 6),
(28, 12),
(20, 25),
(23, 23),
(17, 17),
(23, 9),
(25, 5),
(1, 27),
(6, 17),
(27, 5),
(25, 12),
(2, 22),
(17, 26),
(21, 10),
(4, 19),
(1, 9),
(18, 25),
(17, 16),
(17, 16),
(23, 2),
(12, 17),
(8, 1),
(18, 8),
(15, 23),
(20, 15),
(28, 11),
(24, 17);