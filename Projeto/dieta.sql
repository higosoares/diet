-- MySQL Script generated by MySQL Workbench
-- Ter 20 Set 2016 16:26:14 BRT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Dieta
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Dieta` ;

-- -----------------------------------------------------
-- Schema Dieta
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Dieta` DEFAULT CHARACTER SET utf8 ;
USE `Dieta` ;

-- -----------------------------------------------------
-- Table `Dieta`.`tb_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Dieta`.`tb_usuario` ;

CREATE TABLE IF NOT EXISTS `Dieta`.`tb_usuario` (
  `idt_usuario` INT NOT NULL,
  `nme_usuario` VARCHAR(45) NOT NULL,
  `val_cpf` VARCHAR(45) NOT NULL,
  `val_telefone` VARCHAR(45) NOT NULL,
  `val_peso` INT NOT NULL,
  `val_altura` VARCHAR(45) NOT NULL,
  `val_idade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idt_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dieta`.`tb_objetivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Dieta`.`tb_objetivo` ;

CREATE TABLE IF NOT EXISTS `Dieta`.`tb_objetivo` (
  `idt_objetivo` INT NOT NULL,
  `nme_objetivo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idt_objetivo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dieta`.`tb_dieta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Dieta`.`tb_dieta` ;

CREATE TABLE IF NOT EXISTS `Dieta`.`tb_dieta` (
  `idt_dieta` INT NOT NULL,
  `dat_inicial` DATE NOT NULL,
  `dat_final` DATE NOT NULL,
  `val_peso_ideal` INT NOT NULL,
  `cod_objetivo` INT NOT NULL,
  PRIMARY KEY (`idt_dieta`),
  INDEX `fk_Dieta_Objetivo1_idx` (`cod_objetivo` ASC),
  CONSTRAINT `fk_Dieta_Objetivo1`
    FOREIGN KEY (`cod_objetivo`)
    REFERENCES `Dieta`.`tb_objetivo` (`idt_objetivo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dieta`.`tb_alimento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Dieta`.`tb_alimento` ;

CREATE TABLE IF NOT EXISTS `Dieta`.`tb_alimento` (
  `idt_alimento` INT NOT NULL,
  `nme_alimento` VARCHAR(45) NOT NULL,
  `val_calorias` INT NOT NULL,
  `val_peso` INT NOT NULL,
  PRIMARY KEY (`idt_alimento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dieta`.`tb_localizacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Dieta`.`tb_localizacao` ;

CREATE TABLE IF NOT EXISTS `Dieta`.`tb_localizacao` (
  `idt_localizacao` INT NOT NULL,
  `cord_longitude` DECIMAL NULL,
  `cord_latitude` DECIMAL NULL,
  PRIMARY KEY (`idt_localizacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dieta`.`Usuario_has_Dieta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Dieta`.`Usuario_has_Dieta` ;

CREATE TABLE IF NOT EXISTS `Dieta`.`Usuario_has_Dieta` (
  `Usuario_idt_usuario` INT NOT NULL,
  `Dieta_idt_dieta` INT NOT NULL,
  PRIMARY KEY (`Usuario_idt_usuario`, `Dieta_idt_dieta`),
  INDEX `fk_Usuario_has_Dieta_Dieta1_idx` (`Dieta_idt_dieta` ASC),
  INDEX `fk_Usuario_has_Dieta_Usuario_idx` (`Usuario_idt_usuario` ASC),
  CONSTRAINT `fk_Usuario_has_Dieta_Usuario`
    FOREIGN KEY (`Usuario_idt_usuario`)
    REFERENCES `Dieta`.`tb_usuario` (`idt_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Dieta_Dieta1`
    FOREIGN KEY (`Dieta_idt_dieta`)
    REFERENCES `Dieta`.`tb_dieta` (`idt_dieta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dieta`.`td_usuario_dieta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Dieta`.`td_usuario_dieta` ;

CREATE TABLE IF NOT EXISTS `Dieta`.`td_usuario_dieta` (
  `cod_usuario` INT NOT NULL,
  `cod_dieta` INT NOT NULL,
  PRIMARY KEY (`cod_usuario`, `cod_dieta`),
  INDEX `fk_Usuario_has_Dieta1_Dieta1_idx` (`cod_dieta` ASC),
  INDEX `fk_Usuario_has_Dieta1_Usuario1_idx` (`cod_usuario` ASC),
  CONSTRAINT `fk_Usuario_has_Dieta1_Usuario1`
    FOREIGN KEY (`cod_usuario`)
    REFERENCES `Dieta`.`tb_usuario` (`idt_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Dieta1_Dieta1`
    FOREIGN KEY (`cod_dieta`)
    REFERENCES `Dieta`.`tb_dieta` (`idt_dieta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dieta`.`td_dieta_alimento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Dieta`.`td_dieta_alimento` ;

CREATE TABLE IF NOT EXISTS `Dieta`.`td_dieta_alimento` (
  `cod_dieta` INT NOT NULL,
  `cod_alimento` INT NOT NULL,
  PRIMARY KEY (`cod_dieta`, `cod_alimento`),
  INDEX `fk_tb_dieta_has_tb_alimento_tb_alimento1_idx` (`cod_alimento` ASC),
  INDEX `fk_tb_dieta_has_tb_alimento_tb_dieta1_idx` (`cod_dieta` ASC),
  CONSTRAINT `fk_tb_dieta_has_tb_alimento_tb_dieta1`
    FOREIGN KEY (`cod_dieta`)
    REFERENCES `Dieta`.`tb_dieta` (`idt_dieta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_dieta_has_tb_alimento_tb_alimento1`
    FOREIGN KEY (`cod_alimento`)
    REFERENCES `Dieta`.`tb_alimento` (`idt_alimento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dieta`.`td_alimento_localizacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Dieta`.`td_alimento_localizacao` ;

CREATE TABLE IF NOT EXISTS `Dieta`.`td_alimento_localizacao` (
  `cod_alimento` INT NOT NULL,
  `cod_localizacao` INT NOT NULL,
  PRIMARY KEY (`cod_alimento`, `cod_localizacao`),
  INDEX `fk_tb_alimento_has_tb_localizacao_tb_localizacao1_idx` (`cod_localizacao` ASC),
  INDEX `fk_tb_alimento_has_tb_localizacao_tb_alimento1_idx` (`cod_alimento` ASC),
  CONSTRAINT `fk_tb_alimento_has_tb_localizacao_tb_alimento1`
    FOREIGN KEY (`cod_alimento`)
    REFERENCES `Dieta`.`tb_alimento` (`idt_alimento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_alimento_has_tb_localizacao_tb_localizacao1`
    FOREIGN KEY (`cod_localizacao`)
    REFERENCES `Dieta`.`tb_localizacao` (`idt_localizacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Dieta`.`tb_usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `Dieta`;
INSERT INTO `Dieta`.`tb_usuario` (`idt_usuario`, `nme_usuario`, `val_cpf`, `val_telefone`, `val_peso`, `val_altura`, `val_idade`) VALUES (1, 'Higo Soares', '020202020', '33434332', 55, '169', '20');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Dieta`.`tb_objetivo`
-- -----------------------------------------------------
START TRANSACTION;
USE `Dieta`;
INSERT INTO `Dieta`.`tb_objetivo` (`idt_objetivo`, `nme_objetivo`) VALUES (1, 'Hipertrofia');
INSERT INTO `Dieta`.`tb_objetivo` (`idt_objetivo`, `nme_objetivo`) VALUES (2, 'Perda de peso');
INSERT INTO `Dieta`.`tb_objetivo` (`idt_objetivo`, `nme_objetivo`) VALUES (3, 'Redução alimentar');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Dieta`.`tb_dieta`
-- -----------------------------------------------------
START TRANSACTION;
USE `Dieta`;
INSERT INTO `Dieta`.`tb_dieta` (`idt_dieta`, `dat_inicial`, `dat_final`, `val_peso_ideal`, `cod_objetivo`) VALUES (1, '2016-09-17', '2016-09-17', 66, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Dieta`.`tb_alimento`
-- -----------------------------------------------------
START TRANSACTION;
USE `Dieta`;
INSERT INTO `Dieta`.`tb_alimento` (`idt_alimento`, `nme_alimento`, `val_calorias`, `val_peso`) VALUES (1, 'Abacaxi', 200, 200);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Dieta`.`tb_localizacao`
-- -----------------------------------------------------
START TRANSACTION;
USE `Dieta`;
INSERT INTO `Dieta`.`tb_localizacao` (`idt_localizacao`, `cord_longitude`, `cord_latitude`) VALUES (1, -2.323123, -0.28282);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Dieta`.`td_usuario_dieta`
-- -----------------------------------------------------
START TRANSACTION;
USE `Dieta`;
INSERT INTO `Dieta`.`td_usuario_dieta` (`cod_usuario`, `cod_dieta`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Dieta`.`td_dieta_alimento`
-- -----------------------------------------------------
START TRANSACTION;
USE `Dieta`;
INSERT INTO `Dieta`.`td_dieta_alimento` (`cod_dieta`, `cod_alimento`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Dieta`.`td_alimento_localizacao`
-- -----------------------------------------------------
START TRANSACTION;
USE `Dieta`;
INSERT INTO `Dieta`.`td_alimento_localizacao` (`cod_alimento`, `cod_localizacao`) VALUES (1, 1);

COMMIT;

