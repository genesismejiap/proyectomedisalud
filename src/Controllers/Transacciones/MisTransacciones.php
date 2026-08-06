<?php

namespace Controllers\Transacciones;

use Controllers\PrivateController;
use Utilities\Security;

class MisTransacciones extends PrivateController
{
    public function run(): void
    {
        $userId = Security::getUserId();

      
        $selectedTxnId = isset($_GET["txnid"]) ? intval($_GET["txnid"]) : 0;
        $selectedTxn = null;
        $selectedDetails = array();

        if ($selectedTxnId > 0) {
            $selectedTxn = \Dao\Transaccion::getTransactionById($selectedTxnId);
            
            if ($selectedTxn) {
                $selectedDetails = \Dao\Transaccion::getTransactionDetails($selectedTxnId);
            } else {
                $selectedTxn = null;
            }
        }

        $transacciones = \Dao\Transaccion::getAllTransactions();
        $hasTransacciones = count($transacciones) > 0;

        $viewData = array(
            "transacciones" => $transacciones,
            "hasTransacciones" => $hasTransacciones,
            "selectedTxn" => $selectedTxn,
            "selectedDetails" => $selectedDetails,
            "hasSelected" => !empty($selectedTxn)
        );

        \Views\Renderer::render("transacciones/mis_transacciones", $viewData);
    }
}
