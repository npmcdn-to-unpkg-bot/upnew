[{oxscript include="js/widgets/oxinputvalidator.js" priority=10 }]
[{oxscript add="$('form.js-oxValidate').oxInputValidator();"}]
[{block name="user_checkout_change"}]
    <form class="js-oxValidate" action="[{$oViewConf->getSslSelfLink()}]" name="order" method="post">
        [{block name="user_checkout_change_form"}]
            [{assign var="aErrors" value=$oView->getFieldValidationErrors()}]

            <div>
                [{$oViewConf->getHiddenSid()}]
                [{$oViewConf->getNavFormParams()}]
                <input type="hidden" name="cl" value="user" />
                <input type="hidden" name="option" value="[{$oView->getLoginOption()}]" />
                <input type="hidden" name="fnc" value="changeuser" />
                <input type="hidden" name="lgn_cook" value="0" />
                <input type="hidden" name="blshowshipaddress" value="1" />
            </div>

            <div>
                <div class="checkout-section">
                    [{block name="user_checkout_billing"}]
                        [{block name="user_checkout_billing_head"}]
                          
                                [{block name="user_checkout_change_next_step_top"}]
                                   
                                     <input type="button" id="userNextStepTop" name="userform" class="btn btn-checkout-guide top" value="[{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}]" /> 
                                   
                                [{/block}]
                               

                                    <h3 class="section-heading"><span>[{oxmultilang ident="BILLING_ADDRESS" }]</span>
                                        <input class="btn pull-right btn-xs" type="button" id="userChangeAddress" name="changeBillAddress" value="[{oxmultilang ident="CHANGE" }]" /></h3>
                                   
                              
                            
                            [{oxscript add="$('#userNextStepTop').click( function() { $('#userNextStepBottom').click();return false;});"}]
                            [{oxscript add="$('#userChangeAddress').click( function() { $('#addressForm').show();$('#addressText').hide();$('#userChangeAddress').hide();return false;});"}]
                            [{if $aErrors}]
                                [{oxscript add="$(document).ready(function(){ $('#userChangeAddress').trigger('click');});"}]
                            [{/if}]
                        [{/block}]
                        [{block name="user_checkout_billing_form"}]
                            <div id="addressForm" class="form" style="display: none;">
                                [{include file="form/fieldset/user_billing.tpl" noFormSubmit=true blSubscribeNews=true blOrderRemark=true}]
                            </div>
                        [{/block}]
                        [{block name="user_checkout_billing_feedback"}]
                            <div id="addressText" >
                                    [{include file="widget/address/billing_address.tpl" noFormSubmit=true blSubscribeNews=true blOrderRemark=true}]
                            </div>
                        [{/block}]
                    [{/block}]
                </div>

                <div class="checkout-section">
                    [{block name="user_checkout_shipping"}]
                        
                        [{block name="user_checkout_shipping_change"}]
                           

                            <div class="row">
                            <div class="form-group">
                                    <div class="col-lg-12">
                                      <div class="checkbox">
                                        <label>
                                            <input id="showShipAddress" type="checkbox" name="blshowshipaddress" [{if !$oView->showShipAddress()}]checked[{/if}] value="0"> [{oxmultilang ident="USE_BILLINGADDRESS_FOR_SHIPPINGADDRESS"}]
                                        </label>
                                      </div>
                                    </div>
                            </div>
                            </div>

                            [{oxscript add="$('#showShipAddress').change( function() { $('#shippingAddress').toggle($(this).is(':not(:checked)'));});"}]
                        [{/block}]



                        [{block name="user_checkout_shipping_head"}]
                            
                        [{/block}]
                        [{block name="user_checkout_shipping_form"}]
                            <div id="shippingAddress" class="form" [{if !$oView->showShipAddress()}]style="display: none;"[{/if}]>
                                    <h3 class="section-heading"><span>[{oxmultilang ident="SHIPPING_ADDRESS"}] </span>
                                    <input class="btn btn-xs checkout-change-shipping-address pull-right" type="button" id="userChangeShippingAddress" name="changeShippingAddress" value="[{oxmultilang ident="CHANGE"}]" />
                                    </h3>
                                [{include file="form/fieldset/user_shipping.tpl" noFormSubmit=true onChangeClass='user'}]
                            </div>
                            [{if !$oxcmp_user->getSelectedAddress()}]
                                [{oxscript add="$('#userChangeShippingAddress').hide();"}]
                            [{/if}]
                            [{oxscript add="$('#addressId').change(function() { $('#userChangeShippingAddress').toggle($('#addressId').val() != -1 && $('#shippingAddressForm').is(':hidden') ); });"}]
                        [{/block}]



                        [{* 
                        [{block name="user_checkout_shipping_feedback"}]
                            <ul class="form">
                                [{include file="form/fieldset/order_remark.tpl" blOrderRemark=true}]
                            </ul>
                        [{/block}]
                        *}]
                    [{/block}]
                </div>
            </div>
            [{block name="user_checkout_change_next_step_bottom"}]
                <div class="checkout-next bottom-line">
                       
                        <input type="submit" id="userNextStepBottom" class="btn btn-checkout-guide" name="userform" value="[{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}]" />
                        <hr>
                        <input type="button" class="btn previous btn-xs" value="[{oxmultilang ident="PREVIOUS_STEP"}]" onclick="window.open('[{oxgetseourl ident=$oViewConf->getBasketLink()}]', '_self');" />  
                </div>
            [{/block}]
        [{/block}]
    </form>
[{/block}]