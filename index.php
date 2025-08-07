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

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Página Principal</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
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
        
        /* Estilos de Paginación Actualizados */
        .pagination {
            margin-top: 30px; /* Un poco más de margen superior */
            display: flex;
            justify-content: center;
            flex-wrap: wrap; /* Permite que los botones se envuelvan a la siguiente línea */
            gap: 8px; /* Espacio entre los botones de paginación */
            padding: 0;
            list-style: none; /* Si se usaran <li>, esto sería útil */
        }

        .pagination a, .pagination span {
            display: inline-block;
            padding: 10px 15px; /* Mantenemos el padding original que es generoso */
            font-size: 0.95rem; /* Ligeramente más pequeño para acomodar más números si es necesario */
            font-weight: 500;
            color: #007bff;
            background-color: #fff;
            border: 1px solid #dee2e6; /* Borde más suave */
            border-radius: 0.25rem; /* Radio de borde estándar */
            text-decoration: none;
            transition: all 0.2s ease-in-out;
            line-height: 1.5; /* Asegura buena altura de línea */
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
        
        .pagination .active:hover { /* Para que el hover del activo no cambie el color de fondo */
            color: #fff;
            background-color: #0069d9; /* Un azul ligeramente más oscuro en hover */
            border-color: #0062cc;
        }

        .pagination .disabled {
            color: #6c757d;
            pointer-events: none;
            background-color: #f8f9fa; /* Fondo ligeramente gris para deshabilitado */
            border-color: #dee2e6;
        }

        /* Estilos para el Modal */
        .modal {
            display: none; /* Oculto por defecto */
            position: fixed; /* Se queda fijo en la pantalla */
            z-index: 1; /* Se sitúa por encima de todo */
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto; /* Habilita scroll si es necesario */
            background-color: rgb(0,0,0); /* Color de fondo */
            background-color: rgba(0,0,0,0.4); /* Negro con opacidad */
            padding-top: 60px;
        }

        /* Estilo general para modal-content */
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 400px; /* Este es el valor predeterminado para otros modales */
            border-radius: 8px;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
        }

        /* Estilo específico para el modal de ver pedido */
        #verPedidoModal .modal-content {
            max-width: 90%; /* Aumentamos el ancho máximo */
            width: 1200px; /* Establecemos un ancho fijo más grande */
        }

        /* Ajustamos el contenido interno del modal de ver pedido */
        #verPedidoModalBody .scrollable-table {
            max-height: 70vh;
            overflow-y: auto;
            overflow-x: auto; /* Agregamos scroll horizontal si es necesario */
        }

        #verPedidoModalBody table {
            min-width: 100%; /* Aseguramos que la tabla ocupe todo el ancho disponible */
            width: auto; /* Permitimos que la tabla crezca si es necesario */
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
             width: calc(100% - 22px); /* Ajuste para padding y borde */
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
            background-color: #28a745; /* Verde */
            color: white;
        }
        .modal-footer .confirm-btn:hover {
            background-color: #218838;
        }

        .modal-footer .cancel-btn {
            background-color: #dc3545; /* Rojo */
            color: white;
        }
        .modal-footer .cancel-btn:hover {
            background-color: #c82333;
        }

        .add-btn {
            padding: 8px 12px;
            background-color: #17a2b8; /* Azul claro/info */
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9em;
        }
        .add-btn:hover {
            background-color: #138496;
        }

        /* Estilo para el botón Ver Pedido */
        .action-btn {
            padding: 10px 15px;
            background-color: #5cb85c; /* Un color verde para "Ver Pedido" */
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1em;
            margin-left: 10px; 
        }

        .action-btn:hover {
            background-color: #4cae4c;
        }

        /* Estilo para el botón CÓDIGO */
        .codigo-btn {
            padding: 6px 12px;
            background-color: #6c757d; /* Color gris */
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9em;
        }

        .codigo-btn:hover {
            background-color: #5a6268;
        }

        /* Estilos para la flecha animada y mensaje de recordatorio */
        .reminder-container {
            position: relative;
            display: inline-block;
            margin-left: 15px;
            vertical-align: middle;
        }

        .reminder-arrow {
            position: absolute;
            left: -20px;
            top: 50%;
            transform: translateY(-50%);
            width: 0;
            height: 0;
            border-right: 15px solid #ff6b6b;
            border-top: 8px solid transparent;
            border-bottom: 8px solid transparent;
            animation: bounce 2s infinite;
        }

        .reminder-text {
            background-color: #ff6b6b;
            color: white;
            padding: 8px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: bold;
            white-space: nowrap;
            box-shadow: 0 2px 8px rgba(255, 107, 107, 0.3);
            animation: pulse 3s infinite;
            display: inline-block;
            margin-left: 15px;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(-50%) translateX(0);
            }
            40% {
                transform: translateY(-50%) translateX(5px);
            }
            60% {
                transform: translateY(-50%) translateX(3px);
            }
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
            100% {
                transform: scale(1);
            }
        }

        /* Estilos para el botón de cerrar (X) en el modal de Ver Pedido */
        #verPedidoModal .modal-header .close-ver-pedido {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            line-height: 1;
        }

        #verPedidoModal .modal-header .close-ver-pedido:hover,
        #verPedidoModal .modal-header .close-ver-pedido:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        /* Estilos para la tabla dentro del modal de ver pedido */
        #verPedidoModalBody .scrollable-table {
            max-height: 70vh;
            overflow-y: auto;
            overflow-x: auto; /* Agregamos scroll horizontal si es necesario */
        }

        #verPedidoModalBody table {
            min-width: 100%; /* Aseguramos que la tabla ocupe todo el ancho disponible */
            width: auto; /* Permitimos que la tabla crezca si es necesario */
        }

        #verPedidoModalBody th,
        #verPedidoModalBody td {
            border: 1px solid #dee2e6;
            padding: 8px;
        }

        #verPedidoModalBody th {
            position: sticky;
            top: 0;
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }

        #verPedidoModalBody tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        #verPedidoModalBody tr:hover {
            background-color: #f1f1f1;
        }

        /* Estilos para el botón de eliminar en el modal de ver pedido */
        .btn-eliminar {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 4px 8px;
            border-radius: 3px;
            cursor: pointer;
            font-size: 0.8em;
        }
        
        .btn-eliminar:hover {
            background-color: #c82333;
        }

        /* Estilos para el Modal de Historial de Pedidos */
        #historialModal .modal-content {
            max-width: 800px; /* Ancho máximo para el modal de historial */
        }

        #historialModalBody table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        #historialModalBody th, #historialModalBody td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
            font-size: 0.9em;
        }

        #historialModalBody th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }

        #historialModalBody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        #historialModalBody tr:hover {
            background-color: #f1f1f1;
        }

        .btn-ver, .btn-descargar {
            padding: 5px 10px;
            margin: 0 3px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 0.9em;
        }

        .btn-ver {
            padding: 8px 15px;
            background-color: #17a2b8;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9em;
            transition: all 0.3s ease;
            width: 100%;
            text-align: center;
        }

        .btn-ver:hover {
            background-color: #138496;
            transform: translateY(-1px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        .btn-descargar {
            background-color: #28a745;
            color: white;
        }

        .btn-descargar:hover {
            background-color: #218838;
        }

    </style>
</head>
<body>
    <div class="container">
        <h1>Generar Pedido Sucursal</h1>
        <p>Sucursal: <?php echo htmlspecialchars($_SESSION['UUIDSucursal']); ?>
            <button type="button" id="verPedidoBtn" class="action-btn" style="margin-bottom: 20px;">Ver Pedido Actual</button>
            <button type="button" id="historialBtn" class="action-btn" style="margin-bottom: 20px; background-color: #17a2b8;">Historial de Pedidos</button>
        </p>
        <p>
            <button type="button" id="codigoBtn" class="codigo-btn">CÓDIGO</button>
            <button type="button" id="lacteosBtn" class="codigo-btn">CONGELADOS</button>
            <span class="reminder-container">
                <span class="reminder-arrow"></span>
                <span class="reminder-text">RECUERDA REALIZAR TU PEDIDO DE CONGELADOS ANTES DEL MIÉRCOLES</span>
            </span>
        </p>

        <div class="search-container">
            <form action="index.php" method="GET">
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
                                )">Agregar</button>
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

    <!-- El Modal para Agregar a Pedido -->
    <div id="pedidoModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Agregar a Pedido</h2>
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
            </div>
            <div class="modal-footer">
                <button type="button" class="confirm-btn" onclick="confirmPedido()">&#10004;</button> <!-- Checkmark -->
                <button type="button" class="cancel-btn" onclick="closeModal()">&#10006;</button> <!-- Cross -->
            </div>
        </div>
    </div>

    <!-- El Modal para Ver Pedido -->
    <div id="verPedidoModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Mi Pedido Actual</h2>
                <span class="close-ver-pedido">&times;</span>
            </div>
            <div class="modal-body" id="verPedidoModalBody">
                <p>Cargando pedidos...</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="cancel-btn close-ver-pedido-footer">Cerrar</button>
            </div>
        </div>
    </div>

    <!-- El Modal para Historial de Pedidos -->
    <div id="historialModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Historial de Pedidos</h2>
                <span class="close-historial">&times;</span>
            </div>
            <div class="modal-body" id="historialModalBody">
                <p>Cargando historial...</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="cancel-btn close-historial-footer">Cerrar</button>
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
            document.getElementById("cajasFardos").value = "0";
            document.getElementById("unidades").value = "0";
            document.getElementById("observaciones").value = "";
            modal.style.display = "block";
        }

        // Función para cerrar el modal de agregar producto
        function closeModal() {
            modal.style.display = "none";
        }

        // Función para confirmar el pedido (guardar)
        function confirmPedido() {
            const uuidProducto = document.getElementById("modalProductUUID").value;
            const descripcion = document.getElementById("modalProductName").textContent;
            const contenido1 = document.getElementById("modalProductContent").textContent;
            const cajasFardos = document.getElementById("cajasFardos").value;
            const unidades = document.getElementById("unidades").value;
            const observaciones = document.getElementById("observaciones").value;

            // Primero verificar si el producto fue pedido ayer
            fetch(`verificar_pedido_anterior.php?uuidProducto=${encodeURIComponent(uuidProducto)}`)
            .then(response => response.json())
            .then(data => {
                if (data.encontrado) {
                    // Si el producto fue encontrado en el pedido de ayer, mostrar confirmación
                    return Swal.fire({
                        title: '¡Advertencia!',
                        html: `Este producto ya fue solicitado ayer con las siguientes cantidades:<br>
                      <strong>Cajas/Fardos:</strong> ${data.fardo}<br>
                      <strong>Unidades:</strong> ${data.unidades}<br><br>
                      ¿Deseas agregarlo de todos modos?`,
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Sí, agregar',
                        cancelButtonText: 'Cancelar'
                    });
                }
                return { isConfirmed: true }; // Si no fue encontrado, continuar normalmente
            })
            .then(result => {
                if (result.isConfirmed) {
                    const pedidoData = {
                        UUIDProducto: uuidProducto,
                        Descripcion: descripcion,
                        Contenido1: contenido1,
                        Fardo: cajasFardos,
                        Unidades: unidades,
                        Observaciones: observaciones,
                        UUIDSucursal: uuidSucursalGlobal
                    };

                    return fetch('guardar_pedido.php', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify(pedidoData),
                    });
                }
            })
            .then(response => response ? response.json() : null)
            .then(data => {
                if (data && data.success) {
                    Swal.fire({
                        title: '¡Guardado!',
                        text: 'Pedido guardado exitosamente.',
                        icon: 'success',
                        confirmButtonText: 'Aceptar'
                    });
                    closeModal();
                } else if (data) {
                    Swal.fire({
                        title: 'Error',
                        text: 'Error al guardar el pedido: ' + data.message,
                        icon: 'error',
                        confirmButtonText: 'Aceptar'
                    });
                }
            })
            .catch((error) => {
                console.error('Error:', error);
                Swal.fire({
                    title: 'Error',
                    text: 'Ocurrió un error al procesar la solicitud.',
                    icon: 'error',
                    confirmButtonText: 'Aceptar'
                });
            });
        }

        // Botón CÓDIGO
        const codigoBtn = document.getElementById("codigoBtn");
        if (codigoBtn) {
            codigoBtn.onclick = function() {
                const sucursal = '<?php echo $_SESSION['UUIDSucursal']; ?>';
                if (sucursal === 'N1S001' || sucursal === 'N1S004' || sucursal === 'N1S003' || sucursal === 'N1S006') {
                    window.open('http://100.65.235.99/generar/', '_blank');
                } else {
                    window.open('http://26.123.15.44/GENERAR/', '_blank');
                }
            }
        }

        // Botón LACTEOS
        const lacteosBtn = document.getElementById("lacteosBtn");
        if (lacteosBtn) {
            lacteosBtn.onclick = function() {
                window.location.href = 'lacteos.php';
            }
        }

        // Modal para Ver Pedido
        const verPedidoModal = document.getElementById("verPedidoModal");
        const verPedidoBtn = document.getElementById("verPedidoBtn");
        const verPedidoModalBody = document.getElementById("verPedidoModalBody");
        const closeVerPedidoElements = document.querySelectorAll(".close-ver-pedido, .close-ver-pedido-footer");

        if (verPedidoBtn) {
            verPedidoBtn.onclick = function() {
                verPedidoModalBody.innerHTML = '<p>Cargando pedidos...</p>';
                cargarPedidos();
                verPedidoModal.style.display = "block";
            }
        }

        // función para cargar pedidos actual
        function cargarPedidos() {
            fetch('cargar_pedido.php')
                .then(response => response.json())
                .then(data => {
                    if (data.success && data.pedidos && data.pedidos.length > 0) {
                        let tableHtml = '<div class="scrollable-table"><table>' +
                            '<thead><tr>' +
                            '<th style="background-color: #007bff; color: white;">Producto</th>' +
                            '<th style="background-color: #007bff; color: white; text-align: center;">Solicitado</th>' +
                            '<th style="background-color: #007bff; color: white; text-align: center;">Fecha</th>' +
                            '<th style="background-color: #007bff; color: white; text-align: center;">Acción</th>' +
                            '</tr></thead><tbody>';
                        
                        data.pedidos.forEach(pedido => {
                            const fechaFormateada = new Date(pedido.FechaHoraRegistro).toLocaleString('es-ES', {
                                day: '2-digit',
                                month: '2-digit',
                                year: 'numeric',
                                hour: '2-digit',
                                minute: '2-digit'
                            });
                            
                            const descripcionCompleta = `${pedido.Descripcion || ''} - ${pedido.Contenido1 || ''}`;
                            const solicitado = `${pedido.Fardo || '0'} | ${pedido.Unidades || '0'}`;
                            
                            tableHtml += `<tr>
                                <td style="text-align: left;">${descripcionCompleta}</td>
                                <td style="text-align: center;">${solicitado}</td>
                                <td style="text-align: center;">${fechaFormateada}</td>
                                <td style="text-align: center;">
                                    <button class="btn-eliminar" onclick="eliminarProducto('${pedido.UUIDProducto}', '${(pedido.Descripcion || '').replace(/'/g, "\\'")}')">
                                        Eliminar
                                    </button>
                                </td>
                            </tr>`;
                        });
                        
                        tableHtml += '</tbody></table></div>';
                        verPedidoModalBody.innerHTML = tableHtml;
                    } else if (data.success && data.pedidos && data.pedidos.length === 0) {
                        verPedidoModalBody.innerHTML = '<p>No hay pedidos registrados para esta sucursal.</p>';
                    } else {
                        verPedidoModalBody.innerHTML = `<p>Error al cargar pedidos: ${data.message || 'Error desconocido.'}</p>`;
                    }
                })
                .catch(error => {
                    console.error('Error al cargar pedidos:', error);
                    verPedidoModalBody.innerHTML = '<p>Ocurrió un error al cargar los pedidos.</p>';
                });
        }

        // Función para eliminar producto del pedido
        function eliminarProducto(uuidProducto, descripcionProducto) {
            Swal.fire({
                title: '¿Estás seguro?',
                text: `¿Deseas eliminar "${descripcionProducto}" del pedido?`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc3545',
                cancelButtonColor: '#6c757d',
                confirmButtonText: 'Sí, eliminar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    fetch('eliminar.php', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({
                            UUIDProducto: uuidProducto
                        }),
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            Swal.fire({
                                title: '¡Eliminado!',
                                text: 'El producto ha sido eliminado del pedido.',
                                icon: 'success',
                                timer: 1500,
                                showConfirmButton: false
                            });
                            // Recargar la lista de pedidos
                            cargarPedidos();
                        } else {
                            Swal.fire({
                                title: 'Error',
                                text: 'Error al eliminar el producto: ' + data.message,
                                icon: 'error',
                                confirmButtonText: 'Aceptar'
                            });
                        }
                    })
                    .catch((error) => {
                        console.error('Error:', error);
                        Swal.fire({
                            title: 'Error',
                            text: 'Ocurrió un error al procesar la solicitud.',
                            icon: 'error',
                            confirmButtonText: 'Aceptar'
                        });
                    });
                }
            });
        }

        // Modal para Historial de Pedidos
        const historialModal = document.getElementById("historialModal");
        const historialBtn = document.getElementById("historialBtn");
        const historialModalBody = document.getElementById("historialModalBody");
        const closeHistorialElements = document.querySelectorAll(".close-historial, .close-historial-footer");

        if (historialBtn) {
            historialBtn.onclick = function() {
                historialModalBody.innerHTML = '<p>Cargando historial...</p>';
                cargarHistorial();
                historialModal.style.display = "block";
            }
        }

        // Función para cargar historial
        function cargarHistorial() {
            fetch('cargar_historial.php')
                .then(response => response.json())
                .then(data => {
                    if (data.success && data.historial && data.historial.length > 0) {
                        let tableHtml = '<div class="scrollable-table"><table>' +
                            '<thead><tr><th>Fecha</th><th>Archivo</th><th>Acción</th></tr></thead><tbody>';
                        data.historial.forEach(archivo => {
                            tableHtml += `<tr>
                                <td>${archivo.fecha}</td>
                                <td>${archivo.archivo}</td>
                                <td>
                                    <button class="btn-ver" onclick="verArchivo('${archivo.ruta}')">Ver Pedido</button>
                                </td>
                            </tr>`;
                        });
                        tableHtml += '</tbody></table></div>';
                        historialModalBody.innerHTML = tableHtml;
                    } else {
                        historialModalBody.innerHTML = '<p>No se encontraron archivos de respaldo para esta sucursal.</p>';
                    }
                })
                .catch(error => {
                    console.error('Error al cargar historial:', error);
                    historialModalBody.innerHTML = '<p>Ocurrió un error al cargar el historial.</p>';
                });
        }

        function verArchivo(ruta) {
            fetch(ruta)
                .then(response => response.text())
                .then(contenido => {
                    // Convertir el contenido en un array de líneas y procesar
                    const lineas = contenido.split('\n');
                    let tablaHtml = `
                        <div style="max-height: 70vh; overflow-y: auto;">
                            <table style="width: 100%; border-collapse: collapse; margin-top: 10px;">
                                <thead>
                                    <tr>
                                        <th style="padding: 12px; background-color: #007bff; color: white; text-align: left; border: 1px solid #dee2e6; width: 70%;">Producto</th>
                                        <th style="padding: 12px; background-color: #007bff; color: white; text-align: center; border: 1px solid #dee2e6; width: 30%;">Solicitado</th>
                                    </tr>
                                </thead>
                                <tbody>`;

                    // Procesar cada línea
                    lineas.forEach(linea => {
                        const partes = linea.split('","');
                        if (partes.length >= 5) { // Asegurar que la línea tiene el formato esperado
                            const producto = partes[3].replace(/"/g, '');
                            const solicitado = partes[4].replace(/"/g, '');
                            if (producto !== 'producto' && producto !== '') { // Evitar encabezado y líneas vacías
                                tablaHtml += `
                                    <tr>
                                        <td style="padding: 8px; border: 1px solid #dee2e6;">${producto}</td>
                                        <td style="padding: 8px; border: 1px solid #dee2e6; text-align: center;">${solicitado}</td>
                                    </tr>`;
                            }
                        }
                    });

                    tablaHtml += `
                                </tbody>
                            </table>
                        </div>`;

                    Swal.fire({
                        title: 'Detalle del Pedido',
                        html: tablaHtml,
                        width: '90%', // Aumentado de 80% a 90%
                        maxWidth: '1200px', // Agregado un ancho máximo
                        confirmButtonText: 'Cerrar',
                        confirmButtonColor: '#17a2b8',
                        showClass: {
                            popup: 'animate__animated animate__fadeIn'
                        },
                        hideClass: {
                            popup: 'animate__animated animate__fadeOut'
                        }
                    });
                })
                .catch(error => {
                    Swal.fire({
                        title: 'Error',
                        text: 'No se pudo cargar el contenido del archivo',
                        icon: 'error',
                        confirmButtonColor: '#dc3545'
                    });
                });
        }

        closeHistorialElements.forEach(element => {
            element.onclick = function() {
                historialModal.style.display = "none";
            }
        });

        // Actualizar el window.onclick para incluir el nuevo modal
        window.onclick = function(event) {
            if (event.target == verPedidoModal) {
                verPedidoModal.style.display = "none";
            } else if (event.target == historialModal) {
                historialModal.style.display = "none";
            }
        }
    </script>

</body>
</html>
<?php
$conn->close();
?>
