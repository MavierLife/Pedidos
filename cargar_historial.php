<?php
session_start();

if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    die(json_encode(['success' => false, 'message' => 'No autorizado']));
}

$uuidSucursal = $_SESSION['UUIDSucursal'];
// Extraer identificador de sucursal (ej: S001 de N1S001)
$fileIdentifier = substr($uuidSucursal, 2);

// Buscar archivos de respaldo
$respaldoPath = 'RESPALDO/';
$pattern = $respaldoPath . $fileIdentifier . '-Pedido-*.txt';
$archivos = glob($pattern);

$historial = [];
if ($archivos) {
    foreach ($archivos as $archivo) {
        $nombreArchivo = basename($archivo);
        // Extraer fecha del nombre del archivo (formato: S001-Pedido-ddmmyy_His.txt)
        preg_match('/(\d{2})(\d{2})(\d{2})_(\d{2})(\d{2})(\d{2})/', $nombreArchivo, $matches);
        if (count($matches) === 7) {
            $fecha = "20{$matches[3]}-{$matches[2]}-{$matches[1]} {$matches[4]}:{$matches[5]}:{$matches[6]}";
            $historial[] = [
                'archivo' => $nombreArchivo,
                'fecha' => date('d/m/Y H:i', strtotime($fecha)),
                'ruta' => $archivo
            ];
        }
    }
}

// Ordenar por fecha más reciente
usort($historial, function($a, $b) {
    return strtotime(str_replace('/', '-', $b['fecha'])) - strtotime(str_replace('/', '-', $a['fecha']));
});

echo json_encode(['success' => true, 'historial' => $historial]);
?>