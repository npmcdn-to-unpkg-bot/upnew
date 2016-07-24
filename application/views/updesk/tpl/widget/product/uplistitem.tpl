[{oxscript include="js/libs/cookie/jquery.cookie.js"}]
[{oxscript include="js/widgets/oxwishlistcontrol.js" priority=10}]
[{oxscript add="$('.wishlist-btn').oxWishlistControl();"}]
[{oxscript include="js/widgets/oxtriggerform.js" priority=10}]
[{oxscript add="$('.wishlist-btn').oxFormTrigger();"}]
[{strip}]
[{block name="widget_product_listitem_line"}]
    [{assign var="product"          value=$oView->getProduct()}]
    [{assign var="owishid"          value=$oView->getWishId()}]
    [{assign var="removeFunction"   value=$oView->getRemoveFunction()}]
    [{assign var="recommid"         value=$oView->getRecommId()}]
    [{assign var="iIndex"           value=$oView->getIndex()}]
    [{assign var="showMainLink"     value=$oView->getShowMainLink()}]
    [{assign var="blDisableToCart"  value=$oView->getDisableToCart()}]
    [{assign var="toBasketFunction" value=$oView->getToBasketFunction()}]
    [{assign var="altproduct"       value=$oView->getAltProduct()}]
    
    [{assign var="oVariants"    value=$product->getVariants() }]
    
    [{if $showMainLink}]
        [{assign var='_productLink' value=$product->getMainLink()}]
    [{else}]
        [{assign var='_productLink' value=$product->getLink()}]
    [{/if}]
    [{assign var="aVariantSelections" value=$product->getVariantSelections(null,null,1)}]
  
        [{*}]
        [{block name="widget_product_listitem_line_picturebox"}]
            <div class="pull-left">
                <img src="[{$product->getIconUrl()}]" alt="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
            </div>
        [{/block}]
        <div class="media-body">

            [{block name="widget_product_listitem_line_selections"}]
                <h4 class="media-heading">
                    [{if $removeFunction && (($owishid && ($owishid==$oxcmp_user->oxuser__oxid->value)) || (($wishid==$oxcmp_user->oxuser__oxid->value)) || $recommid)}]
                        [{block name="widget_product_listitem_line_removefromwishlist"}]
                            <div class="article-list-remove">
                                <button data-form="remove_[{$removeFunction}][{$iIndex}]" class="btn remove wishlist-btn" data-action="remove" data-anid="[{$product->oxarticles__oxnid->value}]" name="wishlist_remove_button"><i class="glyphicon-remove"></i></button>
                            </div>
                        [{/block}]
                    [{/if}]
                    <a href="[{$_productLink}]" class="media-heading-link" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                        <span>[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]</span>
                    </a>
                </h4>
                <div class="variants">
                    [{if $aVariantSelections && $aVariantSelections.selections}]
                        <p id="variantselector_[{$iIndex}]" class="js-fnSubmit clear">
                            [{foreach from=$aVariantSelections.selections item=oSelectionList key=iKey name=variantSelection}]
                                [{$oSelectionList->getLabel()}][{if !$smarty.foreach.variantSelection.first}], [{/if}]
                            [{/foreach}]
                            [{oxmultilang ident="SELECT"}]
                        </p>
                    [{elseif $oViewConf->showSelectListsInList()}]
                        [{assign var="oSelections" value=$product->getSelections(1)}]
                        [{if $oSelections}]
                            <div id="selectlistsselector_[{$iIndex}]" class="js-fnSubmit clear">
                                [{foreach from=$oSelections item=oList name=selections}]
                                    <label>[{$oList->getLabel()}] [{oxmultilang ident="SELECT"}]</label>
                                [{/foreach}]
                            </div>
                        [{/if}]
                    [{/if}]
                </div>
            [{/block}]
            [{block name="widget_product_listitem_line_description"}]
            [{/block}]
            <div class="article-list-price">
                [{block name="widget_product_listitem_line_price"}]
                    [{oxhasrights ident="SHOWARTICLEPRICE"}]
                    [{assign var=tprice value=$product->getTPrice()}]
                    [{assign var=price  value=$product->getPrice()}]
                    [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                        <span class="old-price">
                            <del>[{oxprice price=$product->getTPrice() currency=$currency}]</del>
                        </span>
                    [{/if}]
                    [{block name="widget_product_listitem_line_price_value"}]
                        <span id="productPrice_[{$iIndex}]" class="main-price">
                            <span>
                                [{if $product->isRangePrice()}]
                                    [{oxmultilang ident="PRICE_FROM"}]
                                    [{if !$product->isParentNotBuyable() }]
                                        [{assign var="oPrice" value=$product->getMinPrice() }]
                                    [{else}]
                                        [{assign var="oPrice" value=$product->getVarMinPrice() }]
                                    [{/if}]
                                [{else}]
                                    [{if !$product->isParentNotBuyable() }]
                                        [{assign var="oPrice" value=$product->getPrice() }]
                                    [{else}]
                                        [{assign var="oPrice" value=$product->getVarMinPrice() }]
                                    [{/if}]
                                [{/if}]
                            </span> [{oxprice price=$oPrice currency=$currency}]
                            [{if $oView->isVatIncluded()}]
                                [{if !($product->hasMdVariants() || ($oViewConf->showSelectListsInList() && $product->getSelections(1)) || $product->getVariants())}]*[{/if}]
                            [{/if}]
                        </span>
                        
                    [{/block}]
                    [{/oxhasrights}]
                [{/block}]
            </div>
           
        </div>
        [{*}]



      

   <a href="[{ $_productLink }]" >              
[{*}]<div class="image-wrap">
    <img title="[{$product->oxarticles__oxtitle->value}]" alt="[{$product->oxarticles__oxtitle->value}]" src="[{$product->getPictureUrl(1)}]http://www.urbanpeople.com/out/pictures/1/[{$product->oxarticles__oxpic1->value}]" >
   
</div>[{*}]
[{block name="widget_product_listitem_line_picturebox"}]
            <div class="image-wrap [{$product->getBadge()}] [{ if $oVariants}]h-v[{/if}]" data-p2="[{$product->getPictureUrl(2)}]" [{ if $oVariants}]data-powertip="<div>[{oxmultilang ident="LIST_AVA_SIZES"}]</div>[{foreach from=$oVariants item=variant name=varz}]<i>[{ $variant->oxarticles__oxvarselect->value }]</i>[{*[{if !$smarty.foreach.varz.last}], [{/if}]*}][{/foreach}]"[{/if}]>
                <img class="p1" src="[{$product->getThumbnailUrl()}]" alt="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                <div class="aqv">Quickview <span class="glyphicon glyphicon-new-window"></span></div>
            </div>
         
        [{/block}]


    <div class="info">
        <div class="title">
                <div class="st">[{$product->getFirstTitleLine(1)}]</div>
                [{*}]<div class="st_sh">[{$product->getFirstTitleLine(2)}]</div>[{*}]
                <div class="nd">[{$product->getSecondTitleLine()}]</div>
                <div class="rd">[{$product->getThirdTitleLine()}]</div>
        </div>
        <div class="price">
        [{if $type!="basket"}]
            [{assign var=rc value='' }]
            [{if $product->getFTPrice()}]
               [{assign var=rc value='class="reduced"' }]
                <del>[{ $product->getFTPrice()}] </del>
            [{/if}]
       
            [{if $product->getFPrice()}]
               <span [{$rc}]>[{ $currency->sign}] [{ $product->getFPrice() }]</span>
            [{/if}]
        [{else}]
                <span class="left">[{ oxmultilang ident='BASKET_QUANTITY' }]: [{ $basketitem->getAmount() }]</span>
                <span class="left">[{ oxmultilang ident='DETAILS_SIZE' }]: [{ $product->oxarticles__oxvarselect->value }]</span>
             [{if $product->getFPrice()}]
               <span class="right">[{ $currency->sign}] [{ $product->getFPrice() }]</span>
            [{/if}]          
        [{/if}]
        </div> 

    </div>
</a>   


[{/block}]
[{/strip}]
[{oxscript widget=$oView->getClassName()}]
