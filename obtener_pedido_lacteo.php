<?php
header('Content-Type: application/json');

if (!isset($_GET['tienda'])) {
    http_response_code(400);
    echo json_encode(['error' => 'No se especificó la tienda']);
    exit;
}

$tienda = $_GET['tienda'];
$jsonFilePath = 'PedidoLacteo/' . $tienda . '.json';

if (!file_exists($jsonFilePath)) {
    http_response_code(404);
    echo json_encode(['error' => 'No se encontró el archivo de pedidos']);
    exit;
}

$jsonContent = file_get_contents($jsonFilePath);
$pedidos = json_decode($jsonContent, true);

if (!$pedidos) {
    echo json_encode([
        'tienda' => $tienda,
        'pedidos' => []
    ]);
    exit;
}

// Procesar los pedidos
$pedidosProcesados = array_map(function($pedido) {
    return [
        'producto' => $pedido['Descripcion'] . ' ' . ($pedido['Contenido1'] ?? ''),
        'fardos' => $pedido['Fardo'] ?? 0,
        'unidades' => $pedido['Unidades'] ?? 0
    ];
}, $pedidos);

echo json_encode([
    'tienda' => $tienda,
    'pedidos' => $pedidosProcesados
]);