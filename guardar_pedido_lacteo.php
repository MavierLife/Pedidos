<?php
session_start();

// Verificar si el usuario está logueado
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    echo json_encode(['success' => false, 'message' => 'No está autenticado.']);
    exit;
}

// Obtener los datos del pedido
$data = json_decode(file_get_contents('php://input'), true);

if (!$data) {
    echo json_encode(['success' => false, 'message' => 'Datos no válidos.']);
    exit;
}

$uuidProducto = $data['UUIDProducto'] ?? '';
$descripcion = $data['Descripcion'] ?? '';
$contenido1 = $data['Contenido1'] ?? '';
$fardo = $data['Fardo'] ?? '0';
$unidades = $data['Unidades'] ?? '0';
$observaciones = $data['Observaciones'] ?? '';
$uuidSucursal = $data['UUIDSucursal'] ?? '';

// Validar campos requeridos
if (empty($uuidProducto) || empty($descripcion) || empty($uuidSucursal)) {
    echo json_encode(['success' => false, 'message' => 'Faltan campos requeridos.']);
    exit;
}

// Validar que al menos uno de los campos (fardo o unidades) sea mayor a 0
if ($fardo == '0' && $unidades == '0') {
    echo json_encode(['success' => false, 'message' => 'Debe especificar al menos 1 en cajas/fardos o unidades.']);
    exit;
}

// Crear directorio PedidoLacteo si no existe
$directorio = __DIR__ . '/PedidoLacteo';
if (!is_dir($directorio)) {
    if (!mkdir($directorio, 0755, true)) {
        echo json_encode(['success' => false, 'message' => 'No se pudo crear el directorio PedidoLacteo.']);
        exit;
    }
}

// Ruta del archivo JSON para la sucursal
$archivo = $directorio . '/' . $uuidSucursal . '.json';

// Leer el archivo existente o crear un array vacío
$pedidos = [];
if (file_exists($archivo)) {
    $contenido = file_get_contents($archivo);
    $pedidos = json_decode($contenido, true);
    
    if (json_last_error() !== JSON_ERROR_NONE) {
        // Si hay error en el JSON, reiniciar el array
        $pedidos = [];
    }
    if (!is_array($pedidos)) {
        $pedidos = [];
    }
}

// Verificar si el producto ya existe en el pedido
foreach ($pedidos as $pedidoExistente) {
    if (isset($pedidoExistente['UUIDProducto']) && $pedidoExistente['UUIDProducto'] === $uuidProducto) {
        echo json_encode(['success' => false, 'message' => 'Este producto lácteo ya se encuentra en el registro.']);
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

// Agregar el nuevo pedido al array
$pedidos[] = $nuevoPedido;

// Guardar el archivo JSON
if (file_put_contents($archivo, json_encode($pedidos, JSON_PRETTY_PRINT))) {
    echo json_encode(['success' => true, 'message' => 'Pedido lácteo guardado exitosamente.']);
} else {
    echo json_encode(['success' => false, 'message' => 'Error al guardar el pedido lácteo.']);
}
?>