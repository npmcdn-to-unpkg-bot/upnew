[{capture append="oxidBlock_content"}]
[{oxscript include="js/widgets/oxpayship.js" priority=10}]
[{oxscript include="js/widgets/oxpaymentmethods.js" priority=10}]
[{oxscript include="js/widgets/oxpaycostcalc.js" priority=10}]
<div id="paymentSelect" class="content payment-select">

    [{* ordering steps *}]
    [{include file="page/checkout/inc/steps.tpl" active=2}]
     <div class="row">
    [{block name="checkout_payment_main"}]
        [{assign var="currency" value=$oView->getActCurrency()}]

        [{block name="checkout_payment_nextstep_top"}]
            [{if $oView->getPaymentList() && !$oxcmp_basket->isBelowMinOrderPrice()}]
                <div class="payment-row">
                    <input type="button" id="paymentNextStepTop" name="userform" class="btn btn-checkout-guide top" value="[{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}]" />
                   
                </div>
                [{oxscript add="$('#paymentNextStepTop').click( function() { $('#paymentNextStepBottom').click();return false;});"}]
            [{/if}]
        [{/block}]

        [{if 0}]
        [{block name="change_shipping"}]
            <div class="checkout-section">
                <h3 class="section-heading">[{oxmultilang ident="SHIPPING"}]</h3>
                [{if $oView->getAllSets()}]
                    [{assign var="aErrors" value=$oView->getFieldValidationErrors()}]
                    <form action="[{$oViewConf->getSslSelfLink()}]" name="shipping" id="shipping" method="post">
                        <div>
                            [{$oViewConf->getHiddenSid()}]
                            [{$oViewConf->getNavFormParams()}]
                            <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]" />
                            <input type="hidden" name="fnc" value="changeshipping" />
                        </div>
                        <div id="shippingMethods" class="dropdown">
                            <input type="text" id="sShipSet" name="sShipSet" value="" />
                           <button class="btn dropdown-toggle" type="button"  data-toggle="dropdown" data-target="#">
                              
                                    [{* only to track selection within DOM *}]
                                    <span id="shippingSelected">[{oxmultilang ident="SELECT_SHIPPING_METHOD"}]</span>
                                    <i class="caret"></i>  
                               
                            </button>
                            [{block name="act_shipping"}]
                                <ul class="" role="menu" aria-labelledby="dLabelShippingMethods">
                                    [{foreach key=sShipID from=$oView->getAllSets() item=oShippingSet name=ShipSetSelect}]
                                        [{assign var=sShippingName value=$oShippingSet->oxdeliveryset__oxtitle->value}]
                                        <li class="dropdown-option">
                                            <a tabindex="-1" data-selection-id="[{$sShipID}]">[{$sShippingName}]</a>
                                        </li>

                                        [{$oShippingSet->oxdeliveryset__jxdesc->getRawValue()}]

                                        [{if $oShippingSet->blSelected}]
                                            [{oxscript add="$('#sShipSet').val('$sShipID');"}]
                                        [{/if}]
                                    [{/foreach}]
                                </ul>


                            [{/block}]
                        </div>
                        [{if $oxcmp_basket->getDeliveryCosts()}]
                            [{if $oxcmp_basket->getDelCostNet()}]
                                <ul class="form">
                                    <li>
                                        <div id="shipSetCost" class="payment-charge">
                                            [{oxmultilang ident="CHARGES"}] [{$oxcmp_basket->getDelCostNet()}] [{$currency->sign}]
                                                [{if $oxcmp_basket->getDelCostVat()}]
                                                ([{oxmultilang ident="PLUS_VAT"}]
                                                [{$oxcmp_basket->getDelCostVat()}] [{$currency->sign}])
                                                [{/if}]
                                        </div>
                                        [{else}]
                                        <div id="shipSetCost" class="payment-charge">
                                            [{oxmultilang ident="CHARGES"}] [{$oxcmp_basket->getFDeliveryCosts()}] [{$currency->sign}]
                                        </div>
                                    </li>
                                </ul>
                            [{/if}]
                        [{/if}]
                    </form>
                [{/if}]
            </div>
        [{/block}]
        [{/if}]



        [{block name="checkout_payment_errors"}]
            [{assign var="iPayError" value=$oView->getPaymentError()}]
            [{if !empty($iPayError)}]
                <div class="payment-row">
                    [{assign var="sPayErrorClass" value='alert alert-error'}]
                    [{if $iPayError == 1}]
                        <div class="[{$sPayErrorClass}]">[{oxmultilang ident="ERROR_MESSAGE_COMPLETE_FIELDS_CORRECTLY"}]</div>
                    [{elseif $iPayError == 2}]
                      <div class="[{$sPayErrorClass}]">[{oxmultilang ident="MESSAGE_PAYMENT_AUTHORIZATION_FAILED"}]</div>
                    [{elseif $iPayError == 4}]
                        <div class="[{$sPayErrorClass}]">[{oxmultilang ident="MESSAGE_UNAVAILABLE_SHIPPING_METHOD"}]</div>
                    [{elseif $iPayError == 5}]
                        <div class="[{$sPayErrorClass}]">[{oxmultilang ident="MESSAGE_PAYMENT_UNAVAILABLE_PAYMENT"}]</div>
                    [{elseif $iPayError == 6}]
                       <div class="[{$sPayErrorClass}]">[{oxmultilang ident="TRUSTED_SHOP_UNAVAILABLE_PROTECTION"}]</div>
                    [{elseif $iPayError > 6}]
                    <!--Add custom error message here-->
                       <div class="[{$sPayErrorClass}]">[{oxmultilang ident="MESSAGE_PAYMENT_UNAVAILABLE_PAYMENT"}]</div>
                    [{elseif $iPayError == -1}]
                       <div class="[{$sPayErrorClass}]">[{oxmultilang ident="MESSAGE_PAYMENT_UNAVAILABLE_PAYMENT_ERROR"}] "[{$oView->getPaymentErrorText()}]").</div>
                    [{elseif $iPayError == -2}]
                       <div class="[{$sPayErrorClass}]">[{oxmultilang ident="MESSAGE_NO_SHIPPING_METHOD_FOUND"}]</div>
                    [{elseif $iPayError == -3}]
                        <div class="[{$sPayErrorClass}]">[{oxmultilang ident="MESSAGE_PAYMENT_SELECT_ANOTHER_PAYMENT"}]</div>
                    [{elseif $iPayError == -4}]
                        <div class="[{$sPayErrorClass}]">[{oxmultilang ident="MESSAGE_PAYMENT_BANK_CODE_INVALID"}]</div>
                    [{elseif $iPayError == -5}]
                        <div class="[{$sPayErrorClass}]">[{oxmultilang ident="MESSAGE_PAYMENT_ACCOUNT_NUMBER_INVALID"}]</div>
                    [{/if}]
                </div>
            [{/if}]
        [{/block}]

[{if 0}]
        [{block name="change_payment"}]
            <div class="checkout-section">
                <h3 class="section-heading">[{oxmultilang ident="PAYMENT_METHOD"}]</h3>
                [{oxscript include="js/widgets/oxinputvalidator.js" priority=10}]
                [{oxscript add="$('form.js-oxValidate').oxInputValidator();"}]
                <form action="[{$oViewConf->getSslSelfLink()}]" class="js-oxValidate payment" id="payment" name="order" method="post">
                    <div>
                        [{$oViewConf->getHiddenSid()}]
                        [{$oViewConf->getNavFormParams()}]
                        <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]" />
                        <input type="hidden" name="fnc" value="validatepayment" />
                    </div>


                    [{if $oView->getPaymentList()}]
                        [{block name="select_payment_list"}]
                            [{* first loop is to render payment method selection *}]
                            <div id="paymentMethods" class="dropdown">
                                [{* only to track selection within DOM *}]
                                <input type="hidden" id="sPaymentSelected" value="" />
                                 <button class="btn dropdown-toggle" type="button"  data-toggle="dropdown" data-target="#">
                                   
                                        <span id="paymentSelected">[{oxmultilang ident="PAYMENT_METHOD"}]</span>
                                        <i class="caret"></i>
                                    
                                </button>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="dLabelPaymentSelected">
                                    [{foreach key=sPaymentID from=$oView->getPaymentList() item=paymentmethod name=PaymentSelect}]
                                        [{block name="select_payment_dropdown"}]
                                        [{assign var=sPaymentName value=$paymentmethod->oxpayments__oxdesc->value}]
                                        <li class="dropdown-option">
                                            <a tabindex="-1" data-selection-id="[{$sPaymentID}]">[{$sPaymentName}]</a>
                                        </li>
                                        [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]
                                            [{oxscript add="$('#sPaymentSelected').val('$sPaymentID');"}]
                                        [{/if}]
                                        [{/block}]
                                    [{/foreach}]
                                </ul>
                            </div>
                            [{* second loop is to render payment method details *}]
                            [{foreach key=sPaymentID from=$oView->getPaymentList() item=paymentmethod name=PaymentSelect}]
                                [{block name="select_payment"}]
                                    [{if $sPaymentID == "oxidcashondel"}]
                                        [{include file="page/checkout/inc/payment_oxidcashondel.tpl"}]
                                    [{elseif $sPaymentID == "oxidcreditcard"}]
                                        [{include file="page/checkout/inc/payment_oxidcreditcard.tpl"}]
                                    [{elseif $sPaymentID == "oxiddebitnote"}]
                                        [{include file="page/checkout/inc/payment_oxiddebitnote.tpl"}]
                                    [{else}]
                                        [{include file="page/checkout/inc/payment_other.tpl"}]
                                    [{/if}]
                                [{/block}]
                            [{/foreach}]
                        [{/block}]

                        [{block name="checkout_payment_nextstep"}]
                            <div class="checkout-next bottom-line">
                                [{if $oxcmp_basket->isBelowMinOrderPrice()}]
                                    <b>[{oxmultilang ident="MIN_ORDER_PRICE"}] [{oxprice price=$oxcmp_basket->getMinOrderPrice() currency=$currency}]</b>
                                [{else}]
                                   
                                
                        <input type="submit" id="paymentNextStepBottom" class="btn btn-checkout-guide" name="userform" value="[{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}]" />
                        <hr>
                        <input type="button" class="btn previous btn-xs" id="paymentBackStepBottom" value="[{oxmultilang ident="PREVIOUS_STEP"}]" onclick="window.open('[{oxgetseourl ident=$oViewConf->getOrderLink()}]', '_self');" />  
                                [{/if}]
                            </div>
                        [{/block}]

                    [{elseif $oView->getEmptyPayment()}]
                        [{block name="checkout_payment_nopaymentsfound"}]
                            <div class="form">
                                <h3 id="paymentHeader" class="block-head">[{oxmultilang ident="PAYMENT_INFORMATION"}]</h3>
                                [{oxifcontent ident="oxnopaymentmethod" object="oCont"}]
                                    [{$oCont->oxcontents__oxcontent->value}]
                                [{/oxifcontent}]
                                <input type="hidden" name="paymentid" value="oxempty" />
                                <li><input type="submit" id="paymentNextStepBottom" name="userform" class="btn" value="[{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}]" /></li>
                                <li><input type="button" id="paymentBackStepBottom" class="btn previous" value="[{oxmultilang ident="PREVIOUS_STEP"}]" onclick="window.open('[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=user"}]', '_self');" /></li>
                            </div>
                        [{/block}]
                    [{/if}]
                </form>
            </div>
        [{/block}]
[{/if}]
       
         [{block name="change_shipping"}]
        <div class="col-lg-5">
            <div class="c-box c-box--grey">
                <h3 class="c-box__title">[{oxmultilang ident="SHIPPING"}]</h3>
                [{if $oView->getAllSets()}]
                    [{assign var="aErrors" value=$oView->getFieldValidationErrors()}]
                    <form action="[{$oViewConf->getSslSelfLink()}]" name="shipping" id="shipping" method="post">
                        <div>
                            [{$oViewConf->getHiddenSid()}]
                            [{$oViewConf->getNavFormParams()}]
                            <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]" />
                            <input type="hidden" name="fnc" value="changeshipping" />
                        </div>
                        <div id="shippingMethods" class="dropdown">
                            <input type="text" id="sShipSet" name="sShipSet" value="" />
                         
                              
                                    [{* only to track selection within DOM *}]
                                    <span id="shippingSelected">[{oxmultilang ident="SELECT_SHIPPING_METHOD"}]</span>
                                   
                               
                        
                            [{block name="act_shipping"}]
                                <div class="payship" role="menu" aria-labelledby="dLabelShippingMethods">
                                    [{foreach key=sShipID from=$oView->getAllSets() item=oShippingSet name=ShipSetSelect}]
                                        [{assign var=sShippingName value=$oShippingSet->oxdeliveryset__oxtitle->value}]
                                        <div class="option [{if $oShippingSet->blSelected}]selected[{/if}]" data-selection-id="[{$sShipID}]">
                                          

                                             <input id="payment_[{$sShipID}]" type="radio" name="sShipSet" value="[{$sShipID}]" [{if $oShippingSet->blSelected}]checked="checked"[{/if}] />
                                           <div>
                                                <span class="title">[{$sShippingName}]</span>
                                                [{*}]<span class="desc">[{$oShippingSet->oxdeliveryset__jxdesc->getRawValue()}]</span>[{*}]
                                                <img class="icon"/>
                                            </div>
                                        </div>
                                        [{if $oShippingSet->blSelected}]
                                            [{oxscript add="$('#sShipSet').val('$sShipID');"}]
                                        [{/if}]
                                    [{/foreach}]
                                </div>
                            [{/block}]
                        </div>
                        [{if $oxcmp_basket->getDeliveryCosts()}]
                            [{if $oxcmp_basket->getDelCostNet()}]
                                <ul class="form">
                                    <li>
                                        <div id="shipSetCost" class="payment-charge">
                                            [{oxmultilang ident="CHARGES"}] [{$oxcmp_basket->getDelCostNet()}] [{$currency->sign}]
                                                [{if $oxcmp_basket->getDelCostVat()}]
                                                ([{oxmultilang ident="PLUS_VAT"}]
                                                [{$oxcmp_basket->getDelCostVat()}] [{$currency->sign}])
                                                [{/if}]
                                        </div>
                                        [{else}]
                                        <div id="shipSetCost" class="payment-charge">
                                            [{oxmultilang ident="CHARGES"}] [{$oxcmp_basket->getFDeliveryCosts()}] [{$currency->sign}]
                                        </div>
                                    </li>
                                </ul>
                                
                            [{/if}]
                        [{else}]
                        
                                <div id="shipSetCost" class="payment-charge">[{oxmultilang ident="PAYMENT_FREEDELIVERY"}]</div>
                        [{/if}]
                    </form>
                [{/if}]
            </div>
        </div>
        [{/block}]

         [{block name="change_payment"}]
         <div class="col-lg-7">
            <div class="c-box c-box--grey">
                <h3 class="c-box__title">[{oxmultilang ident="PAYMENT_METHOD"}]</h3>
                [{oxscript include="js/widgets/oxinputvalidator.js" priority=10}]
                [{oxscript add="$('form.js-oxValidate').oxInputValidator();"}]
                <form action="[{$oViewConf->getSslSelfLink()}]" class="js-oxValidate payment" id="payment" name="order" method="post">
                    <div>
                        [{$oViewConf->getHiddenSid()}]
                        [{$oViewConf->getNavFormParams()}]
                        <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]" />
                        <input type="hidden" name="fnc" value="validatepayment" />
                    </div>


                    [{if $oView->getPaymentList()}]
                        [{block name="select_payment_list"}]
                            [{* first loop is to render payment method selection *}]
                            <div id="paymentMethods">
                                [{* only to track selection within DOM *}]
                                <input type="hidden" id="sPaymentSelected" value="" />
                                  <span id="shippingSelected">[{oxmultilang ident="SELECT_PAYMENT_METHOD"}]</span>
                                <div class="payship">
                                    [{foreach key=sPaymentID from=$oView->getPaymentList() item=paymentmethod name=PaymentSelect}]
                                        [{block name="select_payment_dropdown"}]
                                        [{assign var=sPaymentName value=$paymentmethod->oxpayments__oxdesc->value}]
                                        <div class="option  [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]selected[{/if}]" data-paytitle="[{$sPaymentName}]" data-paycost="[{$paymentmethod->oxpayments__oxaddsum->value}]">
                                             <input id="payment_[{$sPaymentID}]" type="radio" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]checked="checked"[{/if}] />
                                       
                                            <div class="title">[{$sPaymentName}] [{oxprice price=$paymentmethod->getPrice() currency=$currency}] <div class="payment-tooltip glyphicon glyphicon-info-sign" data-powertip="[{$paymentmethod->oxpayments__oxlongdesc->getRawValue()}]"></div></div>
                                                 [{oxscript add="$('.payment-tooltip').powerTip( { placement: 's', mouseOnToPopup: true  } );"  }]
                                           [{assign var="imgurl" value="payments/de/$sPaymentID.png"}]
                                         
                                            [{if $oViewConf->getImageUrl($imgurl)}]
                                                <img class="payment-icon" src="[{$oViewConf->getImageUrl($imgurl)}]" />
                                            [{/if}]
                                               
                                               [{*<span class="selected-check glyphicon glyphicon-ok"></span>*}]
                                           
                                            <div class="desc">
                                             [{block name="select_payment"}]
                                                [{if $sPaymentID == "oxidcashondel"}]
                                                    [{include file="page/checkout/inc/payment_oxidcashondel.tpl"}]
                                                [{elseif $sPaymentID == "oxidcreditcard"}]
                                                    [{include file="page/checkout/inc/payment_oxidcreditcard.tpl"}]
                                                [{elseif $sPaymentID == "oxiddebitnote"}]
                                                    [{include file="page/checkout/inc/payment_oxiddebitnote.tpl"}]
                                                [{else}]
                                                    [{include file="page/checkout/inc/payment_other.tpl"}]
                                                [{/if}]
                                            [{/block}]
                                            </div>
                                        </div> 
                                        
                                        [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]
                                            [{oxscript add="$('#sPaymentSelected').val('$sPaymentID');"}]
                                        [{/if}]
                                        [{/block}]
                                    [{/foreach}]
                                </div>
                            </div>

                           
                          
                        [{/block}]

                     

                    [{elseif $oView->getEmptyPayment()}]
                        [{block name="checkout_payment_nopaymentsfound"}]
                            <div class="form">
                                <h3 id="paymentHeader" class="block-head">[{oxmultilang ident="PAYMENT_INFORMATION"}]</h3>
                                [{oxifcontent ident="oxnopaymentmethod" object="oCont"}]
                                    [{$oCont->oxcontents__oxcontent->value}]
                                [{/oxifcontent}]
                                <input type="hidden" name="paymentid" value="oxempty" />
                                <li><input type="submit" id="paymentNextStepBottom" name="userform" class="btn" value="[{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}]" /></li>
                                <li><input type="button" id="paymentBackStepBottom" class="btn previous" value="[{oxmultilang ident="PREVIOUS_STEP"}]" onclick="window.open('[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=user"}]', '_self');" /></li>
                            </div>
                        [{/block}]
                    [{/if}]
                    
                </form>
            </div>
        </div>
        [{/block}]
        
          

    [{/block}]
    </div>
    
    [{block name="checkout_payment_nextstep"}]
    <div class="c-box c-box--grey">
        [{if $oxcmp_basket->isBelowMinOrderPrice()}]
            <b>[{oxmultilang ident="MIN_ORDER_PRICE"}] [{oxprice price=$oxcmp_basket->getMinOrderPrice() currency=$currency}]</b>
        [{else}]
            <input type="submit" id="paymentNextStepBottom" class="btn btn-checkout-guide" name="userform" value="[{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}]" />
            <hr>
            <input type="button" class="btn previous btn-xs" id="paymentBackStepBottom" value="[{oxmultilang ident="PREVIOUS_STEP"}]" onclick="window.open('[{oxgetseourl ident=$oViewConf->getOrderLink()}]', '_self');" />
        [{/if}]
    </div>
    [{/block}]
    [{insert name="oxid_tracker" title=$template_title}]

</div>
[{oxscript add="$('#shippingMethods').oxPayShip({form:'#shipping'});"}]
[{ oxscript add="$('#paymentMethods').oxPayShip();" }]


[{ oxscript add="$('#paymentMethods').oxPayCostCalc();" }]


[{* oxscript add="$('#paymentMethods').oxPaymentMethods();" *}]
[{ oxscript add="$('#paymentNextStepBottom').click(function(){ $('#payment').submit(); });" }]
[{/capture}]
[{if $smarty.get.pagedebug ==1 }]
[{debug}]
[{/if}]

[{include file="layout/page-checkout.tpl"}]