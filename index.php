<?php

/**
 * Entrada directa del sistema.
 *
 * En cPanel el Document Root suele ser public_html, así que este es el archivo
 * que se ejecuta al abrir el dominio. Delega en el mismo Front Controller de
 * siempre, pero avisa de que la raíz del sitio es este directorio y no public/.
 * Con eso los enlaces a CSS/JS apuntan a /public/assets y funcionan sin tener
 * que cambiar el Document Root ni depender de mod_rewrite.
 */

define('APP_DESDE_RAIZ', true);

// El Front Controller devuelve false cuando la petición es un archivo estático
// del servidor embebido de PHP. Hay que propagar ese false desde aqui, porque
// un return dentro del archivo incluido solo sale de la inclusión.
$resultado = require_once __DIR__ . '/public/index.php';
if ($resultado === false) {
    return false;
}
