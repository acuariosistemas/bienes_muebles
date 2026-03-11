CREATE TABLE `control_impresiones` (
  `id_impresion` INT(11) NOT NULL AUTO_INCREMENT,
  `fk_bien` INT(11) NOT NULL COMMENT 'Relación con el bien mueble',
  `tipo_reporte` ENUM('ETIQUETA', 'RESGUARDO', 'INVENTARIO') NOT NULL,
  `fecha_solicitud` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `login_impresion` VARCHAR(190) DEFAULT NULL COMMENT 'Quién solicitó la impresión',
  `estatus` ENUM('PENDIENTE', 'IMPRESO', 'ERROR') DEFAULT 'PENDIENTE',
  `veces_impresa` INT(11) DEFAULT 1,
  `fecha_impresion` DATETIME DEFAULT NULL,
  PRIMARY KEY (`id_impresion`),
  KEY `fk_bien_idx` (`fk_bien`),
  CONSTRAINT `fk_impresion_bien` FOREIGN KEY (`fk_bien`) REFERENCES `bien_mueble` (`id_bien`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_impresion_usuario` FOREIGN KEY (`login_impresion`) REFERENCES `sec_users` (`login`) ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;

INSERT INTO control_impresiones (fk_bien, tipo_reporte, login_impresion, estatus, veces_impresa, fecha_impresion)
SELECT 
    id_bien, 
    'ETIQUETA', 
    login_levantamiento, -- Usamos el login de levantamiento como referencia histórica
    'IMPRESO', 
    Veces_Impresa, 
    NOW() 
FROM bien_mueble 
WHERE Veces_Impresa > 0;

ALTER TABLE bien_mueble 
DROP COLUMN Veces_Impresa, 
DROP COLUMN Veces_imp_resguardo,
DROP COLUMN Imprimir,
DROP COLUMN Imprimir_resguardo;

ALTER TABLE `bien_mueble` ADD COLUMN `usuario_imprime` VARCHAR(190) DEFAULT NULL;
