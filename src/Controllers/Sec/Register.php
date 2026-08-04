<?php

namespace Controllers\Sec;

use Controllers\PublicController;
use Utilities\Validators;

class Register extends PublicController
{
    private $txtEmail = "";
    private $txtPswd = "";
    private $errorEmail = "";
    private $errorPswd = "";
    private $generalError = "";
    private $hasErrors = false;

    public function run(): void
    {
        if ($this->isPostBack()) {
            $this->txtEmail = trim(
                $_POST["txtEmail"] ?? ""
            );

            $this->txtPswd =
                $_POST["txtPswd"] ?? "";

            if (!Validators::IsValidEmail(
                $this->txtEmail
            )) {
                $this->errorEmail =
                    "El correo no tiene el formato adecuado.";

                $this->hasErrors = true;
            }

            if (!Validators::IsValidPassword(
                $this->txtPswd
            )) {
                $this->errorPswd =
                    "La contraseña debe tener al menos 8 " .
                    "caracteres, una mayúscula, un número " .
                    "y un carácter especial.";

                $this->hasErrors = true;
            }

            if (
                !$this->hasErrors &&
                \Dao\Security\Security::getUsuarioByEmail(
                    $this->txtEmail
                )
            ) {
                $this->errorEmail =
                    "Este correo ya está registrado.";

                $this->hasErrors = true;
            }

            if (!$this->hasErrors) {
                try {
                    $created =
                        \Dao\Security\Security::newUsuario(
                            $this->txtEmail,
                            $this->txtPswd
                        );

                    if ($created) {
                        $newUser =
                            \Dao\Security\Security
                                ::getUsuarioByEmail(
                                    $this->txtEmail
                                );

                        if (!$newUser) {
                            throw new \Exception(
                                "No se encontró el usuario creado."
                            );
                        }

                        $roleAssigned =
                            \Dao\Security\Security
                                ::addUserToRole(
                                    $newUser["usercod"],
                                    "CLIENT"
                                );

                        if (!$roleAssigned) {
                            throw new \Exception(
                                "No se pudo asignar el rol."
                            );
                        }

                        \Utilities\Site::redirectToWithMsg(
                            "index.php?page=sec_login",
                            "¡Usuario registrado satisfactoriamente!"
                        );

                        return;
                    }

                    $this->generalError =
                        "No se pudo crear la cuenta.";
                } catch (\Throwable $ex) {
                    error_log(
                        "Error de registro: " .
                        $ex->getMessage()
                    );

                    $this->generalError =
                        "Ocurrió un error al registrar la cuenta.";
                }
            }
        }

        $viewData = get_object_vars($this);

        \Views\Renderer::render(
            "security/sigin",
            $viewData
        );
    }
}
?>