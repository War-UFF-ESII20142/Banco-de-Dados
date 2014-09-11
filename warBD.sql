SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `WarBD`.`Jogador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WarBD`.`Jogador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WarBD`.`Partida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WarBD`.`Partida` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WarBD`.`Mapa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WarBD`.`Mapa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `url` VARCHAR(45) NOT NULL,
  `Partida_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC),
  UNIQUE INDEX `url_UNIQUE` (`url` ASC),
  INDEX `fk_Mapa_Partida1_idx` (`Partida_id` ASC),
  CONSTRAINT `fk_Mapa_Partida1`
    FOREIGN KEY (`Partida_id`)
    REFERENCES `WarBD`.`Partida` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WarBD`.`Objetivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WarBD`.`Objetivo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descr` VARCHAR(100) NOT NULL,
  `Mapa_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descr_UNIQUE` (`descr` ASC),
  INDEX `fk_Objetivo_Mapa1_idx` (`Mapa_id` ASC),
  CONSTRAINT `fk_Objetivo_Mapa1`
    FOREIGN KEY (`Mapa_id`)
    REFERENCES `WarBD`.`Mapa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WarBD`.`Continente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WarBD`.`Continente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Continentecol` VARCHAR(45) NOT NULL,
  `Continentecol1` VARCHAR(45) NOT NULL,
  `Mapa_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `Continentecol_UNIQUE` (`Continentecol` ASC),
  INDEX `fk_Continente_Mapa1_idx` (`Mapa_id` ASC),
  CONSTRAINT `fk_Continente_Mapa1`
    FOREIGN KEY (`Mapa_id`)
    REFERENCES `WarBD`.`Mapa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WarBD`.`Pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WarBD`.`Pais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `Continente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC),
  INDEX `fk_Pais_Continente1_idx` (`Continente_id` ASC),
  CONSTRAINT `fk_Pais_Continente1`
    FOREIGN KEY (`Continente_id`)
    REFERENCES `WarBD`.`Continente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WarBD`.`Carta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WarBD`.`Carta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `forma_geo` VARCHAR(15) NOT NULL,
  `Pais_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Carta_Pais1_idx` (`Pais_id` ASC),
  CONSTRAINT `fk_Carta_Pais1`
    FOREIGN KEY (`Pais_id`)
    REFERENCES `WarBD`.`Pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WarBD`.`Joga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WarBD`.`Joga` (
  `Partida_id` INT NOT NULL,
  `Jogador_id` INT NOT NULL,
  `Objetivo_id` INT NOT NULL,
  PRIMARY KEY (`Partida_id`, `Jogador_id`),
  INDEX `fk_Partida_has_Jogador_Jogador1_idx` (`Jogador_id` ASC),
  INDEX `fk_Partida_has_Jogador_Partida_idx` (`Partida_id` ASC),
  INDEX `fk_Joga_Objetivo1_idx` (`Objetivo_id` ASC),
  CONSTRAINT `fk_Partida_has_Jogador_Partida`
    FOREIGN KEY (`Partida_id`)
    REFERENCES `WarBD`.`Partida` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partida_has_Jogador_Jogador1`
    FOREIGN KEY (`Jogador_id`)
    REFERENCES `WarBD`.`Jogador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Joga_Objetivo1`
    FOREIGN KEY (`Objetivo_id`)
    REFERENCES `WarBD`.`Objetivo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WarBD`.`Paises_Vizinhos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WarBD`.`Paises_Vizinhos` (
  `Pais_id` INT NOT NULL,
  `Pais_id1` INT NOT NULL,
  PRIMARY KEY (`Pais_id`, `Pais_id1`),
  INDEX `fk_Pais_has_Pais_Pais2_idx` (`Pais_id1` ASC),
  INDEX `fk_Pais_has_Pais_Pais1_idx` (`Pais_id` ASC),
  CONSTRAINT `fk_Pais_has_Pais_Pais1`
    FOREIGN KEY (`Pais_id`)
    REFERENCES `WarBD`.`Pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pais_has_Pais_Pais2`
    FOREIGN KEY (`Pais_id1`)
    REFERENCES `WarBD`.`Pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WarBD`.`Jog_Paises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WarBD`.`Jog_Paises` (
  `Joga_Partida_id` INT NOT NULL,
  `Joga_Jogador_id` INT NOT NULL,
  `Pais_id` INT NOT NULL,
  PRIMARY KEY (`Joga_Partida_id`, `Pais_id`),
  INDEX `fk_Joga_has_Pais_Pais1_idx` (`Pais_id` ASC),
  INDEX `fk_Joga_has_Pais_Joga1_idx` (`Joga_Partida_id` ASC, `Joga_Jogador_id` ASC),
  CONSTRAINT `fk_Joga_has_Pais_Joga1`
    FOREIGN KEY (`Joga_Partida_id` , `Joga_Jogador_id`)
    REFERENCES `WarBD`.`Joga` (`Partida_id` , `Jogador_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Joga_has_Pais_Pais1`
    FOREIGN KEY (`Pais_id`)
    REFERENCES `WarBD`.`Pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WarBD`.`Jog_Carta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WarBD`.`Jog_Carta` (
  `Joga_Partida_id` INT NOT NULL,
  `Joga_Jogador_id` INT NOT NULL,
  `Carta_id` INT NOT NULL,
  PRIMARY KEY (`Joga_Partida_id`, `Carta_id`),
  INDEX `fk_Joga_has_Carta_Carta1_idx` (`Carta_id` ASC),
  INDEX `fk_Joga_has_Carta_Joga1_idx` (`Joga_Partida_id` ASC, `Joga_Jogador_id` ASC),
  CONSTRAINT `fk_Joga_has_Carta_Joga1`
    FOREIGN KEY (`Joga_Partida_id` , `Joga_Jogador_id`)
    REFERENCES `WarBD`.`Joga` (`Partida_id` , `Jogador_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Joga_has_Carta_Carta1`
    FOREIGN KEY (`Carta_id`)
    REFERENCES `WarBD`.`Carta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
