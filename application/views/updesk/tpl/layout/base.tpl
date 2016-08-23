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

   
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
   <title>
        [{* ############## einscommerce SHOPSEOPACK snippet start... ##############*}]
        [{block name="head_title"}]
        [{* ##############einscommerce SHOPSEOPACK snippet end. ##############*}]
            [{ $_sMetaTitlePrefix }][{if $_sMetaTitlePrefix && $_sMetaTitle }] | [{/if}][{$_sMetaTitle|strip_tags}][{if $_sMetaTitleSuffix && ($_sMetaTitlePrefix || $_sMetaTitle) }] | [{/if}][{$_sMetaTitleSuffix}] [{if $_sMetaTitlePageSuffix }] | [{ $_sMetaTitlePageSuffix }] [{/if}]
        [{* ############## einscommerce SHOPSEOPACK snippet start... ##############*}]
        [{/block}]
        [{* ##############einscommerce SHOPSEOPACK snippet end. ##############*}]
    </title>

    <meta http-equiv="X-UA-Compatible" content="IE=Edge">

    [{* ############## einscommerce SHOPSEOPACK snippet start... ##############*}]
    [{block name="head_meta_robots"}]
    [{* ##############einscommerce SHOPSEOPACK snippet end. ##############*}]
        [{if $oView->noIndex() == 1 }]
            <meta name="ROBOTS" content="NOINDEX, NOFOLLOW">
        [{elseif $oView->noIndex() == 2 }]
            <meta name="ROBOTS" content="NOINDEX, FOLLOW">
        [{/if}]
    [{* ############## einscommerce SHOPSEOPACK snippet start... ##############*}]
    [{/block}]
    [{* ##############einscommerce SHOPSEOPACK snippet end. ##############*}]


    <meta http-equiv="X-UA-Compatible" content="IE=Edge">

    <meta name="apple-mobile-web-app-capable" content="yes">

  
    [{if $oView->getMetaDescription()}]
        <meta name="description" content="[{$oView->getMetaDescription()}]">
    [{/if}]
    
    [{if $oView->getMetaKeywords()}]
        <meta name="keywords" content="[{$oView->getMetaKeywords()}]">
    [{/if}]

     [{block name="head_meta_open_graph"}]
            <meta property="og:site_name" content="[{$oViewConf->getBaseDir()}]">
           [{* <meta property="fb:app_id" content="[{$oViewConf->getFbAppId()}]">*}]
            <meta property="og:title" content="[{$_sMetaTitlePrefix}][{if $_sMetaTitlePrefix && $_sMetaTitle }] | [{/if}][{$_sMetaTitle|strip_tags}][{if $_sMetaTitleSuffix && ($_sMetaTitlePrefix || $_sMetaTitle) }] | [{/if}][{$_sMetaTitleSuffix}] [{if $_sMetaTitlePageSuffix }] | [{$_sMetaTitlePageSuffix}] [{/if}]">
            <meta name="twitter:title" content="[{$_sMetaTitlePrefix}][{if $_sMetaTitlePrefix && $_sMetaTitle }] | [{/if}][{$_sMetaTitle|strip_tags}][{if $_sMetaTitleSuffix && ($_sMetaTitlePrefix || $_sMetaTitle) }] | [{/if}][{$_sMetaTitleSuffix}] [{if $_sMetaTitlePageSuffix }] | [{$_sMetaTitlePageSuffix}] [{/if}]">
         
            [{if $oViewConf->getActiveClassName() == 'details'}]
                <meta property="og:type" content="product">
                <meta property="og:image" content="[{$oView->getActPicture()}]">
                <meta name="twitter:image" content="[{$oView->getActPicture()}]">
                <meta property="og:url" content="[{$oView->getCanonicalUrl()}]">
                [{assign var="oLongdesc" value=$oDetailsProduct->getLongDescription()}]
                [{if $oLongdesc->value}]
                    <meta property="og:description" content="[{$oLongdesc->getRawValue()|htmlspecialchars}]"> 
                    <meta name="twitter:description" content="[{$oLongdesc->getRawValue()|htmlspecialchars}]"> 
                [{/if}]
            [{elseif $oViewConf->getActiveClassName() == 'alist'}]
               [{assign var="listType" value=$oView->getListType()}]
               [{if $listType=='manufacturer'}]
                    
                    [{if $actCategory->getManufacturerDescription() }]
                        <meta property="og:description" content="[{$actCategory->getManufacturerDescription()}]">
                        <meta name="twitter:description" content="[{$actCategory->getManufacturerDescription()}]"> 
                    [{/if}]
                [{else}]
                    [{if $actCategory->oxcategories__oxlongdesc->value }]
                        <meta property="og:description" content="[{oxeval var=$actCategory->oxcategories__oxlongdesc}]">
                        <meta name="twitter:description" content="[{oxeval var=$actCategory->oxcategories__oxlongdesc}]">
                    [{/if}]
                [{/if}]
                
                [{assign var="actCategory" value=$oView->getActiveCategory()}]
                <meta property="og:image" content="[{$actCategory->getThumbUrl()}]">
                <meta name="twitter:image" content="[{$actCategory->getThumbUrl()}]">
                
                <meta property="og:url" content="http://[{$smarty.server.HTTP_HOST}][{$smarty.server.REQUEST_URI}]">
                
                
            
            [{else}]
                <meta property="og:type" content="website">
                <meta property="og:image" content="https://www.urbanpeople.com/out/updesk/img/footer/trustpic_1.jpg">
                <meta name="twitter:image" content="https://www.urbanpeople.com/out/updesk/img/footer/trustpic_1.jpg">
                <meta property="og:url" content="[{$oViewConf->getCurrentHomeDir()}]">
                [{if $oView->getMetaDescription()}]
                    <meta property="og:description" content="[{$oView->getMetaDescription()}]">
                    <meta name="twitter:description" content="[{$oView->getMetaDescription()}]">
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
      [{if 0}]
        <script type="text/javascript">
      window.heap=window.heap||[],heap.load=function(e,t){window.heap.appid=e,window.heap.config=t=t||{};var n=t.forceSSL||"https:"===document.location.protocol,a=document.createElement("script");a.type="text/javascript",a.async=!0,a.src=(n?"https:":"http:")+"//cdn.heapanalytics.com/js/heap-"+e+".js";var o=document.getElementsByTagName("script")[0];o.parentNode.insertBefore(a,o);for(var r=function(e){return function(){heap.push([e].concat(Array.prototype.slice.call(arguments,0)))}},p=["clearEventProperties","identify","setEventProperties","track","unsetEventProperty"],c=0;c<p.length;c++)heap[p[c]]=r(p[c])};
      heap.load("2003046990");
      
       
        [{assign var="fullname" value=$oxcmp_user->oxuser__oxfname->value|cat:" "|cat:$oxcmp_user->oxuser__oxlname->value }]
            window.heap.identify('[{$fullname}]');
        
      
    </script>
    [{/if}]
    <base href="https://www.urbanpeople.com">
</head>
<body>
    
    
    [{block name="after_body_start"}][{/block}]
    [{foreach from=$oxidBlock_pageBody item="_block"}]
        [{$_block}]
    [{/foreach}]
    [{foreach from=$oxidBlock_pagePopup item="_block"}]
        [{$_block}]
    [{/foreach}]

    [{block name="base_js"}]
    
        [{oxscript include="js/libs/jquery.min.js" priority=1}]
        [{oxscript include="js/libs/jquery.ba-throttle-debounce.min.js" priority=1}]
        [{oxscript include="js/libs/slick.min.js" priority=1}]
          
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
         
       
         [{if $smarty.get.algolia == 1}]
          
            [{ oxscript include=$oViewConf->getModuleUrl('upinputform','out/src/js/oxinputform.check.WORKING.js') priority=1 }]

       
            [{*oxscript include=$oViewConf->getModuleUrl('upinputform','out/src/js/oxinputform.check.min.js') priority=1 *}]
            
            [{else}]
                [{oxscript include="js/widgets/oxclist.js" priority=1 }]
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
     
      
      
      
      $(document).on("click",".controlhead a",function(e){
            $("#mfmask").show();
         
        });     
    
    $('.accordion-group').find('.accordion-toggle').click(function(){
				//Expand or collapse this panel
				$(this).next().slideToggle('fast');
	            $(this).toggleClass('open');
	            $(".accordion-toggle").not($(this)).removeClass('open');
	            
				//Hide the other panels
				$(".accordion-content").not($(this).next()).slideUp('fast');
	
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
    
            $( "ul.sidetree .has").click(function(e) {
                 e.preventDefault();
                $( this ).toggleClass("exp");
                $( this ).next( "ul" ).slideToggle();
                                 
            });
            $( ".exp" ).next( "ul" ).show();
         
             
             $(document).on('click', '.preventdefault', function(e) {
                    return false;
                });
             
            
            
            $('body').on({
                  mouseenter: function() {
                      if( !$(this).data('p1') ){
                          $(this).data('p1',  $( this ).find( ".p1" ).attr('src') );
                      }
                      var src = $( this ).data('p2');
                      if (src.indexOf("nopic.jpg") < 0){
                         $( this ).find( ".p1" ).attr('src', src );
                      }
                  },
                  mouseleave: function(event) {
                        if( event.relatedTarget.id == 'powerTip'){ 
                           return false;
                        }
                        $( this ).find( ".p1" ).attr('src', $( this ).data('p1') );
                  }
            }, '.image-wrap'); 
           
            $( "#canvas-blocker" ).click(function(e) {
                    $(".push-left").removeClass();
                    $(".push-down").removeClass();
                    $(".push-right").removeClass();
                    $(".close-state").removeClass("close-state");
                    $(this).removeClass();
            });

            $( ".js-off-canvas" ).click(function(e) {
                   
                    $( "#canvas-header" ).toggleClass("push-" + $(this).data('push') );
                    $( "#canvas-center" ).toggleClass("push-" + $(this).data('push') );
                    
                    $( "#canvas-blocker" ).toggleClass("listening");
                       
                    
                         
                      

                    
                    $( "#off-canvas-" + $(this).data('canvas') ).toggleClass("push-" + $(this).data('push') );

                     if( $(this).data('push') == 'right' ) {
                           $('.js-hamburger-btn').find('.line').toggleClass('close-state');
                     }
                  });
            

           

            $( ".js-search-focus" ).click(function(e) {
                $( "#searchParam" ).focus();

             });

            
           


             $( ".js-dom-load" ).remove();
             
             
             
            $( ".l-1 > li" ).mouseover(function() {
               
                $( this ).addClass('open').find('.subcatlayer').addClass('open');
                
                $(".l-1 > .current").each(function() {
                    $(this).addClass('current-override'); 
                });
               
            });
            
            
            
    
            
            $( ".l-1 > li" ).mouseleave(function() {
                
               $( this ).removeClass('open').find( ".subcatlayer" ).removeClass('open');
                $(".l-1 > .current").each(function() {
                    $(this).removeClass('current-override'); 
                });
               
            });
               
        });
        
        
$(document).ready(function() {
    var stickyNavTop = $('.header').offset().top;
  
    
    var stickyNav = function(){
        var scrollTop = $(window).scrollTop();
              
        if (scrollTop > stickyNavTop) { 
            $('.header').addClass('sticky');
            $('.service-info').addClass('sticky-margin');
        } else {
            $('.sticky').removeClass('sticky'); 
             $('.service-info').removeClass('sticky-margin');
        }
    };
     
    stickyNav();
     
    $(window).scroll(function() {
        stickyNav();
    });
});

$(document).ready(function() {
    
    /*
    var max = -1;
        $(".tab-pane").each(function() {
            var h = $(this).outerHeight(true); 
            max = h > max ? h : max;
        });
    $(".tab-pane").css('height',max);
    */
    
    
    
  
    
    
    
 
   
     
    var stickyNav2 = function(direction){
    
 
            var scrollTop = $(window).scrollTop();
            var d= 0;
            if (direction == 'down'){      

                // if tocart-wrapper lower end passes fold
                if(  $('#tocart-wrapper').outerHeight(false) +  $('#morePicsContainer').offset().top >  scrollTop + $(window).height() ){
                        
                      var h2 = $(window).height() + scrollTop;
                      console.log(  $('#tocart-wrapper').outerHeight(true)+$('#morePicsContainer').offset().top + '/' + scrollTop + '/' + h2);
                }else{
                    
                    if(scrollTop > $('#morePicsContainer').offset().top ){
                         d =  scrollTop - $('#tocart-wrapper').outerHeight(false) - $('#morePicsContainer').offset().top  + $(window).height(); 
                    }
                     console.log( $('#morePicsContainer').outerHeight(false) + "reblet" + $('#morePicsContainer').offset().top + "reblet" + scrollTop);
                     
                       if( scrollTop + $(window).height() < $('#morePicsContainer').outerHeight(false) + $('#morePicsContainer').offset().top ){
                            $('#tocart-wrapper').css('margin-top',d);
                       }
                    
                }
                
                
              
            }
            
            if (direction == 'up' ){       
                        var scrolldelta = lastSavedDownScroll - scrollTop;
                        if( $('#tocart-wrapper').outerHeight(false) - scrolldelta < $(window).height() - 100 ){
                            if(scrollTop > $('#morePicsContainer').offset().top -50  ){
                                 d =  scrollTop - $('#morePicsContainer').offset().top + 60;
                            }
                            $('#tocart-wrapper').css('margin-top',d + 1);
                        }
               
            }

    };
     
     var previousScroll = 0;
     var lastSavedDownScroll = 0;
   /* $(window).scroll(function() {
        
           var direction;
          
           var currentScroll = $(this).scrollTop();
           
         
           
           if (currentScroll > previousScroll){
                direction ='down';
                lastSavedDownScroll = currentScroll;
           } else {
                 direction='up';
                 
                // alert( lastSavedDownScroll);
           }
        
         
           stickyNav2(direction);
     
           previousScroll = currentScroll;
    }); */
    
    
    
    
});




</script>


 
       
  
   
    
    
   
     
[{if 0}]
 <script>$('a.article-zoom').magnifik({classPrefix:"up-",clickCloses:false,stageHTML:function() {
                return '<div class="' + this._getClass('canvas') + '"><img class="'
                    + this._getClass('thumb') + '"><img class="'
                    + this._getClass('full') + '"></div><div class="up-header-close"><span class="up-close glyphicon glyphicon-remove"></span></div>';
          }
    });
 </script>
   [{/if}]

 
</body>
</html>