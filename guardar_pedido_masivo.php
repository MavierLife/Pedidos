<?php
session_start();

header('Content-Type: application/json');

// Verificar si el usuario está logueado
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    echo json_encode(['success' => false, 'message' => 'Usuario no autenticado.']);
    exit;
}

$data = json_decode(file_get_contents('php://input'), true);

if (!$data) {
    echo json_encode(['success' => false, 'message' => 'No se recibieron datos.']);
    exit;
}

$uuidProducto = $data['UUIDProducto'] ?? null;
$descripcion = $data['Descripcion'] ?? null;
$contenido1 = $data['Contenido1'] ?? null;
$fardo = $data['Fardo'] ?? 0;
$unidades = $data['Unidades'] ?? 0;
$observaciones = $data['Observaciones'] ?? '';
$sucursales = $data['Sucursales'] ?? [];

if (!$uuidProducto || !$descripcion) {
    echo json_encode(['success' => false, 'message' => 'Datos incompletos (UUIDProducto y Descripcion son requeridos).']);
    exit;
}

if (empty($sucursales) || !is_array($sucursales)) {
    echo json_encode(['success' => false, 'message' => 'No se especificaron sucursales válidas.']);
    exit;
}

$directory = 'PedidosTemporal/';

// Crear el directorio si no existe
if (!is_dir($directory)) {
    if (!mkdir($directory, 0777, true)) {
        echo json_encode(['success' => false, 'message' => 'No se pudo crear el directorio PedidosTemporal.']);
        exit;
    }
}

$nuevoPedido = [
    'UUIDProducto' => $uuidProducto,
    'Descripcion' => $descripcion,
    'Contenido1' => $contenido1,
    'Fardo' => $fardo,
    'Unidades' => $unidades,
    'Observaciones' => $observaciones,
    'FechaHoraRegistro' => date('Y-m-d H:i:s')
];

$sucursalesActualizadas = 0;
$sucursalesConError = [];
$sucursalesYaExistentes = [];

foreach ($sucursales as $sucursal) {
    $filePath = $directory . $sucursal . '.json';
    
    // Cargar pedidos existentes
    $pedidos = [];
    if (file_exists($filePath)) {
        $jsonContent = file_get_contents($filePath);
        if ($jsonContent !== false) {
            $pedidos = json_decode($jsonContent, true);
            if (json_last_error() !== JSON_ERROR_NONE && !empty($jsonContent)) {
                $pedidos = []; // Resetear si hay error en JSON
            }
            if (!is_array($pedidos)) {
                $pedidos = [];
            }
        }
    }
    
    // Verificar si el producto ya existe en esta sucursal
    $productoExiste = false;
    foreach ($pedidos as $pedidoExistente) {
        if (isset($pedidoExistente['UUIDProducto']) && $pedidoExistente['UUIDProducto'] === $uuidProducto) {
            $productoExiste = true;
            $sucursalesYaExistentes[] = $sucursal;
            break;
        }
    }
    
    // Si el producto no existe, agregarlo
    if (!$productoExiste) {
        $pedidos[] = $nuevoPedido;
        
        // Guardar el archivo
        if (file_put_contents($filePath, json_encode($pedidos, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE))) {
            $sucursalesActualizadas++;
        } else {
            $sucursalesConError[] = $sucursal;
        }
    }
}

// Preparar respuesta
$message = "Producto procesado en pedido masivo.";
$details = [];

if ($sucursalesActualizadas > 0) {
    $details[] = "Agregado a {$sucursalesActualizadas} sucursales nuevas";
}

if (!empty($sucursalesYaExistentes)) {
    $details[] = "Ya existía en " . count($sucursalesYaExistentes) . " sucursales (" . implode(', ', $sucursalesYaExistentes) . ")";
}

if (!empty($sucursalesConError)) {
    $details[] = "Error en " . count($sucursalesConError) . " sucursales (" . implode(', ', $sucursalesConError) . ")";
}

if (!empty($details)) {
    $message .= " " . implode('. ', $details) . ".";
}

// Determinar si fue exitoso
$success = ($sucursalesActualizadas > 0) || (count($sucursalesYaExistentes) === count($sucursales));

echo json_encode([
    'success' => $success, 
    'message' => $message,
    'sucursalesActualizadas' => $sucursalesActualizadas,
    'sucursalesYaExistentes' => count($sucursalesYaExistentes),
    'sucursalesConError' => count($sucursalesConError),
    'detallesSucursalesYaExistentes' => $sucursalesYaExistentes,
    'detallesSucursalesConError' => $sucursalesConError
]);

?>
