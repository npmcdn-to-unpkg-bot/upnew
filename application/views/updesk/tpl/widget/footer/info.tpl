[{assign var="aServices" value=$oView->getServicesList()}]
[{assign var="aServiceItems" value=$oView->getServicesKeys()}]
[{block name="footer_information"}]
    <div class="h4">[{oxmultilang ident="INFORMATION" }]</div>
    <ul class="list-content-links">
        [{foreach from=$aServiceItems item=sItem}]
            [{if isset($aServices.$sItem)}]
                <li><a href="[{$aServices.$sItem->getLink()}]">[{$aServices.$sItem->oxcontents__oxtitle->value}]</a></li>
            [{/if}]
        [{/foreach}]
        [{*<li><a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=newsletter" }]" rel="nofollow">[{ oxmultilang ident="NEWSLETTER" }]</a></li>*}]
        <li><a href="https://www.urbanpeople.com/newsletter-phplist/?p=subscribe&id=3" rel="nofollow">[{ oxmultilang ident="NEWSLETTER" }]</a></li>
    </ul>
[{/block}]