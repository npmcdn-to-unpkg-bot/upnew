<?php
$sMetadataVersion = '1.0';
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */
$aModule = array(
    'id'                            => 'upordersplit',
    'title'                         => 'UPPL Order Split',
    'description'                   => 'Bestellungen aufteilen und Zusammenbringen',
    'thumbnail'                     => 'urbanpeople_logo.png',
    'version'                       => '0.99',
    'author'                        => 'urbanpeople.com - Robert Denus',
    'email'                         => 'info@urbanpeople.com',
    'url'                           => 'http://www.urbanpeople.com',

    'extend'                        => array(   
            'order_overview'         => 'uppl/upordersplit/controllers/admin/upordersplitorder_overview',
            'oxorder'                => 'uppl/upordersplit/models/upordersplitoxorder',         
    ),
  
    'blocks'      => array(
       array(
            'template' => 'order_overview.tpl',
            'block'    => 'admin_order_overview_items',
            'file'     => 'views/admin/blocks/admin_order_overview_items.tpl'
        ),
      
    ),
    'templates' => array(
      
         
    ),
    
    
   
);
