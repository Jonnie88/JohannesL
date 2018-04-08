-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema JohnnesL
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema JohnnesL
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `JohnnesL` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci ;
USE `JohnnesL` ;

-- -----------------------------------------------------
-- Table `JohnnesL`.`movieDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`movieDetails` (
  `idMovieDetails` INT NOT NULL AUTO_INCREMENT,
  `movieName` VARCHAR(45) NULL,
  `moviePlot` TEXT(1000) NULL,
  `movieLenght` INT NULL,
  `movieRealeseYear` YEAR NULL,
  PRIMARY KEY (`idMovieDetails`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`dvdMovie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`dvdMovie` (
  `idDvdMovie` INT NOT NULL AUTO_INCREMENT,
  `idMovieDetails` INT NULL,
  `inStock` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`idDvdMovie`),
  INDEX `movieDetailsFK_idx` (`idMovieDetails` ASC),
  CONSTRAINT `movieDetailsDvdMovieFK`
    FOREIGN KEY (`idMovieDetails`)
    REFERENCES `JohnnesL`.`movieDetails` (`idMovieDetails`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`genre` (
  `idGenre` INT NOT NULL AUTO_INCREMENT,
  `genreName` VARCHAR(45) NULL,
  PRIMARY KEY (`idGenre`),
  UNIQUE INDEX `genreName_UNIQUE` (`genreName` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`movieGenre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`movieGenre` (
  `idMovieGenre` INT NOT NULL AUTO_INCREMENT,
  `idMovieDetails` INT NULL,
  `idGenre` INT NULL,
  PRIMARY KEY (`idMovieGenre`),
  INDEX `genreFk_idx` (`idGenre` ASC),
  INDEX `movieDetailFK_idx` (`idMovieDetails` ASC),
  CONSTRAINT `genreMovieGenreFk`
    FOREIGN KEY (`idGenre`)
    REFERENCES `JohnnesL`.`genre` (`idGenre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `movieDetailMovieGenreFK`
    FOREIGN KEY (`idMovieDetails`)
    REFERENCES `JohnnesL`.`movieDetails` (`idMovieDetails`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`person` (
  `idPerson` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPerson`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`actor` (
  `idactor` INT NOT NULL AUTO_INCREMENT,
  `idPerson` INT NULL,
  `idMovieDetail` INT NULL,
  PRIMARY KEY (`idactor`),
  INDEX `movieDetailFK_idx` (`idMovieDetail` ASC),
  INDEX `personFK_idx` (`idPerson` ASC),
  CONSTRAINT `movieDetailActorFK`
    FOREIGN KEY (`idMovieDetail`)
    REFERENCES `JohnnesL`.`movieDetails` (`idMovieDetails`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `personActorFK`
    FOREIGN KEY (`idPerson`)
    REFERENCES `JohnnesL`.`person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`directors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`directors` (
  `idDirectors` INT NOT NULL AUTO_INCREMENT,
  `idPerson` INT NULL,
  `idMovieDetail` INT NULL,
  PRIMARY KEY (`idDirectors`),
  INDEX `PersonFk_idx` (`idPerson` ASC),
  INDEX `movieDetailFk_idx` (`idMovieDetail` ASC),
  CONSTRAINT `PersonDirectorsFk`
    FOREIGN KEY (`idPerson`)
    REFERENCES `JohnnesL`.`person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `movieDetailDirectorsFk`
    FOREIGN KEY (`idMovieDetail`)
    REFERENCES `JohnnesL`.`movieDetails` (`idMovieDetails`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`customer` (
  `idCustomer` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `phoneNumber` VARCHAR(45) NULL,
  PRIMARY KEY (`idCustomer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`employee` (
  `idEmployee` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `phoneNumber` VARCHAR(45) NULL,
  PRIMARY KEY (`idEmployee`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`address` (
  `idAddress` INT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `streetName` VARCHAR(45) NOT NULL,
  `streetNumber` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAddress`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`customerAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`customerAddress` (
  `idCustomerAddress` INT NOT NULL AUTO_INCREMENT,
  `idCustomer` INT NULL,
  `idAddress` INT NULL,
  PRIMARY KEY (`idCustomerAddress`),
  INDEX `addressFK_idx` (`idAddress` ASC),
  INDEX `customerFK_idx` (`idCustomer` ASC),
  CONSTRAINT `customerAddressFK`
    FOREIGN KEY (`idAddress`)
    REFERENCES `JohnnesL`.`address` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `addressCustomerFK`
    FOREIGN KEY (`idCustomer`)
    REFERENCES `JohnnesL`.`customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`employeeAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`employeeAddress` (
  `idemployeeAddress` INT NOT NULL,
  `idEmployee` INT NULL,
  `idAddress` INT NULL,
  PRIMARY KEY (`idemployeeAddress`),
  INDEX `employeeFK_idx` (`idEmployee` ASC),
  INDEX `addressFK_idx` (`idAddress` ASC),
  CONSTRAINT `employeeAddressFK`
    FOREIGN KEY (`idEmployee`)
    REFERENCES `JohnnesL`.`employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `addressEmployeeFK`
    FOREIGN KEY (`idAddress`)
    REFERENCES `JohnnesL`.`address` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`order` (
  `idOrder` INT NOT NULL AUTO_INCREMENT,
  `idCustomer` INT NULL,
  `idEmployee` INT NULL,
  `idDvd` INT NULL,
  `returnDate` VARCHAR(45) NULL,
  `orderDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idOrder`),
  INDEX `costumerFK_idx` (`idCustomer` ASC),
  INDEX `employeeFK_idx` (`idEmployee` ASC),
  INDEX `dvdMovieFK_idx` (`idDvd` ASC),
  CONSTRAINT `costumerOrderFK`
    FOREIGN KEY (`idCustomer`)
    REFERENCES `JohnnesL`.`customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employeeOrderFK`
    FOREIGN KEY (`idEmployee`)
    REFERENCES `JohnnesL`.`employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `dvdMovieOrderFK`
    FOREIGN KEY (`idDvd`)
    REFERENCES `JohnnesL`.`dvdMovie` (`idDvdMovie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`timestamps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`timestamps` (
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NULL);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- -----------------------------------------------------
-- Dummie Data
-- -----------------------------------------------------
INSERT INTO `person` VALUES (1,'Tim','Robbins'),(2,'Morgan','Freeman'),(3,'Bob','Gunton'),(4,'Marlon','Brandon'),(5,'Al','Pacino'),(6,'James','Caan'),(7,'Frank','Darabont'),(8,'Francis','Ford Coppola'),(9,'Christopher','Nolan'),(10,'Christian','Bale'),(11,'Heath','Ledger'),(12,'Aaron','Eckhart'),(13,'Steven','Spielberg'),(14,'Liam','Neeson'),(15,'Ralph','Fiennes'),(16,'Ben','Kingsley'),(17,'Peter','Jackson'),(18,'Elijah','Woods'),(19,'Viggo','Mortensen'),(20,'Ian','McKellen'),(21,'Robert','Zemeckis'),(22,'Tom','Hanks'),(23,'Robin','Wright'),(24,'Gary','Sinise'),(25,'Milos','Forman'),(26,'Jack','Nicholson'),(27,'Louise','Fletcher'),(28,'Michael','Berryman'),(29,'Jonathan','Demme'),(30,'Jodie','Foster'),(31,'Anthony','Hopkins'),(32,'Lawrence','A. Bonney'),(33,'Kevin','Spacey'),(34,'Bryan','Singer'),(35,'Gabriel','Byrne'),(36,'Chazz','Palmiteri'),(37,'Eddie','Murphy'),(38,'Richard','Pryor'),(39,'Redd','Fox');

INSERT INTO `customer` VALUES (1,'Luke','Sweeney','LS@gmail.com','0551-8867351'),(2,'Joseph','Pennington','Jp@gmail.com','0551-8867352'),(3,'Nakita','Alvarado','na@gmail.com','0551-8867353'),(4,'Abi','Huerta','ah@gmail.com','0551-8867354'),(5,'Jamie-Leigh','Cain','JLC@gmail.com','0551-8867355'),(6,'Milosz','Emery','me@gmail.com','0551-8867356'),(7,'Khalil','Nicholson','kn@gmail.com','0551-8867357'),(8,'Saxon','Cruz','sc@gmail.com','0551-8867358'),(9,'Connah','Hutchings','ch@gmail.com','0551-8867359'),(10,'Nylah','Mckee','nm@gmail.com','0551-8867310');

INSERT INTO `movieDetails` VALUES(1,'The Shawshank redemption','PLOT',140,1994),(2,'The Godftaher','PLOT',170,1972),(3,'The Dark knight','PLOT',150,2008),(4,'Shindlers list','PLOT',120,1993),(5,'The Lord of the rings: The return of the king','PLOT',200,2003),(6,'Forrest Gump','PLOT',120,1994),(7,'One Felw over the cuckoos nest','PLOT',190,1975),(8,'The Silence of the lambs','PLOT',140,1991),(9,'The Usual suspects','PLOT',100,1995),(10,'Harlem nights','PLOT',140,1989),(11,'Star Wars: the Final episod','PLOT',300,2020);

INSERT INTO `actor` VALUES (24,1,1),(27,2,4),(28,18,5),(29,22,6),(30,37,10),(55,2,1),(56,3,1),(57,4,2),(58,5,2),(59,6,2),(60,10,3),(61,11,3),(62,12,3),(63,14,4),(64,15,4),(65,16,4),(67,19,5),(68,20,5),(70,23,6),(71,24,6),(72,26,7),(73,27,7),(74,28,7),(75,30,8),(76,31,8),(77,32,8),(78,33,9),(79,34,9),(80,35,9),(82,38,10),(83,39,10);

INSERT INTO `dvdMovie` VALUES (1,1,1),(2,1,0),(3,1,1),(4,1,1),(5,1,1),(6,2,1),(7,2,1),(8,2,1),(9,3,1),(10,4,1),(11,4,1),(12,5,1),(13,5,1),(14,6,1),(15,6,1),(16,7,1),(17,7,1),(18,7,1),(19,8,1),(20,8,1),(21,8,1),(22,8,1),(23,9,1),(24,9,1),(25,9,1),(26,9,1),(27,10,1),(28,10,1),(29,10,1);

INSERT INTO `genre` VALUES (2,'Action'),(7,'Adventure'),(5,'Biography'),(11,'Comedy'),(3,'Crime'),(1,'Drama'),(8,'Fantasy'),(6,'History'),(10,'Mystery'),(9,'Romance'),(4,'Thriller');

INSERT INTO `movieGenre` VALUES (1,1,1),(2,1,3),(3,2,1),(4,2,3),(5,3,3),(6,3,2),(7,3,4),(8,4,5),(9,4,1),(10,4,6),(11,5,7),(12,5,1),(13,5,8),(14,6,1),(15,6,9),(16,7,1),(17,8,3),(18,8,1),(19,8,4),(20,9,3),(21,9,10),(22,9,4),(23,10,1),(24,10,3),(25,10,11);

INSERT INTO `employee` VALUES (1,'Rianna','Gilmore','RG@maxdvdstore.se',NULL),(2,'Janice','Washington','JW@maxdvdstore.se',NULL),(3,'Jorja','Puckett','JP@maxdvdstore.se',NULL),(4,'Frances','Bravo','FB@maxdvdstore.se',NULL),(5,'Alaina','Mccullough','AM@maxdvdstore.se',NULL),(6,'Rajan','Cortez','RC@maxdvdstore.se',NULL),(7,'Alara','Sharpe','AS@maxdvdstore.se',NULL),(8,'Lisa','English','LE@maxdvdstore.se',NULL),(9,'Josef','Mora','JM@maxdvdstore.se',NULL),(10,'Sameeha','Bellamy','SB@maxdvdstore.se',NULL);

INSERT  INTO `directors` VALUES (1,7,1),(2,8,2),(3,9,3),(4,13,4),(5,17,5),(6,21,6),(7,25,7),(8,29,8),(9,34,9),(10,37,10);

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema JohnnesL
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema JohnnesL
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `JohnnesL` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci ;
USE `JohnnesL` ;

-- -----------------------------------------------------
-- Table `JohnnesL`.`movieDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`movieDetails` (
  `idMovieDetails` INT NOT NULL AUTO_INCREMENT,
  `movieName` VARCHAR(45) NULL,
  `moviePlot` TEXT(1000) NULL,
  `movieLenght` INT NULL,
  `movieRealeseYear` YEAR NULL,
  PRIMARY KEY (`idMovieDetails`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`dvdMovie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`dvdMovie` (
  `idDvdMovie` INT NOT NULL AUTO_INCREMENT,
  `idMovieDetails` INT NULL,
  `inStock` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`idDvdMovie`),
  INDEX `movieDetailsFK_idx` (`idMovieDetails` ASC),
  CONSTRAINT `movieDetailsDvdMovieFK`
    FOREIGN KEY (`idMovieDetails`)
    REFERENCES `JohnnesL`.`movieDetails` (`idMovieDetails`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`genre` (
  `idGenre` INT NOT NULL AUTO_INCREMENT,
  `genreName` VARCHAR(45) NULL,
  PRIMARY KEY (`idGenre`),
  UNIQUE INDEX `genreName_UNIQUE` (`genreName` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`movieGenre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`movieGenre` (
  `idMovieGenre` INT NOT NULL AUTO_INCREMENT,
  `idMovieDetails` INT NULL,
  `idGenre` INT NULL,
  PRIMARY KEY (`idMovieGenre`),
  INDEX `genreFk_idx` (`idGenre` ASC),
  INDEX `movieDetailFK_idx` (`idMovieDetails` ASC),
  CONSTRAINT `genreMovieGenreFk`
    FOREIGN KEY (`idGenre`)
    REFERENCES `JohnnesL`.`genre` (`idGenre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `movieDetailMovieGenreFK`
    FOREIGN KEY (`idMovieDetails`)
    REFERENCES `JohnnesL`.`movieDetails` (`idMovieDetails`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`person` (
  `idPerson` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPerson`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`actor` (
  `idactor` INT NOT NULL AUTO_INCREMENT,
  `idPerson` INT NULL,
  `idMovieDetail` INT NULL,
  PRIMARY KEY (`idactor`),
  INDEX `movieDetailFK_idx` (`idMovieDetail` ASC),
  INDEX `personFK_idx` (`idPerson` ASC),
  CONSTRAINT `movieDetailActorFK`
    FOREIGN KEY (`idMovieDetail`)
    REFERENCES `JohnnesL`.`movieDetails` (`idMovieDetails`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `personActorFK`
    FOREIGN KEY (`idPerson`)
    REFERENCES `JohnnesL`.`person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`directors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`directors` (
  `idDirectors` INT NOT NULL AUTO_INCREMENT,
  `idPerson` INT NULL,
  `idMovieDetail` INT NULL,
  PRIMARY KEY (`idDirectors`),
  INDEX `PersonFk_idx` (`idPerson` ASC),
  INDEX `movieDetailFk_idx` (`idMovieDetail` ASC),
  CONSTRAINT `PersonDirectorsFk`
    FOREIGN KEY (`idPerson`)
    REFERENCES `JohnnesL`.`person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `movieDetailDirectorsFk`
    FOREIGN KEY (`idMovieDetail`)
    REFERENCES `JohnnesL`.`movieDetails` (`idMovieDetails`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`customer` (
  `idCustomer` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `phoneNumber` VARCHAR(45) NULL,
  PRIMARY KEY (`idCustomer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`employee` (
  `idEmployee` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `phoneNumber` VARCHAR(45) NULL,
  PRIMARY KEY (`idEmployee`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`address` (
  `idAddress` INT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `streetName` VARCHAR(45) NOT NULL,
  `streetNumber` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAddress`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`customerAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`customerAddress` (
  `idCustomerAddress` INT NOT NULL AUTO_INCREMENT,
  `idCustomer` INT NULL,
  `idAddress` INT NULL,
  PRIMARY KEY (`idCustomerAddress`),
  INDEX `addressFK_idx` (`idAddress` ASC),
  INDEX `customerFK_idx` (`idCustomer` ASC),
  CONSTRAINT `customerAddressFK`
    FOREIGN KEY (`idAddress`)
    REFERENCES `JohnnesL`.`address` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `addressCustomerFK`
    FOREIGN KEY (`idCustomer`)
    REFERENCES `JohnnesL`.`customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`employeeAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`employeeAddress` (
  `idemployeeAddress` INT NOT NULL,
  `idEmployee` INT NULL,
  `idAddress` INT NULL,
  PRIMARY KEY (`idemployeeAddress`),
  INDEX `employeeFK_idx` (`idEmployee` ASC),
  INDEX `addressFK_idx` (`idAddress` ASC),
  CONSTRAINT `employeeAddressFK`
    FOREIGN KEY (`idEmployee`)
    REFERENCES `JohnnesL`.`employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `addressEmployeeFK`
    FOREIGN KEY (`idAddress`)
    REFERENCES `JohnnesL`.`address` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`order` (
  `idOrder` INT NOT NULL AUTO_INCREMENT,
  `idCustomer` INT NULL,
  `idEmployee` INT NULL,
  `idDvd` INT NULL,
  `returnDate` VARCHAR(45) NULL,
  `orderDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idOrder`),
  INDEX `costumerFK_idx` (`idCustomer` ASC),
  INDEX `employeeFK_idx` (`idEmployee` ASC),
  INDEX `dvdMovieFK_idx` (`idDvd` ASC),
  CONSTRAINT `costumerOrderFK`
    FOREIGN KEY (`idCustomer`)
    REFERENCES `JohnnesL`.`customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employeeOrderFK`
    FOREIGN KEY (`idEmployee`)
    REFERENCES `JohnnesL`.`employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `dvdMovieOrderFK`
    FOREIGN KEY (`idDvd`)
    REFERENCES `JohnnesL`.`dvdMovie` (`idDvdMovie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JohnnesL`.`timestamps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JohnnesL`.`timestamps` (
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NULL);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- -----------------------------------------------------
-- Dummie Data
-- -----------------------------------------------------
INSERT INTO `person` VALUES (1,'Tim','Robbins'),(2,'Morgan','Freeman'),(3,'Bob','Gunton'),(4,'Marlon','Brandon'),(5,'Al','Pacino'),(6,'James','Caan'),(7,'Frank','Darabont'),(8,'Francis','Ford Coppola'),(9,'Christopher','Nolan'),(10,'Christian','Bale'),(11,'Heath','Ledger'),(12,'Aaron','Eckhart'),(13,'Steven','Spielberg'),(14,'Liam','Neeson'),(15,'Ralph','Fiennes'),(16,'Ben','Kingsley'),(17,'Peter','Jackson'),(18,'Elijah','Woods'),(19,'Viggo','Mortensen'),(20,'Ian','McKellen'),(21,'Robert','Zemeckis'),(22,'Tom','Hanks'),(23,'Robin','Wright'),(24,'Gary','Sinise'),(25,'Milos','Forman'),(26,'Jack','Nicholson'),(27,'Louise','Fletcher'),(28,'Michael','Berryman'),(29,'Jonathan','Demme'),(30,'Jodie','Foster'),(31,'Anthony','Hopkins'),(32,'Lawrence','A. Bonney'),(33,'Kevin','Spacey'),(34,'Bryan','Singer'),(35,'Gabriel','Byrne'),(36,'Chazz','Palmiteri'),(37,'Eddie','Murphy'),(38,'Richard','Pryor'),(39,'Redd','Fox');

INSERT INTO `customer` VALUES (1,'Luke','Sweeney','LS@gmail.com','0551-8867351'),(2,'Joseph','Pennington','Jp@gmail.com','0551-8867352'),(3,'Nakita','Alvarado','na@gmail.com','0551-8867353'),(4,'Abi','Huerta','ah@gmail.com','0551-8867354'),(5,'Jamie-Leigh','Cain','JLC@gmail.com','0551-8867355'),(6,'Milosz','Emery','me@gmail.com','0551-8867356'),(7,'Khalil','Nicholson','kn@gmail.com','0551-8867357'),(8,'Saxon','Cruz','sc@gmail.com','0551-8867358'),(9,'Connah','Hutchings','ch@gmail.com','0551-8867359'),(10,'Nylah','Mckee','nm@gmail.com','0551-8867310');

INSERT INTO `movieDetails` VALUES(1,'The Shawshank redemption','PLOT',140,1994),(2,'The Godftaher','PLOT',170,1972),(3,'The Dark knight','PLOT',150,2008),(4,'Shindlers list','PLOT',120,1993),(5,'The Lord of the rings: The return of the king','PLOT',200,2003),(6,'Forrest Gump','PLOT',120,1994),(7,'One Felw over the cuckoos nest','PLOT',190,1975),(8,'The Silence of the lambs','PLOT',140,1991),(9,'The Usual suspects','PLOT',100,1995),(10,'Harlem nights','PLOT',140,1989),(11,'Star Wars: the Final episod','PLOT',300,2020);

INSERT INTO `actor` VALUES (24,1,1),(27,2,4),(28,18,5),(29,22,6),(30,37,10),(55,2,1),(56,3,1),(57,4,2),(58,5,2),(59,6,2),(60,10,3),(61,11,3),(62,12,3),(63,14,4),(64,15,4),(65,16,4),(67,19,5),(68,20,5),(70,23,6),(71,24,6),(72,26,7),(73,27,7),(74,28,7),(75,30,8),(76,31,8),(77,32,8),(78,33,9),(79,34,9),(80,35,9),(82,38,10),(83,39,10);

INSERT INTO `dvdMovie` VALUES (1,1,1),(2,1,0),(3,1,1),(4,1,1),(5,1,1),(6,2,1),(7,2,1),(8,2,1),(9,3,1),(10,4,1),(11,4,1),(12,5,1),(13,5,1),(14,6,1),(15,6,1),(16,7,1),(17,7,1),(18,7,1),(19,8,1),(20,8,1),(21,8,1),(22,8,1),(23,9,1),(24,9,1),(25,9,1),(26,9,1),(27,10,1),(28,10,1),(29,10,1);

INSERT INTO `genre` VALUES (2,'Action'),(7,'Adventure'),(5,'Biography'),(11,'Comedy'),(3,'Crime'),(1,'Drama'),(8,'Fantasy'),(6,'History'),(10,'Mystery'),(9,'Romance'),(4,'Thriller');

INSERT INTO `movieGenre` VALUES (1,1,1),(2,1,3),(3,2,1),(4,2,3),(5,3,3),(6,3,2),(7,3,4),(8,4,5),(9,4,1),(10,4,6),(11,5,7),(12,5,1),(13,5,8),(14,6,1),(15,6,9),(16,7,1),(17,8,3),(18,8,1),(19,8,4),(20,9,3),(21,9,10),(22,9,4),(23,10,1),(24,10,3),(25,10,11);

INSERT INTO `employee` VALUES (1,'Rianna','Gilmore','RG@maxdvdstore.se',NULL),(2,'Janice','Washington','JW@maxdvdstore.se',NULL),(3,'Jorja','Puckett','JP@maxdvdstore.se',NULL),(4,'Frances','Bravo','FB@maxdvdstore.se',NULL),(5,'Alaina','Mccullough','AM@maxdvdstore.se',NULL),(6,'Rajan','Cortez','RC@maxdvdstore.se',NULL),(7,'Alara','Sharpe','AS@maxdvdstore.se',NULL),(8,'Lisa','English','LE@maxdvdstore.se',NULL),(9,'Josef','Mora','JM@maxdvdstore.se',NULL),(10,'Sameeha','Bellamy','SB@maxdvdstore.se',NULL);

INSERT  INTO `directors` VALUES (1,7,1),(2,8,2),(3,9,3),(4,13,4),(5,17,5),(6,21,6),(7,25,7),(8,29,8),(9,34,9),(10,37,10);

-- -----------------------------------------------------
-- Views
-- -----------------------------------------------------
-- update Tabel movie details to with bool to check if the movie is for rent or not. Plus update of dummmie data
ALTER TABLE `JohnnesL`.`movieDetails`
ADD COLUMN `ForRentOrNot` TINYINT NULL DEFAULT 0 AFTER `movieRealeseYear`;
UPDATE `JohnnesL`.`movieDetails` SET `ForRentOrNot`='1' WHERE `idMovieDetails`='1';
UPDATE `JohnnesL`.`movieDetails` SET `ForRentOrNot`='1' WHERE `idMovieDetails`='2';
UPDATE `JohnnesL`.`movieDetails` SET `ForRentOrNot`='1' WHERE `idMovieDetails`='3';
UPDATE `JohnnesL`.`movieDetails` SET `ForRentOrNot`='1' WHERE `idMovieDetails`='4';
UPDATE `JohnnesL`.`movieDetails` SET `ForRentOrNot`='1' WHERE `idMovieDetails`='5';
UPDATE `JohnnesL`.`movieDetails` SET `ForRentOrNot`='1' WHERE `idMovieDetails`='6';
UPDATE `JohnnesL`.`movieDetails` SET `ForRentOrNot`='1' WHERE `idMovieDetails`='7';
UPDATE `JohnnesL`.`movieDetails` SET `ForRentOrNot`='1' WHERE `idMovieDetails`='8';
UPDATE `JohnnesL`.`movieDetails` SET `ForRentOrNot`='1' WHERE `idMovieDetails`='9';

SELECT * FROM JohnnesL.movieDetails WHERE ForRentOrNot IS TRUE;

CREATE VIEW `movies_for_rent` AS
SELECT * FROM JohnnesL.movieDetails WHERE ForRentOrNot IS TRUE;


