[{assign var="listType" value=$oView->getListDisplayType()}]
[{assign var="_additionalParams" value=$oView->getAdditionalParams()}]
[{assign var="_artPerPage" value=$oViewConf->getArtPerPageCount()}]
[{if $oView->canSelectDisplayType()}]
   
    [{oxmultilang ident="LIST_DISPLAY_TYPE" suffix="COLON" }]
    [{ * oxmultilang ident=$listType *}]
    <a href="[{$oView->getBaseLink()|oxaddparams:"ldtype=three&amp;_artperpage=$_artPerPage&amp;pgNr=0&amp;$_additionalParams"}]" [{if $listType eq 'three' }]class="selected" [{/if}]><img src="[{$oViewConf->getImageUrl()}]3grid.png"></a></li>
    <a href="[{$oView->getBaseLink()|oxaddparams:"ldtype=infosingle&amp;_artperpage=$_artPerPage&amp;pgNr=0&amp;$_additionalParams"}]" [{if $listType eq 'infosingle' }]class="selected" [{/if}]><img src="[{$oViewConf->getImageUrl()}]infosingle.png"></a></li>
    <a href="[{$oView->getBaseLink()|oxaddparams:"ldtype=single&amp;_artperpage=$_artPerPage&amp;pgNr=0&amp;$_additionalParams"}]" [{if $listType eq 'single' }]class="selected" [{/if}]><img src="[{$oViewConf->getImageUrl()}]single.png"></a></li>

[{/if}]