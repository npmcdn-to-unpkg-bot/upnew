[{ if $oView->isLanguageLoaded()}]
<div class="service-switcher">
        [{foreach from=$oxcmp_lang item=_lng}]
        [{assign var="sLangImg" value="lang/"|cat:$_lng->abbr|cat:".png"}]
        [{if $_lng->selected}]
            [{capture append="oxidBlock_languageSelected"}]
                <li class="active"><a class="[{$_lng->abbr }]" title="[{$_lng->name}]" href="[{$_lng->link|oxaddparams:$oView->getDynUrlParams()}]" hreflang="[{$_lng->abbr }]" lang="[{$_lng->abbr }]"><span>[{$_lng->abbr }]</span></a></li>
            [{/capture}]
        [{else}]
           [{capture append="oxidBlock_languageList"}]
            <li><a class="[{$_lng->abbr }] [{if $_lng->selected}]selected[{/if}]" title="[{$_lng->name}]" href="[{$_lng->link|oxaddparams:$oView->getDynUrlParams()}]" hreflang="[{$_lng->abbr }]" lang="[{$_lng->abbr }]"><span>[{$_lng->abbr }]</span></a></li>
          [{/capture}]
         [{/if}]
        [{/foreach}]
    <span class="name">[{oxmultilang ident="LANGUAGE"}]:</span>
     <ul class="options-list">
        [{foreach from=$oxidBlock_languageSelected item="_block"}]
             [{$_block}]
         [{/foreach}]
         [{foreach from=$oxidBlock_languageList item="_block"}]
             [{$_block}]
         [{/foreach}]
         
    </ul>
   
   
</div>

[{/if}]