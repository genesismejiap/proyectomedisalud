<?php

namespace Dao;

class Productos extends Table
{
    public static function getAll()
    {
        $sqlstr = "SELECT * FROM products WHERE productStatus = 'ACT';";
        return self::obtenerRegistros($sqlstr, array());
    }

    public static function getById($productId)
    {
        $sqlstr = "SELECT * FROM products WHERE productId = :productId;";
        return self::obtenerUnRegistro($sqlstr, array("productId" => $productId));
    }

    public static function getByCategory($category)
    {
        if (empty($category) || $category === "Todas") {
            return self::getAll();
        }
        $sqlstr = "SELECT * FROM products WHERE productStatus = 'ACT' AND productCategory = :category;";
        return self::obtenerRegistros($sqlstr, array("category" => $category));
    }

    public static function searchProducts($query, $category = "")
    {
        $params = array("query" => "%" . $query . "%");
        $sqlstr = "SELECT * FROM products WHERE productStatus = 'ACT' AND (productName LIKE :query OR productDescription LIKE :query)";
        if (!empty($category) && $category !== "Todas") {
            $sqlstr .= " AND productCategory = :category";
            $params["category"] = $category;
        }
        $sqlstr .= ";";
        return self::obtenerRegistros($sqlstr, $params);
    }

    public static function getCategories()
    {
        $sqlstr = "SELECT DISTINCT productCategory FROM products WHERE productStatus = 'ACT' ORDER BY productCategory ASC;";
        return self::obtenerRegistros($sqlstr, array());
    }

    public static function updateStock($productId, $quantityDeduction)
    {
        $sqlstr = "UPDATE products SET productStock = productStock - :ctd WHERE productId = :productId AND productStock >= :ctd;";
        return self::executeNonQuery($sqlstr, array("ctd" => $quantityDeduction, "productId" => $productId));
    }

    public static function insertProduct($name, $description, $price, $imgUrl, $stock, $category, $status = 'ACT')
    {
        $sqlstr = "INSERT INTO products (productName, productDescription, productPrice, productImgUrl, productStock, productCategory, productStatus)
                   VALUES (:name, :description, :price, :imgUrl, :stock, :category, :status);";
        return self::executeNonQuery($sqlstr, array(
            "name" => $name,
            "description" => $description,
            "price" => $price,
            "imgUrl" => $imgUrl,
            "stock" => $stock,
            "category" => $category,
            "status" => $status
        ));
    }

    public static function updateProduct($productId, $name, $description, $price, $imgUrl, $stock, $category, $status)
    {
        $sqlstr = "UPDATE products SET 
                    productName = :name,
                    productDescription = :description,
                    productPrice = :price,
                    productImgUrl = :imgUrl,
                    productStock = :stock,
                    productCategory = :category,
                    productStatus = :status
                   WHERE productId = :productId;";
        return self::executeNonQuery($sqlstr, array(
            "name" => $name,
            "description" => $description,
            "price" => $price,
            "imgUrl" => $imgUrl,
            "stock" => $stock,
            "category" => $category,
            "status" => $status,
            "productId" => $productId
        ));
    }

    public static function deleteProduct($productId)
    {
        $sqlstr = "UPDATE products SET productStatus = 'INA' WHERE productId = :productId;";
        return self::executeNonQuery($sqlstr, array("productId" => $productId));
    }

    public static function getAllAdmin()
    {
        $sqlstr = "SELECT * FROM products ORDER BY productId DESC;";
        return self::obtenerRegistros($sqlstr, array());
    }
}
