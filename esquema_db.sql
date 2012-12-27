SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `colegio` DEFAULT CHARACTER SET utf8 ;
USE `colegio` ;

-- -----------------------------------------------------
-- Table `colegio`.`tbl1_generales`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `colegio`.`tbl1_generales` (
  `cedula` INT(11) NOT NULL AUTO_INCREMENT ,
  `id_socio` CHAR(7) NULL ,
  `nombre` VARCHAR(30) NULL ,
  `ape_paterno` VARCHAR(15) NULL ,
  `ape_materno` VARCHAR(15) NULL ,
  `sexo` TINYINT NULL ,
  PRIMARY KEY (`cedula`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `colegio`.`estados`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `colegio`.`estados` (
  `cod_estado` INT NOT NULL ,
  `estado` VARCHAR(15) NULL ,
  PRIMARY KEY (`cod_estado`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `colegio`.`del_mun`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `colegio`.`del_mun` (
  `cod_del_mun` INT NOT NULL ,
  `del_mun` VARCHAR(80) NULL ,
  PRIMARY KEY (`cod_del_mun`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `colegio`.`tbl2_direccion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `colegio`.`tbl2_direccion` (
  `tbl2_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `cedula` INT(11) NOT NULL ,
  `cod_estado` INT NULL ,
  `cod_del_mun` INT NOT NULL ,
  `colonia` VARCHAR(45) NULL ,
  `direccion` VARCHAR(150) NULL ,
  `cp` CHAR(6) NULL ,
  PRIMARY KEY (`tbl2_id`, `cedula`) ,
  INDEX `tbl2_tbl1` (`cedula` ASC) ,
  INDEX `estados` (`cod_estado` ASC) ,
  INDEX `del_mun` (`cod_del_mun` ASC) ,
  CONSTRAINT `tbl2_tbl1`
    FOREIGN KEY (`cedula` )
    REFERENCES `colegio`.`tbl1_generales` (`cedula` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `estados`
    FOREIGN KEY (`cod_estado` )
    REFERENCES `colegio`.`estados` (`cod_estado` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `del_mun`
    FOREIGN KEY (`cod_del_mun` )
    REFERENCES `colegio`.`del_mun` (`cod_del_mun` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `colegio`.`tbl3_contacto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `colegio`.`tbl3_contacto` (
  `tbl3_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `cedula` INT(11) NOT NULL ,
  `tel_casa` VARCHAR(15) NULL ,
  `tel_oficina` VARCHAR(15) NULL ,
  `tel_celular` VARCHAR(15) NULL ,
  `mail` VARCHAR(15) NULL ,
  PRIMARY KEY (`tbl3_id`) ,
  INDEX `tbl3_tbl1` (`cedula` ASC) ,
  CONSTRAINT `tbl3_tbl1`
    FOREIGN KEY (`cedula` )
    REFERENCES `colegio`.`tbl1_generales` (`cedula` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `colegio`.`ciudad`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `colegio`.`ciudad` (
  `cod_ciudad` INT NOT NULL ,
  `nombre` VARCHAR(50) NULL ,
  PRIMARY KEY (`cod_ciudad`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `colegio`.`filial`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `colegio`.`filial` (
  `cod_filial` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(25) NULL ,
  `cod_ciudad` INT NULL ,
  PRIMARY KEY (`cod_filial`) ,
  INDEX `ciudad` (`cod_ciudad` ASC) ,
  CONSTRAINT `ciudad`
    FOREIGN KEY (`cod_ciudad` )
    REFERENCES `colegio`.`ciudad` (`cod_ciudad` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `colegio`.`tbl4_afiliacion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `colegio`.`tbl4_afiliacion` (
  `tbl4_id` INT(11) NOT NULL AUTO_INCREMENT ,
  `cedula` INT(11) NOT NULL ,
  `f_afiliacion` DATE NULL ,
  `cod_filial` INT NOT NULL ,
  `cod_socio` INT NULL ,
  PRIMARY KEY (`tbl4_id`) ,
  INDEX `tbl4_tbl1` (`cedula` ASC) ,
  INDEX `filial` (`cod_filial` ASC) ,
  CONSTRAINT `tbl4_tbl1`
    FOREIGN KEY (`cedula` )
    REFERENCES `colegio`.`tbl1_generales` (`cedula` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `filial`
    FOREIGN KEY (`cod_filial` )
    REFERENCES `colegio`.`filial` (`cod_filial` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `colegio`.`banco`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `colegio`.`banco` (
  `cod_banco` INT NOT NULL ,
  `nombre` VARCHAR(20) NULL ,
  PRIMARY KEY (`cod_banco`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `colegio`.`tipo_pago`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `colegio`.`tipo_pago` (
  `cod_tpago` INT NOT NULL ,
  `tipo_pago` VARCHAR(15) NULL ,
  `cod_banco` INT NOT NULL ,
  PRIMARY KEY (`cod_tpago`) ,
  INDEX `banco` (`cod_banco` ASC) ,
  CONSTRAINT `banco`
    FOREIGN KEY (`cod_banco` )
    REFERENCES `colegio`.`banco` (`cod_banco` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `colegio`.`tbl5_suscripcion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `colegio`.`tbl5_suscripcion` (
  `tbl5_id` INT NOT NULL AUTO_INCREMENT ,
  `id_tbl4` INT(11) NULL ,
  `fecha_a` INT NOT NULL ,
  `cod_tpago` INT NULL ,
  `folio_pago` VARCHAR(45) NULL ,
  `fecha_pago` INT NULL ,
  PRIMARY KEY (`tbl5_id`, `fecha_a`) ,
  INDEX `tbl5_tbl4` (`id_tbl4` ASC) ,
  INDEX `tpago` (`cod_tpago` ASC) ,
  CONSTRAINT `tbl5_tbl4`
    FOREIGN KEY (`id_tbl4` )
    REFERENCES `colegio`.`tbl4_afiliacion` (`tbl4_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `tpago`
    FOREIGN KEY (`cod_tpago` )
    REFERENCES `colegio`.`tipo_pago` (`cod_tpago` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `colegio`.`tipo_cursos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `colegio`.`tipo_cursos` (
  `cod_curso` INT NOT NULL ,
  `nombre_curso` VARCHAR(45) NULL ,
  `fecha_curso` DATE NULL ,
  `tipo_curso` VARCHAR(15) NULL ,
  PRIMARY KEY (`cod_curso`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `colegio`.`tbl6_cursos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `colegio`.`tbl6_cursos` (
  `tbl6_id` INT NOT NULL ,
  `id_tbl5` INT NULL ,
  `fecha_a` INT NULL ,
  `cod_curso` INT NULL ,
  `asistencia` TINYINT NULL ,
  PRIMARY KEY (`tbl6_id`) ,
  INDEX `tbl6_tbl5_id` (`id_tbl5` ASC) ,
  INDEX `curso` (`cod_curso` ASC) ,
  CONSTRAINT `tbl6_tbl5_id`
    FOREIGN KEY (`id_tbl5` )
    REFERENCES `colegio`.`tbl5_suscripcion` (`tbl5_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `curso`
    FOREIGN KEY (`cod_curso` )
    REFERENCES `colegio`.`tipo_cursos` (`cod_curso` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
