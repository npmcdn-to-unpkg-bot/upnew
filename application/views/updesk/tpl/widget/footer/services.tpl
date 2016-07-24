[{block name="footer_services"}]
    <div class="h4">[{oxmultilang ident="SERVICES" }]</div>
    <ul class="list-content-links">
        [{block name="footer_services_items"}]
            <li>
                <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=contact" }]">[{ oxmultilang ident="CONTACT" }]</a>
            </li>
            <li><a id="forgotPasswordLink" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=forgotpwd"}]" class="textLink" rel="nofollow">[{oxmultilang ident="FORGOT_PASSWORD"}]</a></li>
            <li><a id="openAccountLink" href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=register"}]" class="textLink" rel="nofollow">[{oxmultilang ident="OPEN_ACCOUNT"}]</a></li>
            [{*[{if $oViewConf->getHelpPageLink() }]
                <li><a href="[{ $oViewConf->getHelpPageLink() }]">[{ oxmultilang ident="HELP" }]</a></li>
            [{/if}]
            <li>
                <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=links" }]">[{ oxmultilang ident="LINKS" }]</a>
            </li>
            <li>
                <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=guestbook" }]">[{ oxmultilang ident="GUESTBOOK" }]</a>
            </li>
            

            [{if $oView->isActive('Invitations') }]
                <li><a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=invite" }]"
                       rel="nofollow">[{ oxmultilang ident="INVITE_YOUR_FRIENDS" }]</a></li>
            [{/if}]*}]
            [{oxhasrights ident="TOBASKET"}]
                <li><a href="[{ oxgetseourl ident=$oViewConf->getBasketLink() }]"
                       rel="nofollow">[{ oxmultilang ident="CART" }]</a></li>
            [{/oxhasrights}]
            <li><a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account" }]"
                   rel="nofollow">[{ oxmultilang ident="ACCOUNT" }]</a></li>
            [{*<li><a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_noticelist" }]"
                   rel="nofollow">[{ oxmultilang ident="WISH_LIST" }]</a></li>
            [{if $oViewConf->getShowWishlist()}]
                <li><a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_wishlist" }]"
                       rel="nofollow">[{ oxmultilang ident="MY_GIFT_REGISTRY" }]</a></li>
                <li>
                    <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=wishlist" params="wishid="|cat:$oView->getWishlistUserId() }]"
                       rel="nofollow">[{ oxmultilang ident="PUBLIC_GIFT_REGISTRIES" }]</a></li>
            [{/if}]
            [{if $oView->isEnabledDownloadableFiles()}]
                <li><a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_downloads" }]"
                       rel="nofollow">[{ oxmultilang ident="MY_DOWNLOADS" }]</a></li>
            [{/if}]*}]
        [{/block}]
    </ul>
       
[{/block}]