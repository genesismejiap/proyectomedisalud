<?php
/**
 * Controlador: Lista de Productos (Mantenimiento)
 * Ruta: index.php?page=Mnt_Productos
 */
namespace Controllers\Mnt;

use Controllers\PrivateController;

class Productos extends PrivateController
{
    public function run(): void
    {
        \Utilities\Context::setContext("layoutFile", "privatelayout");

        $productos = \Dao\Productos::getAllAdmin();

        \Views\Renderer::render(
            "mnt/productos",
            array(
                "hasProductos" => count($productos) > 0,
                "productos"    => $productos,
            )
        );
    }
}
