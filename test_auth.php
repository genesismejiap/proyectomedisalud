<?php
require "vendor/autoload.php";
$env = (new Utilities\DotEnv("parameters.env"))->load();
\Utilities\Site::configure();

$userCod = 5;

echo "Has Menu_MisTransacciones? " . ( \Dao\Security\Security::getFeatureByUsuario($userCod, "Menu_MisTransacciones") ? "YES" : "NO" ) . "\n";
echo "Has Controllers\\Cart\\Cart? " . ( \Dao\Security\Security::getFeatureByUsuario($userCod, "Controllers\\Cart\\Cart") ? "YES" : "NO" ) . "\n";
