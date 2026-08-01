CREATE TABLE `transacciones` (
    `txnid` INT(11) NOT NULL AUTO_INCREMENT,
    `txnreference` VARCHAR(100) NOT NULL,
    `usercod` BIGINT(10) NOT NULL,
    `txnfch` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `txnamount` DECIMAL(12, 2) NOT NULL,
    `txnisv` DECIMAL(12, 2) NOT NULL,
    `txntotal` DECIMAL(12, 2) NOT NULL,
    `txnstt` VARCHAR(20) NOT NULL DEFAULT 'COMPLETED',
    `txnpaymethod` VARCHAR(50) NOT NULL DEFAULT 'PAYPAL_SANDBOX',
    PRIMARY KEY (`txnid`),
    UNIQUE KEY `txnreference_UNIQUE` (`txnreference`),
    CONSTRAINT `fk_txn_user` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `transacciones_detalle` (
    `txnid` INT(11) NOT NULL,
    `productId` INT(11) NOT NULL,
    `prdname` VARCHAR(255) NOT NULL,
    `prdprice` DECIMAL(12, 2) NOT NULL,
    `prdctd` INT(5) NOT NULL,
    `prdsubtotal` DECIMAL(12, 2) NOT NULL,
    PRIMARY KEY (`txnid`, `productId`),
    CONSTRAINT `fk_txnd_txn` FOREIGN KEY (`txnid`) REFERENCES `transacciones` (`txnid`) ON DELETE CASCADE,
    CONSTRAINT `fk_txnd_prd` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `roles` (`rolescod`, `rolesdsc`, `rolesest`) VALUES
('ADMIN', 'Administrador General de mediSalud', 'ACT'),
('CLIENT', 'Cliente Registrado de mediSalud', 'ACT');

INSERT INTO `usuario` (`usercod`, `useremail`, `username`, `userpswd`, `userfching`, `userpswdest`, `userpswdexp`, `userest`, `usertipo`) VALUES
(1, 'admin@medisalud.com', 'Administrador mediSalud', '$2y$10$T/5jLBeEtCDtO.oz1AkWOOqrFP6Vrn5USxloVqAvg4RvSX/BsHVdO', NOW(), 'ACT', DATE_ADD(NOW(), INTERVAL 90 DAY), 'ACT', 'ADM'),
(2, 'cliente@medisalud.com', 'Juan Pérez (Cliente)', '$2y$10$T/5jLBeEtCDtO.oz1AkWOOqrFP6Vrn5USxloVqAvg4RvSX/BsHVdO', NOW(), 'ACT', DATE_ADD(NOW(), INTERVAL 90 DAY), 'ACT', 'PBL');

INSERT INTO `roles_usuarios` (`usercod`, `rolescod`, `roleuserest`, `roleuserfch`) VALUES
(1, 'ADMIN', 'ACT', NOW()),
(2, 'CLIENT', 'ACT', NOW());

INSERT INTO `funciones` (`fncod`, `fndsc`, `fnest`, `fntyp`) VALUES
('Controllers\\Index', 'Página Principal', 'ACT', 'CTR'),
('Controllers\\Checkout\\Catalogo', 'Catálogo de Productos mediSalud', 'ACT', 'CTR'),
('Controllers\\Cart\\Cart', 'Carrito de Compras', 'ACT', 'CTR'),
('Controllers\\Checkout\\Checkout', 'Pasarela de Pago PayPal / Simulada', 'ACT', 'CTR'),
('Controllers\\Checkout\\Accept', 'Confirmación de Orden de Pago', 'ACT', 'CTR'),
('Controllers\\Checkout\\Error', 'Error en Pasarela de Pago', 'ACT', 'CTR'),
('Controllers\\Transacciones\\MisTransacciones', 'Histórico de Compras del Cliente', 'ACT', 'CTR'),
('Controllers\\Transacciones\\GestionTransacciones', 'Gestión Administrativa de Transacciones', 'ACT', 'CTR'),
('Controllers\\Mnt\\Productos', 'Mantenimiento de Catálogo de Productos', 'ACT', 'CTR'),
('Controllers\\Mnt\\Producto', 'Edición/Creación de Producto', 'ACT', 'CTR'),
('Menu_Catalogo', 'Menú Catálogo mediSalud', 'ACT', 'MNU'),
('Menu_Cart', 'Menú Carretilla de Compra', 'ACT', 'MNU'),
('Menu_MisTransacciones', 'Menú Mis Compras', 'ACT', 'MNU'),
('Menu_ProductosMnt', 'Menú Mantenimiento Productos', 'ACT', 'MNU'),
('Menu_GestionTransacciones', 'Menú Histórico General', 'ACT', 'MNU');

INSERT INTO `funciones_roles` (`rolescod`, `fncod`, `fnrolest`) VALUES
('CLIENT', 'Controllers\\Index', 'ACT'),
('CLIENT', 'Controllers\\Checkout\\Catalogo', 'ACT'),
('CLIENT', 'Controllers\\Cart\\Cart', 'ACT'),
('CLIENT', 'Controllers\\Checkout\\Checkout', 'ACT'),
('CLIENT', 'Controllers\\Checkout\\Accept', 'ACT'),
('CLIENT', 'Controllers\\Checkout\\Error', 'ACT'),
('CLIENT', 'Controllers\\Transacciones\\MisTransacciones', 'ACT'),
('CLIENT', 'Menu_Catalogo', 'ACT'),
('CLIENT', 'Menu_Cart', 'ACT'),
('CLIENT', 'Menu_MisTransacciones', 'ACT');

INSERT INTO `funciones_roles` (`rolescod`, `fncod`, `fnrolest`) VALUES
('ADMIN', 'Controllers\\Index', 'ACT'),
('ADMIN', 'Controllers\\Checkout\\Catalogo', 'ACT'),
('ADMIN', 'Controllers\\Cart\\Cart', 'ACT'),
('ADMIN', 'Controllers\\Checkout\\Checkout', 'ACT'),
('ADMIN', 'Controllers\\Checkout\\Accept', 'ACT'),
('ADMIN', 'Controllers\\Checkout\\Error', 'ACT'),
('ADMIN', 'Controllers\\Transacciones\\MisTransacciones', 'ACT'),
('ADMIN', 'Controllers\\Transacciones\\GestionTransacciones', 'ACT'),
('ADMIN', 'Controllers\\Mnt\\Productos', 'ACT'),
('ADMIN', 'Controllers\\Mnt\\Producto', 'ACT'),
('ADMIN', 'Menu_Catalogo', 'ACT'),
('ADMIN', 'Menu_Cart', 'ACT'),
('ADMIN', 'Menu_MisTransacciones', 'ACT'),
('ADMIN', 'Menu_ProductosMnt', 'ACT'),
('ADMIN', 'Menu_GestionTransacciones', 'ACT');

INSERT INTO `products` (`productId`, `productName`, `productDescription`, `productPrice`, `productImgUrl`, `productStock`, `productCategory`, `productStatus`) VALUES
(1, 'Acetaminofén 500mg (Caja x20)', 'Analgésico y antipirético efectivo para aliviar dolores de cabeza, fiebres y malestares musculares leves a moderados.', 85.00, 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500&q=80', 150, 'Medicamentos', 'ACT'),
(2, 'Ibuprofeno 400mg (Caja x24)', 'Antiinflamatorio no esteroideo indicado para dolores severos, inflamación muscular y articular.', 120.00, 'https://images.unsplash.com/photo-1550572017-edf792890581?w=500&q=80', 100, 'Medicamentos', 'ACT'),
(3, 'Amoxicilina 500mg (Caja x15)', 'Antibiótico de amplio espectro para el tratamiento de infecciones respiratorias y bacterianas. Requiere indicación.', 240.00, 'https://images.unsplash.com/photo-1471864190281-a93a3070b6de?w=500&q=80', 85, 'Medicamentos', 'ACT'),
(4, 'Vitamina C Efervescente 1000mg', 'Suplemento vitamínico efervescente sabor a naranja para fortalecer el sistema inmunológico y prevenir resfriados.', 180.00, 'https://images.unsplash.com/photo-1576602976047-174e57a47881?w=500&q=80', 200, 'Vitaminas', 'ACT'),
(5, 'Complejo B Multvitamínico (Frasco 60 Cap)', 'Mezcla concentrada de vitaminas B1, B6 y B12 para el apoyo de la función nerviosa y aumento de energía vital.', 310.00, 'https://images.unsplash.com/photo-1550572017-4fcd95c9029b?w=500&q=80', 60, 'Vitaminas', 'ACT'),
(6, 'Loratadina 10mg (Caja x10)', 'Antihistamínico de acción prolongada no somnoliento para el alivio de rinitis alérgica y urticaria.', 95.00, 'https://images.unsplash.com/photo-1585435557343-3b092031a831?w=500&q=80', 120, 'Medicamentos', 'ACT'),
(7, 'Alcohol Etílico 70% 500ml', 'Antiséptico de uso externo para desinfección de piel, curaciones y esterilización de heridas superficiales.', 65.00, 'https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=500&q=80', 300, 'Primeros Auxilios', 'ACT'),
(8, 'Mascarillas Quirúrgicas N95 (Caja x50)', 'Mascarillas de protección respiratoria tricapa con ajuste nasal flexible y alta eficiencia de filtración bacteriana.', 250.00, 'https://images.unsplash.com/photo-1586942593568-29364ef8858f?w=500&q=80', 90, 'Cuidado Personal', 'ACT'),
(9, 'Termómetro Digital Infrarrojo', 'Termómetro de precisión rápida para medición de temperatura corporal en frente sin contacto físico.', 480.00, 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500&q=80', 40, 'Equipos Médicos', 'ACT'),
(10, 'Gel Antibacterial con Aloe 500ml', 'Desinfectante de manos al 70% de alcohol enriquecido con extracto de Aloe Vera para evitar el resecamiento.', 75.00, 'https://images.unsplash.com/photo-1584483766114-2cea6facdf57?w=500&q=80', 220, 'Higiene', 'ACT'),
(11, 'Suero Oral Electrolitos Fresa 500ml', 'Solución de rehidratación oral recomendada para recuperar electrolitos perdidos por deshidratación.', 45.00, 'https://images.unsplash.com/photo-1527661591475-527312dd65f5?w=500&q=80', 180, 'Primeros Auxilios', 'ACT'),
(12, 'Crema Cicatrizante Neomicina 30g', 'Pomada antiséptica con cicatrizante para curación rápida de quemaduras leves, raspaduras y cortes.', 135.00, 'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500&q=80', 75, 'Primeros Auxilios', 'ACT');

INSERT INTO `transacciones` (`txnid`, `txnreference`, `usercod`, `txnfch`, `txnamount`, `txnisv`, `txntotal`, `txnstt`, `txnpaymethod`) VALUES
(1, 'TXN-20260730-1001', 2, NOW(), 265.00, 39.75, 304.75, 'COMPLETED', 'PAYPAL_SANDBOX');

INSERT INTO `transacciones_detalle` (`txnid`, `productId`, `prdname`, `prdprice`, `prdctd`, `prdsubtotal`) VALUES
(1, 1, 'Acetaminofén 500mg (Caja x20)', 85.00, 1, 85.00),
(1, 4, 'Vitamina C Efervescente 1000mg', 180.00, 1, 180.00);

INSERT INTO `bitacora` (`bitacorafch`, `bitprograma`, `bitdescripcion`, `bitobservacion`, `bitTipo`, `bitusuario`) VALUES
(NOW(), 'SYSTEM', 'Inicialización de Base de Datos mediSalud', 'Se crearon tablas de seguridad, productos, carrito y transacciones con éxito.', 'INFO', 1);
