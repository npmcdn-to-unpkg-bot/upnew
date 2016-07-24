<?php
$sMetadataVersion = '1.1';
/**
 * Poperty of dencodo - this is NOT Freeware.
 *
 * @link      http://www.dencodo.com
 * @copyright (C) dencodo
 */
$aModule = array(
    'id'                            => 'upmods',
    'title'                         => 'Erweiterte Funktionen des Oxarticle Objects',
    'description'                   => 'Additional infos for Order Overview',
    'thumbnail'                     => 'dencodo_recenthistory.png',
    'version'                       => '0.96',
    'author'                        => '',
    'email'                         => '',
    'url'                           => '',


    'extend'      => array(
        // 'oxcmp_basket'   => 'uppl/upmods/components/upmodsoxcmp_basket',
        'oxarticle'         => 'uppl/upmods/models/upmodsoxarticle',
        'oxuser' => 'uppl/upmods/models/upmodsoxuser',
        'oxbasketitem'         => 'uppl/upmods/models/upmodsoxbasketitem',
        'oxcategorylist'    => 'uppl/upmods/models/upmodsoxcategorylist',
        'oxcategory'    => 'uppl/upmods/models/upmodsoxcategory',
        'oxwarticledetails' => 'uppl/upmods/components/widgets/upmodsoxwarticledetails',
        'oxviewconfig'      => 'uppl/upmods/core/upmodsoxviewconfig',
        'alist'  => 'uppl/upmods/controllers/upmodsmanufacturerlist' //zunderweb filter macht faxen, eigentlich sollte manufacturerlist sein
      
        
    ),
    'files' => array(
        // Core
         'upModsRandomFooterPic' => 'uppl/upmods/components/widgets/upmodsrandomfooterpic.php'
    )
);
