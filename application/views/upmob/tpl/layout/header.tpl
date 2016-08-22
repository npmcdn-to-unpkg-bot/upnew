[{if $location != "checkout"}]

<div id="canvas-nav">
  
   
   
    <div class="canvas-nav-inner">
       <div class="nav-toggle js-close"><i class="bl bl-x"></i></div>
           <ul class="tree l-1">
            <li><a href="[{$oViewConf->getBaseDir()}]" class="root" data-icon="home">Home</a></li>
            </ul>
        
            <div class="js-sidetree">
                [{oxid_include_widget cl="oxwCategoryTree" cnid=$oView->getCategoryId() sWidgetType="header" _parent=$oView->getClassName() nocookie=1 }]
          
                [{assign var="mantree" value=$oView->getManufacturerlist() }]
                 <ul class="man-tree n-tree l-1">
                   	<li><a href="#" class="root has [{if $oView->getManufacturerId()}]exp[{/if}]" id="brands">Marken A - Z <i class="bl bl-x"></i></a>
                   		<ul class="l-2">
                			[{foreach from=$mantree item=oman key=mankey name=test_manufacturer }]
                	            [{if $oman->oxmanufacturers__upflag->value == 1}]		
                	            	<li>
                	            		<a class="last [{if $oView->getManufacturerId()==$oman->getId()}]act[{/if}]" href="[{$oman->getLink()}]">[{ $oman->oxmanufacturers__oxtitle->value}]</a>
                	               	</li>
                	            [{/if}]   
                			[{/foreach}]
                            
                		</ul>
                	</li> 
                </ul>
          
          
            </div>
            
    
            [{oxid_include_widget cl="oxwLanguageList" lang=$oViewConf->getActLanguageId() _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId()}]
                       
            [{oxid_include_widget cl="oxwCurrencyList" cur=$oViewConf->getActCurrency() _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId()}]
            
            <div class="trustpic">[{oxid_include_widget cl="upModsRandomFooterPic" noscript=1 nocookie=1}]</div>
            
        
    </div>

</div>

[{oxscript include="js/widgets/oxreco.js" priority=10 }]
[{oxscript add="$( '#canvas-nav' ).oxRefineTreeNav();"}]

[{if 0}]
<div id="off-canvas-left">
        <div id="off-canvas-left-inner">
       <ul class="tree l-1">
        <li><a href="[{$oViewConf->getBaseDir()}]" class="root" data-icon="home">Home</a></li>
        </ul>
        
            <div class="js-sidetree">
            [{oxid_include_widget cl="oxwCategoryTree" cnid=$oView->getCategoryId() sWidgetType="header" _parent=$oView->getClassName() nocookie=1 }]
      
            [{assign var="mantree" value=$oView->getManufacturerlist() }]
            <ul class="tree l-1">
               	<li><a href="#" class="root has [{if $oView->getManufacturerId()}]exp[{/if}]" id="brands">Marken A - Z</a>
               		<ul>
            			[{foreach from=$mantree item=oman key=mankey name=test_manufacturer }]
            	            [{if $oman->oxmanufacturers__upflag->value == 1}]		
            	            	<li>
            	            		<a class="last [{if $oView->getManufacturerId()==$oman->getId()}]act[{/if}]" href="[{$oman->getLink()}]">[{ $oman->oxmanufacturers__oxtitle->value}]</a>
            	               	</li>
            	            [{/if}]   
            			[{/foreach}]
                        
            		</ul>
            	</li>
            </ul>
           
            </div>
       
        </div>
</div>
[{/if}]
<div id="canvas-search">
            <div class="container">
             [{include file="widget/header/search.tpl"}]
            </div>
</div>
[{/if}]

<div class="mob-a" id="minibasket_container"></div>
<div id="canvas-header">
[{if $oViewConf->getTopActionClassName() != 'clearcookies' && $oViewConf->getTopActionClassName() != 'mallstart'}]
    [{oxid_include_widget cl="oxwCookieNote" _parent=$oView->getClassName() nocookie=1}]
[{/if}]

[{if $oxcmp_user || $oView->getCompareItemCount() || $Errors.loginBoxErrors}]
    [{assign var="blAnon" value=0}]
    [{assign var="force_sid" value=$oViewConf->getSessionId()}]
[{else}]
    [{assign var="blAnon" value=1}]
[{/if}]

[{if $oxcmp_basket->getProductsCount()}]
    [{assign var="blAnon" value=0}]
    [{assign var="force_sid" value=$oViewConf->getSessionId()}]
[{else}]
    [{assign var="blAnon" value=1}]
[{/if}]
[{*}]
<div id="header" class="navbar navbar-inverse page-push-left">
    <div class="container">
        [{block name="layout_header_top"}]
        [{/block}]
        [{block name="layout_header_logo"}]
            <a id="logo" class="header-logo" href="[{$oViewConf->getHomeLink()}]" title="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]">
                <img src="[{$oViewConf->getImageUrl('uppl-mob-logo.png')}]" alt="[{oxmultilang ident="OXID_ESALES_URL_TITLE"}]">
            </a>
        [{/block}]
        [{block name="layout_header_bottom"}]
            <div class="headerMenu clearfix">
                [{oxid_include_widget cl="oxwMiniBasket" nocookie=$blAnon force_sid=$force_sid}]

                [{include file="widget/header/search.tpl"}]
            </div>
        [{/block}]
    </div>
</div>
[{*}]
 

<header class="header mob-a" >
   
    
        <div class="hamburger js-hamburger-btn js-off-canvas" data-canvas="left" data-push="right">
            <div class='line'></div>
        </div>
       [{block name="layout_header_logo"}]
       <div class="header-logo" >
            <a href="[{$oViewConf->getHomeLink()}]" title="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]">
                <img src="[{$oViewConf->getImageUrl('logo-wide.png')}]"  alt="[{oxmultilang ident="OXID_ESALES_URL_TITLE"}]">
            </a>
        </div>
        [{/block}]
        
       
        
           <div class="btn-search js-search-focus" data-canvas="top" >  <i class="glyphicon glyphicon-search"></i> </div>
           [{if $smarty.get.algolia == "1"}]
      
           [{else}] 
           [{* oxscript add="$( '.btn-search' ).click(function(e) { $( '#canvas-search' ).slideToggle(); } ) ;" *}]
           [{/if}]
        <div class="minibasket-area"> 
        <div class="minibasket-a">
          <div class="minibasket-tgl-btn js-openMiniBasket">
            <div class="[{if $oxcmp_basket->getProductsCount() eq 0 }]empty[{/if}]">
                <div class="pcount">
                    <i>[{$oxcmp_basket->getProductsCount()}]</i>
                    <div class="bl bl-cart"></div>
                </div> 
            </div>
          </div>
              [{* <div id="minibasket_container"></div> *}]
        </div>
            
        [{* <span class="js-off-canvas" data-canvas="right" data-push="left"><i class="glyphicon glyphicon-option-vertical"></i></span> *}]
     
      

        [{block name="layout_header_bottom"}]
         
                [{* oxid_include_widget cl="oxwMiniBasket" nocookie=$blAnon force_sid=$force_sid *}]
                [{oxscript include="js/widgets/oxajax.js" priority=10 }]
                [{oxscript include="js/widgets/oxminibasketloader.js" priority=10 }]
                [{oxscript include="js/widgets/oxminibasket.js" priority=10 }]
                [{oxscript add="$( '#toMiniBasket' ).oxMiniBasketLoader();"}]
               
                <form class="js-oxMiniBasketLoader" id="toMiniBasket" action="[{$oView->getWidgetLink()}]" method="post">
                        [{$oViewConf->getHiddenSid()}]
                        [{$oViewConf->getNavFormParams()}]
                         <input type="hidden" name="cl" value="oxwminibasket">
                        <input type="hidden" name="oxwparent" value="">
                </form>
        [{/block}]
 
        </div>
  
    
    
    <div id="mfmask">
              <div class="pusher"></div>
    </div>

</header>

</div>


    
    
<div class="instalgo-fixed fixed-modal-ofl-y" id="ia-searchlisting" data-oxid="[{$actCategory->oxcategories__oxid->value}]" data-hits-per-page="28" data-pagination="loadmore" data-hits-per-line="2">
        [{block name="instalgo_list_listhead"}]
        <div class="searchinput resp-sm-hidden">
          <div class="search-wrapper">
           <input type="text" autocomplete="off" tabindex="1" id="search-input-mob" name="q" placeholder="Suche eingeben …" value="" maxlength="128">  
          [{* <div id="search-starter"></div> <i class="bl bl-x"></i> *}]
           <button class="searchinput-btn"><i class="glyphicon glyphicon-search"></i></button>
          </div>
        </div> 
        [{/block}]
        <div id="core-target"></div>
</div>
[{oxscript add="$( '.instalgo-fixed' ).oxSearchList();"}] 