<?php
session_start();

// Configuración de la base de datos - REEMPLAZA CON TUS VALORES
$servername = "127.0.0.1";
$username = "access_permit";
$password_db = "3VTnUWWQaIp!YgHB";
$dbname = "helensystem_data";

$error_message = '';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $uuid_sucursal = strtoupper($_POST['UUIDSucursal'] ?? '');

    if (empty($uuid_sucursal)) {
        $error_message = "Por favor, ingrese el UUID de la Sucursal.";
    } else {
        // Crear conexión
        $conn = new mysqli($servername, $username, $password_db, $dbname);

        // Verificar conexión
        if ($conn->connect_error) {
            die("Conexión fallida: " . $conn->connect_error);
        }

        // Preparar y vincular
        $stmt = $conn->prepare("SELECT UUIDSucursal FROM tblsucursales WHERE UUIDSucursal = ?");
        if ($stmt === false) {
            die("Error al preparar la consulta: " . $conn->error);
        }
        
        $stmt->bind_param("s", $uuid_sucursal);

        // Ejecutar la consulta
        $stmt->execute();
        $stmt->store_result();

        if ($stmt->num_rows > 0) {
            // Usuario autenticado
            $_SESSION['loggedin'] = true;
            $_SESSION['UUIDSucursal'] = $uuid_sucursal;
            header("Location: index.php");
            exit;
        } else {
            $error_message = "UUID de Sucursal incorrecto.";
        }

        $stmt->close();
        $conn->close();
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login de Sucursal</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f4f4f4;
        }
        .login-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }
        .login-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .login-container label {
            display: block;
            margin-bottom: 5px;
        }
        .login-container input[type="text"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .login-container input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .login-container input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Acceso Sucursales</h2>
        <?php if (!empty($error_message)): ?>
            <p class="error-message"><?php echo htmlspecialchars($error_message); ?></p>
        <?php endif; ?>
        <form action="login.php" method="post">
            <div>
                <label for="UUIDSucursal">UUID Sucursal:</label>
                <input type="text" 
                       id="UUIDSucursal" 
                       name="UUIDSucursal" 
                       style="text-transform: uppercase;" 
                       required>
            </div>
            <div>
                <input type="submit" value="Ingresar">
            </div>
        </form>
    </div>
</body>
</html>