<?php
session_start();

header('Content-Type: application/json');

// Verificar si el usuario está logueado y tenemos el UUIDSucursal en sesión
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true || !isset($_SESSION['UUIDSucursal'])) {
    echo json_encode(['success' => false, 'message' => 'Usuario no autenticado o UUIDSucursal no encontrado en la sesión.']);
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
// El UUIDSucursal lo tomamos de la sesión PHP por seguridad, aunque también se envía desde JS
$uuidSucursal = $_SESSION['UUIDSucursal']; 

if (!$uuidProducto || !$descripcion) {
    echo json_encode(['success' => false, 'message' => 'Datos incompletos (UUIDProducto y Descripcion son requeridos).']);
    exit;
}

// Extraer la parte relevante del UUIDSucursal para el nombre del archivo (ej: S001 de N1S001)
$fileIdentifier = substr($uuidSucursal, 2); // Asume que siempre empieza con "N1" o similar de 2 caracteres
if (empty($fileIdentifier)) {
    echo json_encode(['success' => false, 'message' => 'Formato de UUIDSucursal inválido para generar nombre de archivo.']);
    exit;
}

$filePath = 'PedidosTemporal/' . $fileIdentifier . '.json';
$directory = 'PedidosTemporal/';

// Crear el directorio si no existe
if (!is_dir($directory)) {
    if (!mkdir($directory, 0777, true)) {
        echo json_encode(['success' => false, 'message' => 'No se pudo crear el directorio PedidosTemporal.']);
        exit;
    }
}

$pedidos = [];
if (file_exists($filePath)) {
    $jsonContent = file_get_contents($filePath);
    if ($jsonContent === false) {
        echo json_encode(['success' => false, 'message' => 'No se pudo leer el archivo JSON existente.']);
        exit;
    }
    $pedidos = json_decode($jsonContent, true);
    if (json_last_error() !== JSON_ERROR_NONE && !empty($jsonContent)) {
        // Si hay un error y el contenido no estaba vacío, es un JSON inválido.
        // Podrías optar por sobrescribir o manejar el error de otra forma.
        // Por ahora, lo inicializamos como un array vacío para evitar más errores.
        $pedidos = []; 
        // O podrías devolver un error:
        // echo json_encode(['success' => false, 'message' => 'El archivo JSON existente es inválido: ' . json_last_error_msg()]);
        // exit;
    }
    if (!is_array($pedidos)) { // Asegurarse de que $pedidos sea un array
        $pedidos = [];
    }
}

// Verificar si el producto ya existe en el pedido
foreach ($pedidos as $pedidoExistente) {
    if (isset($pedidoExistente['UUIDProducto']) && $pedidoExistente['UUIDProducto'] === $uuidProducto) {
        echo json_encode(['success' => false, 'message' => 'Este producto ya se encuentra en el registro.']);
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
    'FechaHoraRegistro' => date('Y-m-d H:i:s') // Añadir fecha y hora del registro
];

$pedidos[] = $nuevoPedido;

if (file_put_contents($filePath, json_encode($pedidos, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE))) {
    echo json_encode(['success' => true, 'message' => 'Pedido guardado exitosamente.', 'filePath' => $filePath]);
} else {
    echo json_encode(['success' => false, 'message' => 'No se pudo escribir en el archivo JSON. Verifique los permisos.']);
}

?>