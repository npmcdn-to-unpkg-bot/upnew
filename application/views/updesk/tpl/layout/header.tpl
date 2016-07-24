
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
                <img src="[{$oViewConf->getImageUrl('uppl-mob-logo.png')}]" alt="urbanpeople.com">
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


    [{if $location != "checkout"}]
   [{block name="layout_header_top"}]
   <div class="service-info">   
            <div class="container">
                <div class="row">
                    <div class="col-lg-5 resp-xs-hidden">[{oxcontent ident="upheaderwelcome" }]</div>
                    <div class="col-lg-7">
                      
                        [{oxid_include_widget cl="oxwLanguageList" lang=$oViewConf->getActLanguageId() _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId()}]
                   
                        [{oxid_include_widget cl="oxwCurrencyList" cur=$oViewConf->getActCurrency() _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId()}]
                  
                   <div class="service-switcher topPopList">  [{oxid_include_widget cl="oxwServiceMenu" _parent=$oView->getClassName() force_sid=$force_sid nocookie=$blAnon _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId()}]</div>
                   </div>
                   
                </div> 
            </div>
     </div>
    [{/block}]
    [{/if}]
  
<header class="header" >
   
    <div class="container">
       [{block name="layout_header_logo"}]
       <div class="header-logo" >
            <a href="[{$oViewConf->getHomeLink()}]" title="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]">
                <img src="[{$oViewConf->getImageUrl('logo-wide.png')}]"  alt="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]">
            </a>
        </div>
        [{/block}]
        
       
         [{include file="widget/header/search.tpl"}]
     
        <div class="minibasket-area"> 
        <div class="minibasket-a">
          <div class="minibasket-tgl-btn js-openMiniBasket">
            <div class="[{if $oxcmp_basket->getProductsCount() eq 0 }]empty[{/if}]">
                <div class="phead resp-xs-hidden"><div class="bl bl-arrow-down" style="float: left; margin-top: 1px;font-size: 18px;"></div>[{oxmultilang ident="HEADER_YOUR_CART"}]</div>
                <div class="ptotal resp-xs-hidden">[{assign var="currency" value=$oView->getActCurrency() }][{$currency->sign}] [{ $oxcmp_basket->getFProductsPrice()}]</div> 
                
                <div class="pcount">
                    
                    <i>[{$oxcmp_basket->getProductsCount()}]</i>
                    <div class="bl bl-cart"></div>
                    [{*<img src="[{$oViewConf->getImageUrl('cart-ico.png') }]">*}]
                    
                </div>
            </div>
          </div>
          <div id="minibasket_container"></div>
        </div>
            
        [{* <span class="js-off-canvas" data-canvas="right" data-push="left"><i class="glyphicon glyphicon-option-vertical"></i></span> *}]
     
      

        [{block name="layout_header_bottom"}]
                <form class="js-oxMiniBasketLoader" id="toMiniBasket" action="[{$oView->getWidgetLink()}]" method="post">
                        [{$oViewConf->getHiddenSid()}]
                        [{$oViewConf->getNavFormParams()}]
                         <input type="hidden" name="cl" value="oxwminibasket">
                        <input type="hidden" name="oxwparent" value="">
                </form>
                [{* oxid_include_widget cl="oxwMiniBasket" nocookie=$blAnon force_sid=$force_sid *}]
                [{oxscript include="js/widgets/oxajax.js" priority=10 }]
                [{oxscript include="js/widgets/oxminibasketloader.js" priority=10 }]
                [{oxscript include="js/widgets/oxminibasket.js" priority=10 }]
                [{oxscript add="$( '#toMiniBasket' ).oxMiniBasketLoader();"}]
               
             
        [{/block}]
 
        </div>
    </div>
    [{if $location != "checkout"}]
    <div class="container nav-line">
         [{include file="layout/togglenav.tpl"}]
    </div>
    [{/if}]
    
    <div id="mfmask">
              <div class="pusher"></div>
    </div>
     [{if $oView->getClassName() ne "start" && !$blHideBreadcrumb}]
          
      
          
          [{ assign var="oCont" value=$oView->getContentByIdent("upshopalert") }]
            [{if $oCont->oxcontents__oxactive->value == 1}]
                  
                  
                  
                <style>
                    .shopalert.bfcm {
                        [{oxcontent ident="upshopalert" field="oxtitle"}]
                        color: white;
                        font-size: 10px;
                        text-transform: uppercase;
                        font-size: 10px;
                        letter-spacing: 1px;
                        padding: 5px 0;
                    }
                    
                    .blnk {
                          animation: blinker 1.7s cubic-bezier(.5, 0, 1, 1) infinite alternate;  
                }
                @keyframes blinker {  
                  from { opacity: 1; }
                  to { opacity: 0; }
                }
                      
                </style>
                  <div class="shopalert bfcm">
                      <div class="container">
                          <div class="row">
                            [{oxcontent ident="upshopalert"}]  
                          </div>
                      </div>
                  </div>
                  
            [{/if}]

          [{/if}]
</header>


<div class="scp-container">
  <div class="container subcatpage scpbrands">
     [{oxid_include_widget cl="oxwManufacturerList" _parent=$oView->getClassName() noscript=1 nocookie=1}]
  </div>
  <div class="container subcatpage  scpsports">   
     [{include file="widget/header/sportslist.tpl"}]
 </div>
</div>






<div class="instalgo-fixed fixed-modal-ofl-y" id="ia-searchlisting" data-oxid="[{$actCategory->oxcategories__oxid->value}]" data-hits-per-page="36" data-pagination="normal" data-hits-per-line="6">
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
       [{if $smarty.get.algolia != 1}]
[{oxscript add="$( '.instalgo-fixed' ).oxSearchList();"}] 

[{/if}]
