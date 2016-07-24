<?php
$sMetadataVersion = '1.0';
/**
 * Poperty of dencodo - this is NOT Freeware.
 *
 * @link      http://www.dencodo.com
 * @copyright (C) dencodo
 */
$aModule = array(
    'id'                            => 'upvendororder',
    'title'                         => 'Hersteller Bestellung',
    'description'                   => 'Additional infos for Order Overview',
    'thumbnail'                     => 'dencodo_recenthistory.png',
    'version'                       => '0.95',
    'author'                        => 'dencodo',
    'email'                         => 'info@dencodo.com',
    'url'                           => 'http://www.dencodo.com',

    
    'extend'       => array(                   
                           // 'oxmanufacturer' => 'dencodo/dcmanufacturerplus/models/dcmanufacturerplusoxmanufacturer',
                           // 'oxmanufacturerlist' => 'dencodo/dcmanufacturerplus/models/dcmanufacturerplusoxmanufacturerlist',
                        ),
    'files'        => array(
                        'UpVendorOrder_Main'=> 'uppl/upvendororder/controllers/admin/upvendororder_main.php',
                        'UpVendorOrder_Pending'=> 'uppl/upvendororder/controllers/admin/upvendororder_pending.php',
                        ),
    'templates'    => array(
                        'upvendororder_main.tpl'             => 'uppl/upvendororder/views/admin/tpl/upvendororder_main.tpl',
                         'upvendororder_pending.tpl'             => 'uppl/upvendororder/views/admin/tpl/upvendororder_pending.tpl',
                        ),
    'blocks'       => array(
                       
                        ),
    'events'       => array(
       // 'onActivate'   => 'jxadddeldesc_install::onActivate', 
        //'onDeactivate' => 'jxddddeldesc_install::onDeactivate'
                        ),
    'settings'     => array(
                        )

);
