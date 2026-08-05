<?php
require "vendor/autoload.php";
$env = (new Utilities\DotEnv("parameters.env"))->load();
try {
    $pdo = new PDO("mysql:host=127.0.0.1;port=3306;dbname=".$env["DB_DATABASE"], $env["DB_USER"], $env["DB_PSWD"]);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $stmt = $pdo->query("SELECT fncod FROM funciones WHERE fncod LIKE '%Cart%'");
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($rows as $row) {
        echo "DB Value: [" . $row['fncod'] . "]\n";
        echo "Length: " . strlen($row['fncod']) . "\n";
    }
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
}
