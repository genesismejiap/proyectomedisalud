<?php
/**
 * Controlador: Formulario CRUD de Producto (Mantenimiento)
 * Ruta: index.php?page=Mnt_Producto&mode=INS|DSP|UPD|DEL&id=X
 */
namespace Controllers\Mnt;

use Controllers\PublicController;

class Producto extends PublicController
{
    private $categories = [
        "Analgesicos",
        "Antibioticos",
        "Antiinflamatorios",
        "Vitaminas",
        "Antihistaminicos",
        "Cardiovascular",
        "Digestivo",
        "Dermatologia",
        "Otros",
    ];

    private $statusOptions = [
        "ACT" => "Activo",
        "INA" => "Inactivo",
    ];

    public function run(): void
    {
        $mode      = $_GET["mode"] ?? "INS";
        $productId = (int)($_GET["id"] ?? 0);

        // Datos por defecto
        $viewData = array(
            "mode"           => $mode,
            "productId"      => $productId,
            "productName"    => "",
            "productDescription" => "",
            "productPrice"   => "",
            "productStock"   => "",
            "productImgUrl"  => "",
            "productCategory"=> "",
            "productStatus"  => "ACT",
            "readonly"       => false,
            "showDelete"     => false,
            "modeTitle"      => $this->getModeTitle($mode),
        );

        // Cargar producto existente
        if ($productId > 0 && $mode !== "INS") {
            $prod = \Dao\Productos::getById($productId);
            if ($prod) {
                $viewData["productName"]        = $prod["productName"] ?? "";
                $viewData["productDescription"] = $prod["productDescription"] ?? "";
                $viewData["productPrice"]       = $prod["productPrice"] ?? "";
                $viewData["productStock"]       = $prod["productStock"] ?? "";
                $viewData["productImgUrl"]      = $prod["productImgUrl"] ?? "";
                $viewData["productCategory"]    = $prod["productCategory"] ?? "";
                $viewData["productStatus"]      = $prod["productStatus"] ?? "ACT";
            }
        }

        $viewData["readonly"]    = ($mode === "DSP" || $mode === "DEL");
        $viewData["showDelete"]  = ($mode === "DEL");

        // Construir options de categoria
        $catOptions = [];
        foreach ($this->categories as $cat) {
            $catOptions[] = [
                "value"    => $cat,
                "text"     => $cat,
                "selected" => ($cat === $viewData["productCategory"]),
            ];
        }
        $viewData["categoryOptions"] = $catOptions;

        // Construir options de estado
        $stOptions = [];
        foreach ($this->statusOptions as $val => $label) {
            $stOptions[] = [
                "value"    => $val,
                "text"     => $label,
                "selected" => ($val === $viewData["productStatus"]),
            ];
        }
        $viewData["statusOptions"] = $stOptions;

        // POST: guardar cambios
        if ($this->isPostBack()) {
            $name        = trim($_POST["productName"] ?? "");
            $description = trim($_POST["productDescription"] ?? "");
            $price       = (float)($_POST["productPrice"] ?? 0);
            $stock       = (int)($_POST["productStock"] ?? 0);
            $imgUrl      = trim($_POST["productImgUrl"] ?? "");
            $category    = trim($_POST["productCategory"] ?? "");
            $status      = trim($_POST["productStatus"] ?? "ACT");
            $postMode    = trim($_POST["mode"] ?? "INS");
            $postId      = (int)($_POST["productId"] ?? 0);

            $hasError = false;

            if (empty($name)) {
                $viewData["errorName"] = "El nombre del producto es requerido.";
                $hasError = true;
            }
            if ($price <= 0) {
                $viewData["errorPrice"] = "El precio debe ser mayor a 0.";
                $hasError = true;
            }
            if ($stock < 0) {
                $viewData["errorStock"] = "El stock no puede ser negativo.";
                $hasError = true;
            }

            if (!$hasError) {
                if ($postMode === "INS") {
                    \Dao\Productos::insertProduct($name, $description, $price, $imgUrl, $stock, $category, $status);
                } elseif ($postMode === "UPD") {
                    \Dao\Productos::updateProduct($postId, $name, $description, $price, $imgUrl, $stock, $category, $status);
                } elseif ($postMode === "DEL") {
                    \Dao\Productos::deleteProduct($postId);
                }
                \Utilities\Site::redirectTo("index.php?page=Mnt_Productos");
                die();
            }

            // repoblar form con datos enviados
            $viewData["productName"]        = $name;
            $viewData["productDescription"] = $description;
            $viewData["productPrice"]       = $price;
            $viewData["productStock"]       = $stock;
            $viewData["productImgUrl"]      = $imgUrl;
            $viewData["readonly"]           = false;
            $viewData["showDelete"]         = false;
        }

        \Views\Renderer::render("mnt/producto", $viewData);
    }

    private function getModeTitle(string $mode): string
    {
        $titles = [
            "INS" => "Nuevo Producto",
            "DSP" => "Detalle del Producto",
            "UPD" => "Editar Producto",
            "DEL" => "Eliminar Producto",
        ];
        return $titles[$mode] ?? "Producto";
    }
}
