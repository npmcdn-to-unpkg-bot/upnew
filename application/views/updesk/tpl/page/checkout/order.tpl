[{capture append="oxidBlock_content"}]
    <div class="content order">
        [{block name="checkout_order_errors"}]
            [{if $oView->isConfirmAGBActive() && $oView->isConfirmAGBError() == 1}]
            [{include file="message/error.tpl" statusMessage="READ_AND_CONFIRM_TERMS"|oxmultilangassign }]
            [{/if}]
            [{assign var="iError" value=$oView->getAddressError() }]
            [{if $iError == 1}]
               [{include file="message/error.tpl" statusMessage="ERROR_DELIVERY_ADDRESS_WAS_CHANGED_DURING_CHECKOUT"|oxmultilangassign }]
            [{/if}]
        [{/block}]

        [{* ordering steps *}]
        [{include file="page/checkout/inc/steps.tpl" active=3 }]

        [{block name="checkout_order_main"}]

            [{block name="checkout_order_details"}]
                [{if !$oxcmp_basket->getProductsCount()}]
                    [{block name="checkout_order_emptyshippingcart"}]
                    <div class="alert alert-error">[{oxmultilang ident="BASKET_EMPTY"}]</div>
                    [{/block}]
                [{else}]
                    [{assign var="currency" value=$oView->getActCurrency() }]
                    [{block name="checkout_order_next_step_top"}]
                        [{if $oxcmp_basket->isBelowMinOrderPrice()}]
                            [{block name="checkout_order_loworderprice_top"}]
                                <div>[{oxmultilang ident="MIN_ORDER_PRICE"}] [{oxprice price=$oxcmp_basket->getMinOrderPrice() currency=$currency}]</div>
                            [{/block}]
                        [{else}]
                            
                           
                            [{if $oView->showOrderButtonOnTop() }]
                            <div id="orderAgbTop" class="checkout-section resp-lg-hidden">
                                <form action="[{$oViewConf->getSslSelfLink()}]" method="post" id="orderConfirmAgbTop">
                                    [{$oViewConf->getHiddenSid()}]
                                    [{$oViewConf->getNavFormParams()}]
                                    <input type="hidden" name="cl" value="order">
                                    <input type="hidden" name="fnc" value="[{$oView->getExecuteFnc()}]">
                                    <input type="hidden" name="challenge" value="[{$challenge}]">
                                    <input type="hidden" name="sDeliveryAddressMD5" value="[{$oView->getDeliveryAddressMD5()}]">

                                        [{include file="page/checkout/inc/agb.tpl"}]

                                       
                                           <button type="submit" class="btn btn-checkout-guide">[{oxmultilang ident="SUBMIT_ORDER"}]</button>
                                            [{*<input type="button" class="btn previous" value="[{oxmultilang ident="PREVIOUS_STEP"}]" onclick="window.open('[{oxgetseourl ident=$oViewConf->getPaymentLink()}]', '_self');" />*}]
                                        
                                    </form>
                                </div>
                            [{/if}]
                    
                        [{/if}]
                    [{/block}]

                    [{*
                    [{block name="checkout_order_vouchers"}]
                        [{if $oViewConf->getShowVouchers() && $oxcmp_basket->getVouchers()}]
                        [{oxmultilang ident="USED_COUPONS"}]
                            <div>
                                [{foreach from=$Errors.basket item=oEr key=key }]
                                    [{if $oEr->getErrorClassType() == 'oxVoucherException'}]
                                    [{oxmultilang ident="COUPON_NOT_ACCEPTED"}] [{$oEr->getValue('voucherNr')}] [{oxmultilang ident="COUPON_NOT_ACCEPTED"}]<br>
                                    [{oxmultilang ident="REASON"}]
                                        [{$oEr->getOxMessage()}]<br>
                                    [{/if}]
                                [{/foreach}]
                                [{foreach from=$oxcmp_basket->getVouchers() item=sVoucher key=key name=aVouchers}]
                                    [{$sVoucher->sVoucherNr}]<br>
                                [{/foreach }]
                            </div>
                        [{/if}]
                    [{/block}]
                    *}]

                    [{block name="checkout_order_address"}]
                        <div id="orderAddress" class="checkout-section">
                            <form class="form" action="[{$oViewConf->getSslSelfLink()}]" method="post">
                                <h3 class="heading section-heading">
                                    <span>[{oxmultilang ident="ADDRESSES"}]</span>
                                    [{$oViewConf->getHiddenSid()}]
                                    <input type="hidden" name="cl" value="user">
                                    <input type="hidden" name="fnc" value="">
                                    <button type="submit" class="btn btn-xs pull-right">[{oxmultilang ident="EDIT"}]</button>
                                </h3>
                            </form>
                            <div class="row">
                                <div class="col-lg-6">
                                    <dl>
                                        <dt>[{oxmultilang ident="BILLING_ADDRESS"}]</dt>
                                        <dd>
                                            [{include file="widget/address/billing_address.tpl"}]
                                        </dd>
                                    </dl>
                                </div>
                                [{assign var="oDelAdress" value=$oView->getDelAddress() }]
                                [{if $oDelAdress }]
                                <div class="col-lg-6">
                                    <dl class="shippingAddress">
                                        <dt>[{oxmultilang ident="SHIPPING_ADDRESS"}]</dt>
                                        <dd>
                                            [{include file="widget/address/shipping_address.tpl" delivadr=$oDelAdress}]
                                        </dd>
                                    </dl>
                                </div>
                                [{/if}]
                            </div>
                            [{if $oView->getOrderRemark() }]
                                <div class="orderRemarks">
                                    [{oxmultilang ident="WHAT_I_WANTED_TO_SAY"}]<br>
                                    [{$oView->getOrderRemark()}]
                                </div>
                            [{/if}]
                        </div>                      
                    [{/block}]

                    [{block name="shippingAndPayment"}]
                    <div class="row">
                        <div class="col-lg-6">
                            <div id="orderShipping" class="checkout-section">
                                <form action="[{$oViewConf->getSslSelfLink()}]" class="form" method="post">
                                    <h3 class="heading section-heading">
                                        <span>[{oxmultilang ident="SHIPPING_CARRIER"}]</span>
                                        [{$oViewConf->getHiddenSid()}]
                                        <input type="hidden" name="cl" value="payment">
                                        <input type="hidden" name="fnc" value="">
                                        <button type="submit" class="btn btn-xs pull-right">[{oxmultilang ident="EDIT"}]</button>
                                    </h3>
                                </form>
                                [{assign var="oShipSet" value=$oView->getShipSet() }]
                                [{$oShipSet->oxdeliveryset__oxtitle->value}]
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div id="orderPayment" class="checkout-section">
                                <form action="[{$oViewConf->getSslSelfLink()}]" class="form" method="post">
                                    <h3 class="heading section-heading">
                                        <span>[{oxmultilang ident="PAYMENT_METHOD"}]</span>
                                        [{$oViewConf->getHiddenSid()}]
                                        <input type="hidden" name="cl" value="payment">
                                        <input type="hidden" name="fnc" value="">
                                        <button type="submit" class="btn btn-xs pull-right">[{oxmultilang ident="EDIT"}]</button>
                                    </h3>
                                </form>
                                [{assign var="payment" value=$oView->getPayment() }]
                                [{$payment->oxpayments__oxdesc->value}]
                            </div>
                        </div>
                    </div>
                    [{/block}]
                 
                 
                    <div id="orderEditCart" class="checkout-section resp-lg-hidden">
                        <form action="[{$oViewConf->getSslSelfLink()}]" class="form" method="post">
                            <h3 class="heading section-heading">
                                <span>[{oxmultilang ident="CART"}]</span>
                                [{$oViewConf->getHiddenSid()}]
                                <input type="hidden" name="cl" value="basket">
                                <input type="hidden" name="fnc" value="">
                                <button type="submit" class="btn btn-xs pull-right">[{oxmultilang ident="EDIT"}]</button>
                            </h3>
                        </form>
                        [{block name="order_basket"}]
                        <div id="orderBasketSummary">   
                                    [{include file="page/checkout/inc/basketcontents.tpl" editable=false}]
                        </div>     
                        [{/block}]
                    </div>

                    [{block name="checkout_order_next_step_bottom"}]
                        [{if $oxcmp_basket->isBelowMinOrderPrice() }]
                            [{block name="checkout_order_loworderprice_bottom"}]
                                <div>[{oxmultilang ident="MIN_ORDER_PRICE"}] [{oxprice price=$oxcmp_basket->getMinOrderPrice() currency=$currency}]</div>
                            [{/block}]
                        [{else}]
                            [{block name="checkout_order_btn_confirm_bottom"}]
                                <form action="[{$oViewConf->getSslSelfLink()}]" method="post" id="orderConfirmAgbBottom" class="checkout-next bottom-line">
                                    [{$oViewConf->getHiddenSid()}]
                                    [{$oViewConf->getNavFormParams()}]
                                    <input type="hidden" name="cl" value="order">
                                    <input type="hidden" name="fnc" value="[{$oView->getExecuteFnc()}]">
                                    <input type="hidden" name="challenge" value="[{$challenge}]">
                                    <input type="hidden" name="sDeliveryAddressMD5" value="[{$oView->getDeliveryAddressMD5()}]">

                                    [{if !$oView->showOrderButtonOnTop()}]
                                        [{include file="page/checkout/inc/agb.tpl"}]
                                      
                                    [{else}]
                                        [{* include file="page/checkout/inc/agb.tpl" hideButtons=true *}]
                                        [{ include file="page/checkout/inc/agb.tpl" }]
                                    [{/if}]

                                  <button type="submit" class="btn btn-checkout-guide">[{oxmultilang ident="SUBMIT_ORDER"}]</button>
                                   
                                     [{*    <hr>
                                    <input type="button" class="btn previous" value="[{oxmultilang ident="PREVIOUS_STEP"}]" onclick="window.open('[{oxgetseourl ident=$oViewConf->getPaymentLink()}]', '_self');" />  *}]
                                   
                                </form>
                            [{/block}]
                        [{/if}]
                    [{/block}]
                [{/if}]
            [{/block}]
        [{/block}]
        [{insert name="oxid_tracker" title=$template_title }]
    </div>
[{/capture}]
[{if $smarty.get.pagedebug ==1 }]
[{debug}]
[{/if}]
[{assign var="template_title" value="REVIEW_YOUR_ORDER"|oxmultilangassign}]
[{include file="layout/page-checkout.tpl" title=$template_title location=$template_title}]