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


