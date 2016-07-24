
<div class="product-details">
     [{* Img und tocart *}]
    [{include file="page/details/inc/productmain.tpl"}]
</div>
[{if 0}]
<div class="product-attributes">
    [{* Attributes *}]
    [{block name="details_attributes"}]
        [{if $oView->getAttributes()}]
            <span class="product-attributes-switch">
                [{oxmultilang ident="SPECIFICATION"}]
            </span>
            <div id="attributes">
                [{include file="page/details/inc/attributes.tpl"}]
            </div>
            <i class="glyphicon-chevron-down" data-toggle-up="glyphicon-chevron-up" data-toggle-down="glyphicon-chevron-down"></i>
        [{/if}]
    [{/block}]
</div>
[{/if}]

