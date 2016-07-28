[{capture append="oxidBlock_content"}]

    [{block name="checkout_thankyou_main"}]
        [{assign var="order" value=$oView->getOrder()}]
        [{assign var="basket" value=$oView->getBasket()}]

        <div class="col-lg-12 checkout-thank-you content" id="thankyouPage">
            [{* ordering steps *}]
            [{* include file="page/checkout/inc/steps.tpl" active=5 *}]
            <h3 class="block-head">[{oxmultilang ident="THANK_YOU"}]</h3>
            <div class="separator"></div>
            [{block name="checkout_thankyou_info"}]
                [{oxmultilang ident="PAGE_CHECKOUT_THANKYOU_THANKYOU1"}]<br>[{oxmultilang ident="PAGE_CHECKOUT_THANKYOU_THANKYOU2"}] [{$order->oxorder__oxordernr->value}]  [{oxmultilang ident="PAGE_CHECKOUT_THANKYOU_THANKYOU3"}]<br>
                [{oxmultilang ident="PAGE_CHECKOUT_THANKYOU_REGISTEREDYOUORDERNO1"}] [{oxmultilang ident="PAGE_CHECKOUT_THANKYOU_REGISTEREDYOUORDERNO2"}]<br>
                [{if !$oView->getMailError() }]
                   <!-- [{oxmultilang ident="MESSAGE_YOU_RECEIVED_ORDER_CONFIRM"}]<br> -->
                [{else}]<br>
                     <!--  [{oxmultilang ident="MESSAGE_CONFIRMATION_NOT_SUCCEED"}]<br> -->
                [{/if}]
                <br>
                [{oxmultilang ident="MESSAGE_WE_WILL_INFORM_YOU"}]<br><br>
            [{/block}]

            [{block name="checkout_thankyou_proceed"}]
            [{*
                [{oxmultilang ident="YOU_CAN_GO"}]
                <a id="backToShop" rel="nofollow" href="[{oxgetseourl ident=$oViewConf->getHomeLink()}]" class="link">[{oxmultilang ident="BACK_TO_START_PAGE"}]</a>
                [{if $oxcmp_user->oxuser__oxpassword->value }]
                    [{oxmultilang ident="OR"}]
                    <a id="orderHistory" rel="nofollow" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_order"}]" class="link">[{oxmultilang ident="CHECK_YOUR_ORDER_HISTORY"}]</a>.
                [{/if}]
                *}]
            [{/block}]

            [{block name="checkout_thankyou_ts"}]
                [{if $oViewConf->showTs("THANKYOU") && $oViewConf->getTsId() }]
                    [{assign var="sTSRatingImg" value="https://www.trustedshops.com/bewertung/widget/img/bewerten_"|cat:$oView->getActiveLangAbbr()|cat:".gif"}]
                    <h3 class="block-head">[{oxmultilang ident="TRUSTED_SHOPS_CUSTOMER_RATINGS"}]</h3>
                    [{oxmultilang ident="RATE_OUR_SHOP"}]
                    <div class="etrustTsRatingButton">
                        <a href="[{$oViewConf->getTsRatingUrl()}]" target="_blank" title="[{oxmultilang ident="TRUSTED_SHOPS_RATINGS"}]">
                            <img src="[{$sTSRatingImg}]" border="0" alt="[{oxmultilang ident="WRITE_REVIEW_2"}]" align="middle">
                        </a>
                    </div>
                [{/if}]
            [{/block}]

            [{ assign var="aVouchers" value=$order->getVoucherNrList() }]
            <img src="https://[{$oView->getActiveLangAbbr()}].profity.ch/imp/?s=211&amp;b=6&amp;lp=1&amp;ordervalue=[{ $order->getFormattedTotalOrderSum() }]&amp;ordernumber=[{ $order->oxorder__oxordernr->value }]&amp;vouchercode=[{ $aVouchers.0}]">
            <div class="o-flag">
                <a href="https://[{$oView->getActiveLangAbbr()}].profity.ch/clk/?lpk=1036686A0E089B9C7736A07FABDDFC7D3096476C" target="_blank" class="o-flag__image">
                    <img src="[{$oViewConf->getImageUrl('thankyou_profity_box.png')}]" alt="Profity Geschenk" width="120" />
                </a>
                <div class="o-flag__body">
                    <p class="u-text--bold">[{oxmultilang ident="PROFITY_TITLE"}]</p>
                    <p>[{oxmultilang ident="PROFITY_BODY"}]</p>
                    <p><a class="btn btn-success" href="https://[{$oView->getActiveLangAbbr()}].profity.ch/clk/?lpk=1036686A0E089B9C7736A07FABDDFC7D3096476C" target="_blank">[{oxmultilang ident="PROFITY_CTA"}]</a></p>
                </div>
            </div>


        </div>
    [{/block}]
    [{insert name="oxid_tracker" title=$template_title }]
[{/capture}]
[{include file="layout/page.tpl"}]