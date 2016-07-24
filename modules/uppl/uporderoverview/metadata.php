<?php
$sMetadataVersion = '1.0';
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */
$aModule = array(
    'id'                            => 'uporderoverview',
    'title'                         => 'UPPL Order Overview',
    'description'                   => 'Additional tools for Order Overview',
    'thumbnail'                     => 'urbanpeople_logo.png',
    'version'                       => '0.9',
    'author'                        => 'urbanpeople.com - Robert Denus',
    'email'                         => 'info@urbanpeople.com',
    'url'                           => 'http://www.urbanpeople.com',

    'extend'                        => array(
            'order_overview'        => 'uppl/uporderoverview/controllers/admin/uporderovervieworder_overview',
            'oxorder'                => 'uppl/uporderoverview/models/uporderoverviewoxorder',    
            'oxuser'                => 'uppl/uporderoverview/models/uporderoverviewoxuser',    
    ),
  
    'blocks'      => array(
        array(
            'template' => 'order_overview.tpl',
            'block'    => 'admin_order_overview_userinfos',
            'file'     => 'views/admin/blocks/admin_order_overview_userinfos.tpl'
        ),
        array(
            'template' => 'order_overview.tpl',
            'block'    => 'admin_order_overview_send_form',
            'file'     => 'views/admin/blocks/admin_order_overview_send_form.tpl'
        ),
        array(
            'template' => 'order_overview.tpl',
            'block'    => 'admin_order_overview_general',
            'file'     => 'views/admin/blocks/admin_order_overview_general.tpl'
        ),
        
    ),
    
    
   
);
