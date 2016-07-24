<?php
$sMetadataVersion = '1.1';
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 * delete from oxconfig where oxvarname in ( "aModulesHistory", "aModuleVersions", "sUtilModule", "aDisabledModules", "aLegacyModules", "aModuleFiles", "aModulePaths", "aModules", "aModuleTemplates")
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */
$aModule = array(
    'id'                            => 'upuniremark',
    'title'                         => 'UPPL Universal Remark',
    'description'                   => 'Universelle Bemerkungen',
    'thumbnail'                     => 'urbanpeople_ico.png',
    'version'                       => '1.0',
    'author'                        => 'Urbanpeople.com AG - Robert Denus',
    'email'                         => 'info@urbanpeople.com',
    'url'                           => 'http://www.urbanpeople.com',

 'extend'                        => array(         
        'oxviewconfig'  => 'uppl/upuniremark/core/upuniremarkoxviewconfig'
                  
    ),

    'files' => array(
         // Core
      'UpUniRemark' => 'uppl/upuniremark/models/upuniremark.php',
        //Controllers
        'UpUniRemark_Editor' => 'uppl/upuniremark/controllers/admin/upuniremark_editor.php',
       
    ),
  
    'blocks'      => array(
        array(
            'template' => 'order_overview.tpl',
            'block'    => 'admin_order_overview_userinfos',
            'file'     => 'views/admin/blocks/admin_order_overview_userinfos.tpl'
        ),
        array(
            'template' => 'order_overview.tpl',
            'block'    => 'admin_order_overview_billingaddress',
            'file'     => 'views/admin/blocks/admin_order_overview_billingaddress.tpl'
        ),
        array(
            'template' => 'article_main.tpl',
            'block'    => 'admin_article_main_editor',
            'file'     => 'views/admin/blocks/admin_article_main_editor.tpl'
        ),
        array(
            'template' => 'order_overview.tpl',
            'block'    => 'admin_order_overview_items',
            'file'     => 'views/admin/blocks/admin_order_overview_items.tpl'
        ),
        array(
            'template' => 'user_main.tpl',
            'block'    => 'admin_user_main_form',
            'file'     => 'views/admin/blocks/admin_user_main_form.tpl'
        )
    ),
    
    'templates' => array(
        'popups/uniremark_editor.tpl'            => 'uppl/upuniremark/views/admin/tpl/popups/uniremark_editor.tpl',
        'popups/upextadmin_headitem.tpl'         => 'uppl/upuniremark/views/admin/tpl/popups/upextadmin_headitem.tpl',  
    ),
  
    
    
   
);
