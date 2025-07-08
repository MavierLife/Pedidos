<?php
session_start();

header('Content-Type: application/json');

// Verificar si el usuario está logueado y tenemos el UUIDSucursal en sesión
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true || !isset($_SESSION['UUIDSucursal'])) {
    echo json_encode(['success' => false, 'message' => 'Usuario no autenticado o UUIDSucursal no encontrado en la sesión.']);
    exit;
}

$data = json_decode(file_get_contents('php://input'), true);

if (!$data || !isset($data['UUIDProducto'])) {
    echo json_encode(['success' => false, 'message' => 'No se recibió el UUIDProducto a eliminar.']);
    exit;
}

$uuidProductoEliminar = $data['UUIDProducto'];
$uuidSucursal = $_SESSION['UUIDSucursal'];

// Extraer la parte relevante del UUIDSucursal para el nombre del archivo
$fileIdentifier = substr($uuidSucursal, 2);
if (empty($fileIdentifier)) {
    echo json_encode(['success' => false, 'message' => 'Formato de UUIDSucursal inválido para generar nombre de archivo.']);
    exit;
}

$filePath = 'PedidosTemporal/' . $fileIdentifier . '.json';

// Verificar si el archivo existe
if (!file_exists($filePath)) {
    echo json_encode(['success' => false, 'message' => 'No existe archivo de pedidos para esta sucursal.']);
    exit;
}

// Leer el contenido actual del archivo
$jsonContent = file_get_contents($filePath);
if ($jsonContent === false) {
    echo json_encode(['success' => false, 'message' => 'No se pudo leer el archivo de pedidos.']);
    exit;
}

// Decodificar el JSON
$pedidos = json_decode($jsonContent, true);
if (json_last_error() !== JSON_ERROR_NONE || !is_array($pedidos)) {
    echo json_encode(['success' => false, 'message' => 'Error al decodificar el archivo JSON de pedidos.']);
    exit;
}

// Buscar y eliminar el producto
$productoEncontrado = false;
$pedidosActualizados = [];

foreach ($pedidos as $pedido) {
    if (isset($pedido['UUIDProducto']) && $pedido['UUIDProducto'] === $uuidProductoEliminar) {
        $productoEncontrado = true;
        // No agregar este producto al array actualizado (eliminarlo)
    } else {
        $pedidosActualizados[] = $pedido;
    }
}

if (!$productoEncontrado) {
    echo json_encode(['success' => false, 'message' => 'El producto no se encontró en el pedido.']);
    exit;
}

// Guardar el archivo actualizado
if (empty($pedidosActualizados)) {
    // Si no quedan pedidos, dejar el archivo en blanco
    if (file_put_contents($filePath, '') === false) {
        echo json_encode(['success' => false, 'message' => 'Error al vaciar el archivo de pedidos.']);
        exit;
    }
} else {
    // Si quedan pedidos, guardar el JSON actualizado
    $jsonActualizado = json_encode($pedidosActualizados, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
    if (file_put_contents($filePath, $jsonActualizado) === false) {
        echo json_encode(['success' => false, 'message' => 'Error al guardar el archivo actualizado.']);
        exit;
    }
}

echo json_encode(['success' => true, 'message' => 'Producto eliminado exitosamente del pedido.']);
?>