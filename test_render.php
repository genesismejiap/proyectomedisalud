<?php
require "vendor/autoload.php";
session_start();
Utilities\Site::configure();
Utilities\Nav::setPublicNavContext();

$productos = Dao\Productos::getAllAdmin();
echo "Productos encontrados: " . count($productos) . "\n";
echo "hasProductos: " . (count($productos) > 0 ? "true" : "false") . "\n";

$result = Views\Renderer::render(
    "mnt/productos",
    array(
        "hasProductos" => count($productos) > 0,
        "productos"    => $productos,
    ),
    "layout.view.tpl",
    false
);
echo "HTML generado (primeros 500 chars):\n";
echo substr($result, 0, 500) . "\n";

