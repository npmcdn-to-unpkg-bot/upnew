[{assign var="_additionalParams" value=$oView->getAdditionalParams()}]
[{assign var="_listType" value=$oView->getListDisplayType()}]

[{oxmultilang ident="PRODUCTS_PER_PAGE" suffix="COLON" }]

[{* [{if $oViewConf->getArtPerPageCount() }]
    [{ $oViewConf->getArtPerPageCount() }]
[{else}]
    [{oxmultilang ident="CHOOSE"}]
[{/if}] *}]
      

   
[{foreach from=$oViewConf->getNrOfCatArticles() item=iItemsPerPage name=ipp}]
<a href="[{$oView->getBaseLink()|oxaddparams:"ldtype=$_listType&amp;_artperpage=$iItemsPerPage&amp;pgNr=0&amp;$_additionalParams"}]" rel="nofollow" [{if $oViewConf->getArtPerPageCount() == $iItemsPerPage }] class="selected"[{/if}]>[{$iItemsPerPage}]</a> 
[{if not $smarty.foreach.ipp.last}] | [{/if}] 
[{/foreach}]

