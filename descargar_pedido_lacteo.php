<?php
require_once 'lib/fpdf/fpdf.php';

// Función para obtener todos los pedidos lácteos
function obtenerPedidosLacteos() {
    $pedidosLacteos = [];
    $pedidosLacteoDir = 'PedidoLacteo/';
    
    if (!is_dir($pedidosLacteoDir)) {
        return $pedidosLacteos;
    }
    
    $jsonFiles = glob($pedidosLacteoDir . '*.json');
    
    if ($jsonFiles === false) {
        return $pedidosLacteos;
    }
    
    foreach ($jsonFiles as $jsonFile) {
        $tiendaId = basename($jsonFile, '.json');
        
        if (!file_exists($jsonFile)) {
            continue;
        }
        
        $jsonContent = file_get_contents($jsonFile);
        if ($jsonContent === false) {
            continue;
        }
        
        // Verificar si el archivo está vacío
        if (empty(trim($jsonContent))) {
            continue;
        }
        
        $pedidos = json_decode($jsonContent, true);
        if (json_last_error() !== JSON_ERROR_NONE || !is_array($pedidos)) {
            continue;
        }
        
        foreach ($pedidos as $pedido) {
            // Agregar todos los productos de PedidoLacteo ya que todos son lácteos
            $pedidosLacteos[] = [
                'tienda' => $tiendaId,
                'descripcion' => isset($pedido['Descripcion']) ? $pedido['Descripcion'] : '',
                'contenido1' => isset($pedido['Contenido1']) ? $pedido['Contenido1'] : '',
                'unidades' => isset($pedido['Unidades']) ? intval($pedido['Unidades']) : 0,
                'fechaRegistro' => isset($pedido['FechaHoraRegistro']) ? $pedido['FechaHoraRegistro'] : '',
                'uuidProducto' => isset($pedido['UUIDProducto']) ? $pedido['UUIDProducto'] : ''
            ];
        }
    }
    
    return $pedidosLacteos;
}

// Función para generar el PDF con FPDF
function generarPDFLacteos($pedidosLacteos) {
    $pdf = new FPDF();
    $pdf->AddPage();
    
    // Título
    $pdf->SetFont('Arial', 'B', 16);
    $pdf->Cell(0, 10, 'REPORTE DE PEDIDOS LACTEOS', 0, 1, 'C');
    $pdf->SetFont('Arial', '', 12);
    $pdf->Cell(0, 5, 'Fecha: ' . date('d/m/Y H:i:s'), 0, 1, 'C');
    $pdf->Ln(10);
    
    if (empty($pedidosLacteos)) {
        $pdf->SetFont('Arial', '', 12);
        $pdf->Cell(0, 10, 'No se encontraron pedidos lacteos', 0, 1, 'C');
        return $pdf;
    }
    
    // Agrupar por tienda
    $pedidosPorTienda = [];
    foreach ($pedidosLacteos as $pedido) {
        $pedidosPorTienda[$pedido['tienda']][] = $pedido;
    }
    
    // Resumen por tienda
    $pdf->SetFont('Arial', 'B', 12);
    $pdf->Cell(0, 8, 'RESUMEN POR TIENDA', 0, 1, 'L');
    $pdf->Ln(2);
    
    $totalUnidades = 0;
    $totalProductos = 0;
    $resumenProductos = []; // Para el resumen general
    
    foreach ($pedidosPorTienda as $tienda => $pedidos) {
        $unidadesTienda = 0;
        $productosTienda = count($pedidos);
        
        foreach ($pedidos as $pedido) {
            $unidadesTienda += $pedido['unidades'];
            
            // Agregar al resumen general de productos
            $producto = trim($pedido['descripcion'] . ' ' . $pedido['contenido1']);
            if (!isset($resumenProductos[$producto])) {
                $resumenProductos[$producto] = 0;
            }
            $resumenProductos[$producto] += $pedido['unidades'];
        }
        
        // Verificar si necesitamos una nueva página
        if ($pdf->GetY() > 250) {
            $pdf->AddPage();
        }
        
        // Encabezado de la tienda
        $pdf->SetFont('Arial', 'B', 11);
        $pdf->Cell(0, 7, 'Tienda: ' . $tienda, 0, 1, 'L');
        $pdf->Ln(1);
        
        // Encabezado de la tabla
        $pdf->SetFont('Arial', 'B', 8);
        $pdf->Cell(110, 6, 'Producto', 1, 0, 'C');
        $pdf->Cell(25, 6, 'Unidades', 1, 0, 'C');
        $pdf->Cell(40, 6, 'Fecha Registro', 1, 1, 'C');
        
        // Productos de la tienda
        $pdf->SetFont('Arial', '', 8);
        foreach ($pedidos as $pedido) {
            // Verificar si necesitamos una nueva página
            if ($pdf->GetY() > 270) {
                $pdf->AddPage();
                // Repetir encabezado
                $pdf->SetFont('Arial', 'B', 11);
                $pdf->Cell(0, 7, 'Tienda: ' . $tienda . ' (continuacion)', 0, 1, 'L');
                $pdf->Ln(1);
                
                $pdf->SetFont('Arial', 'B', 8);
                $pdf->Cell(110, 6, 'Producto', 1, 0, 'C');
                $pdf->Cell(25, 6, 'Unidades', 1, 0, 'C');
                $pdf->Cell(40, 6, 'Fecha Registro', 1, 1, 'C');
                $pdf->SetFont('Arial', '', 8);
            }
            
            $producto = trim($pedido['descripcion'] . ' ' . $pedido['contenido1']);
            $fecha = '';
            if (!empty($pedido['fechaRegistro'])) {
                try {
                    $dateTime = new DateTime($pedido['fechaRegistro']);
                    $fecha = $dateTime->format('d/m/Y H:i');
                } catch (Exception $e) {
                    $fecha = 'N/A';
                }
            }
            
            // Convertir caracteres especiales para FPDF
            $producto = iconv('UTF-8', 'ISO-8859-1//IGNORE', substr($producto, 0, 50));
            $fecha = iconv('UTF-8', 'ISO-8859-1//IGNORE', $fecha);
            
            $pdf->Cell(110, 5, $producto, 1, 0, 'L');
            $pdf->Cell(25, 5, $pedido['unidades'], 1, 0, 'C');
            $pdf->Cell(40, 5, $fecha, 1, 1, 'C');
        }
        
        // Subtotal por tienda
        $pdf->SetFont('Arial', 'B', 9);
        $pdf->Cell(110, 6, 'SUBTOTAL TIENDA', 1, 0, 'C');
        $pdf->Cell(25, 6, $unidadesTienda, 1, 0, 'C');
        $pdf->Cell(40, 6, $productosTienda . ' items', 1, 1, 'C');
        
        $pdf->Ln(5);
        
        $totalUnidades += $unidadesTienda;
        $totalProductos += $productosTienda;
    }
    
    // Totales generales
    $pdf->SetFont('Arial', 'B', 12);
    $pdf->Cell(0, 8, 'TOTALES GENERALES', 0, 1, 'L');
    $pdf->Ln(2);
    
    $pdf->SetFont('Arial', 'B', 10);
    $pdf->Cell(110, 7, 'TOTAL GENERAL', 1, 0, 'C');
    $pdf->Cell(25, 7, $totalUnidades, 1, 0, 'C');
    $pdf->Cell(40, 7, $totalProductos . ' items', 1, 1, 'C');
    
    $pdf->Ln(5);
    
    // Resumen por producto
    $pdf->SetFont('Arial', 'B', 12);
    $pdf->Cell(0, 8, 'RESUMEN POR PRODUCTO', 0, 1, 'L');
    $pdf->Ln(2);
    
    $pdf->SetFont('Arial', 'B', 9);
    $pdf->Cell(120, 6, 'Producto', 1, 0, 'C');
    $pdf->Cell(30, 6, 'Total Unidades', 1, 1, 'C');
    
    $pdf->SetFont('Arial', '', 8);
    foreach ($resumenProductos as $producto => $totalUnidadesProducto) {
        // Verificar si necesitamos una nueva página
        if ($pdf->GetY() > 270) {
            $pdf->AddPage();
            // Repetir encabezado
            $pdf->SetFont('Arial', 'B', 12);
            $pdf->Cell(0, 8, 'RESUMEN POR PRODUCTO (continuacion)', 0, 1, 'L');
            $pdf->Ln(2);
            
            $pdf->SetFont('Arial', 'B', 9);
            $pdf->Cell(120, 6, 'Producto', 1, 0, 'C');
            $pdf->Cell(30, 6, 'Total Unidades', 1, 1, 'C');
            $pdf->SetFont('Arial', '', 8);
        }
        
        $productoTexto = iconv('UTF-8', 'ISO-8859-1//IGNORE', substr($producto, 0, 55));
        $pdf->Cell(120, 5, $productoTexto, 1, 0, 'L');
        $pdf->Cell(30, 5, $totalUnidadesProducto, 1, 1, 'C');
    }
    
    return $pdf;
}

// Procesar la descarga
try {
    $pedidosLacteos = obtenerPedidosLacteos();
    
    // Verificar si hay pedidos lácteos
    if (empty($pedidosLacteos)) {
        // Si no hay pedidos, mostrar SweetAlert
        session_start();
        $_SESSION['dashboard_message'] = [
            'type' => 'warning',
            'text' => 'No se encontraron pedidos lácteos para generar el reporte.',
            'show_alert' => true
        ];
        header('Location: dashboard.php');
        exit;
    }
    
    $pdf = generarPDFLacteos($pedidosLacteos);
    
    $nombreArchivo = 'Pedidos_Lacteos_' . date('dmy_His') . '.pdf';
    
    // Guardar copia en respaldo
    $directorioRespaldo = 'RESPALDO/';
    if (!is_dir($directorioRespaldo)) {
        mkdir($directorioRespaldo, 0777, true);
    }
    
    $rutaRespaldo = $directorioRespaldo . $nombreArchivo;
    $pdf->Output('F', $rutaRespaldo);
    
    // Descargar el archivo
    $pdf->Output('D', $nombreArchivo);
    
    // Vaciar los archivos JSON de PedidoLacteo después de generar el PDF
    $pedidosLacteoDir = 'PedidoLacteo/';
    if (is_dir($pedidosLacteoDir)) {
        $jsonFiles = glob($pedidosLacteoDir . '*.json');
        
        if ($jsonFiles !== false) {
            foreach ($jsonFiles as $jsonFile) {
                if (file_exists($jsonFile)) {
                    // Vaciar el contenido del archivo JSON
                    if (file_put_contents($jsonFile, '') === false) {
                        // Opcional: Registrar un error si no se pudo vaciar el JSON
                        error_log("Advertencia: No se pudo vaciar el archivo JSON después de la descarga: " . $jsonFile);
                    }
                }
            }
        }
    }
    
} catch (Exception $e) {
    // En caso de error, redirigir al dashboard con mensaje de error
    session_start();
    $_SESSION['dashboard_message'] = [
        'type' => 'error', 
        'text' => 'Error al generar el PDF: ' . $e->getMessage()
    ];
    header('Location: dashboard.php');
    exit;
}
?>