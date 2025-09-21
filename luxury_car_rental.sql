-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema luxury_car_rental
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema luxury_car_rental
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `luxury_car_rental` ;
USE `luxury_car_rental` ;

-- -----------------------------------------------------
-- Table `luxury_car_rental`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `luxury_car_rental`.`Staff` (
  `staff_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `position` VARCHAR(45) NULL,
  `salary` VARCHAR(45) NULL,
  PRIMARY KEY (`staff_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `luxury_car_rental`.`Rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `luxury_car_rental`.`Rental` (
  `rental_id` INT NOT NULL AUTO_INCREMENT,
  `amount` VARCHAR(45) NULL,
  `payment_method` VARCHAR(45) NULL,
  `status` VARCHAR(45) NULL,
  `Staff_staff_id` INT NOT NULL,
  `date_rented` DATE NULL,
  `date_returned` DATE NULL,
  `Customer_customer_id` INT NOT NULL,
  PRIMARY KEY (`rental_id`, `Staff_staff_id`, `Customer_customer_id`),
  INDEX `fk_Rental_Staff1_idx` (`Staff_staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_Rental_Staff1`
    FOREIGN KEY (`Staff_staff_id`)
    REFERENCES `luxury_car_rental`.`Staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `luxury_car_rental`.`Maintenance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `luxury_car_rental`.`Maintenance` (
  `maintenance_id` INT NOT NULL AUTO_INCREMENT,
  `service_type` VARCHAR(45) NULL,
  `cost` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `Staff_staff_id` INT NOT NULL,
  PRIMARY KEY (`maintenance_id`, `Staff_staff_id`),
  INDEX `fk_Maintainence_Staff1_idx` (`Staff_staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_Maintenance_Staff1`
    FOREIGN KEY (`Staff_staff_id`)
    REFERENCES `luxury_car_rental`.`Staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `luxury_car_rental`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `luxury_car_rental`.`Customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `Staff_staff_id` INT NOT NULL,
  PRIMARY KEY (`customer_id`, `Staff_staff_id`),
  INDEX `fk_Customer_Staff1_idx` (`Staff_staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_Staff1`
    FOREIGN KEY (`Staff_staff_id`)
    REFERENCES `luxury_car_rental`.`Staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `luxury_car_rental`.`Insurance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `luxury_car_rental`.`Insurance` (
  `insurance_id` INT NOT NULL AUTO_INCREMENT,
  `provider_name` VARCHAR(45) NULL,
  `policy_name` VARCHAR(45) NULL,
  `coverage` VARCHAR(45) NULL,
  PRIMARY KEY (`insurance_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `luxury_car_rental`.`Vehicles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `luxury_car_rental`.`Vehicles` (
  `vehicle_id` INT NOT NULL AUTO_INCREMENT,
  `model` VARCHAR(45) NULL,
  `color` VARCHAR(45) NULL,
  `rental_rate` VARCHAR(45) NULL,
  `Customer_customer_id` INT NOT NULL,
  `Insurance_insurance_id` INT NOT NULL,
  `Maintenance_maintenance_id` INT NOT NULL,
  `Maintenance_Staff_staff_id` INT NOT NULL,
  PRIMARY KEY (`vehicle_id`, `Customer_customer_id`, `Insurance_insurance_id`, `Maintenance_maintenance_id`, `Maintenance_Staff_staff_id`),
  INDEX `fk_Vehicles_Customer_idx` (`Customer_customer_id` ASC) VISIBLE,
  INDEX `fk_Vehicles_Insurance1_idx` (`Insurance_insurance_id` ASC) VISIBLE,
  INDEX `fk_Vehicles_Maintainence1_idx` (`Maintenance_maintenance_id` ASC, `Maintenance_Staff_staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_Vehicles_Customer`
    FOREIGN KEY (`Customer_customer_id`)
    REFERENCES `luxury_car_rental`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vehicles_Insurance1`
    FOREIGN KEY (`Insurance_insurance_id`)
    REFERENCES `luxury_car_rental`.`Insurance` (`insurance_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vehicles_Maintainence1`
    FOREIGN KEY (`Maintenance_maintenance_id` , `Maintenance_Staff_staff_id`)
    REFERENCES `luxury_car_rental`.`Maintenance` (`maintenance_id` , `Staff_staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `luxury_car_rental`.`Marketing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `luxury_car_rental`.`Marketing` (
  `marketing_id` INT NOT NULL,
  `budget` VARCHAR(45) NULL,
  `start_date` DATE NULL,
  `end_date` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `Rental_rental_id` INT NOT NULL,
  PRIMARY KEY (`marketing_id`, `Rental_rental_id`),
  INDEX `fk_Marketing_Rental1_idx` (`Rental_rental_id` ASC) VISIBLE,
  CONSTRAINT `fk_Marketing_Rental1`
    FOREIGN KEY (`Rental_rental_id`)
    REFERENCES `luxury_car_rental`.`Rental` (`rental_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `luxury_car_rental`.`Loan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `luxury_car_rental`.`Loan` (
  `loan_id` INT NOT NULL,
  `interest_rate` VARCHAR(45) NULL,
  `monthy_payment` VARCHAR(45) NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`loan_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `luxury_car_rental`.`purchase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `luxury_car_rental`.`purchase` (
  `Vehicles_vehicle_id` INT NOT NULL,
  `Vehicles_Customer_customer_id` INT NOT NULL,
  `Vehicles_Insurance_insurance_id` INT NOT NULL,
  `Vehicles_Maintenance_maintenance_id` INT NOT NULL,
  `Vehicles_Maintenance_Staff_staff_id` INT NOT NULL,
  `Loan_loan_id` INT NOT NULL,
  PRIMARY KEY (`Vehicles_vehicle_id`, `Vehicles_Customer_customer_id`, `Vehicles_Insurance_insurance_id`, `Vehicles_Maintenance_maintenance_id`, `Vehicles_Maintenance_Staff_staff_id`, `Loan_loan_id`),
  INDEX `fk_Vehicles_has_Loan_Loan1_idx` (`Loan_loan_id` ASC) VISIBLE,
  INDEX `fk_Vehicles_has_Loan_Vehicles1_idx` (`Vehicles_vehicle_id` ASC, `Vehicles_Customer_customer_id` ASC, `Vehicles_Insurance_insurance_id` ASC, `Vehicles_Maintenance_maintenance_id` ASC, `Vehicles_Maintenance_Staff_staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_Vehicles_has_Loan_Vehicles1`
    FOREIGN KEY (`Vehicles_vehicle_id` , `Vehicles_Customer_customer_id` , `Vehicles_Insurance_insurance_id` , `Vehicles_Maintenance_maintenance_id` , `Vehicles_Maintenance_Staff_staff_id`)
    REFERENCES `luxury_car_rental`.`Vehicles` (`vehicle_id` , `Customer_customer_id` , `Insurance_insurance_id` , `Maintenance_maintenance_id` , `Maintenance_Staff_staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vehicles_has_Loan_Loan1`
    FOREIGN KEY (`Loan_loan_id`)
    REFERENCES `luxury_car_rental`.`Loan` (`loan_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `luxury_car_rental`.`pay_loan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `luxury_car_rental`.`pay_loan` (
  `Rental_rental_id` INT NOT NULL,
  `Rental_Staff_staff_id` INT NOT NULL,
  `Loan_loan_id` INT NOT NULL,
  PRIMARY KEY (`Rental_rental_id`, `Rental_Staff_staff_id`, `Loan_loan_id`),
  INDEX `fk_Rental_has_Loan_Loan1_idx` (`Loan_loan_id` ASC) VISIBLE,
  INDEX `fk_Rental_has_Loan_Rental1_idx` (`Rental_rental_id` ASC, `Rental_Staff_staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_Rental_has_Loan_Rental1`
    FOREIGN KEY (`Rental_rental_id` , `Rental_Staff_staff_id`)
    REFERENCES `luxury_car_rental`.`Rental` (`rental_id` , `Staff_staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rental_has_Loan_Loan1`
    FOREIGN KEY (`Loan_loan_id`)
    REFERENCES `luxury_car_rental`.`Loan` (`loan_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `luxury_car_rental` ;

-- -----------------------------------------------------
-- Placeholder table for view `luxury_car_rental`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `luxury_car_rental`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `luxury_car_rental`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `luxury_car_rental`.`view1`;
USE `luxury_car_rental`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
