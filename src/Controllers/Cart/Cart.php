<?php

namespace Controllers\Cart;

use Controllers\PrivateController;
use Dao\Cart\Cart as CartDao;

class Cart extends PrivateController
{
    public function run(): void
    {
        /*
         * Obtiene el código del usuario que inició sesión.
         * Revisa la nota al final sobre este método.
         */
        $userCod = \Utilities\Security::getUserId();

        if (empty($userCod)) {
            \Utilities\Site::redirectTo(
                "index.php?page=Sec_Login"
            );
            return;
        }

        if ($this->isPostBack()) {
            $action = $_POST["action"] ?? "";
            $productId = intval($_POST["productId"] ?? 0);
            $quantity = intval($_POST["quantity"] ?? 1);

            /*
             * AGREGAR PRODUCTO
             */
            if ($action === "add" && $productId > 0) {
                $product = \Dao\Productos::getById($productId);

                if ($product) {
                    $stock = intval(
                        $product["productStock"] ?? 0
                    );

                    $price = floatval(
                        $product["productPrice"] ?? 0
                    );

                    if ($quantity < 1) {
                        $quantity = 1;
                    }

                    if ($quantity > $stock) {
                        $quantity = $stock;
                    }

                    if ($stock > 0 && $quantity > 0) {
                        CartDao::addToCart(
                            $userCod,
                            $productId,
                            $quantity,
                            $price
                        );
                    }
                }
            }

            /*
             * ACTUALIZAR CANTIDAD
             */
            elseif (
                $action === "update" &&
                $productId > 0
            ) {
                $product = \Dao\Productos::getById($productId);

                if ($product) {
                    $stock = intval(
                        $product["productStock"] ?? 0
                    );

                    if ($quantity > $stock) {
                        $quantity = $stock;
                    }

                    CartDao::updateQuantity(
                        $userCod,
                        $productId,
                        $quantity
                    );
                }
            }

            /*
             * ELIMINAR PRODUCTO
             */
            elseif (
                $action === "delete" &&
                $productId > 0
            ) {
                CartDao::removeFromCart(
                    $userCod,
                    $productId
                );
            }

            /*
             * VACIAR CARRITO
             */
            elseif ($action === "clear") {
                CartDao::clearCart($userCod);
            }

            \Utilities\Site::redirectTo(
                "index.php?page=Cart_Cart"
            );
            return;
        }

        /*
         * Obtiene solamente el carrito del usuario actual.
         */
        $cartData = CartDao::getCartSummary($userCod);

        $items = array();

        foreach ($cartData["items"] as $item) {
            $items[] = array(
                "productId" => $item["productId"],
                "productImgUrl" => $item["productImgUrl"],
                "productName" => $item["productName"],
                "productCategory" => $item["productCategory"],

                "crrprc" => number_format(
                    floatval($item["crrprc"]),
                    2,
                    ".",
                    ","
                ),

                "crrctd" => intval(
                    $item["crrctd"]
                ),

                "productStock" => intval(
                    $item["productStock"]
                ),

                "subtotal" => number_format(
                    floatval($item["subtotal"]),
                    2,
                    ".",
                    ","
                )
            );
        }

        $viewData = array(
            "hasItems" => count($items) > 0,
            "items" => $items,
            "itemCount" => $cartData["itemCount"],

            "subtotal" => number_format(
                $cartData["rawSubtotal"],
                2,
                ".",
                ","
            ),

            "isv" => number_format(
                $cartData["rawIsv"],
                2,
                ".",
                ","
            ),

            "total" => number_format(
                $cartData["rawTotal"],
                2,
                ".",
                ","
            )
        );

        \Views\Renderer::render(
            "cart/cart",
            $viewData
        );
    }
}
?>