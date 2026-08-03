<?php

use Utilities\Context;
use Utilities\Site;

require __DIR__ . '/vendor/autoload.php';

session_start();

try {
    Site::configure();

    $pageRequest = Site::getPageRequest();

    $instance = new $pageRequest();
    $instance->run();

    die();

} catch (\Controllers\PrivateNoAuthException $ex) {

    $instance = new \Controllers\NoAuth();
    $instance->run();

    die();

} catch (\Controllers\PrivateNoLoggedException $ex) {

    $redirTo = urlencode(
        Context::getContextByKey("request_uri")
    );

    Site::redirectTo(
        "index.php?page=sec.login&redirto=" . $redirTo
    );

    die();

} catch (Exception $ex) {

    echo "<pre>";
    echo "EXCEPTION:\n";
    echo $ex->getMessage() . "\n\n";
    echo "Archivo: " . $ex->getFile() . "\n";
    echo "Línea: " . $ex->getLine() . "\n\n";
    echo $ex->getTraceAsString();
    echo "</pre>";

    die();

} catch (Error $ex) {

    echo "<pre>";
    echo "ERROR:\n";
    echo $ex->getMessage() . "\n\n";
    echo "Archivo: " . $ex->getFile() . "\n";
    echo "Línea: " . $ex->getLine() . "\n\n";
    echo $ex->getTraceAsString();
    echo "</pre>";

    die();
}