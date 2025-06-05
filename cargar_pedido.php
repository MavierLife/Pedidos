<?php
session_start();
header('Content-Type: application/json');

if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true || !isset($_SESSION['UUIDSucursal'])) {
    echo json_encode(['success' => false, 'message' => 'Usuario no autenticado o UUIDSucursal no encontrado en la sesión.']);
    exit;
}

$uuidSucursal = $_SESSION['UUIDSucursal'];
// Extraer la parte relevante del UUIDSucursal para el nombre del archivo (ej: S001 de N1S001)
$fileIdentifier = substr($uuidSucursal, 2); 
if (empty($fileIdentifier)) {
    echo json_encode(['success' => false, 'message' => 'Formato de UUIDSucursal inválido para generar nombre de archivo.']);
    exit;
}

$filePath = 'PedidosTemporal/' . $fileIdentifier . '.json';

if (file_exists($filePath)) {
    $jsonContent = file_get_contents($filePath);
    if ($jsonContent === false) {
        echo json_encode(['success' => false, 'message' => 'No se pudo leer el archivo de pedidos.']);
        exit;
    }

    // Si el archivo está vacío o solo contiene espacios en blanco, se considera un array de pedidos vacío.
    if (empty(trim($jsonContent))) { 
        echo json_encode(['success' => true, 'pedidos' => []]);
        exit;
    }

    $pedidos = json_decode($jsonContent, true);

    // Verificar si hubo un error al decodificar el JSON
    if (json_last_error() !== JSON_ERROR_NONE) {
        echo json_encode(['success' => false, 'message' => 'Error al decodificar el archivo JSON de pedidos: ' . json_last_error_msg()]);
        exit;
    }
    
    // Asegurarse de que $pedidos sea un array (podría ser null si el JSON era 'null' literal)
    if (!is_array($pedidos)) {
        $pedidos = []; // Tratar como vacío si no es un array después de un decode exitoso
    }

    echo json_encode(['success' => true, 'pedidos' => $pedidos]);
} else {
    // Si el archivo no existe, se considera un pedido vacío.
    echo json_encode(['success' => true, 'pedidos' => [], 'message' => 'No se encontró archivo de pedidos para esta sucursal.']);
}
?>