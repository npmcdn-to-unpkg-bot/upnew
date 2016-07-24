[{assign var="listType" value=$oView->getListDisplayType()}]
[{assign var="_additionalParams" value=$oView->getAdditionalParams()}]
[{assign var="_artPerPage" value=$oViewConf->getArtPerPageCount()}]
[{if $oView->canSelectDisplayType()}]
   
    [{oxmultilang ident="LIST_DISPLAY_TYPE" suffix="COLON" }]
    [{ * oxmultilang ident=$listType *}]
    <a href="[{$oView->getBaseLink()|oxaddparams:"ldtype=three&amp;_artperpage=$_artPerPage&amp;pgNr=0&amp;$_additionalParams"}]" [{if $listType eq 'three' }]class="selected" [{/if}]><img src="[{$oViewConf->getImageUrl()}]/3grid.png"></a></li>
    <a href="[{$oView->getBaseLink()|oxaddparams:"ldtype=four&amp;_artperpage=$_artPerPage&amp;pgNr=0&amp;$_additionalParams"}]" [{if $listType eq 'four' }]class="selected" [{/if}]><img src="[{$oViewConf->getImageUrl()}]/4grid.png"></a></li>
    <a href="[{$oView->getBaseLink()|oxaddparams:"ldtype=six&amp;_artperpage=$_artPerPage&amp;pgNr=0&amp;$_additionalParams"}]" [{if $listType eq 'six' }]class="selected" [{/if}]><img src="[{$oViewConf->getImageUrl()}]/6grid.png"></a></li>

[{/if}]