<?php
$sMetadataVersion = '1.0';
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */
$aModule = array(
    'id'                            => 'upbetterstock',
    'title'                         => 'UPPL Order Overview User Infos',
    'description'                   => 'Additional infos for Order Overview',
    'thumbnail'                     => 'urbanpeople_logo.png',
    'version'                       => '0.9',
    'author'                        => 'urbanpeople.com - Robert Denus',
    'email'                         => 'info@urbanpeople.com',
    'url'                           => 'http://www.urbanpeople.com',

    'extend'                        => array(
           
            'oxorderarticle'                => 'uppl/upbetterstock/models/upbetterstockoxorderarticle',
            'oxarticle'                => 'uppl/upbetterstock/models/upbetterstockoxarticle',
            'oxviewconfig' => 'uppl/upbetterstock/controllers/admin/upbetterstockoxadminview',
           
    ),

    'files' => array(
        // Core

        // Controllers
        'upbetterstockarticle_stockhistory'             => 'uppl/upbetterstock/controllers/admin/upbetterstockarticle_stockhistory.php',
        'upbetterstockarticle_pendingorders'            => 'uppl/upbetterstock/controllers/admin/upbetterstockarticle_pendingorders.php',
    ),
  
    'blocks'      => array(
       array(
            'template' => 'order_overview.tpl',
            'block'    => 'admin_order_overview_items',
            'file'     => 'views/admin/blocks/admin_order_overview_items.tpl'
        ),
       array(
            'template' => 'article_main.tpl',
            'block'    => 'admin_article_main_editor',
            'file'     => 'views/admin/blocks/admin_article_main_editor.tpl'
        ),
        array(
            'template' => 'article_stock.tpl',
            'block'    => 'admin_article_stock_form',
            'file'     => 'views/admin/blocks/admin_article_stock_form.tpl'
        ),
    ),
    'templates' => array(
        'article_stockhistory.tpl'            => 'uppl/upbetterstock/views/admin/tpl/article_stockhistory.tpl',
        'article_pendingorders.tpl'            => 'uppl/upbetterstock/views/admin/tpl/article_pendingorders.tpl',
        'up_headitem.tpl'            => 'uppl/upbetterstock/views/admin/tpl/up_headitem.tpl'
         
    ),
    
    
   
);
