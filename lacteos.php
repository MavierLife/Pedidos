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

// Construir la consulta SQL para productos lácteos específicos
$sql_base = "FROM tblcatalogodeproductos";
$sql_where = " WHERE (Descripcion LIKE '%QUESO DURO%' OR Descripcion LIKE '%QUESO SECO%' OR Descripcion LIKE '%QUESILLO%')";

// Agregar búsqueda si existe
if (!empty($termino_busqueda)) {
    $sql_where .= " AND (Descripcion LIKE '%$termino_busqueda%' OR Contenido1 LIKE '%$termino_busqueda%' OR UUIDProducto LIKE '%$termino_busqueda%')";
}

// Contar total de productos para la paginación
$sql_total = "SELECT COUNT(*) AS total " . $sql_base . $sql_where;
$result_total = $conn->query($sql_total);
$total_productos = $result_total->fetch_assoc()['total'];
$total_paginas = ceil($total_productos / $productos_por_pagina);

// Consultar productos con paginación y búsqueda
$sql = "SELECT UUIDProducto, Descripcion, Contenido1 " . $sql_base . $sql_where . " LIMIT $offset, $productos_por_pagina";
$result = $conn->query($sql);

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Productos Lácteos</title>
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
        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .back-link:hover {
            background-color: #5a6268;
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
            background-color: #17a2b8;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9em;
        }
        .add-btn:hover {
            background-color: #138496;
        }

        .lacteos-header {
            background-color: #e8f5e8;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #28a745;
        }

    </style>
</head>
<body>
    <div class="container">
        <div class="lacteos-header">
            <h1>Productos Lácteos</h1>
            <p>Sucursal: <?php echo htmlspecialchars($_SESSION['UUIDSucursal']); ?></p>
            <p><strong>Productos disponibles:</strong> Queso Duro, Queso Seco, Quesillo</p>
        </div>

        <div class="search-container">
            <form action="lacteos.php" method="GET">
                <input type="text" name="search" placeholder="Buscar productos lácteos..." value="<?php echo htmlspecialchars($termino_busqueda); ?>">
                <button type="submit">Buscar</button>
            </form>
        </div>
        
        <h2>Lista de Productos Lácteos</h2>
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
                                )">Agregar</button>
                            </td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>

            <div class="pagination">
                <?php
                // Construir URL base para paginación
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
            <p>No se encontraron productos lácteos<?php if (!empty($termino_busqueda)) echo " para la búsqueda '" . htmlspecialchars($termino_busqueda) . "'"; ?>.</p>
        <?php endif; ?>

        <p><a href="index.php" class="back-link">← Volver al Inicio</a></p>
    </div>

    <!-- El Modal para Agregar a Pedido Lácteo -->
    <div id="pedidoModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Agregar a Pedido Lácteo</h2>
            </div>
            <div class="modal-body">
                <p id="modalProductName" class="product-name"></p>
                <p id="modalProductContent" class="product-content"></p>
                <input type="hidden" id="modalProductUUID" name="modalProductUUID">
                
                <div class="input-group">
                    <div style="width: 100%;">
                        <label for="unidades">UNIDADES:</label>
                        <input type="number" id="unidades" name="unidades" value="0" min="0" style="width: calc(100% - 22px);">
                    </div>
                </div>
                
                <label for="observaciones">Observaciones:</label>
                <textarea id="observaciones" name="observaciones" rows="3"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="confirm-btn" onclick="confirmPedido()">&#10004;</button>
                <button type="button" class="cancel-btn" onclick="closeModal()">&#10006;</button>
            </div>
        </div>
    </div>

    <script>
        const uuidSucursalGlobal = '<?php echo htmlspecialchars($_SESSION['UUIDSucursal']); ?>';
        
        // Modal para Agregar Producto
        var modal = document.getElementById("pedidoModal");

        // Función para abrir el modal y popular datos
        function openModal(descripcion, contenido1, uuidProducto) {
            document.getElementById("modalProductName").textContent = descripcion;
            document.getElementById("modalProductContent").textContent = contenido1;
            document.getElementById("modalProductUUID").value = uuidProducto;
            document.getElementById("unidades").value = "0";
            document.getElementById("observaciones").value = "";
            modal.style.display = "block";
        }

        // Función para cerrar el modal
        function closeModal() {
            modal.style.display = "none";
        }

        // Función para confirmar el pedido lácteo
        function confirmPedido() {
            const uuidProducto = document.getElementById("modalProductUUID").value;
            const descripcion = document.getElementById("modalProductName").textContent;
            const contenido1 = document.getElementById("modalProductContent").textContent;
            const unidades = document.getElementById("unidades").value;
            const observaciones = document.getElementById("observaciones").value;

            // Validar que se haya ingresado al menos 1 unidad
            if (unidades == '0' || unidades == '') {
                Swal.fire({
                    title: 'Error',
                    text: 'Debe especificar al menos 1 unidad.',
                    icon: 'error',
                    confirmButtonText: 'Aceptar'
                });
                return;
            }

            const pedidoData = {
                UUIDProducto: uuidProducto,
                Descripcion: descripcion,
                Contenido1: contenido1,
                Fardo: '0',
                Unidades: unidades,
                Observaciones: observaciones,
                UUIDSucursal: uuidSucursalGlobal
            };

            fetch('guardar_pedido_lacteo.php', {
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
                        text: 'Pedido lácteo guardado exitosamente.',
                        icon: 'success',
                        confirmButtonText: 'Aceptar'
                    });
                } else {
                    Swal.fire({
                        title: 'Error',
                        text: 'Error al guardar el pedido lácteo: ' + data.message,
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