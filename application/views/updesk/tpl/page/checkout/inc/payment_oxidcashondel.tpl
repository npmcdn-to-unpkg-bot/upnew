[{*  <input id="payment_[{$sPaymentID}]" type="radio" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]checked="checked"[{/if}] />*}]
[{block name="checkout_payment_longdesc"}]
    [{if $paymentmethod->oxpayments__oxlongdesc->value}]
        <div class="payment-desc">
            [{$paymentmethod->oxpayments__oxlongdesc->getRawValue()}]
        </div>
    [{/if}]
[{/block}]

