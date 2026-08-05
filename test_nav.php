<?php
require "vendor/autoload.php";
$env = (new Utilities\DotEnv("parameters.env"))->load();
\Utilities\Site::configure();

$userID = 5;

// Let's emulate Nav::setNavContext()
$filePath = 'nav.config.json';
$jsonContent = file_get_contents($filePath);
$jsonData = json_decode($jsonContent, true);
$navigationData = $jsonData["private"];

$tmpNAVIGATION = [];
foreach ($navigationData as $navEntry) {
    if (\Utilities\Security::isAuthorized($userID, $navEntry["id"], 'MNU')) {
        $tmpNAVIGATION[] = $navEntry;
    }
}
echo "Navigation for user $userID:\n";
print_r($tmpNAVIGATION);

