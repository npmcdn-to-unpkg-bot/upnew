<?php
$sMetadataVersion = '1.0';
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */
$aModule = array(
    'id'                            => 'uppostbarcode',
    'title'                         => 'UPPL Post Barcode Service',
    'description'                   => 'Post Barcode Etikette und Trackingnummer',
    'thumbnail'                     => 'urbanpeople_logo.png',
    'version'                       => '0.2',
    'author'                        => 'urbanpeople.com - Robert Denus',
    'email'                         => 'info@urbanpeople.com',
    'url'                           => 'http://www.urbanpeople.com',

    'extend'                        => array(   
           //'oxorder'         => 'uppl/uppostbarcode/models/uppostbarcodeoxorder',
        'order_overview'         => 'uppl/uppostbarcode/controllers/admin/uppostbarcodeorder_overview',
    ),
  
    'blocks'      => array(
         array(
            'template' => 'order_overview.tpl',
            'block'    => 'admin_order_overview_export',
            'file'     => 'views/admin/blocks/admin_order_overview_export.tpl'
        ),
      
    ),
    'templates' => array(
      
         
    ),
    
    
   
);
