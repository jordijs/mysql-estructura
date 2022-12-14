-- MySQL Script generated by MySQL Workbench
-- Mon Nov  7 12:57:06 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema culDAmpolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema culDAmpolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `culDAmpolla` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci ;
USE `culDAmpolla` ;

-- -----------------------------------------------------
-- Table `culDAmpolla`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culDAmpolla`.`employees` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culDAmpolla`.`suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culDAmpolla`.`suppliers` (
  `id` INT NOT NULL,
  `name` VARCHAR(30) NULL,
  `addr_street` VARCHAR(30) NULL,
  `addr_num` INT NULL,
  `addr_floor` INT NULL,
  `addr_door` INT NULL,
  `addr_city` VARCHAR(30) NULL,
  `addr_postcode` CHAR(5) NULL,
  `addr_country` VARCHAR(30) NULL,
  `phone` CHAR(9) NULL,
  `fax` CHAR(9) NULL,
  `nif` CHAR(9) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culDAmpolla`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culDAmpolla`.`brand` (
  `id` INT NOT NULL,
  `brand` VARCHAR(30) NULL,
  `supplier` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_brand_suppliers1_idx` (`supplier` ASC) VISIBLE,
  CONSTRAINT `fk_brand_suppliers1`
    FOREIGN KEY (`supplier`)
    REFERENCES `culDAmpolla`.`suppliers` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culDAmpolla`.`frametype`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culDAmpolla`.`frametype` (
  `id` INT NOT NULL,
  `frametype` VARCHAR(10) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culDAmpolla`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culDAmpolla`.`glasses` (
  `id` INT NOT NULL,
  `brand` INT NOT NULL,
  `refraction_left` DECIMAL(2,1) NULL,
  `refraction_right` DECIMAL(2,1) NULL,
  `frame_type` INT NOT NULL,
  `frame_color` VARCHAR(10) NULL,
  `glass_left_color` VARCHAR(10) NULL,
  `glass_right_color` VARCHAR(10) NULL,
  `price` FLOAT(6) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_glasses_brand1_idx` (`brand` ASC) VISIBLE,
  INDEX `fk_glasses_frametype1_idx` (`frame_type` ASC) VISIBLE,
  CONSTRAINT `fk_glasses_brand1`
    FOREIGN KEY (`brand`)
    REFERENCES `culDAmpolla`.`brand` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_glasses_frametype1`
    FOREIGN KEY (`frame_type`)
    REFERENCES `culDAmpolla`.`frametype` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `culDAmpolla`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culDAmpolla`.`customer` (
  `customer_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `address` VARCHAR(100) NULL,
  `phone` CHAR(9) NULL,
  `mail` VARCHAR(30) NULL,
  `date_enrol` DATE NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culDAmpolla`.`glassSell`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culDAmpolla`.`glassSell` (
  `id` INT NOT NULL,
  `employee` INT NOT NULL,
  `glass` INT NOT NULL,
  `time` TIMESTAMP NULL,
  `customer` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_glassSell_employees_idx` (`employee` ASC) VISIBLE,
  INDEX `fk_glassSell_glasses1_idx` (`glass` ASC) VISIBLE,
  INDEX `fk_glassSell_customer1_idx` (`customer` ASC) VISIBLE,
  CONSTRAINT `fk_glassSell_employees`
    FOREIGN KEY (`employee`)
    REFERENCES `culDAmpolla`.`employees` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_glassSell_glasses1`
    FOREIGN KEY (`glass`)
    REFERENCES `culDAmpolla`.`glasses` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_glassSell_customer1`
    FOREIGN KEY (`customer`)
    REFERENCES `culDAmpolla`.`customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `culDAmpolla`.`newCustomer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culDAmpolla`.`newCustomer` (
  `id_newCustomer` INT NOT NULL,
  `id_referrerCustomer` INT NOT NULL,
  INDEX `fk_newCustomer_customer1_idx` (`id_referrerCustomer` ASC) VISIBLE,
  PRIMARY KEY (`id_referrerCustomer`, `id_newCustomer`),
  CONSTRAINT `fk_newCustomer_customer1`
    FOREIGN KEY (`id_referrerCustomer`)
    REFERENCES `culDAmpolla`.`customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
