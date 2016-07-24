[{assign var="product"  value=$oView->getProduct()}]
[{assign var="oCat" value=$product->getCategory() }]
[{assign var="oManufacturer" value=$oView->getManufacturer()}]




[{if 0}]
[{block name="details_relatedproducts_crossselling"}]
    [{if $oView->getCrossSelling()|count}]
        [{capture append="oxidBlock_product_tabsbutton" }]
         <li role="presentation"><a href="#tab-crossselling" aria-controls="profile" role="tab" data-toggle="tab">Könnten dir gefallen</a></li>
        [{/capture}]
        [{capture append="oxidBlock_product_tabscontent"}]
           <div role="tabpanel" class="tab-pane" id="tab-crossselling">
            [{* include file="widget/product/boxproducts.tpl" _boxId="cross" _oBoxProducts=$oView->getCrossSelling() _sHeaderIdent="HAVE_YOU_SEEN" _sHeaderCssClass="lightHead" *}]
             [{include file="widget/product/upprodtabscontent.tpl" _boxId="similar"  _oBoxProducts=$oView->getCrossSelling() _sHeaderIdent="SIMILAR_PRODUCTS" _sHeaderCssClass="lightHead"}]
         </div>
        [{/capture}]
    [{/if}]
[{/block}]

[{block name="details_relatedproducts_similarproducts"}]
    [{ if $oView->getSimilarProducts()|count}]
        [{capture append="oxidBlock_productbar" }]
            [{include file="widget/product/boxproducts.tpl" _boxId="similar"  _oBoxProducts=$oView->getSimilarProducts() _sHeaderIdent="SIMILAR_PRODUCTS" _sHeaderCssClass="lightHead"}]
        [{/capture}]
    [{/if }]
[{/block}]


[{block name="details_relatedproducts_accessoires"}]
    [{ if $oView->getAccessoires()|count}]
        [{capture append="oxidBlock_productbar"}]
            [{include file="widget/product/boxproducts.tpl" _boxId="accessories" _oBoxProducts=$oView->getAccessoires() _sHeaderIdent="ACCESSORIES" _sHeaderCssClass="lightHead"}]
        [{/capture}]
    [{/if }]
[{/block}]

[{block name="details_relatedproducts_similarproducts"}]
    [{ if $oView->getSimilarManufacturerProducts()|count}]
         [{capture append="oxidBlock_product_tabsbutton" }]
       [{assign var="oManufacturer" value=$oView->getManufacturer()}]
                    
        <li role="presentation" class="active"><a href="#tab-similarmanufacturerproducts" aria-controls="home" role="tab" data-toggle="tab">[{ oxmultilang ident="DETAIL_MOREFROM" }] [{$oManufacturer->oxmanufacturers__oxtitle->value}]</a></li>
       
        <li role="presentation"><a href="#tab-recenthistory" aria-controls="settings" role="tab" data-toggle="tab">[{ oxmultilang ident="RECENTHISTORY" }]</a></li>
 
        [{/capture}]
        [{capture append="oxidBlock_product_tabscontent" }]
         <div role="tabpanel" class="tab-pane active" id="tab-similarmanufacturerproducts">
           [{include file="widget/product/upprodtabscontent.tpl" _boxId="similar"  _oBoxProducts=$oView->getSimilarManufacturerProducts() _sHeaderIdent="SIMILAR_PRODUCTS" _sHeaderCssClass="lightHead"}]
        </div>
       
        
         [{/capture}]
         [{capture append="oxidBlock_product_tabscontent" }]
         <div role="tabpanel" class="tab-pane active" id="tab-similarmanufacturerproducts">
             [{if $oView->getSimilarCategoryProducts()}]
           [{include file="widget/product/upprodtabscontent.tpl" _boxId="similar"  _oBoxProducts=$oView->getSimilarCategoryProducts() _sHeaderIdent="SIMILAR_PRODUCTS" _sHeaderCssClass="lightHead" }]
           [{/if}]
        </div>
         [{/capture}]
         [{capture append="oxidBlock_product_tabscontent" }]
         <div role="tabpanel" class="tab-pane active" id="tab-recenthistory">
            [{block name="details_relatedproducts_dcrecenthistory"}][{/block}]
        </div>
         [{/capture}]
    [{/if }]
[{/block}]




[{ if $oxidBlock_product_tabsbutton}]
<div class="addsales">
    [{*<ul class="nav nav-tabs" role="tablist">
        [{foreach from=$oxidBlock_product_tabsbutton item="_block"}]
            [{$_block}]
        [{/foreach}]
    </ul>
    <div class="tab-content">
        [{foreach from=$oxidBlock_product_tabscontent item="_block"}]
            [{$_block}]
        [{/foreach}]
    </div>
    *}]
    [{assign var="product"  value=$oView->getProduct()}]
    [{if $product->oxarticles__oxmanufacturerid->value}]
    [{assign var="oManufacturer" value=$product->getManufacturer()}]

    [{if $oManufacturer}]
    <h3>[{ oxmultilang ident="DETAIL_MOREFROM" }] [{$oManufacturer->oxmanufacturers__oxtitle->value}] <span>|</span> <a href="[{$oManufacturer->getLink()}]">[{ oxmultilang ident="ALL_ITEMS_SHOW" }]</a></h3>
    [{$oxidBlock_product_tabscontent.0}]
    [{/if}]
     [{/if}]
    
    

    [{assign var="oCat" value=$product->getCategory() }]
    [{if $oCat}]
    <h3>[{ oxmultilang ident="DETAIL_MOREFROM_CAT" }] [{$oCat->oxcategories__oxtitle->value}] <span>|</span> <a href="[{$oCat->getLink()}]">[{ oxmultilang ident="ALL_ITEMS_SHOW" }]</a></h3>
    [{$oxidBlock_product_tabscontent.1}]
     <h3>[{ oxmultilang ident="RECENTHISTORY" }]</h3>
    [{$oxidBlock_product_tabscontent.2}]
    [{/if}]

</div>

 

[{/if }]
[{/if }]