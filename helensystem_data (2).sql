-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 04-06-2025 a las 22:29:06
-- Versión del servidor: 8.0.40
-- Versión de PHP: 8.3.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `helensystem_data`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblareas`
--

CREATE TABLE `tblareas` (
  `IDArea` int NOT NULL,
  `NombreArea` varchar(255) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `IDEncargado` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcargosdeempleados`
--

CREATE TABLE `tblcargosdeempleados` (
  `IDCargo` int NOT NULL,
  `Descripcion` varchar(255) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Funciones` varchar(255) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcatalogodeactividades`
--

CREATE TABLE `tblcatalogodeactividades` (
  `IDActividad` int NOT NULL,
  `CodigoActividad` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `DescripcionActividad` text COLLATE utf8mb4_spanish2_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcatalogodecategorias`
--

CREATE TABLE `tblcatalogodecategorias` (
  `IDCategoria` int NOT NULL,
  `Categoria` varchar(100) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Estado` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcatalogodeclientes`
--

CREATE TABLE `tblcatalogodeclientes` (
  `UUIDCliente` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `CodigoCLI` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UUIDSucursal` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TipoDeCliente` int DEFAULT NULL,
  `ModalidadCliente` int NOT NULL DEFAULT '1',
  `TipoCliente` int NOT NULL DEFAULT '0',
  `NombreDeCliente` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NombreComercial` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Direccion` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Referencia` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UbicacionGPS` mediumtext COLLATE utf8mb3_spanish2_ci,
  `LatitudGPS` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL DEFAULT '0',
  `LongitudGPS` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL DEFAULT '0',
  `RFID` varchar(255) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UUIDEmpleado` text COLLATE utf8mb3_spanish2_ci,
  `IDZona` int DEFAULT '0',
  `IDDepartamento` int DEFAULT NULL,
  `Departamento` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `IDMunicipio` int DEFAULT NULL,
  `Municipio` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `IDDistrito` int DEFAULT NULL,
  `Distrito` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TelFijo` varchar(10) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TelMovil` varchar(10) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TelWhatsApp` varchar(10) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `DUI` varchar(50) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NIT` varchar(50) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CorreoElectronico` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Contribuyente` int NOT NULL DEFAULT '0',
  `NRC` varchar(50) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodActividad` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `GiroComercial` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Estado` int NOT NULL DEFAULT '1',
  `Observaciones` text COLLATE utf8mb3_spanish2_ci,
  `EstadoDeTarjeta` int DEFAULT '0',
  `TipoDePrecioAutorizado` int DEFAULT '1',
  `NumeroDeTarjeta` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodigoTarjeta64` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci,
  `DocumentoEstablecido` varchar(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT '01',
  `CondicionEstablecida` int DEFAULT '1',
  `MontoMaximoEstablecido` decimal(10,2) DEFAULT '0.00',
  `PlazoEstablecido` int DEFAULT '0',
  `VenderPrecioEspecial` int DEFAULT '0',
  `duifrente` varchar(255) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `duivuelto` varchar(255) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UltimoPedido` date DEFAULT NULL,
  `Actualizado` int NOT NULL DEFAULT '0',
  `EstadoLlamada` int NOT NULL DEFAULT '0',
  `ObservacionesLlamada` text COLLATE utf8mb3_spanish2_ci,
  `FechaHoraLlamada` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcatalogodepresentaciones`
--

CREATE TABLE `tblcatalogodepresentaciones` (
  `IDPresentacion` int NOT NULL,
  `DescripcionPresentacion` varchar(255) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcatalogodeproductos`
--

CREATE TABLE `tblcatalogodeproductos` (
  `UUIDProducto` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodigoPROD` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UUIDNegocio` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Descripcion` varchar(100) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Contenido1` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Contenido2` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TipoProducto` int NOT NULL DEFAULT '1',
  `TipoDeItem` int NOT NULL DEFAULT '1',
  `IDUbicacion` int DEFAULT '0',
  `Unidades` int DEFAULT '0',
  `PrecioCosto` decimal(10,2) DEFAULT '0.00',
  `PrecioEspecial` decimal(10,2) DEFAULT '0.00',
  `PrecioMayoreo` decimal(10,2) DEFAULT '0.00',
  `PrecioDetalle` decimal(10,2) DEFAULT '0.00',
  `PrecioDetalleDespacho` decimal(10,2) NOT NULL DEFAULT '0.00',
  `PrecioPublico` decimal(10,2) DEFAULT '0.00',
  `UtilidadEspecial` decimal(10,2) NOT NULL DEFAULT '0.00',
  `UtilidadMayoreo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `UtilidadDetalle` decimal(10,2) NOT NULL DEFAULT '0.00',
  `UtilidadDetalleDespacho` decimal(10,2) NOT NULL DEFAULT '0.00',
  `UtilidadPublico` decimal(10,2) NOT NULL DEFAULT '0.00',
  `UMinimaPublico` decimal(10,2) DEFAULT '0.00',
  `UMaximaPublico` decimal(10,2) DEFAULT '0.00',
  `UMinimaDetalle` decimal(10,2) DEFAULT '0.00',
  `UMaximaDetalle` decimal(10,2) DEFAULT '0.00',
  `UMinimaMayoreo` decimal(10,2) DEFAULT '0.00',
  `UMinimaMayoreoDespacho` decimal(10,2) NOT NULL DEFAULT '0.00',
  `UMaximaMayoreo` decimal(10,2) DEFAULT '0.00',
  `IDCategoria` int DEFAULT '0',
  `IDPresentacion` int DEFAULT '0',
  `IDFamilia` int DEFAULT '0',
  `Retornable` int DEFAULT '0',
  `Vence` int DEFAULT '0',
  `SeEmpaca` int DEFAULT '0',
  `Estado` int DEFAULT '1',
  `PagaImpuesto` int DEFAULT '0',
  `PorcentajeImpuesto` decimal(10,2) DEFAULT '0.00',
  `ControlarInventario` int DEFAULT '1',
  `Inventariado` int DEFAULT '0',
  `FechaInventariado` datetime DEFAULT NULL,
  `TipodeDistribucion` int DEFAULT '0',
  `AgregarPorBuscador` int DEFAULT '1',
  `MostrarEnCatalogo` int DEFAULT '1',
  `SeVendeSurtido` int DEFAULT '0',
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcatalogodeproductostemporal`
--

CREATE TABLE `tblcatalogodeproductostemporal` (
  `UUIDProducto` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodigoPROD` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UUIDNegocio` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Descripcion` varchar(100) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Contenido1` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Contenido2` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TipoProducto` int NOT NULL DEFAULT '1',
  `TipoDeItem` int NOT NULL DEFAULT '1',
  `IDUbicacion` int DEFAULT '0',
  `Unidades` int DEFAULT '0',
  `PrecioCosto` decimal(10,2) DEFAULT '0.00',
  `PrecioEspecial` decimal(10,2) DEFAULT '0.00',
  `PrecioMayoreo` decimal(10,2) DEFAULT '0.00',
  `PrecioDetalle` decimal(10,2) DEFAULT '0.00',
  `PrecioDetalleDespacho` decimal(10,2) NOT NULL DEFAULT '0.00',
  `PrecioPublico` decimal(10,2) DEFAULT '0.00',
  `UtilidadEspecial` decimal(10,2) NOT NULL DEFAULT '0.00',
  `UtilidadMayoreo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `UtilidadDetalle` decimal(10,2) NOT NULL DEFAULT '0.00',
  `UtilidadDetalleDespacho` decimal(10,2) NOT NULL DEFAULT '0.00',
  `UtilidadPublico` decimal(10,2) NOT NULL DEFAULT '0.00',
  `UMinimaPublico` decimal(10,2) DEFAULT '0.00',
  `UMaximaPublico` decimal(10,2) DEFAULT '0.00',
  `UMinimaDetalle` decimal(10,2) DEFAULT '0.00',
  `UMaximaDetalle` decimal(10,2) DEFAULT '0.00',
  `UMinimaMayoreo` decimal(10,2) DEFAULT '0.00',
  `UMinimaMayoreoDespacho` decimal(10,2) NOT NULL DEFAULT '0.00',
  `UMaximaMayoreo` decimal(10,2) DEFAULT '0.00',
  `IDCategoria` int DEFAULT '0',
  `IDPresentacion` int DEFAULT '0',
  `IDFamilia` int DEFAULT '0',
  `Retornable` int DEFAULT '0',
  `Vence` int DEFAULT '0',
  `SeEmpaca` int DEFAULT '0',
  `Estado` int DEFAULT '1',
  `PagaImpuesto` int DEFAULT '0',
  `PorcentajeImpuesto` decimal(10,2) DEFAULT '0.00',
  `ControlarInventario` int DEFAULT '1',
  `Inventariado` int DEFAULT '0',
  `FechaInventariado` datetime DEFAULT NULL,
  `TipodeDistribucion` int DEFAULT '0',
  `AgregarPorBuscador` int DEFAULT '1',
  `MostrarEnCatalogo` int DEFAULT '1',
  `SeVendeSurtido` int DEFAULT '0',
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcatalogodeproveedores`
--

CREATE TABLE `tblcatalogodeproveedores` (
  `UUIDProveedor` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodigoPRO` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TipoDeProveedor` int NOT NULL DEFAULT '0',
  `Proveedor` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NombreComercial` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Direccion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci,
  `Nacionalidad` varchar(100) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `DUI` varchar(50) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NIT` varchar(100) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NRC` varchar(50) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Telefono` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Fax` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Vendedor` varchar(50) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TelMovil` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TelMovilWhatsApp` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CorreoElectronico` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `SitioWeb` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `EmiteDocumento` int DEFAULT NULL,
  `NoResolucion` varchar(100) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NoSerie` varchar(100) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Estado` int NOT NULL DEFAULT '1',
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcategoriagastos`
--

CREATE TABLE `tblcategoriagastos` (
  `IDCategoria` int NOT NULL,
  `DescripcionCategoria` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `Visualizacion` int NOT NULL DEFAULT '0',
  `Estado` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcodigosdebarras`
--

CREATE TABLE `tblcodigosdebarras` (
  `UUIDBarra` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodigoPROD` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodigoDeBarras` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TipoBarra` int NOT NULL DEFAULT '2'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblconfiguraciones`
--

CREATE TABLE `tblconfiguraciones` (
  `codigoautorizacion` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `TokenTransmision` text COLLATE utf8mb4_general_ci,
  `FechaUpdateToken` datetime DEFAULT NULL,
  `TransmisionAutomatica` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcontroldecajafuerte`
--

CREATE TABLE `tblcontroldecajafuerte` (
  `UUIDTraslado` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `CodigoTRAS` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `UUIDSucursal` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `UUIDTerminal` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UUIDAutoriza` int NOT NULL DEFAULT '0',
  `EmpleadoAutoriza` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Cien` int NOT NULL DEFAULT '0',
  `Cincuenta` int DEFAULT '0',
  `Veinte` int NOT NULL DEFAULT '0',
  `Diez` int NOT NULL DEFAULT '0',
  `Cinco` int NOT NULL DEFAULT '0',
  `Uno` int NOT NULL DEFAULT '0',
  `UnDolar` int NOT NULL DEFAULT '0',
  `CeroVeinticinco` int NOT NULL DEFAULT '0',
  `CeroDiez` int NOT NULL DEFAULT '0',
  `CeroCinco` int NOT NULL DEFAULT '0',
  `CeroUno` int NOT NULL DEFAULT '0',
  `TotalTraslado` decimal(10,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcontroldecajafuertecnb`
--

CREATE TABLE `tblcontroldecajafuertecnb` (
  `UUIDTraslado` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `CodigoTRAS` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `UUIDSucursal` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `FechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Cien` int NOT NULL DEFAULT '0',
  `Cincuenta` int DEFAULT '0',
  `Veinte` int NOT NULL DEFAULT '0',
  `Diez` int NOT NULL DEFAULT '0',
  `Cinco` int NOT NULL DEFAULT '0',
  `Uno` int NOT NULL DEFAULT '0',
  `UnDolar` int NOT NULL DEFAULT '0',
  `CeroVeinticinco` int NOT NULL DEFAULT '0',
  `CeroDiez` int NOT NULL DEFAULT '0',
  `CeroCinco` int NOT NULL DEFAULT '0',
  `CeroUno` int NOT NULL DEFAULT '0',
  `TotalTraslado` decimal(10,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcontroldeofertas`
--

CREATE TABLE `tblcontroldeofertas` (
  `UUIDPromocion` varchar(200) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(20) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `Estado` int NOT NULL DEFAULT '1',
  `TipoOferta` int NOT NULL DEFAULT '0',
  `Para` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `AplicarA` int NOT NULL DEFAULT '0',
  `CodigoUUID` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `ProductosAfectados` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `NombreOferta` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `DescripcionOferta` varchar(500) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `InicioOferta` date DEFAULT NULL,
  `HoraInicioOferta` time DEFAULT NULL,
  `FinOferta` date DEFAULT NULL,
  `HoraFinOferta` time DEFAULT NULL,
  `EstaOfertado` int NOT NULL DEFAULT '1',
  `PrecioOferta` decimal(10,2) NOT NULL DEFAULT '0.00',
  `PorcentajeDescuento` decimal(10,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcontroldeterminales`
--

CREATE TABLE `tblcontroldeterminales` (
  `UUIDApertura` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `CodigoAPER` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `FechaApertura` date DEFAULT NULL,
  `OperadorApertura` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `OperadorCierre` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `UUIDSucursal` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `UUIDTerminal` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `EfectivoApertura` decimal(10,2) NOT NULL DEFAULT '0.00',
  `EfectivoDeclarado` decimal(10,2) NOT NULL DEFAULT '0.00',
  `HoraApertura` time DEFAULT NULL,
  `HoraCierre` time DEFAULT NULL,
  `Estado` int NOT NULL DEFAULT '1',
  `UsuarioUpdate` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `FechaUpdate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcortesdecaja`
--

CREATE TABLE `tblcortesdecaja` (
  `UUIDCorteCaja` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `CodigoCOR` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaDeCorte` date DEFAULT NULL,
  `UUIDSucursal` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UUIDTerminal` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Inicial` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Apertura` decimal(10,2) NOT NULL DEFAULT '0.00',
  `VentaMostrador` decimal(10,2) NOT NULL DEFAULT '0.00',
  `VentaDomicilio` decimal(10,2) NOT NULL DEFAULT '0.00',
  `VentaDespacho` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Movimientos` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalIngresos` decimal(10,2) NOT NULL DEFAULT '0.00',
  `CajaFuerte` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalGastos` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalCargos` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalAbonosMercaderia` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalAbonosEfectivo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalDevoluciones` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalPagosCompras` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Cien` int NOT NULL DEFAULT '0',
  `Cincuenta` int NOT NULL DEFAULT '0',
  `Veinte` int NOT NULL DEFAULT '0',
  `Diez` int NOT NULL DEFAULT '0',
  `Cinco` int NOT NULL DEFAULT '0',
  `Uno` int NOT NULL DEFAULT '0',
  `UnDolar` int NOT NULL DEFAULT '0',
  `CeroVeinticinco` int NOT NULL DEFAULT '0',
  `CeroDiez` int NOT NULL DEFAULT '0',
  `CeroCinco` int NOT NULL DEFAULT '0',
  `CeroUno` int NOT NULL DEFAULT '0',
  `TotalEfectivo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `CienR` int NOT NULL DEFAULT '0',
  `CincuentaR` int NOT NULL DEFAULT '0',
  `VeinteR` int NOT NULL DEFAULT '0',
  `DiezR` int NOT NULL DEFAULT '0',
  `CincoR` int NOT NULL DEFAULT '0',
  `UnoR` int NOT NULL DEFAULT '0',
  `UnDolarR` int NOT NULL DEFAULT '0',
  `CeroVeinticincoR` int NOT NULL DEFAULT '0',
  `CeroDiezR` int NOT NULL DEFAULT '0',
  `CeroCincoR` int NOT NULL DEFAULT '0',
  `CeroUnoR` int NOT NULL DEFAULT '0',
  `Remanente` decimal(10,2) NOT NULL DEFAULT '0.00',
  `MontoTotal` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Calculado` int NOT NULL DEFAULT '0',
  `Diferencia` decimal(10,2) NOT NULL DEFAULT '0.00',
  `ModificarFecha` int NOT NULL DEFAULT '0',
  `Estado` int NOT NULL DEFAULT '1',
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcortesdecnb`
--

CREATE TABLE `tblcortesdecnb` (
  `UUIDCorteCNB` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `CodigoCNB` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaDeCorte` date DEFAULT NULL,
  `UUIDSucursal` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `SaldoCNBFedecredito` decimal(13,2) NOT NULL DEFAULT '0.00',
  `SaldoCNBPromerica` decimal(13,2) NOT NULL DEFAULT '0.00',
  `SaldoCNBBAC` decimal(13,2) NOT NULL DEFAULT '0.00',
  `SaldoTigoMoney` decimal(13,2) NOT NULL DEFAULT '0.00',
  `CajaFuerte` decimal(13,2) NOT NULL DEFAULT '0.00',
  `OtroDinero` decimal(13,2) NOT NULL DEFAULT '0.00',
  `MontoTotal` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Notas` text COLLATE utf8mb3_spanish2_ci,
  `MontoComparativo` decimal(13,2) NOT NULL DEFAULT '0.00',
  `Cien` int NOT NULL DEFAULT '0',
  `Cincuenta` int NOT NULL DEFAULT '0',
  `Veinte` int NOT NULL DEFAULT '0',
  `Diez` int NOT NULL DEFAULT '0',
  `Cinco` int NOT NULL DEFAULT '0',
  `Uno` int NOT NULL DEFAULT '0',
  `UnDolar` int NOT NULL DEFAULT '0',
  `CeroVeinticinco` int NOT NULL DEFAULT '0',
  `CeroDiez` int NOT NULL DEFAULT '0',
  `CeroCinco` int NOT NULL DEFAULT '0',
  `CeroUno` int NOT NULL DEFAULT '0',
  `TotalEfectivo` decimal(13,2) NOT NULL DEFAULT '0.00',
  `Calculado` int NOT NULL DEFAULT '0',
  `Diferencia` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Estado` int NOT NULL DEFAULT '1',
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcortesderecarga`
--

CREATE TABLE `tblcortesderecarga` (
  `UUIDCorteRecarga` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `CodigoRecarga` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `FechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaDeCorte` date DEFAULT NULL,
  `UUIDSucursal` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TotalEfectivo` decimal(13,2) NOT NULL DEFAULT '0.00',
  `VentaTicket` decimal(10,2) NOT NULL DEFAULT '0.00',
  `OtroDinero` decimal(13,2) NOT NULL DEFAULT '0.00',
  `Notas` text COLLATE utf8mb3_spanish2_ci,
  `SaldoInicial` decimal(13,2) NOT NULL DEFAULT '0.00',
  `Compras` decimal(13,2) NOT NULL DEFAULT '0.00',
  `SaldoFinal` decimal(13,2) NOT NULL DEFAULT '0.00',
  `Facturacion` decimal(13,2) NOT NULL DEFAULT '0.00',
  `Ajuste` decimal(13,2) NOT NULL DEFAULT '0.00',
  `Cien` int DEFAULT '0',
  `Cincuenta` int DEFAULT '0',
  `Veinte` int DEFAULT '0',
  `Diez` int DEFAULT '0',
  `Cinco` int DEFAULT '0',
  `Uno` int DEFAULT '0',
  `UnDolar` int DEFAULT '0',
  `CeroVeinticinco` int NOT NULL DEFAULT '0',
  `CeroDiez` int NOT NULL DEFAULT '0',
  `CeroCinco` int NOT NULL DEFAULT '0',
  `CeroUno` int NOT NULL DEFAULT '0',
  `Diferencia` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Calculado` int NOT NULL DEFAULT '0',
  `Estado` int NOT NULL DEFAULT '1',
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcreditos`
--

CREATE TABLE `tblcreditos` (
  `UUIDCredito` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Tipo` int NOT NULL DEFAULT '1',
  `NoCorrelativo` int NOT NULL,
  `NoSolicitud` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `CodigoCRE` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `FechaDeSolicitud` date NOT NULL,
  `UUIDSucursal` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `UUIDCobrador` int NOT NULL DEFAULT '0',
  `TipoDeCredito` int NOT NULL DEFAULT '1',
  `PlanDeCredito` int NOT NULL DEFAULT '0',
  `MontoCredito` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Prima` decimal(10,2) NOT NULL DEFAULT '0.00',
  `MontoOtorgado` decimal(10,2) NOT NULL DEFAULT '0.00',
  `ComisionDesembolso` decimal(10,2) NOT NULL DEFAULT '0.00',
  `SeguroDeuda` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TasaInteresMensual` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TasaInteresMora` decimal(10,2) NOT NULL DEFAULT '0.00',
  `FechaInicio` date DEFAULT NULL,
  `Plazo` int NOT NULL DEFAULT '0',
  `FechaFin` date DEFAULT NULL,
  `CuotaPago` decimal(10,2) NOT NULL DEFAULT '0.00',
  `DiaVencimientoCuota` int NOT NULL DEFAULT '0',
  `TipoSolicitante` int NOT NULL DEFAULT '1',
  `CodigoCLI` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `NombreSolicitante` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Direccion` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `IDDepartamento` int NOT NULL DEFAULT '0',
  `Departamento` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `IDMunicipio` int NOT NULL DEFAULT '0',
  `Municipio` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `IDDistrito` int NOT NULL DEFAULT '0',
  `Distrito` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `DUI` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `NIT` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Telefono` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `WhatsApp` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `CorreoElectronico` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `RangoIngresos` int NOT NULL DEFAULT '0',
  `OrigenIngresos` int NOT NULL DEFAULT '0',
  `DestinoCredito` int NOT NULL DEFAULT '0',
  `DireccionTrabajoProyecto` text COLLATE utf8mb4_general_ci,
  `TelefonoTrabajo` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Referencia1` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ContactoReferencia1` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Referencia2` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ContactoReferencia2` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `FechaAprobacion` datetime DEFAULT NULL,
  `UsuarioAprobacion` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `TotalAbonos` decimal(10,2) NOT NULL DEFAULT '0.00',
  `SaldoActual` decimal(10,2) NOT NULL DEFAULT '0.00',
  `FechaUltimoAbono` date DEFAULT NULL,
  `Estado` int NOT NULL DEFAULT '1',
  `FechaDesembolso` datetime DEFAULT NULL,
  `UsuarioDesembolso` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `DocContrato` int NOT NULL DEFAULT '0',
  `ImprimirPlanPagos` int NOT NULL DEFAULT '0',
  `ImprimirGarantia` int NOT NULL DEFAULT '0',
  `TipoObservacion` int NOT NULL DEFAULT '0',
  `Documentos` int NOT NULL DEFAULT '0',
  `Cronograma` int DEFAULT '0',
  `Archivada` int NOT NULL DEFAULT '0',
  `Observaciones` text COLLATE utf8mb4_general_ci,
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcreditosconfiguracion`
--

CREATE TABLE `tblcreditosconfiguracion` (
  `InteresesMensuales` decimal(10,2) NOT NULL DEFAULT '0.00',
  `RecargoMora` decimal(10,2) NOT NULL DEFAULT '0.00',
  `AplicarRecargoMoratorio` int NOT NULL DEFAULT '1',
  `ComisionDesembolso` decimal(10,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcreditosdocumentos`
--

CREATE TABLE `tblcreditosdocumentos` (
  `UUIDDocumento` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `FechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `DUI` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TipoDeDocumento` int NOT NULL DEFAULT '0',
  `NombreArchivo` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcreditospagos`
--

CREATE TABLE `tblcreditospagos` (
  `UUIDPago` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `CodigoPAGO` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodigoCRE` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `UUIDTerminal` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `IDCobrador` int DEFAULT '0',
  `UltimaFechaPago` date DEFAULT NULL,
  `SaldoActual` decimal(10,2) NOT NULL DEFAULT '0.00',
  `MontoAbono` decimal(10,2) NOT NULL DEFAULT '0.00',
  `SeguroDeuda` decimal(10,2) NOT NULL DEFAULT '0.00',
  `RecargoMora` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Capital` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Interes` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TipoCobro` int NOT NULL DEFAULT '0',
  `FormaPago` int NOT NULL DEFAULT '1',
  `ReferenciaPago` varchar(500) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NuevoSaldo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Estado` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcronogramadepagos`
--

CREATE TABLE `tblcronogramadepagos` (
  `UUIDCuota` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CodigoCRE` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `NoCorrelativo` int DEFAULT NULL,
  `FechaPago` date DEFAULT NULL,
  `Cuota` decimal(10,2) DEFAULT NULL,
  `SaldoCuota` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Capital` decimal(10,2) DEFAULT NULL,
  `Interes` decimal(10,2) DEFAULT NULL,
  `SeguroDeuda` decimal(10,2) DEFAULT NULL,
  `Saldo` decimal(10,2) DEFAULT NULL,
  `Estado` varchar(200) COLLATE utf8mb4_general_ci DEFAULT 'Pendiente',
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcurrency`
--

CREATE TABLE `tblcurrency` (
  `idcurrency` int NOT NULL,
  `CurrencyISO` varchar(3) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Language` varchar(3) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `CurrencyName` varchar(35) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Money` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Symbol` varchar(3) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbldepartamentos`
--

CREATE TABLE `tbldepartamentos` (
  `UUIDDepartamento` int NOT NULL,
  `CodigoMH` varchar(100) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Departamento` varchar(50) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbldetalleformasdepagos`
--

CREATE TABLE `tbldetalleformasdepagos` (
  `UUIDPagoRecibido` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `UUIDVenta` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `TipoDePago` int NOT NULL DEFAULT '0',
  `Monto` decimal(10,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbldistritos`
--

CREATE TABLE `tbldistritos` (
  `UUIDDistrito` int NOT NULL,
  `UUIDMunicipio` int DEFAULT NULL,
  `UUIDDepartamento` int DEFAULT NULL,
  `Distrito` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbleventoanulacion`
--

CREATE TABLE `tbleventoanulacion` (
  `UUIDEventoANU` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `CodigoEVEN` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDSucursal` varchar(10) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `VersionJSON` int NOT NULL DEFAULT '0',
  `Ambiente` varchar(10) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `CodigoDeGeneracion` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `SelloDeRecepcion` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `FechaAnulacion` date DEFAULT NULL,
  `HoraAnulacion` time DEFAULT NULL,
  `TipoDTE` varchar(10) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `CodigoDeGeneracionEmitido` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `SelloDeRecepcionEmitido` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `NumeroDeControlEmitido` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `FechaEmision` date DEFAULT NULL,
  `MontoIVA` decimal(10,2) NOT NULL DEFAULT '0.00',
  `MontoDTE` decimal(10,2) NOT NULL DEFAULT '0.00',
  `CodigoDeGeneracionR` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `TipoDocReceptor` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `NumeroDocReceptor` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `NombreReceptor` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `TipoDeAnulacion` int NOT NULL DEFAULT '0',
  `MotivoAnulacion` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `TipoDocResponsable` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `NumeroDocResponsable` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `NombreResponsable` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `TipoDocSolicitante` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `NumeroDocSolicitante` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `NombreSolicitante` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `FechaUpdate` date DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `Estado` int NOT NULL DEFAULT '1',
  `Token` text COLLATE utf8mb4_spanish2_ci,
  `JSONGenerado` text COLLATE utf8mb4_spanish2_ci,
  `JSONFirmado` text COLLATE utf8mb4_spanish2_ci,
  `RespuestaMH` text COLLATE utf8mb4_spanish2_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbleventocontingencia`
--

CREATE TABLE `tbleventocontingencia` (
  `UUIDEventoCON` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `CodigoEVEN` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDNegocio` int NOT NULL DEFAULT '1',
  `UUIDSucursal` varchar(10) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `Version` int NOT NULL DEFAULT '0',
  `Ambiente` varchar(10) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `CodigoDeGeneracion` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `SelloDeRecepcion` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `FechaDeTransmision` date DEFAULT NULL,
  `HoraTransmision` time DEFAULT NULL,
  `NombreResponsable` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `TipoDocResponsable` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `NumeroDocResponsable` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `FechaInicio` date DEFAULT NULL,
  `FechaFin` date DEFAULT NULL,
  `HoraInicio` time DEFAULT NULL,
  `HoraFin` time DEFAULT NULL,
  `TipoContingencia` int NOT NULL DEFAULT '0',
  `MotivoContingencia` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `FechaUpdate` date DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `Estado` int NOT NULL DEFAULT '1',
  `Token` text COLLATE utf8mb4_spanish2_ci,
  `JSONGenerado` text COLLATE utf8mb4_spanish2_ci,
  `JSONFirmado` text COLLATE utf8mb4_spanish2_ci,
  `RespuestaMH` text COLLATE utf8mb4_spanish2_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbleventocontingenciadetalle`
--

CREATE TABLE `tbleventocontingenciadetalle` (
  `UUIDDetalleCON` varchar(200) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `UUIDEventoCON` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `NoItem` int NOT NULL DEFAULT '0',
  `TipoDTE` varchar(10) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `CodigoDeGeneracion` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblmodulosacceso`
--

CREATE TABLE `tblmodulosacceso` (
  `Codigo` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `NombreModulo` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `Descripcion` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `Estado` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblmovimientodeefectivo`
--

CREATE TABLE `tblmovimientodeefectivo` (
  `UUIDMovimiento` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `CodigoMOV` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDSucursal` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDTerminal` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `TipoMovimiento` int NOT NULL DEFAULT '1',
  `TerminalOrigen` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `TerminalDestino` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDEntrega` int NOT NULL DEFAULT '0',
  `EmpleadoEntrega` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDRecibe` int NOT NULL DEFAULT '0',
  `EmpleadoRecibe` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `Monto` decimal(10,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblmunicipios`
--

CREATE TABLE `tblmunicipios` (
  `UUIDDepartamento` int DEFAULT NULL,
  `UUIDMunicipio` int NOT NULL,
  `CodigoMH` varchar(100) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `Municipio` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblnegocios`
--

CREATE TABLE `tblnegocios` (
  `UUIDNegocio` int NOT NULL,
  `CodigoNEG` varchar(10) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NombreNegocio` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `IDRubro` int NOT NULL,
  `Estado` int NOT NULL DEFAULT '1',
  `ClavePrivada` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `ClavePublica` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `ClaveAPI` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Ambiente` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL DEFAULT '00',
  `URLFirmador` text COLLATE utf8mb3_spanish2_ci,
  `URLAutenticacion` text COLLATE utf8mb3_spanish2_ci,
  `URLRecepcion` text COLLATE utf8mb3_spanish2_ci,
  `URLRecepcionLOTE` text COLLATE utf8mb3_spanish2_ci,
  `URLConsultarDTE` text COLLATE utf8mb3_spanish2_ci,
  `URLContingencia` text COLLATE utf8mb3_spanish2_ci,
  `URLAnularDTE` text COLLATE utf8mb3_spanish2_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblnotasdeentrega`
--

CREATE TABLE `tblnotasdeentrega` (
  `UUIDVenta` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `CodigoVEN` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaFacturacion` date DEFAULT NULL,
  `FechaEnvio` datetime DEFAULT NULL,
  `FechaEntrega` datetime DEFAULT NULL,
  `NoAnualCorrelativo` int NOT NULL DEFAULT '0',
  `FechaHoraGeneracion` datetime DEFAULT NULL,
  `Ambiente` varchar(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TipoContingencia` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `MotivoContingencia` text COLLATE utf8mb3_spanish2_ci,
  `TipoMoneda` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodDocumento` varchar(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL DEFAULT '01',
  `NoCorrelativo` int NOT NULL DEFAULT '0',
  `VersionDTE` int NOT NULL DEFAULT '1',
  `CodigoDeGeneracion` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NumeroDeControl` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `SelloDeRecepcion` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `ModeloDeFacturacion` int NOT NULL DEFAULT '1',
  `TipoDeTransmision` int NOT NULL DEFAULT '1',
  `UUIDSucursal` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UUIDCaja` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UUIDOperador` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Operador` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UUIDVendedor` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodEstablecimiento` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodEstablecimientoMH` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodPuntoVenta` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodPuntoVentaMH` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TipoDespacho` int NOT NULL DEFAULT '1',
  `Repartidor` int DEFAULT '0',
  `Carga` int DEFAULT '0',
  `Condicion` int DEFAULT '1',
  `Plazo` int DEFAULT '0',
  `FechaVencimiento` date DEFAULT NULL,
  `SaldoActual` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Abonos` decimal(10,2) NOT NULL DEFAULT '0.00',
  `CodigoCLI` varchar(100) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NombreDeCliente` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NombreComercial` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodigoActividad` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Actividad` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Direccion` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `IDDepartamento` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Departamento` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `IDMunicipio` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Municipio` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `IDDistrito` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Distrito` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `DUI` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NRC` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NIT` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TelMovilWhatsApp` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CorreoElectronico` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TipoDocumentoReceptor` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NumeroDocumentoReceptor` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TelefonoReceptor` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodActividadReceptor` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `DocumentoRelacionado` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci,
  `Notas` text COLLATE utf8mb3_spanish2_ci,
  `TotalCosto` decimal(10,2) DEFAULT '0.00',
  `TotalImporte` decimal(10,2) DEFAULT '0.00',
  `PagoTarjeta` decimal(10,2) NOT NULL DEFAULT '0.00',
  `PagoCheque` decimal(10,2) NOT NULL DEFAULT '0.00',
  `PagoElectronico` decimal(10,2) NOT NULL DEFAULT '0.00',
  `PagoVale` decimal(10,2) NOT NULL DEFAULT '0.00',
  `PagoGiftCard` decimal(10,2) NOT NULL DEFAULT '0.00',
  `PagoEfectivo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `PagoRecibido` decimal(10,2) DEFAULT '0.00',
  `Cambio` decimal(10,2) DEFAULT '0.00',
  `PagoContado` decimal(10,2) NOT NULL DEFAULT '0.00',
  `NumeroComprobante` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Estado` int DEFAULT '1',
  `Para` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `DireccionEnvio` text COLLATE utf8mb3_spanish2_ci,
  `Contacto` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Cancelada` int DEFAULT '0',
  `DescuentosNoSujetas` decimal(10,2) NOT NULL DEFAULT '0.00',
  `DescuentosExentas` decimal(10,2) NOT NULL DEFAULT '0.00',
  `DescuentosGravadas` decimal(10,2) NOT NULL DEFAULT '0.00',
  `NumPagoElectronico` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `PorcentajeDescuento` decimal(10,2) NOT NULL DEFAULT '0.00',
  `SaldoFavor` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalDescuentos` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalNoSujetas` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalExentas` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalGravadas` decimal(10,2) NOT NULL DEFAULT '0.00',
  `SubTotal` decimal(10,2) DEFAULT '0.00',
  `TotalIVA` decimal(10,2) NOT NULL DEFAULT '0.00',
  `SubTotalVentas` decimal(10,2) NOT NULL DEFAULT '0.00',
  `IVAPercibido` decimal(10,2) NOT NULL DEFAULT '0.00',
  `IVARetencion` decimal(10,2) NOT NULL DEFAULT '0.00',
  `RetencionRenta` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalLetras` varchar(500) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Tributos` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci,
  `TotalNoGravado` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalOperacion` decimal(10,2) NOT NULL DEFAULT '0.00',
  `descuSE` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalPagar` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Anulada` int DEFAULT '0',
  `NotasDespacho` text COLLATE utf8mb3_spanish2_ci,
  `Mensaje` mediumtext COLLATE utf8mb3_spanish2_ci,
  `FechaUpdate` date DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Token` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci,
  `JSONGenerado` text COLLATE utf8mb3_spanish2_ci,
  `JSONFirmado` text COLLATE utf8mb3_spanish2_ci,
  `RespuestaMH` text COLLATE utf8mb3_spanish2_ci,
  `Entregado` int NOT NULL DEFAULT '0',
  `RespuestaMHAnulacion` text COLLATE utf8mb3_spanish2_ci,
  `RespuestaCORREO` text COLLATE utf8mb3_spanish2_ci,
  `MensajePublicitario` varchar(500) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblnotasdeentregadetalle`
--

CREATE TABLE `tblnotasdeentregadetalle` (
  `UUIDDetalleVenta` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `UUIDVenta` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NumeroDocumento` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NoItem` int NOT NULL DEFAULT '0',
  `TipoDeItem` int DEFAULT '1',
  `CodigoPROD` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodigoBarra` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Concepto` text COLLATE utf8mb3_spanish2_ci,
  `TV` int NOT NULL DEFAULT '1',
  `UnidadDeMedida` int NOT NULL DEFAULT '99',
  `Cantidad` decimal(10,4) DEFAULT '0.0000',
  `UnidadesVendidas` int NOT NULL DEFAULT '0',
  `PrecioVenta` decimal(10,4) DEFAULT '0.0000',
  `PrecioVentaSinImpuesto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `PrecioNormal` decimal(10,2) DEFAULT '0.00',
  `PrecioSugeridoVenta` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Descuento` decimal(10,2) DEFAULT '0.00',
  `VentaNoSujeta` decimal(10,2) NOT NULL DEFAULT '0.00',
  `VentaExenta` decimal(10,2) NOT NULL DEFAULT '0.00',
  `VentaGravada` decimal(10,2) NOT NULL DEFAULT '0.00',
  `VentaGravadaSinImpuesto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `TotalImporte` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalOperacion` decimal(10,2) NOT NULL DEFAULT '0.00',
  `IVAItem` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `PrecioCosto` decimal(10,2) DEFAULT '0.00',
  `TotalCosto` decimal(10,2) NOT NULL DEFAULT '0.00',
  `PagaImpuesto` int NOT NULL DEFAULT '1',
  `PorcentajeImpuesto` decimal(10,2) NOT NULL DEFAULT '0.00',
  `CodigoTributo` varchar(10) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Tributo` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblplanesdecreditos`
--

CREATE TABLE `tblplanesdecreditos` (
  `UUIDPlanCredito` int NOT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `TipoPlan` int NOT NULL DEFAULT '1',
  `DescripcionPlan` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `TasaInteresMensual` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TasaInteresMora` decimal(10,2) NOT NULL DEFAULT '0.00',
  `ComisionDesembolso` decimal(10,2) NOT NULL DEFAULT '0.00',
  `PrimaObligatoria` decimal(10,2) NOT NULL DEFAULT '0.00',
  `SeguroDeuda` decimal(10,2) NOT NULL DEFAULT '0.00',
  `PlazoMaximo` int NOT NULL DEFAULT '12'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblproductossucursal`
--

CREATE TABLE `tblproductossucursal` (
  `UUID` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `UUIDSucursal` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodigoPROD` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `Existencia` decimal(10,2) DEFAULT '0.00',
  `Estado` int NOT NULL DEFAULT '1',
  `Inventariado` int NOT NULL DEFAULT '0',
  `FechaInventariado` datetime DEFAULT NULL,
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblregistrodecargosanticipos`
--

CREATE TABLE `tblregistrodecargosanticipos` (
  `UUIDCargo` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `CodigoCAR` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDSucursal` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDTerminal` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `Tipo` int NOT NULL DEFAULT '1',
  `UUIDAutoriza` int NOT NULL DEFAULT '0',
  `EmpleadoAutoriza` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDEmpleado` int NOT NULL DEFAULT '0',
  `EmpleadoRecibe` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `Monto` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Concepto` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblregistrodecompras`
--

CREATE TABLE `tblregistrodecompras` (
  `UUIDCompra` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `CodigoCOM` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaCompra` date DEFAULT NULL,
  `CodDocumento` varchar(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL DEFAULT '03',
  `CodigoDeGeneracion` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NumeroDeControl` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UUIDNegocio` varchar(100) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UUIDSucursal` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Condicion` int DEFAULT '1',
  `Plazo` int DEFAULT '0',
  `FechaVencimiento` date DEFAULT NULL,
  `SaldoActual` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Abonos` decimal(10,2) NOT NULL DEFAULT '0.00',
  `DocProveedor` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodigoPRO` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NombreDeProveedor` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Notas` text COLLATE utf8mb3_spanish2_ci,
  `Estado` int DEFAULT '1',
  `Cancelada` int DEFAULT '0',
  `TotalOperacion` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalDescuentos` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalIVA` decimal(10,2) NOT NULL DEFAULT '0.00',
  `SubTotal` decimal(10,2) DEFAULT '0.00',
  `IVAPercibido` decimal(10,2) NOT NULL DEFAULT '0.00',
  `IVARetencion` decimal(10,2) NOT NULL DEFAULT '0.00',
  `RetencionRenta` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalOtrosMontos` decimal(10,2) DEFAULT '0.00',
  `TotalPagar` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Anulada` int DEFAULT '0',
  `FechaUpdate` date DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblregistrodecomprasdetalle`
--

CREATE TABLE `tblregistrodecomprasdetalle` (
  `UUIDDetalleCompra` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL,
  `UUIDCompra` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NumeroDocumento` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NoItem` int NOT NULL DEFAULT '0',
  `TipoDeItem` int DEFAULT '1',
  `CodigoPROD` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodigoBarra` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Concepto` text COLLATE utf8mb3_spanish2_ci,
  `TV` int NOT NULL DEFAULT '1',
  `UnidadDeMedida` int NOT NULL DEFAULT '99',
  `Cantidad` decimal(10,4) DEFAULT '0.0000',
  `UnidadesVendidas` int NOT NULL DEFAULT '0',
  `PrecioVenta` decimal(10,4) DEFAULT '0.0000',
  `PrecioVentaSinImpuesto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `PrecioNormal` decimal(10,2) DEFAULT '0.00',
  `PrecioSugeridoVenta` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Descuento` decimal(10,2) DEFAULT '0.00',
  `VentaNoSujeta` decimal(10,2) NOT NULL DEFAULT '0.00',
  `VentaExenta` decimal(10,2) NOT NULL DEFAULT '0.00',
  `VentaGravada` decimal(10,2) NOT NULL DEFAULT '0.00',
  `VentaGravadaSinImpuesto` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `TotalImporte` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TotalOperacion` decimal(10,2) NOT NULL DEFAULT '0.00',
  `IVAItem` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `PrecioCosto` decimal(10,2) DEFAULT '0.00',
  `TotalCosto` decimal(10,2) NOT NULL DEFAULT '0.00',
  `PagaImpuesto` int NOT NULL DEFAULT '1',
  `PorcentajeImpuesto` decimal(10,2) NOT NULL DEFAULT '0.00',
  `CodigoTributo` varchar(10) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Tributo` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblregistrodeegresos`
--

CREATE TABLE `tblregistrodeegresos` (
  `UUIDEgreso` varchar(200) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `CodigoEGR` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDSucursal` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDTerminal` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDAutoriza` int NOT NULL DEFAULT '0',
  `EmpleadoAutoriza` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `IDCategoria` int NOT NULL DEFAULT '0',
  `Monto` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Concepto` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `ImgComprobante` varchar(100) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `Estado` int NOT NULL DEFAULT '1',
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblregistrodeempleados`
--

CREATE TABLE `tblregistrodeempleados` (
  `UUIDEmpleado` int NOT NULL,
  `CodigoEMP` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UUIDNegocio` int DEFAULT '0',
  `ModuloAcceso` varchar(20) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Nombres` varchar(50) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Apellidos` varchar(50) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TipoEmpleado` int DEFAULT '0',
  `TipoContrato` int DEFAULT '0',
  `Sexo` int DEFAULT '0',
  `EstadoCivil` varchar(50) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `ProfesionOficio` varchar(100) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Nacionalidad` varchar(50) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `IDArea` int DEFAULT '0',
  `IDCargo` int NOT NULL DEFAULT '0',
  `Cargo` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Iniciales` varchar(25) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaNacimiento` datetime DEFAULT NULL,
  `FechaIngreso` datetime DEFAULT NULL,
  `FechaContratacion` datetime DEFAULT NULL,
  `FechaBaja` datetime DEFAULT NULL,
  `Direccion` varchar(255) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Departamento` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Municipio` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Distrito` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TelMovil` varchar(10) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TelFijo` varchar(10) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CorreoElectronico` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Foto` varchar(255) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Notas` mediumtext COLLATE utf8mb3_spanish2_ci,
  `Jefe` int DEFAULT '0',
  `DUI` varchar(50) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NIT` varchar(50) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `ISSS` varchar(50) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `IDAFP` int DEFAULT '0',
  `AFP` varchar(50) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FormaDePago` int DEFAULT '0',
  `SueldoBase` decimal(10,2) DEFAULT '0.00',
  `PagoDiario` decimal(10,2) DEFAULT '0.00',
  `Incentivo` decimal(10,2) DEFAULT '0.00',
  `MontoMeta1` decimal(10,2) DEFAULT '0.00',
  `MontoMeta2` decimal(10,2) DEFAULT '0.00',
  `MontoMeta3` decimal(10,2) DEFAULT '0.00',
  `ComisionMeta1` decimal(10,2) DEFAULT '0.00',
  `ComisionMeta2` decimal(10,2) DEFAULT '0.00',
  `ComisionMeta3` decimal(10,2) DEFAULT '0.00',
  `Estado` int DEFAULT '1',
  `Observaciones` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `RecibeAnticipos` int NOT NULL DEFAULT '0',
  `MarcarAsistencia` int NOT NULL DEFAULT '0',
  `CodigoAutorizacion` varchar(10) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `RespuestaCORREO` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NombreUsuario` varchar(50) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `ClaveAcceso` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CambiarClave` int NOT NULL DEFAULT '0',
  `UpdateClaveAcceso` datetime DEFAULT NULL,
  `Asignacion` int DEFAULT NULL,
  `Comision` decimal(10,2) DEFAULT '0.00',
  `PagaSeguro` int DEFAULT '0',
  `PorcentajeSeguro` decimal(10,2) DEFAULT '0.00',
  `PagaPension` int DEFAULT '0',
  `PorcentajePension` decimal(10,2) DEFAULT '0.00',
  `PagaRenta` int DEFAULT '0',
  `PorcentajeRenta` decimal(10,2) DEFAULT '0.00',
  `OtrasDeducciones` decimal(10,2) DEFAULT '0.00',
  `TipoPago` int DEFAULT '0',
  `CuentaBancariaNo` varchar(100) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `InstitucionBancaria` varchar(100) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `mensajes` int NOT NULL DEFAULT '0',
  `compras` int NOT NULL DEFAULT '0',
  `compras-1` int NOT NULL DEFAULT '0',
  `compras-2` int NOT NULL DEFAULT '0',
  `compras-3` int NOT NULL DEFAULT '0',
  `compras-3-1` int NOT NULL DEFAULT '0',
  `compras-3-2` int NOT NULL DEFAULT '0',
  `ventas` int NOT NULL DEFAULT '0',
  `ventas-1` int NOT NULL DEFAULT '0',
  `ventas-1-1` int NOT NULL DEFAULT '0',
  `ventas-1-2` int NOT NULL DEFAULT '0',
  `ventas-1-3` int NOT NULL DEFAULT '0',
  `ventas-1-4` int NOT NULL DEFAULT '0',
  `ventas-2` int NOT NULL DEFAULT '0',
  `ventas-3` int NOT NULL DEFAULT '0',
  `ventas-3-1` int NOT NULL DEFAULT '0',
  `ventas-3-2` int NOT NULL DEFAULT '0',
  `ventas-4` int NOT NULL DEFAULT '0',
  `ventas-4-1` int NOT NULL DEFAULT '0',
  `ventas-4-2` int NOT NULL DEFAULT '0',
  `ventas-4-3` int NOT NULL DEFAULT '0',
  `ventas-4-4` int NOT NULL DEFAULT '0',
  `ventas-4-5` int NOT NULL DEFAULT '0',
  `ventas-4-6` int NOT NULL DEFAULT '0',
  `facturacion` int NOT NULL DEFAULT '0',
  `facturacion-1` int NOT NULL DEFAULT '0',
  `facturacion-2` int NOT NULL DEFAULT '0',
  `facturacion-3` int NOT NULL DEFAULT '0',
  `facturacion-4` int NOT NULL DEFAULT '0',
  `facturacion-5` int NOT NULL DEFAULT '0',
  `facturacion-6` int NOT NULL DEFAULT '0',
  `facturacion-7` int NOT NULL DEFAULT '0',
  `controles` int NOT NULL DEFAULT '0',
  `controles-1` int NOT NULL DEFAULT '0',
  `controles-2` int NOT NULL DEFAULT '0',
  `controles-3` int NOT NULL DEFAULT '0',
  `controles-4` int NOT NULL DEFAULT '0',
  `controles-5` int NOT NULL DEFAULT '0',
  `controles-6` int NOT NULL DEFAULT '0',
  `controles-7` int NOT NULL DEFAULT '0',
  `controles-8` int NOT NULL DEFAULT '0',
  `controles-9` int NOT NULL DEFAULT '0',
  `controles-10` int NOT NULL DEFAULT '0',
  `controles-11` int NOT NULL DEFAULT '0',
  `controles-12` int NOT NULL DEFAULT '0',
  `controles-13` int NOT NULL DEFAULT '0',
  `creditos` int NOT NULL DEFAULT '0',
  `creditos-1` int NOT NULL DEFAULT '0',
  `creditos-2` int NOT NULL DEFAULT '0',
  `supervision` int NOT NULL DEFAULT '0',
  `supervision-1` int NOT NULL DEFAULT '0',
  `supervision-2` int NOT NULL DEFAULT '0',
  `corresponsal` int NOT NULL DEFAULT '0',
  `corresponsal-1` int NOT NULL DEFAULT '0',
  `corresponsal-2` int NOT NULL DEFAULT '0',
  `recargas` int NOT NULL DEFAULT '0',
  `recargas-1` int NOT NULL DEFAULT '0',
  `recargas-2` int NOT NULL DEFAULT '0',
  `inventario` int NOT NULL DEFAULT '0',
  `inventario-1` int NOT NULL DEFAULT '0',
  `inventario-1-1` int NOT NULL DEFAULT '0',
  `inventario-1-2` int NOT NULL DEFAULT '0',
  `inventario-2` int NOT NULL DEFAULT '0',
  `inventario-2-1` int NOT NULL DEFAULT '0',
  `inventario-2-2` int NOT NULL DEFAULT '0',
  `inventario-3` int NOT NULL DEFAULT '0',
  `inventario-4` int NOT NULL DEFAULT '0',
  `inventario-5` int NOT NULL DEFAULT '0',
  `inventario-6` int NOT NULL DEFAULT '0',
  `inventario-6-1` int NOT NULL DEFAULT '0',
  `inventario-6-2` int NOT NULL DEFAULT '0',
  `proveedores` int NOT NULL DEFAULT '0',
  `proveedores-1` int NOT NULL DEFAULT '0',
  `proveedores-2` int NOT NULL DEFAULT '0',
  `proveedores-3` int NOT NULL DEFAULT '0',
  `proveedores-3-1` int NOT NULL DEFAULT '0',
  `proveedores-3-2` int NOT NULL DEFAULT '0',
  `clientes` int NOT NULL DEFAULT '0',
  `clientes-1` int NOT NULL DEFAULT '0',
  `clientes-2` int DEFAULT '0',
  `clientes-2-1` int NOT NULL DEFAULT '0',
  `clientes-2-2` int NOT NULL DEFAULT '0',
  `clientes-2-3` int NOT NULL DEFAULT '0',
  `clientes-2-4` int NOT NULL DEFAULT '0',
  `clientes-2-5` int NOT NULL DEFAULT '0',
  `clientes-3` int NOT NULL DEFAULT '0',
  `cuentas` int NOT NULL DEFAULT '0',
  `cuentas-1` int NOT NULL DEFAULT '0',
  `cuentas-2` int NOT NULL DEFAULT '0',
  `contabilidad` int NOT NULL DEFAULT '0',
  `contabilidad-1` int NOT NULL DEFAULT '0',
  `contabilidad-2` int NOT NULL DEFAULT '0',
  `herramientas` int NOT NULL DEFAULT '0',
  `herramientas-1` int NOT NULL DEFAULT '0',
  `herramientas-1-1` int NOT NULL DEFAULT '0',
  `herramientas-1-2` int NOT NULL DEFAULT '0',
  `herramientas-2` int NOT NULL DEFAULT '0',
  `herramientas-3` int NOT NULL DEFAULT '0',
  `herramientas-4` int NOT NULL DEFAULT '0',
  `herramientas-5` int NOT NULL DEFAULT '0',
  `herramientas-6` int NOT NULL DEFAULT '0',
  `herramientas-7` int NOT NULL DEFAULT '0',
  `mantenimiento` int NOT NULL DEFAULT '0',
  `mantenimiento-1` int NOT NULL DEFAULT '0',
  `mantenimiento-1-1` int NOT NULL DEFAULT '0',
  `mantenimiento-1-2` int NOT NULL DEFAULT '0',
  `mantenimiento-2` int NOT NULL DEFAULT '0',
  `marcacion` int NOT NULL DEFAULT '0',
  `marcacion-1` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblregistrodeingresos`
--

CREATE TABLE `tblregistrodeingresos` (
  `UUIDIngreso` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `CodigoING` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDSucursal` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDTerminal` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `Monto` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Concepto` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblregistrodemarcacion`
--

CREATE TABLE `tblregistrodemarcacion` (
  `UUIDMarcacion` varchar(200) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `CodigoMAR` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDEmpleado` int NOT NULL DEFAULT '0',
  `Colaborador` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDSucursal` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `Turno` int NOT NULL DEFAULT '1',
  `TipoMovimiento` int NOT NULL DEFAULT '0',
  `FechaMarcacion` date DEFAULT NULL,
  `HoraDeEntrada` time DEFAULT NULL,
  `HoraDeSalida` time DEFAULT NULL,
  `HoraDeControl` time DEFAULT NULL,
  `Estado` int NOT NULL DEFAULT '0',
  `Accion` int NOT NULL DEFAULT '0',
  `UsuarioUpdate` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `FechaUpdate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblregistrodepagoscaja`
--

CREATE TABLE `tblregistrodepagoscaja` (
  `UUIDPago` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL,
  `CodigoPAG` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDSucursal` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDTerminal` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDProveedor` int NOT NULL DEFAULT '0',
  `Proveedor` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `UUIDAutoriza` int NOT NULL DEFAULT '0',
  `EmpleadoAutoriza` varchar(100) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `Concepto` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `Monto` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Estado` int NOT NULL DEFAULT '1',
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblregistrodesucesos`
--

CREATE TABLE `tblregistrodesucesos` (
  `UUIDSuceso` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `CodigoSUC` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UUIDSucursal` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Suceso` text COLLATE utf8mb3_spanish2_ci,
  `DetalleSuceso` text COLLATE utf8mb3_spanish2_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblregistrodesucesoscnb`
--

CREATE TABLE `tblregistrodesucesoscnb` (
  `UUIDSuceso` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `CodigoSUC` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UUIDSucursal` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Suceso` text COLLATE utf8mb3_spanish2_ci,
  `DetalleSuceso` text COLLATE utf8mb3_spanish2_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblregistrodesucesosrecarga`
--

CREATE TABLE `tblregistrodesucesosrecarga` (
  `UUIDSuceso` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `CodigoSUC` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UUIDSucursal` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Suceso` text COLLATE utf8mb3_spanish2_ci,
  `DetalleSuceso` text COLLATE utf8mb3_spanish2_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblsucursales`
--

CREATE TABLE `tblsucursales` (
  `UUIDSucursal` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `FechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` text COLLATE utf8mb3_spanish2_ci,
  `UUIDNegocio` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Negocio` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Codigo` varchar(6) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `Tipo` int NOT NULL DEFAULT '0',
  `Numero` int NOT NULL DEFAULT '0',
  `Sucursal` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `RazonSocial` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TipoEstablecimiento` varchar(10) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Direccion` varchar(255) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodDepartamento` int DEFAULT '0',
  `Departamento` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodMunicipio` int DEFAULT '0',
  `Municipio` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodActividad` varchar(10) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `DescripcionActividad` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodEstablecimiento` varchar(10) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodEstablecimientoMH` varchar(10) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NIT` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `NRC` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `DUI` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Telefono` text COLLATE utf8mb3_spanish2_ci,
  `TelWhatsApp` varchar(10) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CorreoElectronico` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `FechaInicio` date DEFAULT NULL,
  `TipoMoneda` varchar(10) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `MontoCNB` decimal(13,2) NOT NULL DEFAULT '0.00',
  `SaldoRecarga` decimal(13,2) NOT NULL DEFAULT '0.00',
  `UpdateMontoCNB` datetime DEFAULT NULL,
  `UpdateSaldoRecarga` datetime DEFAULT NULL,
  `UsuarioSucursal` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `ClaveAcceso` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UpdateClaveAcceso` datetime DEFAULT NULL,
  `MensajePublicitario` varchar(500) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `VerificarToken` int NOT NULL DEFAULT '0',
  `VenderPorDomicilio` int NOT NULL DEFAULT '0',
  `VenderPorDespacho` int NOT NULL DEFAULT '0',
  `UltimoNumFactura` int NOT NULL DEFAULT '0',
  `UltimoNumCreditoFiscal` int NOT NULL DEFAULT '0',
  `UltimoNumNotaDeCredito` int NOT NULL DEFAULT '0',
  `UltimoNumSujetoExcluido` int NOT NULL DEFAULT '0',
  `Estado` int NOT NULL DEFAULT '0',
  `CodigoEmpresa` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `AmbienteDTE` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci NOT NULL DEFAULT '01',
  `TokenTransmision` text COLLATE utf8mb3_spanish2_ci,
  `FechaUpdateToken` datetime DEFAULT NULL,
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblterminales`
--

CREATE TABLE `tblterminales` (
  `UUIDTerminal` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `UUIDSucursal` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TipoTerminal` int NOT NULL DEFAULT '1',
  `AccesoTerminal` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Terminal` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `NoTerminal` varchar(50) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodPuntoVenta` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodPuntoVentaMH` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UsuarioTerminal` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `ClaveAcceso` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `PIN` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Remanente` decimal(10,2) NOT NULL DEFAULT '0.00',
  `UpdateRemanente` datetime DEFAULT NULL,
  `TransmitirDTE` int NOT NULL DEFAULT '0',
  `VerificarToken` int NOT NULL DEFAULT '0',
  `DespachoPorDomicilio` int NOT NULL DEFAULT '0',
  `DespachoPorRuta` int NOT NULL DEFAULT '0',
  `Estado` int NOT NULL DEFAULT '1',
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbltipodecontingencia`
--

CREATE TABLE `tbltipodecontingencia` (
  `Codigo` int NOT NULL,
  `Descripcion` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbltipodedocumentos`
--

CREATE TABLE `tbltipodedocumentos` (
  `Codigo` varchar(10) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `Valor` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `VersionDTE` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbltiposdecontingencia`
--

CREATE TABLE `tbltiposdecontingencia` (
  `Codigo` int NOT NULL DEFAULT '0',
  `Valor` varchar(200) COLLATE utf8mb4_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbltokendispositivos`
--

CREATE TABLE `tbltokendispositivos` (
  `UUIDTokenAcceso` varchar(255) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `FechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  `UsuarioRegistro` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `TipoAcceso` varchar(11) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `UUIDSucursal` varchar(200) COLLATE utf8mb3_spanish2_ci NOT NULL,
  `UUID` varchar(255) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `CodigoToken` varchar(255) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Dispositivo` varchar(255) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `Vencimiento` date NOT NULL,
  `FechaUpdate` datetime DEFAULT NULL,
  `UsuarioUpdate` varchar(200) COLLATE utf8mb3_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tblareas`
--
ALTER TABLE `tblareas`
  ADD PRIMARY KEY (`IDArea`);

--
-- Indices de la tabla `tblcargosdeempleados`
--
ALTER TABLE `tblcargosdeempleados`
  ADD PRIMARY KEY (`IDCargo`);

--
-- Indices de la tabla `tblcatalogodeactividades`
--
ALTER TABLE `tblcatalogodeactividades`
  ADD PRIMARY KEY (`IDActividad`);

--
-- Indices de la tabla `tblcatalogodecategorias`
--
ALTER TABLE `tblcatalogodecategorias`
  ADD PRIMARY KEY (`IDCategoria`);

--
-- Indices de la tabla `tblcatalogodeclientes`
--
ALTER TABLE `tblcatalogodeclientes`
  ADD PRIMARY KEY (`UUIDCliente`);

--
-- Indices de la tabla `tblcatalogodepresentaciones`
--
ALTER TABLE `tblcatalogodepresentaciones`
  ADD PRIMARY KEY (`IDPresentacion`);

--
-- Indices de la tabla `tblcatalogodeproductos`
--
ALTER TABLE `tblcatalogodeproductos`
  ADD PRIMARY KEY (`UUIDProducto`),
  ADD KEY `UUIDNegocio` (`UUIDNegocio`),
  ADD KEY `CodigoPROD` (`CodigoPROD`),
  ADD KEY `Descripcion` (`Descripcion`);

--
-- Indices de la tabla `tblcatalogodeproductostemporal`
--
ALTER TABLE `tblcatalogodeproductostemporal`
  ADD PRIMARY KEY (`UUIDProducto`);

--
-- Indices de la tabla `tblcatalogodeproveedores`
--
ALTER TABLE `tblcatalogodeproveedores`
  ADD PRIMARY KEY (`UUIDProveedor`);

--
-- Indices de la tabla `tblcategoriagastos`
--
ALTER TABLE `tblcategoriagastos`
  ADD PRIMARY KEY (`IDCategoria`);

--
-- Indices de la tabla `tblcodigosdebarras`
--
ALTER TABLE `tblcodigosdebarras`
  ADD PRIMARY KEY (`UUIDBarra`);

--
-- Indices de la tabla `tblcontroldecajafuerte`
--
ALTER TABLE `tblcontroldecajafuerte`
  ADD PRIMARY KEY (`UUIDTraslado`);

--
-- Indices de la tabla `tblcontroldecajafuertecnb`
--
ALTER TABLE `tblcontroldecajafuertecnb`
  ADD PRIMARY KEY (`UUIDTraslado`);

--
-- Indices de la tabla `tblcontroldeofertas`
--
ALTER TABLE `tblcontroldeofertas`
  ADD PRIMARY KEY (`UUIDPromocion`);

--
-- Indices de la tabla `tblcontroldeterminales`
--
ALTER TABLE `tblcontroldeterminales`
  ADD PRIMARY KEY (`UUIDApertura`);

--
-- Indices de la tabla `tblcortesdecaja`
--
ALTER TABLE `tblcortesdecaja`
  ADD PRIMARY KEY (`UUIDCorteCaja`);

--
-- Indices de la tabla `tblcortesdecnb`
--
ALTER TABLE `tblcortesdecnb`
  ADD PRIMARY KEY (`UUIDCorteCNB`);

--
-- Indices de la tabla `tblcortesderecarga`
--
ALTER TABLE `tblcortesderecarga`
  ADD PRIMARY KEY (`UUIDCorteRecarga`);

--
-- Indices de la tabla `tblcreditos`
--
ALTER TABLE `tblcreditos`
  ADD PRIMARY KEY (`UUIDCredito`),
  ADD KEY `NoCorrelativo` (`NoCorrelativo`);

--
-- Indices de la tabla `tblcreditosdocumentos`
--
ALTER TABLE `tblcreditosdocumentos`
  ADD PRIMARY KEY (`UUIDDocumento`);

--
-- Indices de la tabla `tblcreditospagos`
--
ALTER TABLE `tblcreditospagos`
  ADD PRIMARY KEY (`UUIDPago`);

--
-- Indices de la tabla `tblcronogramadepagos`
--
ALTER TABLE `tblcronogramadepagos`
  ADD PRIMARY KEY (`UUIDCuota`);

--
-- Indices de la tabla `tblcurrency`
--
ALTER TABLE `tblcurrency`
  ADD PRIMARY KEY (`idcurrency`);

--
-- Indices de la tabla `tbldepartamentos`
--
ALTER TABLE `tbldepartamentos`
  ADD PRIMARY KEY (`UUIDDepartamento`);

--
-- Indices de la tabla `tbldetalleformasdepagos`
--
ALTER TABLE `tbldetalleformasdepagos`
  ADD PRIMARY KEY (`UUIDPagoRecibido`);

--
-- Indices de la tabla `tbldistritos`
--
ALTER TABLE `tbldistritos`
  ADD PRIMARY KEY (`UUIDDistrito`);

--
-- Indices de la tabla `tbleventoanulacion`
--
ALTER TABLE `tbleventoanulacion`
  ADD PRIMARY KEY (`UUIDEventoANU`),
  ADD KEY `CodigoEVEN` (`CodigoEVEN`),
  ADD KEY `CodigoDeGeneracion` (`CodigoDeGeneracion`),
  ADD KEY `CodigoDeGeneracionEmitido` (`CodigoDeGeneracionEmitido`);

--
-- Indices de la tabla `tbleventocontingencia`
--
ALTER TABLE `tbleventocontingencia`
  ADD PRIMARY KEY (`UUIDEventoCON`);

--
-- Indices de la tabla `tbleventocontingenciadetalle`
--
ALTER TABLE `tbleventocontingenciadetalle`
  ADD PRIMARY KEY (`UUIDDetalleCON`);

--
-- Indices de la tabla `tblmovimientodeefectivo`
--
ALTER TABLE `tblmovimientodeefectivo`
  ADD PRIMARY KEY (`UUIDMovimiento`);

--
-- Indices de la tabla `tblmunicipios`
--
ALTER TABLE `tblmunicipios`
  ADD PRIMARY KEY (`UUIDMunicipio`);

--
-- Indices de la tabla `tblnegocios`
--
ALTER TABLE `tblnegocios`
  ADD PRIMARY KEY (`UUIDNegocio`),
  ADD KEY `UUIDNegocio` (`UUIDNegocio`);

--
-- Indices de la tabla `tblnotasdeentrega`
--
ALTER TABLE `tblnotasdeentrega`
  ADD PRIMARY KEY (`UUIDVenta`),
  ADD KEY `TipoDespacho` (`TipoDespacho`),
  ADD KEY `Estado` (`Estado`),
  ADD KEY `UUIDCaja` (`UUIDCaja`),
  ADD KEY `UUIDSucursal` (`UUIDSucursal`),
  ADD KEY `UUIDOperador` (`UUIDOperador`),
  ADD KEY `UUIDVendedor` (`UUIDVendedor`),
  ADD KEY `Repartidor` (`Repartidor`),
  ADD KEY `Carga` (`Carga`),
  ADD KEY `CodigoDeGeneracion` (`CodigoDeGeneracion`),
  ADD KEY `NumeroDeControl` (`NumeroDeControl`),
  ADD KEY `SelloDeRecepcion` (`SelloDeRecepcion`);

--
-- Indices de la tabla `tblnotasdeentregadetalle`
--
ALTER TABLE `tblnotasdeentregadetalle`
  ADD PRIMARY KEY (`UUIDDetalleVenta`);

--
-- Indices de la tabla `tblplanesdecreditos`
--
ALTER TABLE `tblplanesdecreditos`
  ADD PRIMARY KEY (`UUIDPlanCredito`);

--
-- Indices de la tabla `tblproductossucursal`
--
ALTER TABLE `tblproductossucursal`
  ADD PRIMARY KEY (`UUID`),
  ADD KEY `codigoprod` (`CodigoPROD`),
  ADD KEY `UUIDSucursal` (`UUIDSucursal`);

--
-- Indices de la tabla `tblregistrodecargosanticipos`
--
ALTER TABLE `tblregistrodecargosanticipos`
  ADD PRIMARY KEY (`UUIDCargo`);

--
-- Indices de la tabla `tblregistrodecompras`
--
ALTER TABLE `tblregistrodecompras`
  ADD PRIMARY KEY (`UUIDCompra`),
  ADD KEY `Estado` (`Estado`),
  ADD KEY `UUIDSucursal` (`UUIDSucursal`),
  ADD KEY `CodigoDeGeneracion` (`CodigoDeGeneracion`),
  ADD KEY `NumeroDeControl` (`NumeroDeControl`);

--
-- Indices de la tabla `tblregistrodecomprasdetalle`
--
ALTER TABLE `tblregistrodecomprasdetalle`
  ADD PRIMARY KEY (`UUIDDetalleCompra`),
  ADD KEY `UUIDCompra` (`UUIDCompra`),
  ADD KEY `CodigoPROD` (`CodigoPROD`);

--
-- Indices de la tabla `tblregistrodeegresos`
--
ALTER TABLE `tblregistrodeegresos`
  ADD PRIMARY KEY (`UUIDEgreso`);

--
-- Indices de la tabla `tblregistrodeempleados`
--
ALTER TABLE `tblregistrodeempleados`
  ADD PRIMARY KEY (`UUIDEmpleado`);

--
-- Indices de la tabla `tblregistrodeingresos`
--
ALTER TABLE `tblregistrodeingresos`
  ADD PRIMARY KEY (`UUIDIngreso`);

--
-- Indices de la tabla `tblregistrodemarcacion`
--
ALTER TABLE `tblregistrodemarcacion`
  ADD PRIMARY KEY (`UUIDMarcacion`);

--
-- Indices de la tabla `tblregistrodepagoscaja`
--
ALTER TABLE `tblregistrodepagoscaja`
  ADD PRIMARY KEY (`UUIDPago`);

--
-- Indices de la tabla `tblregistrodesucesos`
--
ALTER TABLE `tblregistrodesucesos`
  ADD PRIMARY KEY (`UUIDSuceso`);

--
-- Indices de la tabla `tblregistrodesucesoscnb`
--
ALTER TABLE `tblregistrodesucesoscnb`
  ADD PRIMARY KEY (`UUIDSuceso`);

--
-- Indices de la tabla `tblregistrodesucesosrecarga`
--
ALTER TABLE `tblregistrodesucesosrecarga`
  ADD PRIMARY KEY (`UUIDSuceso`);

--
-- Indices de la tabla `tblsucursales`
--
ALTER TABLE `tblsucursales`
  ADD PRIMARY KEY (`UUIDSucursal`);

--
-- Indices de la tabla `tblterminales`
--
ALTER TABLE `tblterminales`
  ADD PRIMARY KEY (`UUIDTerminal`);

--
-- Indices de la tabla `tbltipodecontingencia`
--
ALTER TABLE `tbltipodecontingencia`
  ADD PRIMARY KEY (`Codigo`);

--
-- Indices de la tabla `tbltokendispositivos`
--
ALTER TABLE `tbltokendispositivos`
  ADD PRIMARY KEY (`UUIDTokenAcceso`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tblareas`
--
ALTER TABLE `tblareas`
  MODIFY `IDArea` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblcargosdeempleados`
--
ALTER TABLE `tblcargosdeempleados`
  MODIFY `IDCargo` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblcatalogodeactividades`
--
ALTER TABLE `tblcatalogodeactividades`
  MODIFY `IDActividad` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblcatalogodecategorias`
--
ALTER TABLE `tblcatalogodecategorias`
  MODIFY `IDCategoria` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblcatalogodepresentaciones`
--
ALTER TABLE `tblcatalogodepresentaciones`
  MODIFY `IDPresentacion` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblcategoriagastos`
--
ALTER TABLE `tblcategoriagastos`
  MODIFY `IDCategoria` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblcreditos`
--
ALTER TABLE `tblcreditos`
  MODIFY `NoCorrelativo` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblcurrency`
--
ALTER TABLE `tblcurrency`
  MODIFY `idcurrency` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbldepartamentos`
--
ALTER TABLE `tbldepartamentos`
  MODIFY `UUIDDepartamento` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbldistritos`
--
ALTER TABLE `tbldistritos`
  MODIFY `UUIDDistrito` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblmunicipios`
--
ALTER TABLE `tblmunicipios`
  MODIFY `UUIDMunicipio` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblnegocios`
--
ALTER TABLE `tblnegocios`
  MODIFY `UUIDNegocio` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblplanesdecreditos`
--
ALTER TABLE `tblplanesdecreditos`
  MODIFY `UUIDPlanCredito` int NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
