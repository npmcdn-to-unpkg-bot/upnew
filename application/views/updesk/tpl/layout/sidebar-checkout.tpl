  [{oxscript add="$( '.js-checkout-cart' ).click(function(e){ $( '.resp-xs-togglecart' ).slideToggle(); });"}] 
  [{oxscript add="$( '.js-close-cart' ).click(function(e){ $( '.resp-xs-togglecart' ).hide(); });"}] 
  [{oxscript add="$(document).click( function( e ){  if( !$(e.target).parents( 'div' ).hasClass( 'resp-xs-togglecart' ) && !$(e.target).parents( 'div' ).hasClass( 'js-checkout-cart' )  ){ $( '.resp-xs-togglecart' ).hide(); } });"}]
<div class="sidebar-checkout resp-lg-sidebar-checkout">
        <div class="sidebar-head">[{oxmultilang ident="HEADER_YOUR_CART"}]<a class="edit-cart resp-xs-hidden" href="[{ oxgetseourl ident=$oViewConf->getBasketLink() }]">[{ oxmultilang ident="MINIBASKET_EDIT" }]</a><span class="resp-lg-hidden close-cart js-close-cart" href="[{ oxgetseourl ident=$oViewConf->getBasketLink() }]">X</a></div> 
        <div class="sidebar-minibasket" data-paycostpreset="[{$oxcmp_basket->getFPaymentCosts()}]" data-basket="[{assign var='basketprice' value=$oxcmp_basket->getPrice()}][{$basketprice->getBruttoPrice()}]">
                    [{assign var="currency" value=$oView->getActCurrency() }]
                    <ul class="minibasketitems">
                    [{foreach from=$oxcmp_basket->getContents() name=miniBasketList item=_product key=basketindex}]
                        [{block name="widget_minibasket_product"}]
                            [{ assign var="minibasketItemTitle" value=$_product->getTitle() }]
                           
                            <li>
                                <a href="[{$_product->getLink()}]"><img class="icon" src="[{ $_product->getIconUrl() }]" ></a>

                                <div class="item-infos">
                                        [{assign var="title" value=" -"|explode:$_product->getTitle()}]
                                        [{assign var="subtitle" value=" ("|explode:$title[1]}] 
                                        <div class="fir">[{ $title[0]|strip_tags }]</div>
                                        <div class="sec"> [{ $subtitle[0]|strip_tags }]</div>
                                        <div class="thi">[{if $_product->getVarSelect()}]<span class="size">Size: [{$_product->getVarSelect()}]</span>[{/if}] [{if $_product->getAmount() gte 2}]<span class="amount">Anzahl: [{$_product->getAmount()}]</span>[{/if}]</div>
                                        <div class="fou">[{oxprice price=$_product->getPrice() currency=$currency}]</div>
                                </div>
                            </li>
                        [{/block}]
                    [{/foreach}]
                    </ul>
                    [{* <button type="submit" value="submit"/></button> *}]
                  
                    <hr>
                    [{block name="checkout_basketcontents_delcosts"}]
                    
                    [{if $oxcmp_basket->getFDeliveryCosts() }]
                        <p class="totals">
                            <span class="item">[{oxmultilang ident="SHIPPING_COST"}]</span>
                            <strong class="price pull-right">[{oxprice price=$oxcmp_basket->getFDeliveryCosts() currency=$currency}]</strong>
                        </p>
                    [{else}][{*
                        <p class="totals">
                            <span class="item">[{oxmultilang ident="SHIPPING_COST"}]</span>
                            [{if $oxcmp_basket->getFProductsPrice() >= $oViewConf->getConvert(80) }]
                            <strong class="price pull-right">[{oxprice price=0 currency=$currency}]</strong>
                            [{else}]
                            <strong class="price pull-right">[{oxprice price=5 currency=$currency}]</strong>
                            [{/if}]
                        </p>*}]
                    [{/if }]
                    [{block name="checkout_basketcontents_paymentcosts"}]
                        <p class="totals paymentcosts">
                        [{if $oxcmp_basket->getFPaymentCosts() }]
                           
                                <span class="item">[{if $oxcmp_basket->getPaymentCosts() >= 0}][{oxmultilang ident="SURCHARGE"}][{else}][{oxmultilang ident="DEDUCTION"}][{/if}] [{oxmultilang ident="PAYMENT_METHOD"}]</span>
                                <strong class="price pull-right">[{oxprice price=$oxcmp_basket->getFPaymentCosts() currency=$currency}]</strong>
                            
                        [{/if }]
                        </p>
                    [{/block}]
                    
                 
                    [{block name="checkout_basketcontents_voucherdiscount"}]
                            [{if $oViewConf->getShowVouchers() && $oxcmp_basket->getVoucherDiscValue() }]
                                [{foreach from=$oxcmp_basket->getVouchers() item=sVoucher key=key name=Voucher}]
                                    <p class="totals">
                                        <span class="item">[{oxmultilang ident="COUPON"}]</span>
                                        <strong class="price pull-right">[{oxprice price=$sVoucher->dVoucherdiscount*-1 currency=$currency}]</strong>
                                    </p>
                                [{/foreach}]
                            [{/if}]
                    [{/block}]

                    
                    [{/block}]
                    [{block name="widget_minibasket_total"}]
                        <p class="totals basketsum">
                           <span class="item">[{ oxmultilang ident="TOTAL" }]</span>
                           <strong class="price pull-right">[{oxprice price=$oxcmp_basket->getPrice() currency=$currency}]</strong>
                        </p>
                    [{/block}]
                    
                

            
    </div>
    <hr>
    <div class="sidebar-checkout-content">
        [{*<h3 class="text-center">[{ oxmultilang ident="CHECKOUT_SIDEBAR_OPTIONS" }]</h3> *}]
        <ul>
          <li><a href="[{ oxgetseourl ident=$oViewConf->getBasketLink() }]" rel="nofollow" style="    background: #D30000;
    color: white;
    padding: 4px 28px;
    border-radius: 4px;">[{ oxmultilang ident="ENTER_COUPON_NUMBER" }]</a></li>
          <li><a href="[{ oxgetseourl ident=$oViewConf->getBasketLink() }]" rel="nofollow"><img src="[{$oViewConf->getImageUrl('cart-ico.png')}]" class="li-icon-img">[{ oxmultilang ident="DISPLAY_BASKET" }]</a></li>
          <li><a href="[{ oxgetseourl ident=$oViewConf->getBasketLink() }]" rel="nofollow"><span class="glyphicon glyphicon-pencil"></span>[{ oxmultilang ident="ORDER_REMARK" }]</a></li>

        </ul>
    </div>
    <hr>
    <div class="sidebar-checkout-trusticons clearfix resp-xs-hidden">
        <h4>[{oxmultilang ident="FOOTER_PAYMENT_METHODS"}]</h4>
        <ul class="clearfix">
            <li><a href=""><img src="[{$oViewConf->getImageUrl('footer/footer-payment-mastercard.png')}]" ></a></li>
            <li><a href=""><img src="[{$oViewConf->getImageUrl('footer/footer-payment-visa.png')}]" ></a></li>
            <li><a href=""><img src="[{$oViewConf->getImageUrl('footer/footer-payment-paypal.png')}]"></a></li>
            <li class="txt-icon"><a href="">[{oxmultilang ident="FOOTER_PAYMENT_INVOICE"}]</a>
            <li class="txt-icon"><a href="">[{oxmultilang ident="FOOTER_PAYMENT_PREPAYMENT"}]</a>
            <li class="txt-icon"><a href="">[{oxmultilang ident="FOOTER_PAYMENT_COD"}]</a>
        </ul>
        <h4>[{oxmultilang ident="FOOTER_SHIPPING_METHODS"}]</h4>
        <ul class="list-content-links inline-box">
            <li><a href=""><img src="[{$oViewConf->getImageUrl('footer/footer-shipping-post.png')}]" ></a></li>
            <li><a href=""><img src="[{$oViewConf->getImageUrl('footer/footer-shipping-ups.png')}]" ></a></li>
            <li class="txt-icon"><a href="">[{oxmultilang ident="FOOTER_PICKUP}]</a></li>
        </ul>
    </div>
    
</div>



[{if 0}]
<div class="sidebar-checkout">
    <h3 class="text-center">[{ oxmultilang ident="CHECKOUT_SIDEBAR_TITLE" }]</h3> 
    <div class="sidebar-checkout-content">
        [{oxcontent ident="checkout_sidebar_right" }] 
    </div>

 
[{foreach from=$oxidBlock_sidebar item="_block"}]
    [{$_block}]
[{/foreach}]
[{/if}]
[{if 0}]
[{block name="sidebar"}]
    [{block name="sidebar_adminbanner"}]
        [{if $oView->isDemoShop()}]
            [{ include file="widget/sidebar/adminbanner.tpl" }]
        [{/if}]
    [{/block}]

    [{block name="sidebar_categoriestree"}]
        [{if $oView->getClassName() != 'start' && $oView->getClassName() != 'compare'}]
            [{oxid_include_widget cl="oxwCategoryTree" cnid=$oView->getCategoryId() deepLevel=0 noscript=1 nocookie=1}]
        [{/if}]
    [{/block}]

    [{block name="sidebar_trustedshopsratings"}]
        [{if $oView->getClassName() eq "start"}]
            [{if $oViewConf->showTs("WIDGET") }]
                [{include file="widget/trustedshops/ratings.tpl" }]
            [{/if}]
        [{/if}]
    [{/block}]

    [{block name="sidebar_partners"}]
        [{if $oView->getClassName() eq "start"}]
            [{include file="widget/sidebar/partners.tpl" }]
        [{/if}]
    [{/block}]

    [{block name="sidebar_boxproducts"}]
        [{if $oView->getTop5ArticleList()}]
            [{include file="widget/product/boxproducts.tpl" _boxId="topBox" _oBoxProducts=$oView->getTop5ArticleList() _sHeaderIdent="TOP_OF_THE_SHOP"}]
        [{/if}]
    [{/block}]

    [{block name="sidebar_recommendation"}]
        [{if $oViewConf->getShowListmania() && $oView->getSimilarRecommListIds() }]
            [{oxid_include_widget nocookie=1 cl="oxwRecommendation" aArticleIds=$oView->getSimilarRecommListIds() searchrecomm=$oView->getRecommSearch()}]
        [{elseif $oViewConf->getShowListmania() && $oView->getRecommSearch()}]
            [{oxid_include_widget nocookie=1 cl="oxwRecommendation" _parent=$oView->getClassName() searchrecomm=$oView->getRecommSearch()}]
        [{/if}]
    [{/block}]

    [{block name="sidebar_tags"}]
        [{if $oView->showTags() && $oView->getClassName() ne "details" && $oView->getClassName() ne "alist" && $oView->getClassName() ne "suggest" && $oView->getClassName() ne "tags"}]
            [{oxid_include_widget nocookie=1 cl="oxwTagCloud" blShowBox="1" noscript=1 }]
        [{/if}]
    [{/block}]

    [{block name="sidebar_news"}]
        [{if $oxcmp_news|count }]
            [{include file="widget/sidebar/news.tpl" oNews=$oxcmp_news}]
        [{/if}]
    [{/block}]

    [{block name="sidebar_facebookfacepile"}]
          [{if $oView->isActive('FbFacepile') && $oView->isConnectedWithFb()}]
            <div id="facebookFacepile" class="box">
                <h3>[{oxmultilang ident="FACEBOOK_FACEPILE"}]</h3>
                <div class="content" id="productFbFacePile">
                    [{include file="widget/facebook/enable.tpl" source="widget/facebook/facepile.tpl" ident="#productFbFacePile" type="text"}]
                </div>
            </div>
        [{/if}]
    [{/block}]

    [{block name="sidebar_shopluperatings"}]
        [{if $oView->getClassName() eq "start"}]
           [{include file="widget/shoplupe/ratings.tpl" }]
        [{/if}]
    [{/block}]
[{/block}]

[{/if}]