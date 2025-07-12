<?php
session_start();

// Verificar si el usuario está logueado, si no, redirigir a login.php
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header("Location: login.php");
    exit;
}

// Configuración de la base de datos
$servername = "127.0.0.1";
$username = "access_permit";
$password_db = "3VTnUWWQaIp!YgHB";
$dbname = "helensystem_data";

// Crear conexión
$conn = new mysqli($servername, $username, $password_db, $dbname);

// Verificar conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Paginación y Búsqueda
$productos_por_pagina = 50;
$pagina_actual = isset($_GET['page']) && is_numeric($_GET['page']) ? (int)$_GET['page'] : 1;
$offset = ($pagina_actual - 1) * $productos_por_pagina;

$termino_busqueda = isset($_GET['search']) ? $conn->real_escape_string($_GET['search']) : '';

// Construir la consulta SQL
$sql_base = "FROM tblcatalogodeproductos";
$sql_where = "";
if (!empty($termino_busqueda)) {
    $sql_where = " WHERE Descripcion LIKE '%$termino_busqueda%' OR Contenido1 LIKE '%$termino_busqueda%' OR UUIDProducto LIKE '%$termino_busqueda%'";
}

// Contar total de productos para la paginación (con filtro de búsqueda)
$sql_total = "SELECT COUNT(*) AS total " . $sql_base . $sql_where;
$result_total = $conn->query($sql_total);
$total_productos = $result_total->fetch_assoc()['total'];
$total_paginas = ceil($total_productos / $productos_por_pagina);

// Consultar productos con paginación y búsqueda
$sql = "SELECT UUIDProducto, Descripcion, Contenido1 " . $sql_base . $sql_where . " LIMIT $offset, $productos_por_pagina";
$result = $conn->query($sql);

// Obtener lista de todas las sucursales disponibles
$sucursales = [];
$directorio = 'PedidosTemporal/';
if (is_dir($directorio)) {
    $archivos = scandir($directorio);
    foreach ($archivos as $archivo) {
        if (pathinfo($archivo, PATHINFO_EXTENSION) === 'json') {
            $sucursal = pathinfo($archivo, PATHINFO_FILENAME);
            $sucursales[] = $sucursal;
        }
    }
}

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pedido Masivo - Todas las Sucursales</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f7f6;
            color: #333;
        }
        .container {
            max-width: 1000px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h1, h2 {
            color: #0056b3;
        }
        .header-info {
            background-color: #e7f3ff;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #007bff;
        }
        .header-info h3 {
            margin: 0 0 10px 0;
            color: #0056b3;
        }
        .sucursales-list {
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
            margin-top: 10px;
        }
        .sucursal-tag {
            background-color: #007bff;
            color: white;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 0.8em;
        }
        .search-container {
            margin-bottom: 20px;
            display: flex;
            justify-content: flex-end;
        }
        .search-container input[type="text"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px 0 0 4px;
            outline: none;
            flex-grow: 1;
            max-width: 300px;
        }
        .search-container button {
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: 1px solid #007bff;
            border-left: none;
            border-radius: 0 4px 4px 0;
            cursor: pointer;
        }
        .search-container button:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.2);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .logout-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #dc3545;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .logout-link:hover {
            background-color: #c82333;
        }
        
        /* Estilos de Paginación */
        .pagination {
            margin-top: 30px;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 8px;
            padding: 0;
            list-style: none;
        }

        .pagination a, .pagination span {
            display: inline-block;
            padding: 10px 15px;
            font-size: 0.95rem;
            font-weight: 500;
            color: #007bff;
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 0.25rem;
            text-decoration: none;
            transition: all 0.2s ease-in-out;
            line-height: 1.5;
        }

        .pagination a:hover {
            color: #0056b3;
            background-color: #e9ecef;
            border-color: #adb5bd;
        }

        .pagination .active {
            z-index: 3;
            color: #fff;
            background-color: #007bff;
            border-color: #007bff;
        }
        
        .pagination .active:hover {
            color: #fff;
            background-color: #0069d9;
            border-color: #0062cc;
        }

        .pagination .disabled {
            color: #6c757d;
            pointer-events: none;
            background-color: #f8f9fa;
            border-color: #dee2e6;
        }

        /* Estilos para el Modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 400px;
            border-radius: 8px;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
        }

        .modal-header h2 {
            margin-top: 0;
            color: #333;
            font-size: 1.2em;
        }
        
        .modal-body .product-name {
            font-size: 1.1em;
            font-weight: bold;
            color: #0056b3;
            text-align: center;
            margin-bottom: 5px;
        }

        .modal-body .product-content {
            font-size: 0.9em;
            color: #555;
            text-align: center;
            margin-bottom: 15px;
        }

        .modal-body label {
            display: block;
            margin-top: 10px;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .modal-body input[type="number"], .modal-body textarea {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .modal-body .input-group {
            display: flex;
            justify-content: space-between;
        }

        .modal-body .input-group div {
            width: 48%;
        }
        
        .modal-body .input-group input[type="number"] {
             width: calc(100% - 22px);
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
        }

        .modal-footer button {
            padding: 10px 15px;
            margin-left: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .modal-footer .confirm-btn {
            background-color: #28a745;
            color: white;
        }
        .modal-footer .confirm-btn:hover {
            background-color: #218838;
        }

        .modal-footer .cancel-btn {
            background-color: #dc3545;
            color: white;
        }
        .modal-footer .cancel-btn:hover {
            background-color: #c82333;
        }

        .add-btn {
            padding: 8px 12px;
            background-color: #ff6b35; /* Color naranja para diferenciarlo del botón normal */
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9em;
            font-weight: bold;
        }
        .add-btn:hover {
            background-color: #e55a2b;
        }

        .back-btn {
            padding: 10px 15px;
            background-color: #6c757d;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1em;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
        }

        .back-btn:hover {
            background-color: #5a6268;
        }

    </style>
</head>
<body>
    <div class="container">
        <a href="index.php" class="back-btn">← Volver al Pedido Normal</a>
        
        <h1>Pedido Masivo - Todas las Sucursales</h1>
        
        <div class="header-info">
            <h3>⚠️ MODO PEDIDO MASIVO</h3>
            <p><strong>ATENCIÓN:</strong> Al agregar un producto aquí, se agregará automáticamente a TODAS las sucursales listadas abajo.</p>
            <p><strong>Sucursales que recibirán el pedido:</strong></p>
            <div class="sucursales-list">
                <?php foreach ($sucursales as $sucursal): ?>
                    <span class="sucursal-tag"><?php echo htmlspecialchars($sucursal); ?></span>
                <?php endforeach; ?>
            </div>
            <p><em>Total de sucursales: <?php echo count($sucursales); ?></em></p>
        </div>

        <div class="search-container">
            <form action="pedidomasivo.php" method="GET">
                <input type="text" name="search" placeholder="Buscar productos..." value="<?php echo htmlspecialchars($termino_busqueda); ?>">
                <button type="submit">Buscar</button>
            </form>
        </div>
        
        <h2>Lista de Productos</h2>
        <?php if ($result && $result->num_rows > 0): ?>
            <table>
                <thead>
                    <tr>
                        <th>UUID Producto</th>
                        <th>Descripción</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while($row = $result->fetch_assoc()): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($row['UUIDProducto']); ?></td>
                            <td><?php echo htmlspecialchars($row['Descripcion'] . " - " . $row['Contenido1']); ?></td>
                            <td>
                                <button class="add-btn" onclick="openModal(
                                    '<?php echo htmlspecialchars(addslashes($row['Descripcion'])); ?>',
                                    '<?php echo htmlspecialchars(addslashes($row['Contenido1'])); ?>',
                                    '<?php echo htmlspecialchars($row['UUIDProducto']); ?>'
                                )">Agregar a Todas</button>
                            </td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>

            <div class="pagination">
                <?php
                // Construir URL base para paginación, manteniendo el término de búsqueda si existe
                $url_params = [];
                if (!empty($termino_busqueda)) {
                    $url_params['search'] = $termino_busqueda;
                }

                if ($pagina_actual > 1):
                    $url_params['page'] = $pagina_actual - 1; ?>
                    <a href="?<?php echo http_build_query($url_params); ?>">Anterior</a>
                <?php else: ?>
                    <span class="disabled">Anterior</span>
                <?php endif; ?>

                <?php for ($i = 1; $i <= $total_paginas; $i++):
                    $url_params['page'] = $i; ?>
                    <a href="?<?php echo http_build_query($url_params); ?>" class="<?php if ($i == $pagina_actual) echo 'active'; ?>"><?php echo $i; ?></a>
                <?php endfor; ?>

                <?php if ($pagina_actual < $total_paginas):
                    $url_params['page'] = $pagina_actual + 1; ?>
                    <a href="?<?php echo http_build_query($url_params); ?>">Siguiente</a>
                <?php else: ?>
                    <span class="disabled">Siguiente</span>
                <?php endif; ?>
            </div>

        <?php else: ?>
            <p>No se encontraron productos<?php if (!empty($termino_busqueda)) echo " para la búsqueda '" . htmlspecialchars($termino_busqueda) . "'"; ?>.</p>
        <?php endif; ?>

        <p><a href="logout.php" class="logout-link">Cerrar Sesión</a></p>
    </div>

    <!-- El Modal para Agregar a Pedido Masivo -->
    <div id="pedidoModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Agregar a TODAS las Sucursales</h2>
            </div>
            <div class="modal-body">
                <p id="modalProductName" class="product-name"></p>
                <p id="modalProductContent" class="product-content"></p>
                <input type="hidden" id="modalProductUUID" name="modalProductUUID">
                
                <div class="input-group">
                    <div>
                        <label for="cajasFardos">CAJAS/FARDOS:</label>
                        <input type="number" id="cajasFardos" name="cajasFardos" value="0" min="0">
                    </div>
                    <div>
                        <label for="unidades">UNIDADES:</label>
                        <input type="number" id="unidades" name="unidades" value="0" min="0">
                    </div>
                </div>
                
                <label for="observaciones">Observaciones:</label>
                <textarea id="observaciones" name="observaciones" rows="3"></textarea>
                
                <div style="background-color: #fff3cd; padding: 10px; border-radius: 4px; margin-top: 10px; border-left: 4px solid #ffc107;">
                    <strong>⚠️ ADVERTENCIA:</strong> Este producto se agregará a <strong><?php echo count($sucursales); ?> sucursales</strong> simultáneamente.
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="confirm-btn" onclick="confirmPedidoMasivo()">✓ Agregar a Todas</button>
                <button type="button" class="cancel-btn" onclick="closeModal()">✗ Cancelar</button>
            </div>
        </div>
    </div>

    <script>
        const sucursalesDisponibles = <?php echo json_encode($sucursales); ?>;
        
        // Modal para Agregar Producto
        var modal = document.getElementById("pedidoModal");

        // Función para abrir el modal y popular datos
        function openModal(descripcion, contenido1, uuidProducto) {
            document.getElementById("modalProductName").textContent = descripcion;
            document.getElementById("modalProductContent").textContent = contenido1;
            document.getElementById("modalProductUUID").value = uuidProducto;
            document.getElementById("cajasFardos").value = "0";
            document.getElementById("unidades").value = "0";
            document.getElementById("observaciones").value = "";
            modal.style.display = "block";
        }

        // Función para cerrar el modal de agregar producto
        function closeModal() {
            modal.style.display = "none";
        }

        // Función para confirmar el pedido masivo (guardar en todas las sucursales)
        function confirmPedidoMasivo() {
            const uuidProducto = document.getElementById("modalProductUUID").value;
            const descripcion = document.getElementById("modalProductName").textContent;
            const contenido1 = document.getElementById("modalProductContent").textContent;
            const cajasFardos = document.getElementById("cajasFardos").value;
            const unidades = document.getElementById("unidades").value;
            const observaciones = document.getElementById("observaciones").value;

            const pedidoData = {
                UUIDProducto: uuidProducto,
                Descripcion: descripcion,
                Contenido1: contenido1,
                Fardo: cajasFardos,
                Unidades: unidades,
                Observaciones: observaciones,
                Sucursales: sucursalesDisponibles
            };

            // Mostrar loading
            Swal.fire({
                title: 'Procesando...',
                text: `Agregando producto a ${sucursalesDisponibles.length} sucursales`,
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });

            fetch('guardar_pedido_masivo.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(pedidoData),
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    Swal.fire({
                        title: '¡Guardado!',
                        text: `Producto agregado exitosamente a ${data.sucursalesActualizadas || sucursalesDisponibles.length} sucursales.`,
                        icon: 'success',
                        confirmButtonText: 'Aceptar'
                    });
                } else {
                    Swal.fire({
                        title: 'Error',
                        text: 'Error al guardar el pedido masivo: ' + data.message,
                        icon: 'error',
                        confirmButtonText: 'Aceptar'
                    });
                }
                closeModal();
            })
            .catch((error) => {
                console.error('Error:', error);
                Swal.fire({
                    title: 'Error',
                    text: 'Ocurrió un error al procesar la solicitud.',
                    icon: 'error',
                    confirmButtonText: 'Aceptar'
                });
                closeModal();
            });
        }

        // Cerrar el modal si el usuario hace clic fuera de él
        window.onclick = function(event) {
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>

</body>
</html>
<?php
$conn->close();
?>
