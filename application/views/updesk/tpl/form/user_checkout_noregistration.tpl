[{oxscript include="js/widgets/oxinputvalidator.js" priority=10 }]
[{oxscript add="$('form.js-oxValidate').oxInputValidator();"}]
[{block name="user_checkout_noregistration"}]
    <form class="form js-oxValidate" action="[{$oViewConf->getSslSelfLink()}]" name="order" method="post">
    [{block name="user_checkout_noregistration_form"}]
        [{assign var="aErrors" value=$oView->getFieldValidationErrors()}]
        [{$oViewConf->getHiddenSid()}]
        [{$oViewConf->getNavFormParams()}]
        <input type="hidden" name="cl" value="user">
        <input type="hidden" name="option" value="1">
        [{if !$oxcmp_user->oxuser__oxpassword->value }]
        <input type="hidden" name="fnc" value="createuser">
        [{else}]
        <input type="hidden" name="fnc" value="changeuser">
        <input type="hidden" name="lgn_cook" value="0">
        [{/if}]
        <input type="hidden" id="reloadAddress" name="reloadaddress" value="">
        <input type="hidden" name="blshowshipaddress" value="1">

       <div class="checkout-section">
            <h3 class="section-heading">[{oxmultilang ident="NOTREGISTERED_ACCOUNTINFO"}]</h3>
           
                [{include file="form/fieldset/user_noaccount.tpl"}]
           
            <h3 class="block-head">[{oxmultilang ident="BILLING_ADDRESS"}]</h3>
          
            [{include file="form/fieldset/user_billing.tpl" noFormSubmit=true blOrderRemark=true}]
        
            <h3 class="block-head">[{oxmultilang ident="SHIPPING_ADDRESS"}]</h3>
            <div class="checkbox">
                <label for="showShipAddress">
                <input type="checkbox" name="blshowshipaddress" id="showShipAddress" [{if !$oView->showShipAddress()}]checked[{/if}] value="0">
                [{oxmultilang ident="USE_BILLINGADDRESS_FOR_SHIPPINGADDRESS"}]</label>
          
            </div>
           
            <div id="shippingAddress" class="form" [{if !$oView->showShipAddress()}]style="display: none;"[{/if}]>
            [{include file="form/fieldset/user_shipping.tpl" noFormSubmit=true}]
            </div>
           
        </div>
        
       
        [{oxscript add="$('#showShipAddress').change( function() { $('#shippingAddress').toggle($(this).is(':not(:checked)'));});"}]
        [{block name="user_checkout_noregistration_next_step_bottom"}]
        <div class="checkout-section">
           
            <input type="submit" id="userNextStepBottom" class="btn btn-checkout-guide" name="userform" value="[{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}]" />
            <hr>
            <input type="button" class="btn previous btn-xs" value="[{oxmultilang ident="PREVIOUS_STEP"}]" onclick="window.open('[{oxgetseourl ident=$oViewConf->getBasketLink()}]', '_self');" />  
            
        </div>
        [{/block}]
    [{/block}]
    </form>
[{/block}]