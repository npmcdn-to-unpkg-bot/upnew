<?php
$sMetadataVersion = '1.1';
/**
 * Poperty of dencodo - this is NOT Freeware.
 *
 * @link      http://www.dencodo.com
 * @copyright (C) dencodo
 */
$aModule = array(
    'id'                            => 'uprecalcbug',
    'title'                         => 'Basketitem Recalculation Bug',
    'description'                   => 'preisberechnungsfehler bei recalculation',
    'thumbnail'                     => 'uppl.png',
    'version'                       => '0.96',
    'author'                        => '',
    'email'                         => '',
    'url'                           => '',


    'extend'      => array(
        'oxbasketitem'      => 'uppl/uprecalcbug/models/uprecalcbugoxbasketitem',
        'oxbasket'    => 'uppl/uprecalcbug/models/uprecalcbugoxbasket',
    )
);
