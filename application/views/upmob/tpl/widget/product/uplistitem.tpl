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

    [{if $showMainLink}]
        [{assign var='_productLink' value=$product->getMainLink()}]
    [{else}]
        [{assign var='_productLink' value=$product->getLink()}]
    [{/if}]


   <a href="[{ $_productLink }]" >              

    [{block name="widget_product_listitem_line_picturebox"}]
        <div class="image-wrap [{$product->getBadge()}]" >
          <div class="iclick" style="position:absolute;width:100%;height:100%;z-index:333;"></div>
            <img class="p1" src="[{$product->getThumbnailUrl()}]" alt="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]" >
           
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
        [{ if $product->getVariants()}]
            <div class="varsizes">
            <div>[{* oxmultilang ident="LIST_SIZES" *}]Verfügbare Grössen</div>
            [{foreach from=$product->getVariants() item=variant name=varz}]<i>[{ $variant->oxarticles__oxvarselect->value }]</i>[{*[{if !$smarty.foreach.varz.last}], [{/if}]*}][{/foreach}]
            </div>
        [{/if}]
    </div>
</a>   


[{/block}]
[{/strip}]
[{oxscript widget=$oView->getClassName()}]
