[{capture append="oxidBlock_content"}]

    <div class="content">
        [{* ordering steps *}]
        [{* include file="page/checkout/inc/steps.tpl" active=1 *}]

        [{block name="checkout_basket_main"}]
            [{assign var="currency" value=$oView->getActCurrency() }]
            [{if !$oxcmp_basket->getProductsCount()  }]
                [{block name="checkout_basket_emptyshippingcart"}]
                    <div class="alert alert-error">[{oxmultilang ident="BASKET_EMPTY"}]</div>
                [{/block}]
            [{else }]
            [{if 0}]
                [{* basket btn next *}]
                [{block name="checkout_basket_next_step_top"}]
                    [{if !$oxcmp_basket->isBelowMinOrderPrice() }]
                        <div id="btnNextStepTop">
                        [{block name="mb_basket_btn_next_top"}]
                            <form class="form" action="[{$oViewConf->getSslSelfLink()}]" method="post">
                                [{$oViewConf->getHiddenSid()}]
                                <input type="hidden" name="cl" value="user">
                                <input type="submit" class="btn nextStep" value="[{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}]" />
                            </form>
                        [{/block}]
                        </div>
                    [{/if}]
                [{/block}]
            [{/if}]
              
                
          <div id="orderEditCart" class="checkout-section">
               
                    <h3 class="heading section-heading">
                        <span>[{oxmultilang ident="CART"}]</span>
                       
                    </h3>
    
            

                [{block name="order_basket"}]
                <div id="orderBasketSummary" class="block-order-basket">   
                            [{include file="page/checkout/inc/basketcontents.tpl" editable=true}]
                </div>     
                [{/block}]
            
            </div>
            
            
               <div class="row">
                 <div class="col-lg-6">
                [{if $oViewConf->getShowVouchers()}]
                  <div class="checkout-section">
                    [{block name="checkout_basket_vouchers"}]
                        [{oxscript include="js/widgets/oxinputvalidator.js" priority=10 }]
                        [{oxscript add="$('form.js-oxValidate').oxInputValidator();"}]
                        <h3 class="heading section-heading">
                        <span>[{ oxmultilang ident="COUPON" }]</span>
                       
                        </h3>
                        <div id="basketVoucher">
                            <form name="voucher" action="[{$oViewConf->getSelfActionLink()}]" method="post" class="js-oxValidate">
                                <div class="couponBox" id="coupon">
                                    [{foreach from=$Errors.basket item=oEr key=key}]
                                        [{if $oEr->getErrorClassType() == 'oxVoucherException'}]
                                            <div class="alert alert-danger">
                                                [{ oxmultilang ident="COUPON_NOT_ACCEPTED" args=$oEr->getValue('voucherNr') }]
                                                <strong>[{ oxmultilang ident="REASON" suffix="COLON" }]</strong>
                                                [{ $oEr->getOxMessage() }]
                                            </div>
                                        [{/if}]
                                    [{/foreach}]
                                   
                                    [{ $oViewConf->getHiddenSid() }]
                                    <input type="hidden" name="cl" value="basket">
                                    <input type="hidden" name="fnc" value="addVoucher">
                                        <div class="form-group"><label for="">[{ oxmultilang ident="ENTER_COUPON_NUMBER" }]</label><input name="voucherNr" type="text" class="form-control " value="" placeholder=""> </div>
                                        <button type="submit" class="btn btn-checkout-guide btn-compact">[{ oxmultilang ident="SUBMIT_COUPON" }]</button>
                                     
                                    <input type="hidden" name="CustomError" value='basket'>
                                </div>
                            </form>
                        </div>
                    [{/block}]
                      </div>
                [{/if}]
                </div>
                <div class="col-lg-6">
                     <div class="checkout-section">
                     [{ include file="form/fieldset/order_remark.tpl" blOrderRemark=true }]
                     </div>
                </div>
                </div>
                
          
                
                
                [{if $oViewConf->getShowVouchers()}]
                    [{block name="checkout_basket_vouchers"}]
                    [{/block}]
                [{/if}]


                [{block name="checkout_basket_next_step_bottom"}]
                    [{if $oView->showBackToShop()}]
                        [{block name="checkout_basket_backtoshop_bottom"}]
                            <form action="[{$oViewConf->getSslSelfLink()}]" method="post">
                                <div class="backtoshop">
                                    [{$oViewConf->getHiddenSid()}]
                                    <input type="hidden" name="cl" value="basket">
                                    <input type="hidden" name="fnc" value="backtoshop">
                                    <button type="submit" class="btn">[{oxmultilang ident="CONTINUE_SHOPPING"}]</button>
                                </div>
                            </form>
                        [{/block}]
                    [{/if}]

                    [{* basket btn next *}]
                    [{if $oxcmp_basket->isBelowMinOrderPrice() }]
                        [{block name="checkout_basket_loworderprice_bottom"}]
                        <div class="alert alert-error">[{oxmultilang ident="MIN_ORDER_PRICE"}] [{oxprice price=$oxcmp_basket->getMinOrderPrice() currency=$currency}]</div>
                        [{/block}]
                    [{else}]
                        <div class="checkout-next bottom-line">
                        [{block name="mb_basket_btn_next_bottom"}]
                            <form class="form" action="[{$oViewConf->getSslSelfLink()}]" method="post">
                                [{$oViewConf->getHiddenSid()}]
                                <input type="hidden" name="cl" value="user">
                                <input type="hidden" name="order_remark" id="cloned_order_remark" value="">
                                <button type="submit" class="btn btn-checkout-guide">[{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}]</button>
                               [{* <input type="submit" class="btn nextStep" value="[{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}]" /> *}]
                            </form>
                        [{/block}]
                        </div>
                    [{/if}]
                [{/block}]
            [{/if}]
        [{/block}]
        [{insert name="oxid_tracker" title=$template_title }]
    </div>
[{/capture}]

[{include file="layout/page-checkout.tpl"}]