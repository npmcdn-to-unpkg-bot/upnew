[{assign var="oDetailsProduct" value=$oView->getProduct()}]

[{assign var="currency" value=$oView->getActCurrency()}]


[{block name="details_productmain_price"}]
[{*Price Info*}]
[{oxhasrights ident="SHOWARTICLEPRICE"}]
<div class="product-price-container" itemprop="offers" itemscope itemtype="http://schema.org/Offer">

[{if $oDetailsProduct->getPrice()}]
    <div class="product-price price [{$reducedclass}]">
        [{assign var="sFrom" value=""}]
        [{assign var="oPrice" value=$oDetailsProduct->getPrice()}]
        [{if $oDetailsProduct->isParentNotBuyable() }]
        [{assign var="oPrice" value=$oDetailsProduct->getVarMinPrice()}]
        [{if $oDetailsProduct->isRangePrice() }]
        [{assign var="sFrom" value="PRICE_FROM"|oxmultilangassign}]
        [{/if}]
        [{/if}]
        <strong>
            <meta itemprop="price" content="[{ $oPrice->getBruttoPrice() }]" />
            <span>[{$sFrom}]</span> <span class="js-">[{oxprice price=$oPrice currency=$currency}]</span>
            [{* if $oView->isVatIncluded() }]
                                    <span>*</span>
                                [{/if *}]
        </strong>
    </div>
    [{/if}]
[{/block}]
</div>
[{/oxhasrights}]


[{* Variant pre-assigns *}]
[{assign var="aVariantSelections" value=$oView->getVariantSelections()}]

[{if $aVariantSelections && $aVariantSelections.rawselections}]
    [{assign var="_sSelectionHashCollection" value=""}]
    [{foreach from=$aVariantSelections.rawselections item=oSelectionList key=iKey}]
        [{assign var="_sSelectionHash" value=""}]
        [{foreach from=$oSelectionList item=oListItem key=iPos}]
            [{assign var="_sSelectionHash" value=$_sSelectionHash|cat:$iPos|cat:":"|cat:$oListItem.hash|cat:"|"}]
        [{/foreach}]
        [{if $_sSelectionHash}]
            [{if $_sSelectionHashCollection}][{assign var="_sSelectionHashCollection" value=$_sSelectionHashCollection|cat:","}][{/if}]
            [{assign var="_sSelectionHashCollection" value=$_sSelectionHashCollection|cat:"'`$_sSelectionHash`'"}]
        [{/if}]
    [{/foreach}]
    [{oxscript add="var oxVariantSelections  = [`$_sSelectionHashCollection`];"}]

    <form class="js-oxWidgetReload" action="[{$oView->getWidgetLink()}]" method="get">
        <div>
            [{$oViewConf->getHiddenSid()}]
            [{$oViewConf->getNavFormParams()}]
            <input type="hidden" name="cl" value="[{$oView->getClassName()}]">
            <input type="hidden" name="oxwparent" value="[{$oViewConf->getTopActiveClassName()}]">
            <input type="hidden" name="listtype" value="[{$oView->getListType()}]">
            <input type="hidden" name="nocookie" value="1">
            <input type="hidden" name="cnid" value="[{$oView->getCategoryId()}]">
            <input type="hidden" name="anid" value="[{if !$oDetailsProduct->oxarticles__oxparentid->value}][{$oDetailsProduct->oxarticles__oxid->value}][{else}][{$oDetailsProduct->oxarticles__oxparentid->value}][{/if}]">
            <input type="hidden" name="actcontrol" value="[{$oViewConf->getTopActiveClassName()}]">
        </div>
    </form>
[{/if}]


[{* To basket form start *}]
[{oxhasrights ident="TOBASKET"}]
<form class="js-oxProductForm" id="toBasketForm" action="[{$oView->getWidgetLink()}]" method="post" >

    <div>
        [{$oViewConf->getHiddenSid()}]
        [{$oViewConf->getNavFormParams()}]
        <input type="hidden" name="cl" value="oxwminibasket">
        <input type="hidden" name="oxwparent" value="">
        <input type="hidden" name="aid" value="[{$oDetailsProduct->oxarticles__oxid->value}]">
        <input type="hidden" name="anid" value="[{$oDetailsProduct->oxarticles__oxnid->value}]">
        <input type="hidden" name="parentid" value="[{if !$oDetailsProduct->oxarticles__oxparentid->value}][{$oDetailsProduct->oxarticles__oxid->value}][{else}][{$oDetailsProduct->oxarticles__oxparentid->value}][{/if}]">
        <input type="hidden" name="panid" value="">
        [{if !$oDetailsProduct->isNotBuyable()}]
            <input type="hidden" name="fnc" value="tobasket">
        [{/if}]
    </div>
    [{/oxhasrights}]

    [{if $oDetailsProduct->isNotBuyable()}]
        <div class="alert alert-info" role="alert">Leider ist der gewünschte Artikel nicht mehr verfügbar.</div>
    [{/if}]
    

   


        
  [{if 0}]
    <div id="product-variants-container">
        [{* Variant Selector *}]
        [{assign var="blCanBuy" value=true}]
        [{* Variants | md variants *}]
        [{block name="details_productmain_variantselections"}]
            [{if $aVariantSelections && $aVariantSelections.selections }]
                [{oxscript include="js/widgets/oxajax.js" priority=10 }]
                [{oxscript include="js/widgets/oxarticlevariant.js" priority=10 }]
                [{oxscript add="$( '#variants' ).oxArticleVariant();"}]
                [{assign var="blCanBuy" value=$aVariantSelections.blPerfectFit}]
                <ul id="variants" class="form js-fnSubmit clear">
                    [{assign var="blHasActiveSelections" value=false}]
                    [{foreach from=$aVariantSelections.selections item=oList key=iKey}]
                        <li>
                            [{if $oList->getActiveSelection()}]
                                [{assign var="blHasActiveSelections" value=true}]
                            [{/if}]
                            [{include file="widget/product/selectbox.tpl" oSelectionList=$oList iKey=$iKey blInDetails=true}]
                        </li>
                    [{/foreach}]
                </ul>
                [{if !$blCanBuy }]
                    [{* <p class="product-variants-message">[{oxmultilang ident="CHOOSE_VARIANT"}]</p> *}]
                [{/if}]
            [{/if}]
        [{/block}]
        [{* Selection lists *}]
        [{block name="details_productmain_selectlists"}]
            [{if $oViewConf->showSelectLists()}]
                [{assign var="oSelections" value=$oDetailsProduct->getSelections()}]
                [{if $oSelections}]
                    <div class="js-fnSubmit clear" id="productSelections">
                        [{foreach from=$oSelections item=oList name=selections}]
                            [{include file="widget/product/selectbox.tpl" oSelectionList=$oList sFieldName="sel" iKey=$smarty.foreach.selections.index blHideDefault=true sSelType="seldrop"}]
                        [{/foreach}]
                    </div>
                [{/if}]
            [{/if}]
        [{/block}]
    </div>[{/if}]
    
    
        <div id="product-variants-container">
        [{* Variant Selector *}]
        [{assign var="blCanBuy" value=true}]
        [{* Variants | md variants *}]
        [{block name="details_productmain_variantselections"}]
            [{if $aVariantSelections && $aVariantSelections.selections }]
                 <ul id="variants" class="form js-fnSubmit clear">
                    [{assign var="blHasActiveSelections" value=false}]
                    [{foreach from=$aVariantSelections.selections item=oList key=iKey}]
                        <li>
                            [{if $oList->getActiveSelection()}]
                                [{assign var="blHasActiveSelections" value=true}]
                            [{/if}]
                            [{include file="widget/product/selectbox-boxes.tpl" oSelectionList=$oList iKey=$iKey blInDetails=true}]
                        </li>
                    [{/foreach}]
                </ul>
                [{if !$blCanBuy }]
                    [{* <p class="product-variants-message">[{oxmultilang ident="CHOOSE_VARIANT"}]</p> *}]
                [{/if}]
                [{oxscript include="js/widgets/oxajax.js" priority=10 }]
                [{oxscript include="js/widgets/oxarticlevariant.js" priority=10 }]
                [{oxscript add="$( '#variants' ).oxArticleVariant();"}]
                [{assign var="blCanBuy" value=$aVariantSelections.blPerfectFit}]
               
            [{/if}]
        [{/block}]
        [{* Selection lists *}]
        [{block name="details_productmain_selectlists"}]
            [{if $oViewConf->showSelectLists()}]
                [{assign var="oSelections" value=$oDetailsProduct->getSelections()}]
                [{if $oSelections}]
                    <div class="js-fnSubmit clear" id="productSelections">
                        [{foreach from=$oSelections item=oList name=selections}]
                            [{include file="widget/product/selectbox.tpl" oSelectionList=$oList sFieldName="sel" iKey=$smarty.foreach.selections.index blHideDefault=true sSelType="seldrop"}]
                        [{/foreach}]
                    </div>
                [{/if}]
            [{/if}]
        [{/block}]
    </div>
   
    
   
    
    [{* Add to basket *}]
    <div id="productAddToBasket" class="form">
        [{* Persistent parameters *}]
        [{block name="details_productmain_persparams"}]
        [{if $oView->isPersParam()}]
            <li id="persparamBox">
                <input type="text" id="persistentParam" name="persparam[details]" value="[{$oDetailsProduct->aPersistParam.text }]" size="35" placeholder="[{oxmultilang ident="LABEL"}]" />
            </li>
        [{/if}]
        [{/block}]
        
        [{block name="mb_details_productmain_tobasket"}]
            [{oxhasrights ident="TOBASKET"}]
            [{if !$oDetailsProduct->isNotBuyable()}]
                <input id="amountToBasket" type="hidden" name="am" value="1" size="3" autocomplete="off" class="textbox">
                [{if !$blCanBuy}]
                 <button id="toBasket" type="submit" disabled="disabled" class="submitButton largeButton btn btn-block btn-checkout-guide disabled"><span class="glyphicon glyphicon-arrow-up"></span>[{oxmultilang ident="DETAIL_CHOOSESIZE"}]</button>
                [{else}]
                 <button id="toBasket" type="submit" class="submitButton largeButton btn btn-block btn-checkout-guide">[{oxmultilang ident="TO_CART"}]</button>
                [{/if}]
            [{/if}]
            [{/oxhasrights}]
        [{/block}]
    </div>
    
   
   
    
     [{* Additional info *}]
    <div class="product-additional-info detail-section">
        [{block name="details_productmain_priceperunit"}]
            [{if $oDetailsProduct->getUnitPrice()}]
                <span class="product-price-per-unit">[{$oDetailsProduct->getUnitQuantity()}] [{$oDetailsProduct->getUnitName()}] | [{oxprice price=$oDetailsProduct->getUnitPrice() }] [{$currency->sign}]/[{$oDetailsProduct->getUnitName()}]</span>
            [{/if}]
        [{/block}]
        [{* Stock status *}]
        [{block name="details_productmain_stockstatus"}]
        <span><b>[{oxmultilang ident="DETAIL_STOCK_AVAIL" suffix="COLON"}]</b></span>
            [{if $oDetailsProduct->getVarStockStatus() == -1}]
                <span class="product-stock-flag no-stock">
                    [{if $oDetailsProduct->getDeliveryDate()}]
                        <span class="product-stock-flag low-stock" style="color:#0000FF;">
                            [{oxmultilang ident="AVAILABLE_ON"}] [{$oDetailsProduct->getDeliveryDate()}]
                        </span>
                    [{else}]
                        [{if $oDetailsProduct->oxarticles__oxnostocktext->value}]
                            [{$oDetailsProduct->oxarticles__oxnostocktext->value}]
                        [{elseif $oViewConf->getStockOffDefaultMessage()}]
                            [{oxmultilang ident="MESSAGE_NOT_ON_STOCK"}]
                        [{/if}]
                    [{/if}]
                    
                </span>
            [{elseif $oDetailsProduct->getVarStockStatus() == 1}]
                <span class="product-stock-flag low-stock" style="color:#07B107;">
                    [{*oxmultilang ident="LOW_STOCK"*}]
                     [{oxmultilang ident="READY_FOR_SHIPPING"}]
                </span>
            [{elseif $oDetailsProduct->getVarStockStatus() == 0}]
                <span class="product-stock-flag"  style="color:#07B107;">
                    [{if $oDetailsProduct->oxarticles__oxstocktext->value}]
                        [{$oDetailsProduct->oxarticles__oxstocktext->value}]
                    [{elseif $oViewConf->getStockOnDefaultMessage()}]
                        [{oxmultilang ident="READY_FOR_SHIPPING"}]
                    [{/if}]
                </span>
            [{elseif $oDetailsProduct->getVarStockStatus() == 99}]
                <span class="product-stock-flag low-stock" style="color:#07B107;">
                    [{oxmultilang ident="DETAIL_STOCKCHOOSESIZE"}]
                </span>
            [{/if}]
        [{/block}]
        [{* Delivery time *}]
        [{block name="details_productmain_deliverytime"}]
            [{oxhasrights ident="TOBASKET"}]
                [{if $oDetailsProduct->isBuyable() || 1==1 }]
                    [{include file="page/details/inc/deliverytime.tpl"}]
                [{/if}]
            [{/oxhasrights}]
        [{/block}]
    </div>
    
    [{* Delivery info *}]
    [{*
    <div class="product-delivery-info">
        [{block name="details_productmain_deliveryinfo"}]
        
            [{oxifcontent ident="oxdeliveryinfo" object="oCont"}]
            [{if $oView->isVatIncluded()}]
                <a href="[{$oCont->getLink()}]" rel="nofollow">* [{oxmultilang ident="PLUS_SHIPPING"}] [{oxmultilang ident="PLUS_SHIPPING2"}]</a>
            [{else}]
                <a href="[{$oCont->getLink()}]" rel="nofollow">* [{oxmultilang ident="PLUS"}] [{oxmultilang ident="PLUS_SHIPPING2"}]</a>
            [{/if}]
            [{/oxifcontent}]
           
        [{/block}]
    </div> *}]


[{* To basket form end *}]
[{oxhasrights ident="TOBASKET"}]
</form>
[{/oxhasrights}]

 [{oxscript include="js/widgets/oxtobasket.js" priority=10 }]
 [{oxscript add="$( '#toBasketForm' ).oxToBasket();"}]



[{oxscript widget=$oView->getClassName() }]
