<?php
$sMetadataVersion = '3.2';
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */
$aModule = array(

    'id'                            => 'upstreetdeal',
    'title'                         => 'Streetdeal Sync',
    'description'                   => 'Additional infos for Order Overview',
    'thumbnail'                     => 'dencodo_recenthistory.png',
    'version'                       => '3.2',
    'author'                        => '',
    'email'                         => '',
    'url'                           => '',

    'extend' => array(
      'oxcmp_basket' => 'uppl/upstreetdeal/components/upstreetdealoxcmp_basket',
      'oxarticle' => 'uppl/upstreetdeal/models/upstreetdealoxarticle',
      'article_main' => 'uppl/upstreetdeal/controllers/admin/upstreetdealarticle_main',
    ),
    
    'blocks'      => array(
        array(
            'template' => 'article_main.tpl',
            'block'    => 'upstreetdeal_admin_article_main_form',
            'file'     => 'views/admin/blocks/admin_article_main_form.tpl'
        )
        
    ),
    
   
    
   'settings' => array(
        array('group' => 'main', 'name' => 'bDaOptionExtendDefaultBlock', 'type' => 'bool', 'value' => 'false'),
        array('group' => 'main', 'name' => 'aDaOptionPersColors', 'type' => 'arr',  'value' => array('Rot','Grün','Blau')),
    ),
    
    'files' => array(
        // Core
        'upStreetDealJSONP' => 'uppl/upstreetdeal/controllers/upstreetdealjsonp.php',
        'upStreetDealArticle' => 'uppl/upstreetdeal/controllers/upstreetdealarticle.php',
        'upStreetDealStatusBar' => 'uppl/upstreetdeal/controllers/upstreetdealstatusbar.php'
    )

);