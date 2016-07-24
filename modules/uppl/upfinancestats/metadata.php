<?php
$sMetadataVersion = '1.1';
/**
 * Poperty of * - this is NOT Freeware.
 *
 * @link      http://www.dencodo.com
 * @copyright (C) dencodo
 */
$aModule = array(
    'id'                            => 'upfinancestats',
    'title'                         => 'Finanz Statistik',
    'description'                   => 'Additional infos',
    'thumbnail'                     => 'xx.png',
    'version'                       => '0.96',
    'author'                        => '',
    'email'                         => '',
    'url'                           => '',


    'files'        => array(
                        'UpFinanceStatsFinanceOverview' => 'uppl/upfinancestats/controllers/admin/upfinancestatsfinanceoverview.php',
    ),
    'templates'    => array(
                        'financeoverview.tpl'             => 'uppl/upfinancestats/views/admin/tpl/financeoverview.tpl',
    ),
);
