<?php

namespace Controllers\Checkout;

use Controllers\PublicController;

class Accept extends PublicController
{
    public function run(): void
    {
        $dataview = array();
        $token = $_GET["token"] ?: "";
        $session_token = $_SESSION["orderid"] ?: "";
        if ($token !== "" && $token == $session_token) {
            $PayPalRestApi = new \Utilities\PayPal\PayPalRestApi(
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_ID"),
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_SECRET")
            );
            $result = $PayPalRestApi->captureOrder($session_token);
            $dataview["orderjson"] = json_encode($result, JSON_PRETTY_PRINT);

            if (isset($result->id)) {
                $dataview["hasOrder"] = true;
                $dataview["orderId"] = $result->id;
                $dataview["status"] = $result->status;
                
                $paypalInfo = $result->payment_source->paypal ?? null;
                if ($paypalInfo) {
                    $dataview["payerEmail"] = $paypalInfo->email_address ?? "";
                    $dataview["payerName"] = ($paypalInfo->name->given_name ?? "") . " " . ($paypalInfo->name->surname ?? "");
                }
                
                $purchase_unit = $result->purchase_units[0] ?? null;
                if ($purchase_unit) {
                    $dataview["shippingName"] = $purchase_unit->shipping->name->full_name ?? "";
                    $address = $purchase_unit->shipping->address ?? null;
                    if ($address) {
                        $dataview["shippingAddress"] = trim(($address->address_line_1 ?? "") . ", " . 
                                                       ($address->admin_area_2 ?? "") . ", " . 
                                                       ($address->admin_area_1 ?? ""), ", ");
                        $dataview["country"] = $address->country_code ?? "";
                    }
                }
            }
        } else {
            $dataview["orderjson"] = "No Order Available!!!";
            $dataview["hasOrder"] = false;
        }
        \Views\Renderer::render("paypal/accept", $dataview);
    }
}
