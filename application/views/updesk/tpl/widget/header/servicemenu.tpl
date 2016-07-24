[{* include file="widget/header/servicebox.tpl" *}]
<ul class="topMenu">
<li class="login flyout[{if $oxcmp_user->oxuser__oxpassword->value}] logged[{/if}]">
     <a href="#" id="flyoutBoxOpener" title="[{ oxmultilang ident="LOGIN" }]">[{if $oxcmp_user}][{oxmultilang ident="MY_ACCOUNT"}][{else}][{ oxmultilang ident="LOGIN" }][{/if}]<span class="caret"></span></a>
     <div class="flyoutBox flyout-container">
           [{* if $oxcmp_user}]
            <ul id="services" class="corners flyoutMenu">
                [{block name="widget_header_servicebox_items"}]
                    <li class="active"><a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account" }]"><span>[{oxmultilang ident="ACCOUNT"}]</span></a></li>
                    <li><a href="[{ oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=account" }]" rel="nofollow"><span>[{oxmultilang ident="MY_ACCOUNT"}]</span></a></li>
                    <li><a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_order" }]" rel="nofollow"><span>[{oxmultilang ident="MY_ORDER_HISTORY"}]</span></a></li>
                   
                [{/block}]
            </ul>
            [{/if *}]
        [{include file="widget/header/loginbox.tpl"}]
     </div>
  
 
</li>
[{if !$oxcmp_user}]
    <li><a id="registerLink" href="[{ oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=register" }]" title="[{oxmultilang ident="REGISTER"}]">[{oxmultilang ident="REGISTER"}]</a></li>
[{/if}]
</ul>
[{oxscript widget=$oView->getClassName()}]