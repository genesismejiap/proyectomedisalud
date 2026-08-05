<?php
require "vendor/autoload.php";
$env = (new Utilities\DotEnv("parameters.env"))->load();
try {
    $pdo = new PDO("mysql:host=127.0.0.1;port=3306;dbname=".$env["DB_DATABASE"], $env["DB_USER"], $env["DB_PSWD"]);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $stmt = $pdo->query("SELECT usercod, useremail, username FROM usuario ORDER BY usercod DESC LIMIT 10");
    print_r($stmt->fetchAll(PDO::FETCH_ASSOC));
    
    $stmt = $pdo->query("SELECT * FROM roles_usuarios ORDER BY usercod DESC LIMIT 10");
    print_r($stmt->fetchAll(PDO::FETCH_ASSOC));
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
}
