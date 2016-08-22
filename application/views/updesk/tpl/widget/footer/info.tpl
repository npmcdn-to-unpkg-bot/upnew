[{assign var="aServices" value=$oView->getServicesList()}]
[{assign var="aServiceItems" value=$oView->getServicesKeys()}]
[{block name="footer_information"}]
    <div class="h4">[{oxmultilang ident="INFORMATION" }]</div>
    <ul class="c-list">
        [{foreach from=$aServiceItems item=sItem}]
            [{if isset($aServices.$sItem)}]
                <li class="c-list__item"><a href="[{$aServices.$sItem->getLink()}]">[{$aServices.$sItem->oxcontents__oxtitle->value}]</a></li>
            [{/if}]
        [{/foreach}]
        [{*<li><a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=newsletter" }]" rel="nofollow">[{ oxmultilang ident="NEWSLETTER" }]</a></li>*}]
        [{ oxcontent ident=footer_information_links }]
    </ul>
[{/block}]