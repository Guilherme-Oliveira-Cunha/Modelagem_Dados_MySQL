-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DBnota_fiscal
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DBnota_fiscal
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DBnota_fiscal` ;
USE `DBnota_fiscal` ;

-- -----------------------------------------------------
-- Table `DBnota_fiscal`.`endereço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBnota_fiscal`.`endereço` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(30) NOT NULL,
  `cidade` VARCHAR(30) NOT NULL,
  `bairro` VARCHAR(30) NOT NULL,
  `rua` VARCHAR(30) NOT NULL,
  `numero_casa` INT(3) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBnota_fiscal`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBnota_fiscal`.`telefone` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `celular` CHAR(14) NOT NULL,
  `fixo` CHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBnota_fiscal`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBnota_fiscal`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(30) NOT NULL,
  `cpf` CHAR(14) NOT NULL,
  `id_endereço` INT NOT NULL,
  `id_telefone` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_nome_1_idx` (`id_endereço` ASC) VISIBLE,
  INDEX `fk_nome_2_idx` (`id_telefone` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_1`
    FOREIGN KEY (`id_endereço`)
    REFERENCES `DBnota_fiscal`.`endereço` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientes_2`
    FOREIGN KEY (`id_telefone`)
    REFERENCES `DBnota_fiscal`.`telefone` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBnota_fiscal`.`produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBnota_fiscal`.`produtos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `codigo` INT(5) NOT NULL,
  `descrição` VARCHAR(50) NOT NULL,
  `valor_unidade` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `DBnota_fiscal`.`quantidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBnota_fiscal`.`quantidades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantidade` INT NOT NULL,
  `id_produtos` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_quantidade_1_idx` (`id_produtos` ASC) VISIBLE,
  CONSTRAINT `fk_quantidades_1`
    FOREIGN KEY (`id_produtos`)
    REFERENCES `DBnota_fiscal`.`produtos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `DBnota_fiscal`.`preço_total`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBnota_fiscal`.`preço_total` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_quantidades` INT NOT NULL,
  `preço` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_preço_total_1_idx` (`id_quantidades` ASC) VISIBLE,
  CONSTRAINT `fk_preço_total_1`
    FOREIGN KEY (`id_quantidades`)
    REFERENCES `DBnota_fiscal`.`quantidades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `DBnota_fiscal`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBnota_fiscal`.`compra` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data` DATETIME NOT NULL,
  `id_preço_total` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_compra_1_idx` (`id_preço_total` ASC) VISIBLE,
  CONSTRAINT `fk_compra_1`
    FOREIGN KEY (`id_preço_total`)
    REFERENCES `DBnota_fiscal`.`preço_total` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `DBnota_fiscal`.`nota_fiscal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBnota_fiscal`.`nota_fiscal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_clientes` INT NOT NULL,
  `id_compra` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_nota_fiscal_1_idx` (`id_clientes` ASC) VISIBLE,
  INDEX `fk_nota_fiscal_2_idx` (`id_compra` ASC) VISIBLE,
  CONSTRAINT `fk_nota_fiscal_1`
    FOREIGN KEY (`id_clientes`)
    REFERENCES `DBnota_fiscal`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nota_fiscal_2`
    FOREIGN KEY (`id_compra`)
    REFERENCES `DBnota_fiscal`.`compra` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
