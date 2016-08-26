[{block name="checkout_payment_longdesc"}]
    [{if $paymentmethod->oxpayments__oxlongdesc->value}]
        <div class="payment-desc">
            [{$paymentmethod->oxpayments__oxlongdesc->getRawValue()}]
        </div>
    [{/if}]
[{/block}]