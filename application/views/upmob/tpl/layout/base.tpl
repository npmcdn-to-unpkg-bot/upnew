[{* Important ! render page head and body to collect scripts and styles *}]
[{capture append="oxidBlock_pageHead"}]
    <meta http-equiv="Content-Type" content="text/html; charset=[{$oView->getCharSet()}]">

    [{assign var="_sMetaTitlePrefix" value=$oView->getTitlePrefix() }]
    [{assign var="_sMetaTitleSuffix" value=$oView->getTitleSuffix() }]
    [{assign var="_sMetaTitlePageSuffix" value=$oView->getTitlePageSuffix() }]
    [{assign var="_sMetaTitle" value=$oView->getTitle() }]
    [{if !$_sMetaTitle }]
        [{assign var="_sMetaTitle" value=$template_title }]
    [{/if}]

    <title>[{$_sMetaTitlePrefix}][{if $_sMetaTitlePrefix && $_sMetaTitle }] | [{/if}][{$_sMetaTitle|strip_tags}][{if $_sMetaTitleSuffix && ($_sMetaTitlePrefix || $_sMetaTitle) }] | [{/if}][{$_sMetaTitleSuffix}] [{if $_sMetaTitlePageSuffix }] | [{$_sMetaTitlePageSuffix}] [{/if}]</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">


    <meta http-equiv="X-UA-Compatible" content="IE=Edge">

    <meta name="apple-mobile-web-app-capable" content="yes">

    [{if $oView->noIndex() == 1 }]
        <meta name="ROBOTS" content="NOINDEX, NOFOLLOW">
    [{elseif $oView->noIndex() == 2 }]
        <meta name="ROBOTS" content="NOINDEX, FOLLOW">
    [{/if}]
    [{if $oView->getMetaDescription()}]
        <meta name="description" content="[{$oView->getMetaDescription()}]">
    [{/if}]
    [{if $oView->getMetaKeywords()}]
        <meta name="keywords" content="[{$oView->getMetaKeywords()}]">
    [{/if}]
    
    [{block name="head_meta_open_graph"}]
        [{if $oViewConf->getFbAppId()}]
            <meta property="og:site_name" content="[{$oViewConf->getBaseDir()}]">
            <meta property="fb:app_id" content="[{$oViewConf->getFbAppId()}]">
            <meta property="og:title" content="[{$_sMetaTitlePrefix}][{if $_sMetaTitlePrefix && $_sMetaTitle}] | [{/if}][{$_sMetaTitle|strip_tags}][{if $_sMetaTitleSuffix && ($_sMetaTitlePrefix || $_sMetaTitle)}] | [{/if}][{$_sMetaTitleSuffix}] [{if $_sMetaTitlePageSuffix}] | [{$_sMetaTitlePageSuffix}] [{/if}]">
            [{if $oViewConf->getActiveClassName() == 'details'}]
                <meta property="og:type" content="product">
                <meta property="og:image" content="[{$oView->getActPicture()}]">
                <meta property="og:url" content="[{$oView->getCanonicalUrl()}]">
            [{else}]
                <meta property="og:type" content="website">
                <meta property="og:image" content="[{$oViewConf->getImageUrl('basket.png')}]">
                <meta property="og:url" content="[{$oViewConf->getCurrentHomeDir()}]">
            [{/if}]
        [{/if}]
    [{/block}]

    [{assign var="canonical_url" value=$oView->getCanonicalUrl()}]
    [{if $canonical_url }]
        <link rel="canonical" href="[{$canonical_url}]">
    [{/if}]
    <link rel="shortcut icon" href="[{$oViewConf->getImageUrl('favicon.ico')}]">

    [{block name="base_style"}]

    <!-- Latest styles -->
    <link href='//fonts.googleapis.com/css?family=Roboto:400,500,700' rel='stylesheet' type='text/css'>
    [{oxstyle include="css/bootstrap.min.css"}]
    [{oxstyle include="css/upnew.min.css"}]



    [{oxstyle include="css/libs/slick.css"}]
    [{oxstyle include="css/libs/slick-theme.css"}]
    [{oxstyle include="css/libs/magnific-popup.css"}]

    [{oxstyle include="css/libs/jquery.powertip.min.css"}]

    [{/block}]
   

    
 


 
    [{assign var='rsslinks' value=$oView->getRssLinks() }]
    [{if $rsslinks}]
        [{foreach from=$rsslinks item='rssentry'}]
            <link rel="alternate" type="application/rss+xml" title="[{$rssentry.title|strip_tags}]" href="[{$rssentry.link}]">
        [{/foreach}]
    [{/if}]

    [{block name="head_css"}]
        [{foreach from=$oxidBlock_head item="_block"}]
            [{$_block}]
        [{/foreach}]
    [{/block}]

[{/capture}]
<!DOCTYPE HTML>
[{assign var="sLanguage" value=$oView->getActiveLangAbbr()}]
[{assign var="currency" value=$oViewConf->getActShopCurrencyObject()}]
<html [{if $sLanguage}]lang="[{$sLanguage}]"[{/if}] data-cur-iso="[{$currency->sign}]" data-cur-xr="[{$currency->rate}]" data-cur-sep="[{$currency->dec}]">
<head>
    [{foreach from=$oxidBlock_pageHead item="_block"}]
        [{$_block}]
    [{/foreach}]
    [{oxstyle}]
    <base href="https://www.urbanpeople.com">
</head>
<body class="mob-a">
    [{block name="instalgo_base_top"}]
    <div id="tophead-target">
        <div id="searchcontrol"></div>
        <div id="facetcontrol"></div>
    </div>
    [{/block}]
    [{block name="after_body_start"}][{/block}]
    [{foreach from=$oxidBlock_pageBody item="_block"}]
        [{$_block}]
    [{/foreach}]
    [{foreach from=$oxidBlock_pagePopup item="_block"}]
        [{$_block}]
    [{/foreach}]

    [{block name="base_js"}]
   
        [{oxscript include="js/libs/jquery.min.js" priority=1}]
        [{oxscript include="js/libs/slick.min.js" priority=1}]
        [{oxscript include="js/libs/jquery.ba-throttle-debounce.min.js" priority=1}]
        [{oxscript include="https://cdnjs.cloudflare.com/ajax/libs/json2/20110223/json2.js"}]
    [{oxscript include="https://cdnjs.cloudflare.com/ajax/libs/jStorage/0.4.4/jstorage.min.js"}]
 
         [{***** MULTIFILTER MOD BEGIN *****}]
        [{*oxscript include="js/libs/jquery-ui.min.js" priority=1*}]
        [{oxscript include=$oViewConf->getModuleUrl('z_multifilter','out/src/js/jquery-ui-1.10.3.custom.min.js') priority=1 }]
        [{oxscript include=$oViewConf->getModuleUrl('z_multifilter','out/src/js/jquery.ui.touch-punch.min.js') priority=1 }]
        [{***** MULTIFILTER MOD END *****}]
        
   
     
         [{oxscript include=$oViewConf->getModuleUrl('upinputform','out/src/js/solr_searchclient.min.js') priority=1 }]
         [{oxscript include=$oViewConf->getModuleUrl('upinputform','out/src/js/oxinputform.min.js') priority=1 }]
         [{oxscript include=$oViewConf->getModuleUrl('upinputform','out/src/js/oxinputform.helper.min.js') priority=1 }]
         
         
          [{oxscript include="js/widgets/oxclist.js" priority=1 }]
         
         [{if $smarty.get.algolia == 1}]
           
            [{* oxscript include=$oViewConf->getModuleUrl('upinputform','out/src/js/oxinputform.check.WORKING.js') priority=1 *}]
         
            [{* oxscript include=$oViewConf->getModuleUrl('upinputform','out/src/js/oxinputform.check.min.js') priority=1 *}]
         [{/if}]

     [{*
        <script src="//cdn.jsdelivr.net/jquery.ion.rangeslider/2.0.12/js/ion.rangeSlider.min.js"></script>
      *}]
     <script src="//cdn.jsdelivr.net/hogan.js/3.0.2/hogan.min.common.js"></script>
         
        
        [{oxscript include="js/libs/jquery.mobile.custom.min.js" priority=1}]
        [{ oxscript include="js/libs/bootstrap.js" priority=1 }]

        [{oxscript include="js/libs/jquery.nanoscroller.min.js" priority=1}]
        [{* oxscript include="js/libs/magnifik.min.js" priority=1 *}]

         [{oxscript include="js/libs/jquery.powertip.min.js" priority=10 }]
            [{* UP EDIT *}] 
        [{*
        [{capture assign="upptipjs"}]
                 
                     $('.image-wrap').powerTip({ followMouse: true, intentSensitivity: 1,intentPollInterval:1, offset:15 });
        [{/capture}]
        *}]
        
        [{oxscript add=$upptipjs}]
        
        
        [{* UP EDIT *}] 
        [{capture assign="upfilterjs"}]
                       $( ".attrhead" ).click(function(e) {
                                   $(this ).parent().toggleClass('open' );
                    });
        [{/capture}]
        
        [{oxscript add=$upfilterjs}]
        [{* UP EDIT FINI *}]
    [{/block}]





   

    <!--[if lt IE 9]>
    <script type="text/javascript" src="[{$oViewConf->getResourceUrl('js/libs/respond.min.js')}]"></script>
    <![endif]-->

    [{oxscript}]
    [{oxid_include_dynamic file="widget/dynscript.tpl"}]

    [{foreach from=$oxidBlock_pageScript item="_block"}]
        [{$_block}]
    [{/foreach}]



     <script type="text/javascript">

    $(document).ready(function(){
     
        $( "#brands" ).not('.exp').click(function(e) {
            //	$("body").animate({ scrollTop: $("body").scrollTop()  + ( 300) }, 1000);
            
            $("#off-canvas-left").animate({scrollTop: $("#off-canvas-left-inner").height() -  $(window).width() + 200  });
            
       });
        
      
      
      $(document).on("click",".controlhead a",function(e){
            $("#mfmask").show();
         
        });     
    
       
    
    
    
             //$(".list-six .st").each(function() {
                // $(".grid .st").each(function() {
                    
                   // $(this).html( $(this).html().split(' ')[1] ); 
                   //  $(this).html("test").split(' ')[0];
               // });
           
    
    
    //get offset right.. in minibasket widget implementieren
    //var rt = ( $(window).width() - ( $('.js-openMiniBasket').offset().left + $('.js-openMiniBasket').outerWidth() ) );  
    //$("#minibasket_container").css('right',rt);
    //not used anymore
    
    /*
            $( ".js-sidetree .has").click(function(e) {
              
                 e.preventDefault();
                $( this ).toggleClass("exp");
                $( this ).next( "ul" ).slideToggle();
                                 
            });
            $( ".exp" ).next( "ul" ).show();
             
               $( ".iclick" ).click(function(e) {
                     console.log('test');
      
                    $(this).closest('a').trigger("click");
                  
            });
       
      */          
           
            $( "#canvas-blocker" ).click(function(e) {
                    $(".push-left").removeClass();
                    $(".push-down").removeClass();
                    $(".push-right").removeClass();
                    $(".close-state").removeClass("close-state");
                    $(this).removeClass();
            });
            
            
            $(document).on('click', '.preventdefault', function(e) {
                return false;
            });
            
    /*
            $( ".js-off-canvas" ).click(function(e) {
                   
                    $( "#canvas-header" ).toggleClass("push-" + $(this).data('push') );
                    $( "#canvas-center" ).toggleClass("push-" + $(this).data('push') );
                    
                    $( "#canvas-blocker" ).toggleClass("listening");
                       
                    
                         
                      

                    
                    $( "#off-canvas-" + $(this).data('canvas') ).toggleClass("push-" + $(this).data('push') );

                     if( $(this).data('push') == 'right' ) {
                           $('.js-hamburger-btn').find('.line').toggleClass('close-state');
                     }
                  });
            
*/
           

            $( ".js-search-focus" ).click(function(e) {
                $( "#searchParam" ).focus();

             });

            
           


             $( ".js-dom-load" ).remove();
             
             
             /*
            $( ".l-1 > li" ).mouseover(function() {
               
                $( this ).addClass('open').find('.subcatlayer').addClass('open');
                
                $(".l-1 > .current").each(function() {
                    $(this).addClass('current-override'); 
                });
               
            });*/
            
            
            
    
            /*
            $( ".l-1 > li" ).mouseleave(function() {
                
               $( this ).removeClass('open').find( ".subcatlayer" ).removeClass('open');
                $(".l-1 > .current").each(function() {
                    $(this).removeClass('current-override'); 
                });
               
            });
               */
          
              
             
             
             
           
            
        });
        
        







</script>


 
    

    [{block name="instalgo_base_bottom"}]
    <script type="text/template" id="list-tophead-searchcontrol-template">
    
      <div class="mob-a tophead head-searchcontrol resp-sm-hidden">
        <i class="glyphicon glyphicon-menu-left"></i>
        <span class="th-title">Suche</span>
        <span class="th-count"><em></em> Artikel</span>
        <span class="th-back">[{oxmultilang ident="INSTALGO_BACK"}]</span>
      </div>

    </script>
    <script type="text/template" id="list-tophead-facetcontrol-template">
    <div id="jstophead_{{trigger}}">
      <div class="mob-a tophead head-facetcontrol resp-sm-hidden">
        <i class="glyphicon glyphicon-menu-left"></i>
        <span class="th-title"></span>
        <span class="th-count"><em></em> Artikel</span>
        <span class="th-back">[{oxmultilang ident="INSTALGO_FILTERBACK"}]</span>
      </div>
      </div>
    </script>


    [{/block}]
     
</body>
</html>