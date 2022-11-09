-- MySQL Script generated by MySQL Workbench
-- Wed Nov  9 10:29:38 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`province`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`province` (
  `province_code` INT NOT NULL,
  `province_name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`province_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(30) NOT NULL,
  `customer_surname` VARCHAR(60) NOT NULL,
  `customer_address` TEXT(100) NOT NULL,
  `customer_postcode` CHAR(5) NOT NULL,
  `customer_city` VARCHAR(30) NOT NULL,
  `customer_province_code` INT NOT NULL,
  `customer_phone` VARCHAR(15) NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_customer_province1_idx` (`customer_province_code` ASC) VISIBLE,
  CONSTRAINT `fk_customer_province1`
    FOREIGN KEY (`customer_province_code`)
    REFERENCES `pizzeria`.`province` (`province_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`shop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`shop` (
  `shop_id` INT NOT NULL AUTO_INCREMENT,
  `shop_address` VARCHAR(30) NOT NULL,
  `shop_postcode` CHAR(5) NOT NULL,
  `shop_city` VARCHAR(30) NOT NULL,
  `shop_province_code` INT NOT NULL,
  PRIMARY KEY (`shop_id`),
  INDEX `fk_shop_province1_idx` (`shop_province_code` ASC) VISIBLE,
  CONSTRAINT `fk_shop_province1`
    FOREIGN KEY (`shop_province_code`)
    REFERENCES `pizzeria`.`province` (`province_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`employee_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`employee_role` (
  `employee_role_id` INT NOT NULL AUTO_INCREMENT,
  `employee_role_name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`employee_role_id`))
ENGINE = InnoDB
COMMENT = '	\n';


-- -----------------------------------------------------
-- Table `pizzeria`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `employee_name` VARCHAR(30) NOT NULL,
  `employee_surname` VARCHAR(30) NOT NULL,
  `nif` CHAR(9) NOT NULL,
  `phone` CHAR(9) NULL,
  `employee_role` INT NOT NULL,
  `shop` INT NOT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_employee_employee_role1_idx` (`employee_role` ASC) VISIBLE,
  INDEX `fk_employee_shop1_idx` (`shop` ASC) VISIBLE,
  CONSTRAINT `fk_employee_employee_role1`
    FOREIGN KEY (`employee_role`)
    REFERENCES `pizzeria`.`employee_role` (`employee_role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_shop1`
    FOREIGN KEY (`shop`)
    REFERENCES `pizzeria`.`shop` (`shop_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`deliveryType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`deliveryType` (
  `deliveryType_id` INT NOT NULL AUTO_INCREMENT,
  `deliveryType` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`deliveryType_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `order_time` TIMESTAMP NOT NULL,
  `deliveryType` INT NOT NULL,
  `order_productQuant` INT NOT NULL,
  `order_price` FLOAT NOT NULL,
  `customer` INT NOT NULL,
  `shop` INT NOT NULL,
  `deliveryEmployee` INT NULL,
  `delivery_time` TIMESTAMP NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_order_customer1_idx` (`customer` ASC) VISIBLE,
  INDEX `fk_order_shop1_idx` (`shop` ASC) VISIBLE,
  INDEX `fk_order_employee1_idx` (`deliveryEmployee` ASC) VISIBLE,
  INDEX `fk_order_deliveryType1_idx` (`deliveryType` ASC) VISIBLE,
  CONSTRAINT `fk_order_customer1`
    FOREIGN KEY (`customer`)
    REFERENCES `pizzeria`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_shop1`
    FOREIGN KEY (`shop`)
    REFERENCES `pizzeria`.`shop` (`shop_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_employee1`
    FOREIGN KEY (`deliveryEmployee`)
    REFERENCES `pizzeria`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_deliveryType1`
    FOREIGN KEY (`deliveryType`)
    REFERENCES `pizzeria`.`deliveryType` (`deliveryType_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`productType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`productType` (
  `productType_id` INT NOT NULL AUTO_INCREMENT,
  `productType_name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`productType_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizzaCategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizzaCategory` (
  `pizzaCategory_id` INT NOT NULL AUTO_INCREMENT,
  `pizzaCategory_name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`pizzaCategory_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_type` INT NOT NULL,
  `pizzaCategory` INT NULL,
  `product_name` VARCHAR(30) NOT NULL,
  `product_description` TEXT(100) NULL,
  `product_image` LONGBLOB NULL,
  `product_price` FLOAT NOT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_product_productType_idx` (`product_type` ASC) VISIBLE,
  INDEX `fk_product_pizzaCategory1_idx` (`pizzaCategory` ASC) VISIBLE,
  CONSTRAINT `fk_product_productType`
    FOREIGN KEY (`product_type`)
    REFERENCES `pizzeria`.`productType` (`productType_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_pizzaCategory1`
    FOREIGN KEY (`pizzaCategory`)
    REFERENCES `pizzeria`.`pizzaCategory` (`pizzaCategory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`order_has_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`order_has_product` (
  `order_order_id` INT NOT NULL,
  `product_product_id` INT NOT NULL,
  PRIMARY KEY (`order_order_id`, `product_product_id`),
  INDEX `fk_order_has_product_product1_idx` (`product_product_id` ASC) VISIBLE,
  INDEX `fk_order_has_product_order1_idx` (`order_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_has_product_order1`
    FOREIGN KEY (`order_order_id`)
    REFERENCES `pizzeria`.`order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_has_product_product1`
    FOREIGN KEY (`product_product_id`)
    REFERENCES `pizzeria`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
