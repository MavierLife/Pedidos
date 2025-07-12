<?php
session_start(); // Usaremos sesiones para mostrar mensajes de estado

// Función para generar el contenido CSV (la misma que antes)
function generarContenidoCsvParaTienda($jsonFilePath, $iniciales) {
    if (!file_exists($jsonFilePath)) {
        error_log("Archivo JSON no encontrado: " . $jsonFilePath);
        return false;
    }
    $jsonContent = file_get_contents($jsonFilePath);
    if ($jsonContent === false) {
        error_log("No se pudo leer el archivo: " . $jsonFilePath);
        return false;
    }
    $pedidos = json_decode($jsonContent, true);
    if (json_last_error() !== JSON_ERROR_NONE || !is_array($pedidos)) {
        error_log("Error al decodificar JSON o no es un array: " . $jsonFilePath . " - Error: " . json_last_error_msg());
        return false;
    }
    if (empty($pedidos)) {
        return false; 
    }

    $csvHeader = ['Iniciales', 'FechaIngreso', 'IdImportacion', 'producto', 'Solicitado'];
    $csvRows = [];
    $csvRows[] = '"' . implode('","', array_map(function($h) { return str_replace('"', '""', $h); }, $csvHeader)) . '"';

    foreach ($pedidos as $pedido) {
        $fechaIngreso = '';
        if (isset($pedido['FechaHoraRegistro'])) {
            try {
                $dateTime = new DateTime($pedido['FechaHoraRegistro']);
                $fechaIngreso = $dateTime->format('d/m/Y H:i:s'); 
            } catch (Exception $e) {
                $fechaIngreso = 'Fecha inválida';
            }
        }
        $idImportacion = isset($pedido['UUIDProducto']) ? $pedido['UUIDProducto'] : ''; 
        $descripcion = isset($pedido['Descripcion']) ? trim($pedido['Descripcion']) : '';
        $contenido1 = isset($pedido['Contenido1']) ? trim($pedido['Contenido1']) : '';
        $producto = '';
        if (!empty($descripcion) && !empty($contenido1)) {
            $producto = $descripcion . " " . $contenido1;
        } elseif (!empty($descripcion)) {
            $producto = $descripcion;
        } elseif (!empty($contenido1)) {
            $producto = $contenido1;
        }
        $fardo = isset($pedido['Fardo']) ? $pedido['Fardo'] : '0';
        $unidades = isset($pedido['Unidades']) ? $pedido['Unidades'] : '0';
        $solicitado = "{$fardo} | {$unidades}";
        $csvRowData = [
            str_replace('"', '""', $iniciales),
            str_replace('"', '""', $fechaIngreso),
            str_replace('"', '""', $idImportacion),
            str_replace('"', '""', $producto),
            str_replace('"', '""', $solicitado)
        ];
        $csvRows[] = '"' . implode('","', $csvRowData) . '"';
    }
    if (count($csvRows) > 1) {
        return implode("\r\n", $csvRows);
    }
    return false;
}

// Lógica para descargar un CSV individual cuando se hace clic en un enlace
if (isset($_GET['descargar_csv_tienda'])) {
    $tiendaId = $_GET['descargar_csv_tienda'];
    // Sanear el ID de la tienda por seguridad
    if (!preg_match('/^[a-zA-Z0-9_-]+$/', $tiendaId)) {
        $_SESSION['dashboard_message'] = ['type' => 'error', 'text' => 'ID de tienda inválido.'];
        header('Location: dashboard.php');
        exit;
    }

    $jsonFilePath = 'PedidosTemporal/' . $tiendaId . '.json';
    $csvContent = generarContenidoCsvParaTienda($jsonFilePath, $tiendaId);

    if ($csvContent === false) {
        $_SESSION['dashboard_message'] = ['type' => 'error', 'text' => 'No se pudo generar el archivo CSV para la tienda ' . htmlspecialchars($tiendaId) . '. Verifique si hay pedidos o si el archivo JSON es válido.'];
        header('Location: dashboard.php');
        exit;
    }

    // Vaciar el contenido del archivo JSON después de generar el CSV
    if (file_exists($jsonFilePath)) {
        if (file_put_contents($jsonFilePath, '') === false) {
            // Opcional: Registrar un error si no se pudo vaciar el JSON.
            // La descarga continuará de todas formas ya que el CSV ya está generado.
            error_log("Advertencia: No se pudo vaciar el archivo JSON después de la descarga: " . $jsonFilePath);
        }
    }

    $fechaHoraActualParaNombre = date('dmy_His');
    $txtFileName = $tiendaId . '-Pedido-' . $fechaHoraActualParaNombre . '.txt';

    // Guardar copia en la carpeta RESPALDO
    $directorioRespaldo = 'RESPALDO/';
    if (!is_dir($directorioRespaldo)) {
        if (!mkdir($directorioRespaldo, 0777, true) && !is_dir($directorioRespaldo)) {
            // Opcional: Registrar un error si no se pudo crear el directorio de respaldo
            error_log("Error: No se pudo crear el directorio de respaldo: " . $directorioRespaldo);
            // Considerar si se debe detener la ejecución o solo registrar el error
            // $_SESSION['dashboard_message'] = ['type' => 'error', 'text' => 'Error al crear directorio de respaldo.'];
            // header('Location: dashboard.php');
            // exit;
        }
    }
    
    if (is_dir($directorioRespaldo)) {
        $rutaRespaldo = $directorioRespaldo . $txtFileName;
        if (file_put_contents($rutaRespaldo, $csvContent) === false) {
            // Opcional: Registrar un error si no se pudo guardar la copia de respaldo
            error_log("Advertencia: No se pudo guardar la copia de respaldo del TXT: " . $rutaRespaldo);
            // Considerar si se debe notificar al usuario
            // $_SESSION['dashboard_message'] = ['type' => 'warning', 'text' => 'No se pudo guardar la copia de respaldo del CSV.'];
        }
    }


    header('Content-Type: text/plain; charset=utf-8');
    header('Content-Disposition: attachment; filename="' . $txtFileName . '"'); // Esta línea es la responsable
    header('Pragma: no-cache');
    header('Expires: 0');
    echo $csvContent;
    exit;
}

    
$tiendasDisponibles = [];
$mensajeGlobal = null; // Para mensajes al usuario

// 1. Cargar tiendas disponibles siempre
$pedidosTemporalDir = 'PedidosTemporal/';
$rawJsonFiles = glob($pedidosTemporalDir . '*.json'); // Guardar resultado crudo de glob

if ($rawJsonFiles === false) {
    // Si glob falla, $mensajeGlobal se establecerá aquí y tendrá prioridad.
    $mensajeGlobal = ['type' => 'error', 'text' => 'Error crítico: No se pudo acceder al directorio de pedidos (' . htmlspecialchars($pedidosTemporalDir) . '). Verifique los permisos o la ruta.'];
    $jsonFiles = []; // Para evitar errores en el foreach
} else {
    $jsonFiles = $rawJsonFiles;
    foreach ($jsonFiles as $jsonFile) {
        $iniciales = basename($jsonFile, '.json');
        // Verificar si el archivo tiene contenido válido para CSV antes de listarlo
        if (generarContenidoCsvParaTienda($jsonFile, $iniciales) !== false) {
             $tiendasDisponibles[] = $iniciales;
        }
    }
}

// 2. Determinar el mensajeGlobal (dando prioridad a ciertos mensajes)
if (isset($_SESSION['dashboard_message'])) {
    // Prioridad 1: Mensajes de acciones previas (ej. error de descarga que redirigió aquí)
    $mensajeGlobal = $_SESSION['dashboard_message'];
    unset($_SESSION['dashboard_message']);
} elseif ($rawJsonFiles === false) {
    // Prioridad 2: El mensaje de error de glob ya está establecido si ocurrió.
    // No hacer nada aquí para no sobrescribirlo.
} elseif (isset($_POST['listar_pedidos_para_descarga'])) {
    // Prioridad 3: Acción explícita del usuario de "listar/actualizar"
    if (!empty($tiendasDisponibles)) {
        $mensajeGlobal = ['type' => 'success', 'text' => 'Lista de tiendas con pedidos disponibles actualizada.'];
    } elseif (empty($jsonFiles)) { // No hay archivos JSON en absoluto
        $mensajeGlobal = ['type' => 'info', 'text' => 'No se encontraron archivos de pedidos (.json) en ' . basename($pedidosTemporalDir) . '. Lista actualizada.'];
    } else { // Hay archivos JSON, pero todos están vacíos o son inválidos
        $mensajeGlobal = [
            'type' => 'warning', 
            'text' => 'No se encontraron pedidos válidos en los archivos JSON. Todos los archivos están vacíos o no contienen datos de pedidos.',
            'show_alert' => true
        ];
    }
} elseif (isset($_POST['limpiar_lista'])) {
    // Acción del botón "Limpiar Lista / Volver"
    // Simplemente recarga la página, la lista se actualiza. Podríamos añadir un mensaje.
    // O redirigir a index.php si "Volver" es a la página principal.
    // Por ahora, solo recarga y la lógica de abajo se aplica.
    // Si se quiere un comportamiento específico, se añadiría aquí.
    // Ejemplo: header('Location: index.php'); exit;
    // O: $mensajeGlobal = ['type' => 'info', 'text' => 'Vista reiniciada.'];
} else {
    // Prioridad 4: Estado general en una carga normal de página (sin acción específica ni mensaje de sesión, y glob no falló)
    if (empty($tiendasDisponibles) && $mensajeGlobal === null) { // Solo si no hay otro mensaje más prioritario
        if (empty($jsonFiles)) {
            $mensajeGlobal = ['type' => 'info', 'text' => 'No hay archivos de pedidos en el sistema.'];
        } else { // Hay archivos JSON, pero todos están vacíos/inválidos
            $mensajeGlobal = ['type' => 'info', 'text' => 'No hay pedidos pendientes para descargar.'];
        }
    }
    // Si hay tiendas, $mensajeGlobal permanece null (sin mensaje por defecto en carga normal).
}

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Dashboard de Pedidos - Descarga Individual</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f4f4f4; display: flex; justify-content: center; align-items: flex-start; min-height: 100vh; }
        .container { background-color: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; max-width: 700px; width: 100%; margin-top: 20px; }
        h1 { color: #333; margin-bottom: 20px; }
        h2 { color: #333; margin-bottom: 15px; font-size: 18px; }
        p { color: #555; line-height: 1.6; margin-bottom: 15px; }
        .btn { display: inline-block; padding: 10px 20px; background-color: #5cb85c; color: white; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; font-size: 16px; transition: background-color 0.3s ease; margin-top: 10px; }
        .btn:hover { background-color: #4cae4c; }
        .btn-descarga-tienda { background-color: #007bff; margin-left: 10px; font-size:14px; padding: 8px 15px;}
        .btn-descarga-tienda:hover { background-color: #0056b3; }
        .link-volver { display: block; margin-top: 30px; color: #007bff; text-decoration: none; font-size: 14px; }
        .link-volver:hover { text-decoration: underline; }
        .message { padding: 10px 15px; margin-bottom: 20px; border-radius: 4px; font-size: 14px; border: 1px solid transparent; text-align: left; }
        .message.success { background-color: #d4edda; color: #155724; border-color: #c3e6cb; }
        .message.error { background-color: #f8d7da; color: #721c24; border-color: #f5c6cb; }
        .message.info { background-color: #d1ecf1; color: #0c5460; border-color: #bee5eb; }
        .message.warning { background-color: #fff3cd; color: #856404; border-color: #ffeaa7; }
        ul.lista-tiendas { list-style-type: none; padding: 0; margin-top: 20px; }
        ul.lista-tiendas li { margin-bottom: 10px; display: flex; justify-content: space-between; align-items: center; padding: 10px; border: 1px solid #eee; border-radius: 4px; background-color: #f9f9f9; }
        ul.lista-tiendas li span { font-weight: bold; }
        .btn-lacteo { 
            background-color: #28a745 !important; 
            color: white; 
            font-weight: bold; 
        }
        .btn-lacteo:hover { 
            background-color: #218838 !important; 
        }
        .seccion-lacteos { 
            margin-top: 30px; 
            padding-top: 20px; 
            border-top: 2px solid #ddd; 
            text-align: center; 
        }
        .seccion-lacteos h2 { 
            color: #28a745; 
            margin-bottom: 10px; 
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Dashboard de Pedidos</h1>
        <h2>Descarga Individual de Archivos CSV</h2>

        <?php if ($mensajeGlobal && !isset($mensajeGlobal['show_alert'])): ?>
            <p class="message <?php echo htmlspecialchars($mensajeGlobal['type']); ?>"><?php echo nl2br(htmlspecialchars($mensajeGlobal['text'])); ?></p>
        <?php endif; ?>

        <?php if (!empty($tiendasDisponibles)): ?>
            <ul class="lista-tiendas">
                <?php foreach ($tiendasDisponibles as $tiendaId): ?>
                    <li>
                        <span>Tienda: <?php echo htmlspecialchars($tiendaId); ?></span>
                        <a href="dashboard.php?descargar_csv_tienda=<?php echo urlencode($tiendaId); ?>" 
                           class="btn btn-descarga-tienda"
                           onclick="setTimeout(function() { window.location.href = 'dashboard.php'; }, 200);">
                            Descargar CSV de <?php echo htmlspecialchars($tiendaId); ?>
                        </a>
                    </li>
                <?php endforeach; ?>
            </ul>
            <form method="POST" action="dashboard.php" style="margin-top:20px;">
                 <button type="submit" name="limpiar_lista" class="btn" style="background-color:#6c757d;">Limpiar Lista / Volver</button>
            </form>
        <?php else: ?>
            <p>Presione el botón para listar las tiendas con pedidos disponibles. Luego podrá descargar el archivo CSV para cada tienda individualmente.</p>
            <form method="POST" action="dashboard.php">
                <button type="submit" name="listar_pedidos_para_descarga" class="btn">Listar Pedidos para Descarga Individual</button>
            </form>
        <?php endif; ?>
        
        <!-- Botón para descargar pedidos lácteos -->
        <div class="seccion-lacteos">
            <h2>Pedidos Lácteos</h2>
            <p>Descargue un reporte completo con todos los pedidos lácteos y el total de unidades por tienda.</p>
            <a href="descargar_pedido_lacteo.php" class="btn btn-lacteo" style="margin-bottom: 10px;">
                📄 Descargar Pedido Lácteo (PDF)
            </a>
            <p style="font-size: 12px; color: #666;">El archivo incluye: listado por sucursal, totales y resumen general</p>
        </div>
        
        <a href="index.php" class="link-volver">Volver a la toma de pedidos</a>
    </div>

    <script>
        <?php if (isset($mensajeGlobal) && isset($mensajeGlobal['show_alert'])): ?>
            // Mostrar SweetAlert para mensajes especiales
            Swal.fire({
                title: '<?php echo $mensajeGlobal['type'] === 'warning' ? '¡Atención!' : ($mensajeGlobal['type'] === 'error' ? '¡Error!' : 'Información'); ?>',
                text: '<?php echo htmlspecialchars($mensajeGlobal['text']); ?>',
                icon: '<?php echo $mensajeGlobal['type']; ?>',
                confirmButtonText: 'Aceptar',
                confirmButtonColor: '#3085d6'
            });
        <?php endif; ?>
    </script>
</body>
</html>