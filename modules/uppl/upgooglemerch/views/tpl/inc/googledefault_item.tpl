[{strip}]
[{assign var="oCategory" value=$product->getCategory()}]
[{assign var="oManufacturer" value=$product->getManufacturer()}]           
[{assign var='productLink' value=$product->getMainLink()}]
[{assign var='colorFilter' value=$product->getGsfColor()}]
[{/strip}]
[{if $oCategory }]
[{if !$product->getVariants()}]
<item>
    <title><![CDATA[[{$product->oxarticles__oxtitle->value}]]]></title>
    <link>[{ $productLink }]</link>
    <description>[{assign var="longDesc" value=$product->getLongDesc() }][{$longDesc|strip_tags|htmlentities|htmlspecialchars}]</description>
    <g:id>[{ $product->oxarticles__oxid->value }]</g:id>
    <g:condition>new</g:condition>
    <g:price>[{ $product->getFPrice() }] [{ $currency->sign}]</g:price>
    <g:availability>in stock</g:availability>	
    <g:image_link>[{ $product->getPictureUrl(1)}]</g:image_link>
    [{if $oCategory}]
    <g:product_type>[{$oView->getGoogleCats($oCategory->getLink())}]</g:product_type>
    [{/if}]
     [{if $oCategory}]
    <g:google_product_category>[{ $oCategory->getGoogleCategory() }]</g:google_product_category>
    <g:gender>[{ $oCategory->getGoogleGender() }]</g:gender>
    [{/if}]
    [{if $colorFilter }]
    <g:color><![CDATA[[{$colorFilter}]]]></g:color>
    [{/if}]
    [{if $product->oxarticles__oxcustomtyp->value != 2}]
    <g:size>[{if $product->oxarticles__oxartnum->value == 1}][{elseif $product->oxarticles__oxartnum->value == 3}][{elseif $product->oxarticles__oxartnum->value == 2}][{/if}]</g:size>
    [{/if}]
    <g:brand>[{if ($oManufacturer) }][{ $oManufacturer->oxmanufacturers__oxtitle->value}][{/if}]</g:brand>
    <g:mpn>[{ $product->oxarticles__oxartnum->value }]</g:mpn>
    [{if $product->oxarticles__oxean->value}]<g:gtin>[{ $product->oxarticles__oxean->value }]</g:gtin>[{/if}]
    [{assign var="picgal" value=$product->getPictureGallery() }]
    [{foreach from=$picgal.ZoomPics item=_zoomPic key=i}][{if $i > 1 }]<g:additional_image_link>[{$_zoomPic.file}]</g:additional_image_link>[{/if}][{/foreach}]
</item>
[{else}]
[{foreach from=$product->getVariants() item=variant name=varz}]
<item>
    <title><![CDATA[[{$product->oxarticles__oxtitle->value}]]]></title>
    <link>[{ $productLink }]</link>
    <description>[{assign var="longDesc" value=$product->getLongDesc() }][{$longDesc|strip_tags|htmlentities|htmlspecialchars}]</description>
    <g:id>[{$variant->oxarticles__oxid->value}]</g:id>
    <g:condition>new</g:condition>
    <g:price>[{ $product->getFPrice() }] [{ $currency->sign}]</g:price>
    <g:availability>in stock</g:availability>	
    <g:image_link>[{ $product->getPictureUrl(1)}]</g:image_link>
     [{if $oCategory}]
    <g:product_type>[{$oView->getGoogleCats($oCategory->getLink())}]</g:product_type>
    [{/if}]
    [{if $oCategory}]
    <g:google_product_category>[{ $oCategory->getGoogleCategory() }]</g:google_product_category>
    <g:gender>[{ $oCategory->getGoogleGender() }]</g:gender>
    [{/if}]
    [{if $colorFilter }]
    <g:color><![CDATA[[{$colorFilter}]]]></g:color>
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
</item>
[{/foreach}]
[{/if}]
[{/if}]