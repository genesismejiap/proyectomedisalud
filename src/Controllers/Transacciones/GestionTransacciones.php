<?php

namespace Controllers\Transacciones;

use Controllers\PrivateController;

class GestionTransacciones extends PrivateController
{
    public function run(): void
    {
        // Si viene un ID específico por GET para ver el detalle modal/pantalla
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

        // Totales para las tarjetas de estadísticas del panel
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
