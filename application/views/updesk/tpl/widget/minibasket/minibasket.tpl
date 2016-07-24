
[{oxscript add="$( '#miniBasket' ).oxMiniBasket();"}]

[{if $oxcmp_basket->getProductsCount() gte 8}]
   
[{/if}]

[{block name="widget_minibasket"}]

[{if $oxcmp_basket->getProductsCount()}]
 
    [{capture assign="criteobasket" }]

        dataLayer.push({
            'ct_event' : 'BasketPage',
            'ct_products' : [
                [{foreach from=$oxcmp_basket->getContents() name=basketitems item=_product}]
                {
                    id: '[{$_product->getMainArticleId()}]',
                    price: '[{ $_product->getCleanFloatPrice() }]',
                    quantity: '[{$_product->getAmount()}]'
                 
                }[{if !$smarty.foreach.basketitems.last}],[{/if}]
                [{/foreach}]
            ]
        });

        
    [{/capture}]
      
    [{oxscript add=$criteobasket}]
[{/if}]

<form class="js-oxWidgetReload-miniBasket" action="[{$oView->getWidgetLink()}]" method="get">
    <div>
        <input type="hidden" name="cl" value="[{$oView->getClassName()}]"/>
        <input type="hidden" name="nocookie" value="0"/>
        <input type="hidden" name="force_sid" value="[{$oView->getSidForWidget()}]"/>
    </div>
</form>


    
<div id="miniBasket">
    
        [{* insert name="oxid_newbasketitem" tpl="widget/minibasket/newbasketitemmsg.tpl" type="message" wieso kommt das nur im mobile??*}]
        [{if $oxcmp_basket->isNewItemAdded()}]
        <div class="alert alert-success">
            <span id="newItemMsg" class="mini-basket-new-item">[{oxmultilang ident="NEW_BASKET_ITEM_MSG"}] <i class="glyphicon glyphicon-ok"></i></span>
        </div>
        [{/if}]
        
        [{include file="message/errors.tpl"}]
       
       
        [{if 0}]
        [{if $_prefix != "modal"}]
            [{if $oxcmp_basket->getItemsCount() > 0}]
                <span class="counter FXgradOrange">
                    [{insert name="oxid_newbasketitem" tpl="widget/minibasket/newbasketitemmsg.tpl" type="message"}]
                    <span id="[{$_prefix}]countValue">
                        [{$oxcmp_basket->getItemsCount()}]
                    </span>
                </span>
            [{/if}]
            <img src="[{$oViewConf->getImageUrl('basket.png')}]" id="[{$_prefix}]minibasketIcon" alt="Basket" class="basket">
        [{/if}]
        [{/if}]
  

    [{if $oxcmp_basket->getProductsCount()}]
            [{oxhasrights ident="TOBASKET"}]
          
                [{assign var="currency" value=$oView->getActCurrency() }]
                    <div id="basketFlyout">
                         [{if $oView->getRequestLocation() != 'checkout'}]
                        <button type="button" class="close closePop" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> 
                        [{if 0}]
                        <div class="row">
                            <div class="col-xs-12">
                                <h4 class="modal-title">[{ oxmultilang ident="CART" }] <small> [{$oxcmp_basket->getItemsCount()}] Artikel</small></h4>

                                    [{insert name="oxid_newbasketitem" tpl="widget/minibasket/newbasketitemmsg.tpl" type="message"}]
                                    [{include file="message/errors.tpl"}]
                                [{* <strong>[{$oxcmp_basket->getItemsCount()}] [{ oxmultilang ident="ITEMS_IN_BASKET" suffix="COLON" }]</strong> *}]
                                <button class="js-minibasket-edit minibasket-edit btn btn-default btn-block btn-sm">[{ oxmultilang ident="MINIBASKET_EDIT" }] [{*<span class="glyphicon glyphicon-pencil"></span><span class="glyphicon glyphicon-ok"></span>*}]</button>
                                   
                            </div>
                        </div>
                        [{/if}]
                       
                        <button class="js-minibasket-edit minibasket-edit btn btn-default btn-block btn-sm">[{ oxmultilang ident="MINIBASKET_EDIT" }] [{*<span class="glyphicon glyphicon-pencil"></span><span class="glyphicon glyphicon-ok"></span>*}]</button>
                         [{/if}]      
                           
                    [{if $oxcmp_basket->getProductsCount() gte 4}]
                    <hr>
                        <div class="functions row">
                            <div class="col-xs-12">
                               [{if $oxcmp_user}]
                                    <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=payment" }]" class="btn btn-checkout-guide  btn-block">[{ oxmultilang ident="CHECKOUT" }]</a>
                               [{else}]
                                    <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=user" }]" class="btn btn-checkout-guide  btn-block">[{ oxmultilang ident="CHECKOUT" }]</a>
                               [{/if}]
                            </div>
                        </div>
                    [{/if}]
                    <hr>
                    <form id="js-minibasket-items" action="[{$oView->getWidgetLink()}]" method="post">
                        [{$oViewConf->getHiddenSid()}]
                        <input type="hidden" name="cl" value="[{$oView->getClassName()}]">
                        <input type="hidden" name="fnc" value="changebasket">

                        <ul class="minibasketitems">
                        [{foreach from=$oxcmp_basket->getContents() name=miniBasketList item=_product key=basketindex}]
                            [{block name="widget_minibasket_product"}]
                                [{ assign var="minibasketItemTitle" value=$_product->getTitle() }]
                               
                                <li>
                                    <a href="[{$_product->getLink()}]"><img class="icon" src="[{ $_product->getIconUrl() }]" ></a>

                                    <input type="hidden" name="aproducts[[{$basketindex}]][aid]" value="[{$_product->getProductId()}]">
                                    <input type="hidden" name="aproducts[[{$basketindex}]][basketitemid]" value="[{$basketindex}]">
                                    <input type="hidden" name="aproducts[[{$basketindex}]][override]" value="1">
                                   

                                    <div class="item-infos">
                                            [{assign var="title" value=" -"|explode:$_product->getTitle()}]
                                            [{assign var="subtitle" value=" ("|explode:$title[1]}] 
                                            <div class="fir">[{ $title[0]|strip_tags }]</div>
                                            <div class="sec"> [{ $subtitle[0]|strip_tags }]</div>
                                            <div class="thi">[{if $_product->getVarSelect()}]<span class="size">Size: [{$_product->getVarSelect()}]</span>[{/if}] [{if $_product->getAmount() gte 2}]<span class="amount">Anzahl: [{$_product->getAmount()}]</span>[{/if}]</div>
                                            <div class="fou">[{oxprice price=$_product->getPrice() currency=$currency}]</div>
                                    </div>

                                    <div class="item-edit">
                                            <input class="quantity" type="hidden" step="any" name="aproducts[[{$basketindex}]][am]" value="[{$_product->getAmount()}]" size="2">
                                            [{*<button type="button" name="removeBtn" class="btn btn-sm btn-danger js-minibasket-remove item-remove"><i class="glyphicon glyphicon-remove"></i></button>*}]
                                            <button type="button" name="plusBtn" class="btn btn-sm btn-default js-minibasket-plus"><i class="glyphicon glyphicon-plus"></i></button>
                                            <button type="button" name="minus" class="btn btn-sm btn-default js-minibasket-minus"><i class="glyphicon glyphicon-minus"></i></button>
                                    </div>
                                </li>
                                

                            [{/block}]
                        [{/foreach}]
                        </ul>
                        [{* <button type="submit" value="submit"/></button> *}]
                    </form>
                    <hr>
                    [{block name="widget_minibasket_total"}]
                        <p class="totals">
                           <span class="item">[{ oxmultilang ident="TOTAL" }]</span>
                           <strong class="price pull-right">
                           [{ $currency->sign}]
                           [{if $oxcmp_basket->isPriceViewModeNetto()}]
                           [{ $oxcmp_basket->getProductsNetPrice()}]
                           [{else}]
                           [{ $oxcmp_basket->getFProductsPrice()}]
                           [{/if}]
                           </strong>
                        </p>
                    [{/block}]
                    <hr>
                   
                    <div class="functions row">
                         [{if $oView->getRequestLocation() != 'checkout'}]
                        <div class="col-xs-12">
                           [{if $oxcmp_user}]
                                <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=payment" }]" class="btn btn-checkout-guide  btn-block">[{ oxmultilang ident="CHECKOUT" }]</a>
                           [{else}]
                                <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=user" }]" class="btn btn-checkout-guide  btn-block">[{ oxmultilang ident="CHECKOUT" }]</a>
                           [{/if}]
                           
                        [{if $oxcmp_basket->isNewItemAdded() && 0}]
                        <button type="button" class="close closePop" data-dismiss="modal" aria-label="Close">[{ oxmultilang ident="CONTINUE_SHOPPING" }]</button> 
                        [{/if}]
                          
                             [{*<button class="js-minibasket-edit minibasket-edit btn btn-default btn-sm">Warenkorb Bearbeiten <span class="glyphicon glyphicon-pencil"></span><span class="glyphicon glyphicon-ok"></span></button>*}]
                       </div>
                       [{else}]
                        <div class="col-xs-12">
                           <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=basket" }]" class="minibasket-edit btn btn-default btn-sm">[{ oxmultilang ident="DISPLAY_BASKET" }]</a>
                        </div>
                       [{/if}]
                       
                    </div>
                </div>
            [{/oxhasrights}]
        [{else}]
        <div class="alert alert-danger">[{ oxmultilang ident="MINIBASKET_EMPTY" }]</div>
        [{/if}]

</div>   
[{/block}]



[{if $oxcmp_basket->getProductsCount() gte 0}]
[{capture assign="emptyclass"}] $( '.minibasket-tgl-btn .empty' ).removeClass('empty'); [{/capture}]
[{oxscript add=$emptyclass}]
[{/if}]
[{capture assign="pcount"}] $( '.pcount' ).html(' <i>[{$oxcmp_basket->getProductsCount()}]</i><div class="bl bl-cart"></div>'); [{/capture}]
[{oxscript add=$pcount}]

[{capture assign="ptotal"}] $( '.ptotal' ).html(' [{ $currency->sign}] [{ $oxcmp_basket->getFProductsPrice()}] '); [{/capture}]
[{oxscript add=$ptotal}]
[{oxstyle widget=$oView->getClassName()}]