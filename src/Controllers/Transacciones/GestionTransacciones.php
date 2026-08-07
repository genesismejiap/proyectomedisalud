<?php

namespace Controllers\Transacciones;

use Controllers\PrivateController;

class GestionTransacciones extends PrivateController
{
    public function run(): void
    {
        
        $selectedTxnId = isset($_GET["txnid"]) ? intval($_GET["txnid"]) : 0;
        $selectedTxn = null;
        $selectedDetails = array();

        if ($selectedTxnId > 0) {
            $selectedTxn = \Dao\Transaccion::getTransactionById($selectedTxnId);
            if ($selectedTxn) {
                $selectedDetails = \Dao\Transaccion::getTransactionDetails($selectedTxnId);
            }
        }

        $transacciones = \Dao\Transaccion::getAllTransactions();
        $hasTransacciones = count($transacciones) > 0;

        
        $totalVentas = 0;
        foreach ($transacciones as $txn) {
            $totalVentas += floatval($txn["txntotal"]);
        }

        $viewData = array(
            "transacciones" => $transacciones,
            "hasTransacciones" => $hasTransacciones,
            "totalVentas" => number_format($totalVentas, 2),
            "totalTransacciones" => count($transacciones),
            "selectedTxn" => $selectedTxn,
            "selectedTxnId" => $selectedTxnId,
            "selectedDetails" => $selectedDetails,
            "hasSelected" => !empty($selectedTxn)
        );

        \Views\Renderer::render("transacciones/gestion_transacciones", $viewData);
    }
}
