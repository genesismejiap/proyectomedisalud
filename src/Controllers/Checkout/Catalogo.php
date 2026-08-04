<?php
/**
 * PHP Version 7.2
 * Checkout
 *
 * @category Controller
 * @package  Controllers\Checkout
 * @author   Orlando J Betancourth <orlando.betancourth@gmail.com>
 * @license  Comercial http://
 * @version  CVS:1.0.0
 * @link     http://url.com
 */
 namespace Controllers\Checkout;

// ---------------------------------------------------------------
// Sección de imports
// ---------------------------------------------------------------
use Controllers\PrivateController;

/**
 * Catalogo
 *
 * @category Public
 * @package  Controllers\Checkout;
 * @author   Orlando J Betancourth <orlando.betancourth@gmail.com>
 * @license  MIT http://
 * @link     http://
 */
class Catalogo extends PrivateController
{
    /**
     * Runs the controller
     *
     * @return void
     */
    public function run():void
    {
        \Utilities\Site::addLink("public/css/catalog.css");

        $searchQuery = trim($_GET["search"] ?? "");
        $categoryFilter = trim($_GET["category"] ?? "");

        // Obtener productos según filtros
        if (!empty($searchQuery)) {
            $productos = \Dao\Productos::searchProducts($searchQuery, $categoryFilter);
        } elseif (!empty($categoryFilter)) {
            $productos = \Dao\Productos::getByCategory($categoryFilter);
        } else {
            $productos = \Dao\Productos::getAll();
        }

        // Agregar flag de stock
        foreach ($productos as &$prod) {
            $prod["hasStock"] = intval($prod["productStock"] ?? 0) > 0;
        }

        // Obtener categorías para los filtros
        $dbCategories = \Dao\Productos::getCategories();
        $categories = [];
        $categories[] = [
            "categoryName" => "Todas",
            "selected" => empty($categoryFilter) || $categoryFilter === "Todas",
        ];
        foreach ($dbCategories as $cat) {
            $categories[] = [
                "categoryName" => $cat["productCategory"],
                "selected" => ($cat["productCategory"] === $categoryFilter),
            ];
        }

        \Views\Renderer::render("checkout/catalogo", array(
            "productos"   => $productos,
            "categories"  => $categories,
            "searchQuery" => $searchQuery,
        ));
    }
}

