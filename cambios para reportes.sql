CREATE TABLE `control_impresiones` (
  `id_impresion` INT(11) NOT NULL AUTO_INCREMENT,
  `fk_bien` INT(11) NOT NULL COMMENT 'Relación con el bien mueble',
  `tipo_reporte` CHAR(40) NOT NULL,
  `fecha_impesion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `login_impresion` VARCHAR(190) DEFAULT NULL COMMENT 'Quién solicitó la impresión',
  PRIMARY KEY (`id_impresion`),
  KEY `fk_bien_idx` (`fk_bien`),
  KEY `fk_impresion_usuario` (`login_impresion`),
  CONSTRAINT `fk_impresion_bien` FOREIGN KEY (`fk_bien`) REFERENCES `bien_mueble` (`id_bien`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_impresion_usuario` FOREIGN KEY (`login_impresion`) REFERENCES `sec_users` (`login`) ON UPDATE CASCADE
) ENGINE=INNODB AUTO_INCREMENT=6561 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

INSERT INTO control_impresiones (fk_bien, tipo_reporte, login_impresion)
SELECT 
    id_bien, 
    'ETIQUETA', 
    login_levantamiento    
FROM bien_mueble 
WHERE Veces_Impresa > 0;

ALTER TABLE bien_mueble 
DROP COLUMN Veces_Impresa, 
DROP COLUMN Veces_imp_resguardo,
DROP COLUMN Imprimir,
DROP COLUMN Imprimir_resguardo
ADD COLUMN `usuario_imprime` VARCHAR(255) DEFAULT NULL;
