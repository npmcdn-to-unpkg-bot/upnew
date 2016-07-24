<?php
$sMetadataVersion = '1.1';
/**
 * Poperty of * - this is NOT Freeware.
 *
 * @link      http://www.dencodo.com
 * @copyright (C) dencodo
 */
$aModule = array(
    'id'                            => 'upsiroop',
    'title'                         => 'Siroop Artikel',
    'description'                   => 'Additional infos',
    'thumbnail'                     => 'xx.png',
    'version'                       => '0.96',
    'author'                        => '',
    'email'                         => '',
    'url'                           => '',
    'templates'    => array(
        'category_siroop.tpl'  => 'uppl/sirooptaxonomy/views/admin/tpl/category_siroop.tpl',
    ),
    'files' => array(
        'category_siroop' => 'uppl/sirooptaxonomy/controllers/admin/category_siroop.php',
    ),
);
