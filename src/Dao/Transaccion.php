<?php

namespace Dao;

class Transaccion extends Table
{
    public static function createTransaction($userCod, $amount, $isv, $total, $payMethod = 'PAYPAL_SANDBOX', $reference = null)
    {
        if (!$reference) {
            $reference = "TXN-" . date("Ymd") . "-" . rand(1000, 9999);
        }

        $sqlstr = "INSERT INTO transacciones (txnreference, usercod, txnfch, txnamount, txnisv, txntotal, txnstt, txnpaymethod)
                   VALUES (:txnreference, :usercod, NOW(), :txnamount, :txnisv, :txntotal, 'COMPLETED', :txnpaymethod);";
        
        $params = array(
            "txnreference" => $reference,
            "usercod" => $userCod,
            "txnamount" => $amount,
            "txnisv" => $isv,
            "txntotal" => $total,
            "txnpaymethod" => $payMethod
        );

        self::executeNonQuery($sqlstr, $params);
        return self::getLastId();
    }

    public static function saveTransactionDetail($txnId, $productId, $prdName, $prdPrice, $prdCtd, $prdSubtotal)
    {
        $sqlstr = "INSERT INTO transacciones_detalle (txnid, productId, prdname, prdprice, prdctd, prdsubtotal)
                   VALUES (:txnid, :productId, :prdname, :prdprice, :prdctd, :prdsubtotal);";
        
        return self::executeNonQuery($sqlstr, array(
            "txnid" => $txnId,
            "productId" => $productId,
            "prdname" => $prdName,
            "prdprice" => $prdPrice,
            "prdctd" => $prdCtd,
            "prdsubtotal" => $prdSubtotal
        ));
    }

    public static function getTransactionsByUser($userCod)
    {
        $sqlstr = "SELECT t.*, DATE_FORMAT(t.txnfch, '%d/%m/%Y %H:%i') as fecha_formateada,
                   (SELECT COUNT(*) FROM transacciones_detalle d WHERE d.txnid = t.txnid) as total_items
                   FROM transacciones t
                   WHERE t.usercod = :usercod
                   ORDER BY t.txnid DESC;";
        return self::obtenerRegistros($sqlstr, array("usercod" => $userCod));
    }

    public static function getAllTransactions()
    {
        $sqlstr = "SELECT t.*, u.username, u.useremail, DATE_FORMAT(t.txnfch, '%d/%m/%Y %H:%i') as fecha_formateada,
                   (SELECT COUNT(*) FROM transacciones_detalle d WHERE d.txnid = t.txnid) as total_items
                   FROM transacciones t
                   INNER JOIN usuario u ON t.usercod = u.usercod
                   ORDER BY t.txnid DESC;";
        return self::obtenerRegistros($sqlstr, array());
    }

    public static function getTransactionById($txnId)
    {
        $sqlstr = "SELECT t.*, u.username, u.useremail, DATE_FORMAT(t.txnfch, '%d/%m/%Y %H:%i') as fecha_formateada
                   FROM transacciones t
                   INNER JOIN usuario u ON t.usercod = u.usercod
                   WHERE t.txnid = :txnid;";
        return self::obtenerUnRegistro($sqlstr, array("txnid" => $txnId));
    }

    public static function getTransactionDetails($txnId)
    {
        $sqlstr = "SELECT d.*, p.productImgUrl
                   FROM transacciones_detalle d
                   LEFT JOIN products p ON d.productId = p.productId
                   WHERE d.txnid = :txnid;";
        return self::obtenerRegistros($sqlstr, array("txnid" => $txnId));
    }

    public static function logBitacora($programa, $descripcion, $observacion = "", $tipo = "INFO", $usuario = null)
    {
        $sqlstr = "INSERT INTO bitacora (bitacorafch, bitprograma, bitdescripcion, bitobservacion, bitTipo, bitusuario)
                   VALUES (NOW(), :bitprograma, :bitdescripcion, :bitobservacion, :bitTipo, :bitusuario);";
        return self::executeNonQuery($sqlstr, array(
            "bitprograma" => $programa,
            "bitdescripcion" => $descripcion,
            "bitobservacion" => $observacion,
            "bitTipo" => $tipo,
            "bitusuario" => $usuario
        ));
    }
}
