-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema OficinaDataBase
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema OficinaDataBase
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `OficinaDataBase` DEFAULT CHARACTER SET utf8 ;
USE `OficinaDataBase` ;

-- -----------------------------------------------------
-- Table `OficinaDataBase`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaDataBase`.`Clientes` (
  `idClientes` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(45) NOT NULL,
  `Endereço` VARCHAR(45) NOT NULL,
  `CPF` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idClientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OficinaDataBase`.`Mecânico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaDataBase`.`Mecânico` (
  `idMecânico` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Endereço` VARCHAR(45) NOT NULL,
  `Especialidade` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMecânico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OficinaDataBase`.`Tabela Preços`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaDataBase`.`Tabela Preços` (
  `idTabela Preços` INT NOT NULL,
  PRIMARY KEY (`idTabela Preços`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OficinaDataBase`.`Ordem de Serviço OS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaDataBase`.`Ordem de Serviço OS` (
  `idOrdem de Serviço OS` INT NOT NULL,
  `Data de emissão` DATE NOT NULL,
  `Preço serviço` FLOAT NOT NULL,
  `Preço peça` FLOAT NOT NULL,
  `Preço Total` FLOAT NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  `Data conclusão` DATE NOT NULL,
  `Tabela Preços_idTabela Preços` INT NOT NULL,
  `Autorização Cliente_idAutorização Cliente` INT NOT NULL,
  PRIMARY KEY (`idOrdem de Serviço OS`, `Tabela Preços_idTabela Preços`, `Autorização Cliente_idAutorização Cliente`),
  INDEX `fk_Ordem de Serviço OS_Tabela Preços1_idx` (`Tabela Preços_idTabela Preços` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de Serviço OS_Tabela Preços1`
    FOREIGN KEY (`Tabela Preços_idTabela Preços`)
    REFERENCES `OficinaDataBase`.`Tabela Preços` (`idTabela Preços`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OficinaDataBase`.`Equipe de Mecânicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaDataBase`.`Equipe de Mecânicos` (
  `idEquipe de Mecânicos` INT NOT NULL,
  `Mecânico_idMecânico` INT NOT NULL,
  `Ordem de Serviço OS_idOrdem de Serviço OS` INT NOT NULL,
  PRIMARY KEY (`idEquipe de Mecânicos`, `Mecânico_idMecânico`, `Ordem de Serviço OS_idOrdem de Serviço OS`),
  INDEX `fk_Equipe de Mecânicos_Mecânico1_idx` (`Mecânico_idMecânico` ASC) VISIBLE,
  INDEX `fk_Equipe de Mecânicos_Ordem de Serviço OS1_idx` (`Ordem de Serviço OS_idOrdem de Serviço OS` ASC) VISIBLE,
  CONSTRAINT `fk_Equipe de Mecânicos_Mecânico1`
    FOREIGN KEY (`Mecânico_idMecânico`)
    REFERENCES `OficinaDataBase`.`Mecânico` (`idMecânico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipe de Mecânicos_Ordem de Serviço OS1`
    FOREIGN KEY (`Ordem de Serviço OS_idOrdem de Serviço OS`)
    REFERENCES `OficinaDataBase`.`Ordem de Serviço OS` (`idOrdem de Serviço OS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OficinaDataBase`.`Veículo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaDataBase`.`Veículo` (
  `idVeículo` INT NOT NULL,
  `Placa` VARCHAR(45) NOT NULL,
  `Modelo veículo` VARCHAR(45) NOT NULL,
  `Clientes_idClientes` INT NOT NULL,
  `Equipe de Mecânicos_idEquipe de Mecânicos` INT NOT NULL,
  PRIMARY KEY (`idVeículo`, `Clientes_idClientes`, `Equipe de Mecânicos_idEquipe de Mecânicos`),
  INDEX `fk_Veículo_Clientes_idx` (`Clientes_idClientes` ASC) VISIBLE,
  INDEX `fk_Veículo_Equipe de Mecânicos1_idx` (`Equipe de Mecânicos_idEquipe de Mecânicos` ASC) VISIBLE,
  CONSTRAINT `fk_Veículo_Clientes`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `OficinaDataBase`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Veículo_Equipe de Mecânicos1`
    FOREIGN KEY (`Equipe de Mecânicos_idEquipe de Mecânicos`)
    REFERENCES `OficinaDataBase`.`Equipe de Mecânicos` (`idEquipe de Mecânicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OficinaDataBase`.`Conserto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaDataBase`.`Conserto` (
  `idConserto` INT NOT NULL,
  `Descrição do Conserto` VARCHAR(60) NOT NULL,
  `Veículo_idVeículo` INT NOT NULL,
  PRIMARY KEY (`idConserto`, `Veículo_idVeículo`),
  INDEX `fk_Conserto_Veículo1_idx` (`Veículo_idVeículo` ASC) VISIBLE,
  CONSTRAINT `fk_Conserto_Veículo1`
    FOREIGN KEY (`Veículo_idVeículo`)
    REFERENCES `OficinaDataBase`.`Veículo` (`idVeículo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OficinaDataBase`.`Revisão`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaDataBase`.`Revisão` (
  `idRevisão` INT NOT NULL,
  `Descrição da Revisão` VARCHAR(60) NOT NULL,
  `Veículo_idVeículo` INT NOT NULL,
  PRIMARY KEY (`idRevisão`, `Veículo_idVeículo`),
  INDEX `fk_Revisão_Veículo1_idx` (`Veículo_idVeículo` ASC) VISIBLE,
  CONSTRAINT `fk_Revisão_Veículo1`
    FOREIGN KEY (`Veículo_idVeículo`)
    REFERENCES `OficinaDataBase`.`Veículo` (`idVeículo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OficinaDataBase`.`Serviços`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaDataBase`.`Serviços` (
  `idServiços` INT NOT NULL,
  `Descrição` VARCHAR(45) NOT NULL,
  `Preço` FLOAT NOT NULL,
  PRIMARY KEY (`idServiços`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OficinaDataBase`.`OS tem serviços`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaDataBase`.`OS tem serviços` (
  `Ordem de Serviço OS_idOrdem de Serviço OS` INT NOT NULL,
  `Serviços_idServiços` INT NOT NULL,
  PRIMARY KEY (`Ordem de Serviço OS_idOrdem de Serviço OS`, `Serviços_idServiços`),
  INDEX `fk_Ordem de Serviço OS_has_Serviços_Serviços1_idx` (`Serviços_idServiços` ASC) VISIBLE,
  INDEX `fk_Ordem de Serviço OS_has_Serviços_Ordem de Serviço OS1_idx` (`Ordem de Serviço OS_idOrdem de Serviço OS` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de Serviço OS_has_Serviços_Ordem de Serviço OS1`
    FOREIGN KEY (`Ordem de Serviço OS_idOrdem de Serviço OS`)
    REFERENCES `OficinaDataBase`.`Ordem de Serviço OS` (`idOrdem de Serviço OS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem de Serviço OS_has_Serviços_Serviços1`
    FOREIGN KEY (`Serviços_idServiços`)
    REFERENCES `OficinaDataBase`.`Serviços` (`idServiços`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OficinaDataBase`.`Peças`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaDataBase`.`Peças` (
  `idPeças` INT NOT NULL,
  `Descrição` VARCHAR(45) NOT NULL,
  `Preço` FLOAT NOT NULL,
  PRIMARY KEY (`idPeças`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OficinaDataBase`.`OS/Peças`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaDataBase`.`OS/Peças` (
  `Peças_idPeças` INT NOT NULL,
  `Ordem de Serviço OS_idOrdem de Serviço OS` INT NOT NULL,
  PRIMARY KEY (`Peças_idPeças`, `Ordem de Serviço OS_idOrdem de Serviço OS`),
  INDEX `fk_Peças_has_Ordem de Serviço OS_Ordem de Serviço OS1_idx` (`Ordem de Serviço OS_idOrdem de Serviço OS` ASC) VISIBLE,
  INDEX `fk_Peças_has_Ordem de Serviço OS_Peças1_idx` (`Peças_idPeças` ASC) VISIBLE,
  CONSTRAINT `fk_Peças_has_Ordem de Serviço OS_Peças1`
    FOREIGN KEY (`Peças_idPeças`)
    REFERENCES `OficinaDataBase`.`Peças` (`idPeças`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Peças_has_Ordem de Serviço OS_Ordem de Serviço OS1`
    FOREIGN KEY (`Ordem de Serviço OS_idOrdem de Serviço OS`)
    REFERENCES `OficinaDataBase`.`Ordem de Serviço OS` (`idOrdem de Serviço OS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OficinaDataBase`.`Autoriza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OficinaDataBase`.`Autoriza` (
  `Clientes_idClientes` INT NOT NULL,
  `Ordem de Serviço OS_idOrdem de Serviço OS` INT NOT NULL,
  `Autorizado` TINYINT NOT NULL,
  PRIMARY KEY (`Clientes_idClientes`, `Ordem de Serviço OS_idOrdem de Serviço OS`),
  INDEX `fk_Clientes_has_Ordem de Serviço OS_Ordem de Serviço OS1_idx` (`Ordem de Serviço OS_idOrdem de Serviço OS` ASC) VISIBLE,
  INDEX `fk_Clientes_has_Ordem de Serviço OS_Clientes1_idx` (`Clientes_idClientes` ASC) VISIBLE,
  CONSTRAINT `fk_Clientes_has_Ordem de Serviço OS_Clientes1`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `OficinaDataBase`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Clientes_has_Ordem de Serviço OS_Ordem de Serviço OS1`
    FOREIGN KEY (`Ordem de Serviço OS_idOrdem de Serviço OS`)
    REFERENCES `OficinaDataBase`.`Ordem de Serviço OS` (`idOrdem de Serviço OS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
