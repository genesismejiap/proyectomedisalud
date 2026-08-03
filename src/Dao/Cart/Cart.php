<?php

namespace Dao\Cart;

class Cart extends \Dao\Table
{
    public static function getCartItems($userCod)
    {
        $sqlstr = "SELECT c.usercod, c.productId, c.crrctd, c.crrprc, c.crrfching,
                          p.productName, p.productImgUrl, p.productStock, p.productCategory,
                          (c.crrctd * c.crrprc) AS subtotal
                   FROM carretilla c
                   INNER JOIN products p ON c.productId = p.productId
                   WHERE c.usercod = :usercod;";
        return self::obtenerRegistros($sqlstr, array("usercod" => $userCod));
    }

    public static function addToCart($userCod, $productId, $quantity, $price)
    {
        // Verificar si el producto ya existe en el carrito
        $sqlCheck = "SELECT crrctd FROM carretilla WHERE usercod = :usercod AND productId = :productId;";
        $existing = self::obtenerUnRegistro($sqlCheck, array("usercod" => $userCod, "productId" => $productId));

        if ($existing) {
            $newQuantity = $existing["crrctd"] + $quantity;
            $sqlUpdate = "UPDATE carretilla SET crrctd = :crrctd, crrfching = NOW() 
                          WHERE usercod = :usercod AND productId = :productId;";
            return self::executeNonQuery($sqlUpdate, array(
                "crrctd" => $newQuantity,
                "usercod" => $userCod,
                "productId" => $productId
            ));
        } else {
            $sqlInsert = "INSERT INTO carretilla (usercod, productId, crrctd, crrprc, crrfching) 
                          VALUES (:usercod, :productId, :crrctd, :crrprc, NOW());";
            return self::executeNonQuery($sqlInsert, array(
                "usercod" => $userCod,
                "productId" => $productId,
                "crrctd" => $quantity,
                "crrprc" => $price
            ));
        }
    }

    public static function updateQuantity($userCod, $productId, $quantity)
    {
        if ($quantity <= 0) {
            return self::removeFromCart($userCod, $productId);
        }
        $sqlstr = "UPDATE carretilla SET crrctd = :crrctd, crrfching = NOW() 
                   WHERE usercod = :usercod AND productId = :productId;";
        return self::executeNonQuery($sqlstr, array(
            "crrctd" => $quantity,
            "usercod" => $userCod,
            "productId" => $productId
        ));
    }

    public static function removeFromCart($userCod, $productId)
    {
        $sqlstr = "DELETE FROM carretilla WHERE usercod = :usercod AND productId = :productId;";
        return self::executeNonQuery($sqlstr, array("usercod" => $userCod, "productId" => $productId));
    }

    public static function clearCart($userCod)
    {
        $sqlstr = "DELETE FROM carretilla WHERE usercod = :usercod;";
        return self::executeNonQuery($sqlstr, array("usercod" => $userCod));
    }

    public static function getCartSummary($userCod)
    {
        $items = self::getCartItems($userCod);
        $subtotal = 0;
        $itemCount = 0;

        foreach ($items as $item) {
            $subtotal += floatval($item["subtotal"]);
            $itemCount += intval($item["crrctd"]);
        }

        $isv = round($subtotal * 0.15, 2);
        $total = round($subtotal + $isv, 2);

        return array(
            "items" => $items,
            "itemCount" => $itemCount,
            "subtotal" => number_format($subtotal, 2, '.', ''),
            "isv" => number_format($isv, 2, '.', ''),
            "total" => number_format($total, 2, '.', ''),
            "rawSubtotal" => $subtotal,
            "rawIsv" => $isv,
            "rawTotal" => $total
        );
    }
}
