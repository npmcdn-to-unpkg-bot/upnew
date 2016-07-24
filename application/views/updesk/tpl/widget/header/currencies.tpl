[{if $oView->loadCurrency()}]
    <div class="service-switcher">
    [{capture name="currencyList"}]
        [{foreach from=$oxcmp_cur item=_cur}]
            [{if $_cur->selected}]
                [{assign var="selectedCurrency" value=$_cur->name}]
                [{capture name="currencySelected"}]
                    <a href="[{$_cur->link|oxaddparams:$oView->getDynUrlParams()}]" title="[{ $_cur->name }]" rel="nofollow"><span>[{ $_cur->name }]</span></a>
                [{/capture}]
                
            [{else}]
                 <li><a[{if $_cur->selected}] class="selected"[{/if}] href="[{$_cur->link|oxaddparams:$oView->getDynUrlParams()}]" title="[{ $_cur->name }]" rel="nofollow"><span>[{ $_cur->name }]</span></a>
            [{/if}]
           
        [{/foreach}]
    [{/capture}]
    <span class="name">[{oxmultilang ident="CURRENCY"}]:</span>
        <ul class="options-list">
            <li class="active">[{$smarty.capture.currencySelected}]</li>
            [{$smarty.capture.currencyList}]
        </ul>
    </div>
[{/if}]
[{oxscript widget=$oView->getClassName()}]