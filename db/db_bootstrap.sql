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
(3, true, true, 'A strong option at a reasonable price point. Good value.', 'Mid-range headphones');


INSERT INTO Tablet(length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, tabletName)
VALUES (280, 216, 6, 2400, 1080, 16, 512, 'Paper sized'),
(346, 195, 10, 3840, 2160, 16, 1000, 'Studio drawing tablet'),
(280, 214, 6, 2388, 1668, 32, 512, 'Iphone');


INSERT INTO Mouse(description, sensorType, size, weight, freeScrolling, mouseName)
VALUES ('Comfortable, ergonomic mouse fit for the office.', 'Optical', '4.72 x 3.11 x 3.09 inches', 130.408, false, 'Logitech MX Vertical Wireless Mouse'),
('High-end gaming mouse to last a lifetime.', 'Optical', '4.47 x 2.38 x 1.47 inches', 98.65634, false, 'Tt eSPORTS Ventus R'),
('Lightweight and ergonomic wired mouse.', 'Optical', '4.72 x 2.48 x 0.04 inches', 69, false, 'Model O- (Minus) Compact Wired Gaming Mouse');


INSERT INTO Phone(length, depth, thickness, horizontalResolution, verticalResolution, ram, storage, refreshRate,batteryLength, weight, interface, phoneName)
VALUES (149.6, 71.45, 8.25, 1179, 2556, 6, 1000, 60, 16, 171, 'USB-C', 'Iphone 15'),
(146.3, 70.9, 7.6, 2340, 1080, 8, 512, 120, 10, 168.1127, 'USB-C', 'Samsung Galaxy s23'),
(146.7, 71.5, 7.65, 2532, 1170, 4, 128, 60, 17, 174, 'Lighting connector', 'Iphone 13');


INSERT INTO Post(title, contents)
VALUES ('Cheap headphones cord breaks', 'I bought the cheap headphones 2 weeks ago. They were working great until last night when the cord snapped out of nowhere.'),
('Tt Ventus R review', 'I bought the Tt Ventus R mouse in order to review them on my YouTube channel. It arrived 3 days ago and I cannot believe I am saying it but it is worth the money.'),
('Looking for new phone', 'I am in the market for a new phone to replace my Iphone 10. Does anyone have any good information on some of the newer editions?');

INSERT INTO LaptopPorts (laptopID, port)
VALUES (1, 'USB-C'),
(1, 'Dell Charger'),
(1, 'USB-A'),
(1, 'HDMI');

INSERT INTO MakesKeyboard (manufacturerID, KeyboardID)
VALUES (6, 1),
(9, 2),
(5, 3);

INSERT INTO MakesHeadphones (manufacturerID, HeadphoneID)
VALUES (5,1),
(1, 2),
(6, 3);

INSERT INTO MakesLaptop (manufacturerID, laptopID)
VALUES (5,1),
(1, 2),
(6, 3);

INSERT INTO MakesMouse (manufacturerID, mouseID)
VALUES (5,1),
(1, 2),
(6, 3);

INSERT INTO MakesPhone (manufacturerID, phoneID)
VALUES (5,1),
(1, 2),
(6, 3);

INSERT INTO MakesSwitch (switchID, manufacturerID)
VALUES (1,5),
(2, 1),
(3, 6);

INSERT INTO MakesTablet (manufacturerID, tabletID)
VALUES (5,1),
(1, 2),
(6, 3);

INSERT INTO UserPost (userID, title)
VALUES (1, 'Cheap headphones cord breaks'),
(2, 'Tt Ventus R review');

INSERT INTO ManufacturerPost (manufacturerID, title)
VALUES (3, 'Looking for new phone');

INSERT INTO FavoriteKeyboard(userID, KeyboardID)
VALUES (3, 1),
(4, 2),
(5, 3);

INSERT INTO FavoriteLaptop(userID, laptopID)
VALUES (3, 1),
(4, 2),
(5, 3);

INSERT INTO FavoriteMouse(userID, mouseID)
VALUES (3, 1),
(4, 2),
(5, 3);

INSERT INTO FavoritePhone(userID, phoneID)
VALUES (3, 1),
(4, 2),
(5, 3);

INSERT INTO FavoriteTablet(userID, tabletID)
VALUES (3, 1),
(4, 2),
(5, 3);

INSERT INTO FavoritesHeadphones(userID, HeadphoneID)
VALUES (3, 1),
(4, 2),
(5, 3);