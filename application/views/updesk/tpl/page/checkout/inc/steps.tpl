[{block name="checkout_steps_main"}]
        <ul class="cart-breadcrumb">
            <li class="[{if $active == 1}] active [{/if}]">
                <span>[{if $active >= 1}]
                    <a rel="nofollow" href="[{oxgetseourl ident=$oViewConf->getOrderLink()}]"><span>1. [{oxmultilang ident="STEPS_SEND"}]</span></a>
                    [{else}]
                     <span>1. [{oxmultilang ident="STEPS_SEND"}]</span>
                    [{/if}]
                </span>
            </li>
             <li class="[{if $active == 2}] active [{/if}]">
                <span>
                    [{if $active >=2}]
                      <a rel="nofollow" href="[{oxgetseourl ident=$oViewConf->getPaymentLink()}]"><span>2. [{oxmultilang ident="STEPS_PAY"}]</span></a>
                    [{else}]
                    <span>2. [{ oxmultilang ident="STEPS_PAY" }]</span>
                    [{/if}]
                </span>
            </li>
           <li class="[{if $active == 3}] active [{/if}]">
                <span><span>3. [{oxmultilang ident="STEPS_ORDER"}]</span> </span>
            </li>
        </ul>
[{/block}]

[{*}]
[{block name="checkout_steps_main"}]
        <ul class="cart-breadcrumb">
            <li class="[{if $active == 1}] active [{elseif $active > 1}] passed [{/if}]">
                <span>[{if $active >= 1}]
                    <a rel="nofollow" href="[{oxgetseourl ident=$oViewConf->getOrderLink()}]"><span>[{oxmultilang ident="STEPS_SEND"}]</span></a>
                    [{else}]
                     <span>[{oxmultilang ident="STEPS_SEND"}]</span>
                    [{/if}]
                </span>
            </li>
             <li class="[{if $active == 2}] active [{elseif $active > 2}] passed [{/if}]">
                <span>
                    [{if $active >=2}]
                      <a rel="nofollow" href="[{oxgetseourl ident=$oViewConf->getPaymentLink()}]"><span>[{oxmultilang ident="STEPS_PAY"}]</span></a>
                    [{else}]
                    <span>[{ oxmultilang ident="STEPS_PAY" }]</span>
                    [{/if}]
                </span>
            </li>
           <li class="[{if $active == 3}] active [{elseif $active > 3}] passed [{/if}]">
                <span> <span>[{oxmultilang ident="STEPS_ORDER"}]</span> </span>
            </li>
        </ul>
[{/block}]



[{block name="checkout_steps_main"}]
    <ul class="steps [{if $active == 5}] last-step[{/if}]">
        [{if $oxcmp_basket->getProductsCount() }]
            [{assign var=showStepLinks value=true}]
        [{/if}]

        [{block name="checkout_steps_basket"}]
          
        [{/block}]

        [{assign var=showStepLinks value=false}]
        [{if !$oxcmp_basket->isBelowMinOrderPrice() && $oxcmp_basket->getProductsCount() }]
            [{assign var=showStepLinks value=true}]
        [{/if}]

        [{block name="checkout_steps_send"}]
            <li class="step2[{if $active == 2}] active [{elseif $active > 2}] passed [{/if}]">
                [{if $showStepLinks}]<a rel="nofollow" href="[{oxgetseourl ident=$oViewConf->getOrderLink()}]">[{/if}]
                    <span class="step-number">01</span>
                    <span class="step-name">
                        [{oxmultilang ident="STEPS_SEND"}]
                    </span>
                [{if $showStepLinks}]</a>[{/if}]
            </li>
        [{/block}]

        [{assign var=showStepLinks value=false}]
        [{if $active != 1 && $oxcmp_user && !$oxcmp_basket->isBelowMinOrderPrice() && $oxcmp_basket->getProductsCount() }]
            [{assign var=showStepLinks value=true}]
        [{/if}]

        [{block name="checkout_steps_pay"}]
            <li class="step3[{if $active == 3}] active [{elseif $active > 3}] passed [{/if}]">
                [{if $showStepLinks}]<a rel="nofollow" [{if $oViewConf->getActiveClassName() == "user"}]id="paymentStep"[{/if}] href="[{oxgetseourl ident=$oViewConf->getPaymentLink()}]">[{/if}]
                    <span class="step-number">02</span>
                    <span class="step-name">
                        [{oxmultilang ident="STEPS_PAY"}]
                    </span>
                [{if $showStepLinks}]</a>[{/if}]
            </li>
            [{oxscript add="$('#paymentStep').click( function() { $('#userNextStepBottom').click();return false;});"}]
        [{/block}]

        [{assign var=showStepLinks value=false}]
        [{if $active != 1 && $oxcmp_user && $oxcmp_basket->getProductsCount() && $oView->getPaymentList() && !$oxcmp_basket->isBelowMinOrderPrice()}]
            [{assign var=showStepLinks value=true}]
        [{/if}]

        [{block name="checkout_steps_order"}]
            <li class="step4[{if $active == 4}] active [{elseif $active > 4}] passed [{/if}]">
                [{if $showStepLinks}]<a rel="nofollow" [{if $oViewConf->getActiveClassName() == "payment"}]id="orderStep"[{/if}] href="[{if $oViewConf->getActiveClassName() == "payment"}]javascript:document.forms.order.submit();[{else}][{oxgetseourl ident=$oViewConf->getOrderConfirmLink()}][{/if}]">[{/if}]
                    <span class="step-number">03</span>
                    <span class="step-name">
                        [{oxmultilang ident="STEPS_ORDER"}]
                    </span>
                [{if $showStepLinks}]</a>[{/if}]
            </li>
            [{oxscript add="$('#orderStep').click( function() { $('#paymentNextStepBottom').click();return false;});"}]
        [{/block}]

        [{block name="checkout_steps_laststep"}]
           
        [{/block}]
    </ul>
[{/block}]
[{*}]