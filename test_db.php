<?php
require "vendor/autoload.php";
$env = (new Utilities\DotEnv("parameters.env"))->load();
echo "DB: " . $env["DB_DATABASE"] . "\n";
try {
    $pdo = new PDO("mysql:host=127.0.0.1;port=3306;dbname=".$env["DB_DATABASE"], $env["DB_USER"], $env["DB_PSWD"]);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Conexion OK\n";
    $tables = $pdo->query("SHOW TABLES")->fetchAll(PDO::FETCH_COLUMN);
    echo "Tablas: " . implode(", ", $tables) . "\n";
    if (in_array("products", $tables)) {
        $total = $pdo->query("SELECT COUNT(*) FROM products")->fetchColumn();
        echo "Productos en BD: " . $total . "\n";
        $sample = $pdo->query("SELECT * FROM products LIMIT 1")->fetch(PDO::FETCH_ASSOC);
        echo "Ejemplo: " . json_encode($sample) . "\n";
    } else {
        echo "La tabla products NO existe!\n";
    }
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
}

