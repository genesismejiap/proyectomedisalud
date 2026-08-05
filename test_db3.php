<?php
require "vendor/autoload.php";
$env = (new Utilities\DotEnv("parameters.env"))->load();
$pdo = new PDO("mysql:host=127.0.0.1;port=3306;dbname=".$env["DB_DATABASE"], $env["DB_USER"], $env["DB_PSWD"]);
$pdo->query("INSERT IGNORE INTO roles_usuarios (usercod, rolescod, roleuserest, roleuserfch) VALUES (3, 'CLIENT', 'ACT', NOW())");
echo 'Fixed user 3';
