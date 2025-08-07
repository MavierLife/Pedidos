<?php
session_start();
header('Content-Type: application/json');

if (!isset($_SESSION['loggedin']) || !isset($_SESSION['UUIDSucursal'])) {
    echo json_encode(['success' => false, 'message' => 'No autorizado']);
    exit;
}

if (!isset($_GET['uuidProducto'])) {
    echo json_encode(['success' => false, 'message' => 'UUIDProducto no especificado']);
    exit;
}

$uuidProducto = $_GET['uuidProducto'];
$uuidSucursal = $_SESSION['UUIDSucursal'];
$fileIdentifier = substr($uuidSucursal, 2);

// Obtener la fecha de ayer en el formato correcto
$fechaAyer = date('dmy', strtotime('-1 day'));

// Buscar el archivo de respaldo de ayer
$archivoAyer = glob("RESPALDO/{$fileIdentifier}-Pedido-{$fechaAyer}_*.txt");

if (empty($archivoAyer)) {
    echo json_encode(['encontrado' => false]);
    exit;
}

// Leer el archivo más reciente si hay varios del mismo día
$archivo = $archivoAyer[count($archivoAyer) - 1];
$contenido = file_get_contents($archivo);
$lineas = explode("\n", $contenido);

foreach ($lineas as $linea) {
    $partes = str_getcsv($linea);
    if (count($partes) >= 5) {
        // El UUIDProducto está en la tercera columna del CSV
        if (trim($partes[2], '"') === $uuidProducto) {
            // Extraer cantidades del formato "X | Y"
            $cantidades = explode('|', trim($partes[4], '"'));
            $fardo = trim($cantidades[0]);
            $unidades = isset($cantidades[1]) ? trim($cantidades[1]) : '0';
            
            echo json_encode([
                'encontrado' => true,
                'fardo' => $fardo,
                'unidades' => $unidades
            ]);
            exit;
        }
    }
}

echo json_encode(['encontrado' => false]);