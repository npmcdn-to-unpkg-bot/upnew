<?php
$sMetadataVersion = '1.1';
/**
 * Poperty of dencodo - this is NOT Freeware.
 *
 * @link      http://www.dencodo.com
 * @copyright (C) dencodo
 */
$aModule = array(
    'id'                            => 'upgooglemerch',
    'title'                         => 'Uppl Google Merchant XML',
    'description'                   => 'Additional infos for Order Overview',
    'thumbnail'                     => 'dencodo_recenthistory.png',
    'version'                       => '0.96',
    'author'                        => '',
    'email'                         => '',
    'url'                           => '',
    'extend'       => array(
        'oxarticlelist'      => 'uppl/upgooglemerch/models/upgooglemerchoxarticlelist',
        'oxcategory'      => 'uppl/upgooglemerch/models/upgooglemerchoxcategory',
    ),
    'templates' => array(
        'inc/googledefault_item.tpl' => 'uppl/upgooglemerch/views/tpl/inc/googledefault_item.tpl',
        'inc/siroop_item.tpl' => 'uppl/upgooglemerch/views/tpl/inc/siroop_item.tpl',
        'upgooglemerchxml.tpl'   => 'uppl/upgooglemerch/views/tpl/upgooglemerchxml.tpl',
    ),
   
    'files' => array(
        // Core
         'upGoogleMerchXml' => 'uppl/upgooglemerch/controllers/upgooglemerchxml.php',
         'Account_OrderSingle' => 'uppl/upgooglemerch/controllers/account_ordersingle.php',
    )
);
