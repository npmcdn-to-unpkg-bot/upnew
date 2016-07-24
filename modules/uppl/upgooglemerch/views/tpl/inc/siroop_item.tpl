[{strip}]
[{assign var="oCategory" value=$product->getCategory()}]
[{assign var="oManufacturer" value=$product->getManufacturer()}]           
[{assign var='productLink' value=$product->getMainLink()}]
[{assign var='colorFilter' value=$product->getGsfColor()}]
[{/strip}]
[{if $oCategory }]
[{if !$product->getVariants()}]
<item>
    <g:title><![CDATA[[{$product->oxarticles__oxtitle->value}]]]></g:title>
    <g:link>[{ $productLink }]</g:link>
    <g:description>[{assign var="longDesc" value=$product->getLongDesc() }][{$longDesc|strip_tags|htmlentities|htmlspecialchars}]</g:description>
    <g:id>[{ $product->oxarticles__oxid->value }]</g:id>
    <g:condition>new</g:condition>
    [{assign var=pricetag value='price' }]
    [{if $product->getFTPrice()}]
        [{assign var=pricetag value='sale_price' }]
        <g:price>[{ $product->getFTPrice()}] [{ $currency->sign}]</g:price>
    [{/if}]
    [{if $product->getFPrice()}]
        <g:[{$pricetag}]>[{ $product->getFPrice() }] [{ $currency->sign}]</g:[{$pricetag}]>
    [{/if}]
    <g:availability>[{if $product->getStockStatus() < 0 }]out of stock[{else}]in stock[{/if}]</g:availability>	
    <g:image_link>[{ $product->getPictureUrl(1)}]</g:image_link>
    [{if $oCategory}]
    <g:google_product_category>[{$oCategory->getSiroopTid()}]</g:google_product_category>
    <g:gender>[{ $oCategory->getGoogleGender() }]</g:gender>
    [{/if}]
    [{if $colorFilter }]
    <g:color>[{$colorFilter}]</g:color>
    [{/if}]
    [{if $product->oxarticles__oxcustomtyp->value != 2}]
    <g:size>[{if $product->oxarticles__oxartnum->value == 1}][{elseif $product->oxarticles__oxartnum->value == 3}][{elseif $product->oxarticles__oxartnum->value == 2}][{/if}]</g:size>
    [{/if}]
    <g:brand>[{if ($oManufacturer) }][{ $oManufacturer->oxmanufacturers__oxtitle->value}][{/if}]</g:brand>
    <g:mpn>[{ $product->oxarticles__oxartnum->value }]</g:mpn>
    [{if $product->oxarticles__oxean->value}]<g:gtin>[{ $product->oxarticles__oxean->value }]</g:gtin>[{/if}]
    [{assign var="picgal" value=$product->getPictureGallery() }]
    [{foreach from=$picgal.ZoomPics item=_zoomPic key=i}][{if $i > 1 }]<g:additional_image_link>[{$_zoomPic.file}]</g:additional_image_link>[{/if}][{/foreach}]
    [{if $product->getStockStatus() < 0 }]
        <s:dispatch_duration>5</s:dispatch_duration>
    [{/if}]
    [{if $product->oxarticles__oxstockflag->value == 1 }]
        [{* <s:quantity>3</s:quantity> siroop nos hack, sobal ok hier -> if an lager else 3*}]
        <s:quantity>[{$product->oxarticles__oxstock }]</s:quantity>
    [{elseif $product->oxarticles__oxstock > 0}]
        <s:quantity>[{$product->oxarticles__oxstock }]</s:quantity>
    [{/if}]
</item>
[{else}]
[{foreach from=$product->getVariants() item=variant name=varz}]
<item>
    <g:title><![CDATA[[{$product->oxarticles__oxtitle->value}] - [{ $variant->oxarticles__oxvarselect->value }]]]></g:title>
    <g:link>[{ $productLink }]</g:link>
    <g:description>[{assign var="longDesc" value=$product->getLongDesc() }][{$longDesc|strip_tags|htmlentities|htmlspecialchars}]</g:description>
    <g:id>[{$variant->oxarticles__oxid->value}]</g:id>
    <g:condition>new</g:condition>
    [{assign var=pricetag value='price' }]
    [{if $product->getFTPrice()}]
        [{assign var=pricetag value='sale_price' }]
        <g:price>[{ $product->getFTPrice()}] [{ $currency->sign}]</g:price>
    [{/if}]
    [{if $product->getFPrice()}]
        <g:[{$pricetag}]>[{ $product->getFPrice() }] [{ $currency->sign}]</g:[{$pricetag}]>
    [{/if}]
    <g:availability>[{if $variant->getStockStatus() < 0 }]out of stock[{else}]in stock[{/if}]</g:availability>	
    <g:image_link>[{ $product->getPictureUrl(1)}]</g:image_link>
    [{if $oCategory}]
    <g:google_product_category>[{$oCategory->getSiroopTid()}]</g:google_product_category>
    <g:gender>[{ $oCategory->getGoogleGender() }]</g:gender>
    [{/if}]
    [{if $colorFilter }]
    <g:color>[{$colorFilter}]</g:color>
    [{/if}]
    [{if $product->oxarticles__oxcustomtyp->value != 2}]
    <g:size>[{ $variant->oxarticles__oxvarselect->value }]</g:size>
    [{/if}]
    <g:item_group_id>[{ $product->oxarticles__oxid->value }]</g:item_group_id>
    <g:brand>[{if ($oManufacturer) }][{ $oManufacturer->oxmanufacturers__oxtitle->value}][{/if}]</g:brand>
    <g:mpn>[{ $product->oxarticles__oxartnum->value }]</g:mpn>
    [{if $variant->oxarticles__oxean->value}]<g:gtin>[{ $variant->oxarticles__oxean->value }]</g:gtin>[{/if}]
    [{assign var="picgal" value=$product->getPictureGallery() }]
    [{foreach from=$picgal.ZoomPics item=_zoomPic key=i}][{if $i > 1 }]<g:additional_image_link>[{$_zoomPic.file}]</g:additional_image_link>[{/if}][{/foreach}]
    [{if $variant->getStockStatus() < 0 }]
        <s:dispatch_duration>5</s:dispatch_duration>
    [{/if}]
    [{if $variant->oxarticles__oxstockflag->value == 1 }]
        [{* <s:quantity>3</s:quantity> siroop nos hack, sobal ok hier -> if an lager else 3*}]
        <s:quantity>[{$variant->oxarticles__oxstock }]</s:quantity>
    [{elseif $variant->oxarticles__oxstock > 0}]
        <s:quantity>[{$variant->oxarticles__oxstock }]</s:quantity>
    [{/if}]
</item>
[{/foreach}]
[{/if}]
[{/if}]