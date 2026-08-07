-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 06, 2026 at 06:30 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `medisalud_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `bitacora`
--

CREATE TABLE `bitacora` (
  `bitacoracod` int(11) NOT NULL,
  `bitacorafch` datetime NOT NULL DEFAULT current_timestamp(),
  `bitprograma` varchar(255) NOT NULL,
  `bitdescripcion` varchar(255) NOT NULL,
  `bitobservacion` mediumtext DEFAULT NULL,
  `bitTipo` varchar(10) NOT NULL DEFAULT 'INFO',
  `bitusuario` bigint(18) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bitacora`
--

INSERT INTO `bitacora` (`bitacoracod`, `bitacorafch`, `bitprograma`, `bitdescripcion`, `bitobservacion`, `bitTipo`, `bitusuario`) VALUES
(1, '2026-07-31 13:41:22', 'SYSTEM', 'Inicialización de Base de Datos mediSalud', 'Se crearon tablas de seguridad, productos, carrito y transacciones con éxito.', 'INFO', 1);

-- --------------------------------------------------------

--
-- Table structure for table `carretilla`
--

CREATE TABLE `carretilla` (
  `usercod` bigint(10) NOT NULL,
  `productId` int(11) NOT NULL,
  `crrctd` int(5) NOT NULL,
  `crrprc` decimal(12,2) NOT NULL,
  `crrfching` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carretilla`
--

INSERT INTO `carretilla` (`usercod`, `productId`, `crrctd`, `crrprc`, `crrfching`) VALUES
(1, 1, 2, 85.00, '2026-08-05 15:05:21'),
(1, 5, 1, 310.00, '2026-08-05 12:40:34'),
(2, 1, 1, 15.18, '2026-08-05 15:29:49'),
(2, 2, 2, 250.23, '2026-08-05 15:30:14'),
(3, 2, 1, 250.23, '2026-08-05 15:11:06'),
(4, 2, 1, 120.00, '2026-08-04 17:52:39'),
(4, 4, 1, 180.00, '2026-08-04 17:52:45'),
(5, 2, 1, 120.00, '2026-08-04 17:53:44'),
(5, 6, 1, 95.00, '2026-08-04 17:53:52'),
(5, 7, 1, 65.00, '2026-08-04 17:53:48');

-- --------------------------------------------------------

--
-- Table structure for table `carretillaanon`
--

CREATE TABLE `carretillaanon` (
  `anoncod` varchar(128) NOT NULL,
  `productId` int(11) NOT NULL,
  `crrctd` int(5) NOT NULL,
  `crrprc` decimal(12,2) NOT NULL,
  `crrfching` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `funciones`
--

CREATE TABLE `funciones` (
  `fncod` varchar(255) NOT NULL,
  `fndsc` varchar(255) NOT NULL,
  `fnest` char(3) NOT NULL DEFAULT 'ACT',
  `fntyp` char(3) NOT NULL DEFAULT 'FNC'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `funciones`
--

INSERT INTO `funciones` (`fncod`, `fndsc`, `fnest`, `fntyp`) VALUES
('Controllers\\Cart\\Cart', 'Carrito de Compras', 'ACT', 'CTR'),
('Controllers\\Checkout\\Accept', 'Confirmación de Orden de Pago', 'ACT', 'CTR'),
('Controllers\\Checkout\\Catalogo', 'Catálogo de Productos mediSalud', 'ACT', 'CTR'),
('Controllers\\Checkout\\Checkout', 'Pasarela de Pago PayPal / Simulada', 'ACT', 'CTR'),
('Controllers\\Checkout\\Error', 'Error en Pasarela de Pago', 'ACT', 'CTR'),
('Controllers\\Index', 'Página Principal', 'ACT', 'CTR'),
('Controllers\\Mnt\\Producto', 'Edición/Creación de Producto', 'ACT', 'CTR'),
('Controllers\\Mnt\\Productos', 'Mantenimiento de Catálogo de Productos', 'ACT', 'CTR'),
('Controllers\\Transacciones\\GestionTransacciones', 'Gestión Administrativa de Transacciones', 'ACT', 'CTR'),
('Controllers\\Transacciones\\MisTransacciones', 'Histórico de Compras del Cliente', 'ACT', 'CTR'),
('Menu_Cart', 'Menú Carretilla de Compra', 'ACT', 'MNU'),
('Menu_Catalogo', 'Menú Catálogo mediSalud', 'ACT', 'MNU'),
('Menu_GestionTransacciones', 'Menú Histórico General', 'ACT', 'MNU'),
('Menu_MisTransacciones', 'Menú Mis Compras', 'ACT', 'MNU'),
('Menu_PaymentCheckout', 'Menu_PaymentCheckout', 'ACT', 'MNU'),
('Menu_Productos', 'Menu_Productos', 'ACT', 'MNU'),
('Menu_ProductosMnt', 'Menú Mantenimiento Productos', 'ACT', 'MNU');

-- --------------------------------------------------------

--
-- Table structure for table `funciones_roles`
--

CREATE TABLE `funciones_roles` (
  `rolescod` varchar(128) NOT NULL,
  `fncod` varchar(255) NOT NULL,
  `fnrolest` char(3) NOT NULL DEFAULT 'ACT',
  `fnexp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `funciones_roles`
--

INSERT INTO `funciones_roles` (`rolescod`, `fncod`, `fnrolest`, `fnexp`) VALUES
('ADMIN', 'Controllers\\Cart\\Cart', 'ACT', NULL),
('ADMIN', 'Controllers\\Checkout\\Accept', 'ACT', NULL),
('ADMIN', 'Controllers\\Checkout\\Catalogo', 'ACT', NULL),
('ADMIN', 'Controllers\\Checkout\\Checkout', 'ACT', NULL),
('ADMIN', 'Controllers\\Checkout\\Error', 'ACT', NULL),
('ADMIN', 'Controllers\\Index', 'ACT', NULL),
('ADMIN', 'Controllers\\Mnt\\Producto', 'ACT', NULL),
('ADMIN', 'Controllers\\Mnt\\Productos', 'ACT', NULL),
('ADMIN', 'Controllers\\Transacciones\\GestionTransacciones', 'ACT', NULL),
('ADMIN', 'Controllers\\Transacciones\\MisTransacciones', 'ACT', NULL),
('ADMIN', 'Menu_Cart', 'ACT', NULL),
('ADMIN', 'Menu_Catalogo', 'ACT', NULL),
('ADMIN', 'Menu_GestionTransacciones', 'ACT', NULL),
('ADMIN', 'Menu_MisTransacciones', 'ACT', NULL),
('ADMIN', 'Menu_ProductosMnt', 'ACT', NULL),
('CLIENT', 'Controllers\\Cart\\Cart', 'ACT', NULL),
('CLIENT', 'Controllers\\Checkout\\Accept', 'ACT', NULL),
('CLIENT', 'Controllers\\Checkout\\Catalogo', 'ACT', NULL),
('CLIENT', 'Controllers\\Checkout\\Checkout', 'ACT', NULL),
('CLIENT', 'Controllers\\Checkout\\Error', 'ACT', NULL),
('CLIENT', 'Controllers\\Index', 'ACT', NULL),
('CLIENT', 'Controllers\\Transacciones\\MisTransacciones', 'ACT', NULL),
('CLIENT', 'Menu_Cart', 'ACT', NULL),
('CLIENT', 'Menu_Catalogo', 'ACT', NULL),
('CLIENT', 'Menu_MisTransacciones', 'ACT', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `productId` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `productDescription` text NOT NULL,
  `productPrice` decimal(10,2) NOT NULL,
  `productImgUrl` varchar(500) NOT NULL,
  `productStock` int(11) NOT NULL DEFAULT 0,
  `productCategory` varchar(100) NOT NULL DEFAULT 'General',
  `productStatus` char(3) NOT NULL DEFAULT 'ACT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`productId`, `productName`, `productDescription`, `productPrice`, `productImgUrl`, `productStock`, `productCategory`, `productStatus`) VALUES
(1, 'Aliviol Forte 550mg x 1 tableta', 'Analgésico y antipirético efectivo para aliviar dolores de cabeza, fiebres y malestares musculares leves a moderados.', 15.18, 'public/imgs/products/prd_6a738e93b9489.jpeg', 96, 'Analgesicos', 'ACT'),
(2, 'Alicol D x 120ml', 'Alivio integral de la tos, el catarro, la gripe y la congestión nasal.', 250.23, 'public/imgs/products/prd_6a738e4a58208.jpg', 49, 'Otros', 'ACT'),
(3, 'Alfacor - 81mg x 30 tabletas', 'Ayuda a evitar que las células de la sangre (plaquetas) se junten y formen coágulos peligrosos en las arterias.', 270.00, 'public/imgs/products/prd_6a738dda05fd0.jpg', 20, 'Otros', 'ACT'),
(4, 'Enantyum 25mg caja x 10 ampolla bebible', 'Sirve para aliviar el dolor agudo de intensidad leve o moderada, como dolores musculares, articulares, menstruales o dentales', 730.77, 'public/imgs/products/prd_6a738d10bd5d0.jpg', 200, 'Analgesicos', 'ACT'),
(5, 'Gamalate B6 caja x 60 grageas', 'Mezcla concentrada de vitaminas B1, B6 y B12 para el apoyo de la función nerviosa y aumento de energía vital.', 310.00, 'public/imgs/products/prd_6a738c8a4a051.jpg', 60, 'Vitaminas', 'ACT'),
(6, 'Alergil 5omg', 'Antihistamínico de acción prolongada no somnoliento para el alivio de rinitis alérgica y urticaria.', 4.00, 'public/imgs/products/prd_6a738c3762e45.jpg', 31, 'Antihistaminicos', 'ACT'),
(7, 'Acetaminofen Bayern 500mg x 20', 'El acetaminofén estimula la actividad de las vías serotoninérgicas descendentes que bloquean la transmisión de las señales nociceptivas a la médula espinal procedentes de tejidos periféricos', 31.31, 'public/imgs/products/prd_6a738bec803c7.png', 55, 'Analgesicos', 'ACT'),
(8, 'Advil 200mg x 12 grages', 'El Advil sirve para aliviar el dolor leve o moderado, reducir la inflamación y bajar la fiebre.', 83.20, 'public/imgs/products/prd_6a738b9570159.jpg', 40, 'Analgesicos', 'ACT'),
(9, 'Acetaminofen  500 mg TABLETAS', 'El acetaminofén estimula la actividad de las vías serotoninérgicas descendentes que bloquean la transmisión de las señales nociceptivas a la médula espinal procedentes de tejidos periféricos', 350.00, 'public/imgs/products/prd_6a738afd9a1bf.webp', 30, 'Analgesicos', 'ACT'),
(10, 'Neurobion Dc 25000 con 1 Jeringa', 'solución inyectable en jeringa de doble cámara que combina altas dosis de vitaminas del complejo B (B1, B6 y B12)', 455.36, 'public/imgs/products/prd_6a7389f23d4eb.jpg', 5, 'Vitaminas', 'ACT'),
(11, 'Suero Oral Electrolitos Coco 500ml', 'Solución de rehidratación oral recomendada para recuperar electrolitos perdidos por deshidratación.', 52.65, 'public/imgs/products/prd_6a7388cf8c77a.png', 55, 'Vitaminas', 'ACT'),
(12, 'Aceler Crema 2% Tubo 15 G', 'Pomada antiséptica con cicatrizante para curación rápida de quemaduras leves, raspaduras y cortes.', 388.44, 'public/imgs/products/prd_6a7387eb79d17.jpg', 30, 'Antihistaminicos', 'ACT'),
(13, 'Aspirina 500mg adulto caja x 20 tabletas', 'Aliviar dolores leves a moderados, reducir la fiebre, disminuir la inflamación y prevenir la formación de coágulos de sangre', 80.04, 'public/imgs/products/prd_6a738edc73848.jpg', 54, 'Cardiovascular', 'ACT'),
(14, 'Azitromicina Mk 500mg x 1 tableta', 'Sirve para tratar infecciones causadas por bacterias.', 152.75, 'public/imgs/products/prd_6a738f2965ac0.jpg', 30, 'Antibioticos', 'ACT'),
(15, 'Beclo-Asma 250mcg Aerosol', 'Prevenir y controlar los síntomas del asma bronquial, reducir la hinchazón de las vías respiratorias y evitar ataques de asma.', 850.00, 'public/imgs/products/prd_6a738fa2b82fc.jpg', 33, 'Otros', 'ACT'),
(16, 'Buto-Asma Aerosol Frasco Atomizador 200 dosis', 'Sirve para abrir de forma rápida los conductos de aire en los pulmones cuando se cierran o se ponen rígidos, aliviando la falta de aire, las sibilancias (silbidos en el pecho), la tos y la opresión.', 310.84, 'public/imgs/products/prd_6a738ffad052d.jpg', 23, 'Otros', 'ACT'),
(17, 'Sudagrip x 1 sobre', 'Aliviar los síntomas de la gripe y el resfriado común, como el dolor de cuerpo, la fiebre y la congestión nasal.', 24.00, 'public/imgs/products/prd_6a73905f82aea.jpg', 61, 'Antihistaminicos', 'ACT'),
(18, 'Cardio Delor 81mg caja x 30 tabletas', 'Se utiliza para ayudar a prevenir la formación de coágulos sanguíneos.', 199.00, 'public/imgs/products/prd_6a7390a32cd36.jpg', 23, 'Cardiovascular', 'ACT'),
(19, 'CardioAspirina 81mg caja x 30 tabletas', 'Sirve como medicamento antiplaquetario para evitar que las plaquetas de la sangre se junten y formen coágulos', 319.00, 'public/imgs/products/prd_6a7390ff61076.jpg', 41, 'Cardiovascular', 'ACT'),
(20, 'Cetirizina Calox 10mg x 1 tableta', 'Aliviar los síntomas de las alergias y de la urticaria', 13.28, 'public/imgs/products/prd_6a73915dabef9.jpeg', 10, 'Antihistaminicos', 'ACT'),
(21, 'Dolminol', 'Calmar el dolor de leve a moderado, bajar la fiebre y reducir la hinchazón o inflamación en el cuerpo.', 145.09, 'public/imgs/products/prd_6a7391ec84060.jpg', 12, 'Analgesicos', 'ACT'),
(22, 'Esonex 40mg x 30 tabletas', 'Bajar la cantidad de ácido que el estómago produce', 1465.00, 'public/imgs/products/prd_6a739255d5bac.jpg', 20, 'Analgesicos', 'ACT'),
(23, 'Ibuprofeno Fs 600mg x Caja x 30 Tabs', 'Calmar el dolor de leve a moderado, bajar la fiebre y reducir la hinchazón o inflamación en el cuerpo', 242.00, 'public/imgs/products/prd_6a7392cc79d89.jpg', 25, 'Analgesicos', 'ACT'),
(24, 'Martesia 300mg x 30 capsulas', 'Sirve para tratar el dolor en los nervios, calmar la fibromialgia, ayudar con la epilepsia y disminuir la ansiedad generalizad', 2147.44, 'public/imgs/products/prd_6a73932415006.jpg', 18, 'Otros', 'ACT'),
(25, 'Medox Abc Jarabe x 240ml', 'Apoyar el crecimiento y las defensas.', 698.20, 'public/imgs/products/prd_6a73936ed2efd.jpg', 11, 'Vitaminas', 'ACT'),
(26, 'Suero Oral Oralectil Manzana Verde 500ml', 'Reponer agua, glucosa y electrolitos esenciales como sodio, potasio, calcio y magnesio en el cuerpo.', 50.94, 'public/imgs/products/prd_6a7393bc4ea40.png', 9, 'Vitaminas', 'ACT'),
(27, 'Suero Oral Oralectil Piña 500ml', 'Reponer agua, glucosa y electrolitos esenciales como sodio, potasio, calcio y magnesio en el cuerpo.', 50.94, 'public/imgs/products/prd_6a7393e42c7af.png', 3, 'Vitaminas', 'ACT'),
(28, 'Suero Oral Oralectil Cereza 500ml', 'Reponer agua, glucosa y electrolitos esenciales como sodio, potasio, calcio y magnesio en el cuerpo.', 50.94, 'public/imgs/products/prd_6a739410d3464.png', 2, 'Vitaminas', 'ACT'),
(29, 'Panadol Mujer Caja x 24 sobres', 'Panadol Mujer ofrece un rápido y efectivo alivio del dolor menstrual y muscular.', 315.23, 'public/imgs/products/prd_6a73949c81a39.jpg', 8, 'Analgesicos', 'ACT'),
(30, 'Panadol Rapid 500mg', 'Panadol Rapid ofrece un rápido* y efectivo alivio del dolor menstrual y muscular.', 64.66, 'public/imgs/products/prd_6a7394d2b823e.jpg', 10, 'Analgesicos', 'ACT'),
(31, 'Rodiflux Jarabe x 120 ml', 'Calmar la tos irritativa, la bronquitis y los síntomas de la gripe', 311.69, 'public/imgs/products/prd_6a73953099707.jpg', 11, 'Otros', 'ACT'),
(32, 'Salbutamol Pme Aerosol Inhalador 1 + 1', 'Edicamento broncodilatador que relaja los músculos de las vías respiratorias, facilitando la respiración', 280.58, 'public/imgs/products/prd_6a7395990315a.jpg', 5, 'Digestivo', 'ACT'),
(33, 'Tabcin Antigripal Form Mej Caja x 72 tabletas', 'Aliviar de forma rápida los síntomas de la gripe, el resfriado común y la tos', 429.03, 'public/imgs/products/prd_6a73962be1fa5.jpeg', 3, 'Antihistaminicos', 'ACT'),
(34, 'Ultra Doceplex B15 Caja x 1 Ampolla', 'Sirve para disminuir el cansancio físico y mental, mejorar la concentración, apoyar la salud del sistema nervioso y reducir los efectos del estrés prolongado.', 237.18, 'public/imgs/products/prd_6a739666d15b0.jpg', 6, 'Vitaminas', 'ACT'),
(35, 'Unipulmin Capsulas x 100', 'Es un medicamento antigripal formulado para aliviar los síntomas de la gripe y el resfriado común', 607.15, 'public/imgs/products/prd_6a7396ec2b9b2.jpeg', 4, 'Otros', 'ACT');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `rolescod` varchar(128) NOT NULL,
  `rolesdsc` varchar(45) NOT NULL,
  `rolesest` char(3) NOT NULL DEFAULT 'ACT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`rolescod`, `rolesdsc`, `rolesest`) VALUES
('ADMIN', 'Administrador General de mediSalud', 'ACT'),
('CLIENT', 'Cliente Registrado de mediSalud', 'ACT');

-- --------------------------------------------------------

--
-- Table structure for table `roles_usuarios`
--

CREATE TABLE `roles_usuarios` (
  `usercod` bigint(10) NOT NULL,
  `rolescod` varchar(128) NOT NULL,
  `roleuserest` char(3) NOT NULL DEFAULT 'ACT',
  `roleuserfch` datetime NOT NULL DEFAULT current_timestamp(),
  `roleuserexp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles_usuarios`
--

INSERT INTO `roles_usuarios` (`usercod`, `rolescod`, `roleuserest`, `roleuserfch`, `roleuserexp`) VALUES
(1, 'ADMIN', 'ACT', '2026-07-31 13:41:22', NULL),
(2, 'CLIENT', 'ACT', '2026-07-31 13:41:22', NULL),
(3, 'CLIENT', 'ACT', '2026-08-05 14:50:52', NULL),
(4, 'CLIENT', 'ACT', '2026-08-04 17:52:21', NULL),
(5, 'CLIENT', 'ACT', '2026-08-04 17:53:34', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transacciones`
--

CREATE TABLE `transacciones` (
  `txnid` int(11) NOT NULL,
  `txnreference` varchar(100) NOT NULL,
  `usercod` bigint(10) NOT NULL,
  `txnfch` datetime NOT NULL DEFAULT current_timestamp(),
  `txnamount` decimal(12,2) NOT NULL,
  `txnisv` decimal(12,2) NOT NULL,
  `txntotal` decimal(12,2) NOT NULL,
  `txnstt` varchar(20) NOT NULL DEFAULT 'COMPLETED',
  `txnpaymethod` varchar(50) NOT NULL DEFAULT 'PAYPAL_SANDBOX'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transacciones`
--

INSERT INTO `transacciones` (`txnid`, `txnreference`, `usercod`, `txnfch`, `txnamount`, `txnisv`, `txntotal`, `txnstt`, `txnpaymethod`) VALUES
(1, 'TXN-20260730-1001', 2, '2026-07-31 13:41:22', 265.00, 39.75, 304.75, 'COMPLETED', 'PAYPAL_SANDBOX'),
(2, '8E8249515T0738610', 2, '2026-08-04 22:09:54', 0.00, 0.00, 0.00, 'COMPLETED', 'PAYPAL_SANDBOX'),
(3, '89V21782R6817141W', 2, '2026-08-04 22:10:26', 0.00, 0.00, 0.00, 'COMPLETED', 'PAYPAL_SANDBOX'),
(4, '0F3668198Y121992G', 2, '2026-08-04 22:14:23', 0.00, 0.00, 0.00, 'COMPLETED', 'PAYPAL_SANDBOX'),
(5, '8PF67810AA179384W', 2, '2026-08-04 22:16:29', 0.00, 0.00, 0.00, 'COMPLETED', 'PAYPAL_SANDBOX');

-- --------------------------------------------------------

--
-- Table structure for table `transacciones_detalle`
--

CREATE TABLE `transacciones_detalle` (
  `txnid` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `prdname` varchar(255) NOT NULL,
  `prdprice` decimal(12,2) NOT NULL,
  `prdctd` int(5) NOT NULL,
  `prdsubtotal` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transacciones_detalle`
--

INSERT INTO `transacciones_detalle` (`txnid`, `productId`, `prdname`, `prdprice`, `prdctd`, `prdsubtotal`) VALUES
(1, 1, 'Acetaminofén 500mg (Caja x20)', 85.00, 1, 85.00),
(1, 4, 'Vitamina C Efervescente 1000mg', 180.00, 1, 180.00),
(5, 1, 'Compra PayPal Genérica', 0.00, 1, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `usercod` bigint(10) NOT NULL,
  `useremail` varchar(80) NOT NULL,
  `username` varchar(80) NOT NULL,
  `userpswd` varchar(128) NOT NULL,
  `userfching` datetime NOT NULL DEFAULT current_timestamp(),
  `userpswdest` char(3) NOT NULL DEFAULT 'ACT',
  `userpswdexp` datetime DEFAULT NULL,
  `userest` char(3) NOT NULL DEFAULT 'ACT',
  `useractcod` varchar(128) DEFAULT NULL,
  `userpswdchg` varchar(128) DEFAULT NULL,
  `usertipo` char(3) NOT NULL DEFAULT 'PBL' COMMENT 'ADM: Admin, PBL: Publico/Cliente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`usercod`, `useremail`, `username`, `userpswd`, `userfching`, `userpswdest`, `userpswdexp`, `userest`, `useractcod`, `userpswdchg`, `usertipo`) VALUES
(1, 'admin@medisalud.com', 'Administrador mediSalud', '$2y$10$T/5jLBeEtCDtO.oz1AkWOOqrFP6Vrn5USxloVqAvg4RvSX/BsHVdO', '2026-07-31 13:41:22', 'ACT', '2026-10-29 13:41:22', 'ACT', NULL, NULL, 'ADM'),
(2, 'cliente@medisalud.com', 'Juan Pérez (Cliente)', '$2y$10$T/5jLBeEtCDtO.oz1AkWOOqrFP6Vrn5USxloVqAvg4RvSX/BsHVdO', '2026-07-31 13:41:22', 'ACT', '2026-10-29 13:41:22', 'ACT', NULL, NULL, 'PBL'),
(3, 'genesisjulisam@gmail.com', 'John Doe', '$2y$10$mfUdI881vbmYz2UP6qgcXOfmw9Q1.lQmRaAIcxCEIJ5yJdGm5QZqe', '2026-08-04 15:56:11', 'ACT', '2026-11-02 00:00:00', 'ACT', '5f0f91266e78e2579a7c63cf2b648d77be667afcd557dd8d971ade0f89eba9ad', '2026-08-04 15:56:11', 'PBL'),
(4, 'chaconmodestomejia@gmail.com', 'John Doe', '$2y$10$YdsEqLfZx1FQjfoK7dARPea3go1PqehFcgFYU3lpFddQmA.RAxtnO', '2026-08-04 17:52:21', 'ACT', '2026-11-02 00:00:00', 'ACT', '3e00708f60abafa9cd2baacf3c346f1ab80f95bd22c6cdcaa8d850370656adc3', '2026-08-04 17:52:21', 'PBL'),
(5, 'ashlindaniela@gmail.com', 'John Doe', '$2y$10$Fp7MjlLmK5w4RL/ZujvofucUzjKUc9MEX2KkLlKg0f4hBc2DcepQW', '2026-08-04 17:53:34', 'ACT', '2026-11-02 00:00:00', 'ACT', '87c21817c5ef8e99dd01fb2e7106e274c2f25b096c3c25809be5784df924a289', '2026-08-04 17:53:34', 'PBL');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bitacora`
--
ALTER TABLE `bitacora`
  ADD PRIMARY KEY (`bitacoracod`);

--
-- Indexes for table `carretilla`
--
ALTER TABLE `carretilla`
  ADD PRIMARY KEY (`usercod`,`productId`),
  ADD KEY `fk_crr_prd` (`productId`);

--
-- Indexes for table `carretillaanon`
--
ALTER TABLE `carretillaanon`
  ADD PRIMARY KEY (`anoncod`,`productId`),
  ADD KEY `fk_crranon_prd` (`productId`);

--
-- Indexes for table `funciones`
--
ALTER TABLE `funciones`
  ADD PRIMARY KEY (`fncod`);

--
-- Indexes for table `funciones_roles`
--
ALTER TABLE `funciones_roles`
  ADD PRIMARY KEY (`rolescod`,`fncod`),
  ADD KEY `fk_fr_funciones` (`fncod`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`productId`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`rolescod`);

--
-- Indexes for table `roles_usuarios`
--
ALTER TABLE `roles_usuarios`
  ADD PRIMARY KEY (`usercod`,`rolescod`),
  ADD KEY `fk_ru_roles` (`rolescod`);

--
-- Indexes for table `transacciones`
--
ALTER TABLE `transacciones`
  ADD PRIMARY KEY (`txnid`),
  ADD UNIQUE KEY `txnreference_UNIQUE` (`txnreference`),
  ADD KEY `fk_txn_user` (`usercod`);

--
-- Indexes for table `transacciones_detalle`
--
ALTER TABLE `transacciones_detalle`
  ADD PRIMARY KEY (`txnid`,`productId`),
  ADD KEY `fk_txnd_prd` (`productId`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usercod`),
  ADD UNIQUE KEY `useremail_UNIQUE` (`useremail`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bitacora`
--
ALTER TABLE `bitacora`
  MODIFY `bitacoracod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `productId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `transacciones`
--
ALTER TABLE `transacciones`
  MODIFY `txnid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usercod` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carretilla`
--
ALTER TABLE `carretilla`
  ADD CONSTRAINT `fk_crr_prd` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_crr_user` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE CASCADE;

--
-- Constraints for table `carretillaanon`
--
ALTER TABLE `carretillaanon`
  ADD CONSTRAINT `fk_crranon_prd` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE;

--
-- Constraints for table `funciones_roles`
--
ALTER TABLE `funciones_roles`
  ADD CONSTRAINT `fk_fr_funciones` FOREIGN KEY (`fncod`) REFERENCES `funciones` (`fncod`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_fr_roles` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `roles_usuarios`
--
ALTER TABLE `roles_usuarios`
  ADD CONSTRAINT `fk_ru_roles` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ru_usuario` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transacciones`
--
ALTER TABLE `transacciones`
  ADD CONSTRAINT `fk_txn_user` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE CASCADE;

--
-- Constraints for table `transacciones_detalle`
--
ALTER TABLE `transacciones_detalle`
  ADD CONSTRAINT `fk_txnd_prd` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_txnd_txn` FOREIGN KEY (`txnid`) REFERENCES `transacciones` (`txnid`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
