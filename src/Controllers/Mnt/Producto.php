<?php

namespace Controllers\Mnt;

use Controllers\PrivateController;

class Producto extends PrivateController
{
    const IMG_DIR = "public/imgs/products/";

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
            "hasImage"       => false,
            "modeTitle"      => $this->getModeTitle($mode),
        );

       
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
        $viewData["hasImage"]    = ($viewData["productImgUrl"] !== "");

        
        $catOptions = [];
        foreach ($this->categories as $cat) {
            $catOptions[] = [
                "value"    => $cat,
                "text"     => $cat,
                "selected" => ($cat === $viewData["productCategory"]),
            ];
        }
        $viewData["categoryOptions"] = $catOptions;

       
        $stOptions = [];
        foreach ($this->statusOptions as $val => $label) {
            $stOptions[] = [
                "value"    => $val,
                "text"     => $label,
                "selected" => ($val === $viewData["productStatus"]),
            ];
        }
        $viewData["statusOptions"] = $stOptions;

        
        if ($this->isPostBack()) {
            $postMode = trim($_POST["mode"] ?? "INS");
            $postId   = (int)($_POST["productId"] ?? 0);

           
            if ($postMode === "DEL" && $postId > 0) {
                \Dao\Productos::deleteProduct($postId);
                \Utilities\Site::redirectTo("index.php?page=Mnt_Productos");
                die();
            }

            $name        = trim($_POST["productName"] ?? "");
            $description = trim($_POST["productDescription"] ?? "");
            $price       = (float)($_POST["productPrice"] ?? 0);
            $stock       = (int)($_POST["productStock"] ?? 0);
            $imgUrl      = trim($_POST["productImgUrl"] ?? "");
            $category    = trim($_POST["productCategory"] ?? "");
            $status      = trim($_POST["productStatus"] ?? "ACT");
            $deleteImage = isset($_POST["deleteImage"]);

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

            
            $currentImgUrl = "";
            if ($postId > 0) {
                $current = \Dao\Productos::getById($postId);
                if ($current) {
                    $currentImgUrl = $current["productImgUrl"] ?? "";
                }
            }

          
            if ($deleteImage) {
                $this->deleteLocalImage($currentImgUrl);
                if ($imgUrl === $currentImgUrl) {
                    $imgUrl = "";
                }
            }

           
            $upload = $this->processImageUpload();
            if ($upload["error"] !== "") {
                $viewData["errorImg"] = $upload["error"];
                $hasError = true;
            } elseif ($upload["path"] !== "") {
                $this->deleteLocalImage($currentImgUrl);
                $imgUrl = $upload["path"];
            }

            if (!$hasError) {
                if ($postMode === "INS") {
                    \Dao\Productos::insertProduct($name, $description, $price, $imgUrl, $stock, $category, $status);
                } elseif ($postMode === "UPD") {
                    \Dao\Productos::updateProduct($postId, $name, $description, $price, $imgUrl, $stock, $category, $status);
                }
                \Utilities\Site::redirectTo("index.php?page=Mnt_Productos");
                die();
            }

          
            $viewData["productName"]        = $name;
            $viewData["productDescription"] = $description;
            $viewData["productPrice"]       = $price;
            $viewData["productStock"]       = $stock;
            $viewData["productImgUrl"]      = $imgUrl;
            $viewData["hasImage"]           = ($imgUrl !== "");
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

    
    private function processImageUpload(): array
    {
        $result = array("path" => "", "error" => "");

        if (!isset($_FILES["productImgFile"]) || $_FILES["productImgFile"]["error"] === UPLOAD_ERR_NO_FILE) {
            return $result;
        }

        $file = $_FILES["productImgFile"];

        if ($file["error"] !== UPLOAD_ERR_OK) {
            $result["error"] = "Ocurrió un error al subir el archivo (código " . $file["error"] . ").";
            return $result;
        }
        if ($file["size"] > 2 * 1024 * 1024) {
            $result["error"] = "La imagen no debe superar los 2MB.";
            return $result;
        }

        $ext = strtolower(pathinfo($file["name"], PATHINFO_EXTENSION));
        $allowed = array("jpg", "jpeg", "png", "gif", "webp");
        if (!in_array($ext, $allowed)) {
            $result["error"] = "Formato no permitido. Use JPG, PNG, GIF o WEBP.";
            return $result;
        }
        if (getimagesize($file["tmp_name"]) === false) {
            $result["error"] = "El archivo subido no es una imagen válida.";
            return $result;
        }

        if (!is_dir(self::IMG_DIR)) {
            mkdir(self::IMG_DIR, 0777, true);
        }

        $fileName = uniqid("prd_") . "." . $ext;
        if (!move_uploaded_file($file["tmp_name"], self::IMG_DIR . $fileName)) {
            $result["error"] = "No fue posible guardar la imagen en el servidor.";
            return $result;
        }

        $result["path"] = self::IMG_DIR . $fileName;
        return $result;
    }

   
    private function deleteLocalImage(string $imgUrl): void
    {
        if ($imgUrl !== "" && strpos($imgUrl, self::IMG_DIR) === 0 && file_exists($imgUrl)) {
            unlink($imgUrl);
        }
    }
}
