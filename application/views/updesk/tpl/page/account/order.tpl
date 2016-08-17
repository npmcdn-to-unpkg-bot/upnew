[{assign var="config" value=$oViewConf->getConfig()}]
[{capture append="oxidBlock_content"}]
[{assign var="template_title" value="ORDER_HISTORY"|oxmultilangassign}]
<div class="col-lg-2 sidebar-left">

    [{include file="page/account/inc/account_menu.tpl" active_link="password"}]

  [{oxid_include_widget cl="oxwServiceList" noscript=1 nocookie=1}]
  [{oxid_include_widget cl="oxwInformation" noscript=1 nocookie=1}]
</div>
<div class="col-lg-10">

<h1 class="page-head">[{oxmultilang ident="ORDER_HISTORY"}]</h1>

[{assign var=oOrders value=$oView->getOrderList()}]


[{if $order}]

<div class="c-account-order">
    <div class="c-account-order__ordernr">Bestelldetails Nr. [{ $order->oxorder__oxordernr->value }]</div>
	<div class="col-sm-6">

            <p>
                <span class="u-text--bold">[{oxmultilang ident="ORDER_DATE"}]</span> [{ $order->oxorder__oxorderdate->value|date_format:"%d.%m.%Y %H:%M:%S" }]<br>
                <span class="u-text--bold">Letzte Anpassung</span> [{ $order->oxorder__oxtimestamp->value|date_format:"%d.%m.%Y %H:%M:%S" }]
            </p>
            [{if !$order->oxorder__oxstorno->value}]
            <h2>Versandinfos</h2>
            <ul class="list-group">
                <li class="list-group-item"><span class="u-text--bold">[{oxmultilang ident="SHIPPING_CARRIER"}]</span><span class="u-text--float-right">[{assign var="deliveryType" value=$order->getDelSet()}][{$deliveryType->oxdeliveryset__oxtitle->value}]</span></li>
                <li class="list-group-item"><span class="u-text--bold">[{oxmultilang ident="STATUS"}]</span>
                   [{if $order->oxorder__oxstorno->value}]
                        <span class="u-text--red u-text--float-right">[{oxmultilang ident="STATUS_CANCELED"}]</span>
                    [{elseif $order->oxorder__oxsenddate->value !="-" }]
                        <span class="u-text--green u-text--float-right">[{oxmultilang ident="STATUS_SHIPPED"}] [{$order->oxorder__oxsenddate->value|date_format:"%d.%m.%Y" }]</span>
                    [{else}]
                        <span class="u-text--orange u-text--float-right">[{oxmultilang ident="NOT_SHIPPED_YET"}]</span>
                    [{/if }]
                </li>

                [{assign var="trackcodes" value=","|explode:$order->oxorder__oxtrackcode->value}]
                [{foreach from=$trackcodes item=trackcode name=tcodes}]
                    [{if $trackcode}]
                        <li class="list-group-item"><span class="u-text--bold">Paketnummer</span> <span class="u-text--float-right">[{$trackcode}]</span></li>
                    [{/if}]
                [{/foreach}]
            </ul>

            <h2>Zahlungsinfos</h2>
            <ul class="list-group">
                <li class="list-group-item"><span class="u-text--bold">Zahlungsart:</span><span class="u-text--float-right">[{$paymentType->oxpayments__oxdesc->value}]</span></li>
                <li class="list-group-item"><span class="u-text--bold">Bezahlt:</span>
                    [{if $order->oxorder__oxpaid->value != "0000-00-00 00:00:00" }]
                        <span class="u-text--float-right u-text--green">Bezahlt am: [{ $order->oxorder__oxpaid->value|date_format:"%d.%m.%Y" }]</span>
                    [{else}]
                        <span class="u-text--float-right u-text--red">Zahlung offen</span>
                    [{/if }]
                </li>
                [{*}]
                url to pdf, not used atm. should be maybe merged with nice esr design.
                [{if $oView->getEsrUrl()}]
                <li class="list-group-item"><span class="u-text--bold u-text--float-left">Jetzt Bezahlen:</span>
                    <a target="_blank" href="[{$oView->getEsrUrl()}]">Einzahlungsschein ansehen</a>

                    [{$oView->getEsrRef()}]
                </li>
                [{/if}]
                [{*}]
            </ul>
            [{else}]
            <h2>[{oxmultilang ident="STATUS_CANCELED"}]</h2>
            [{/if}]






	</div>
	<div class="col-sm-6">
		<div class="row">
			<div class="col-xs-12 col-sm-6">
				<div class="u-text--bold">Lieferadresse</div>
				<p>
					
				[{if $order->oxorder__oxdellname->value }]
                    [{ $order->oxorder__oxdelcompany->getRawValue()}]<br />
                    [{ $order->oxorder__oxdelfname->value}] [{ $order->oxorder__oxdellname->value}]<br />
                    [{ $order->oxorder__oxdelstreet->value}] [{ $order->oxorder__oxdelstreetnr->value}]<br />
                    [{ $order->oxorder__oxdelzip->value}] [{ $order->oxorder__oxdelcity->value }]<br />
                    [{ $order->oxorder__oxdelcountry->getRawValue()}]<br />
                    [{ $order->oxorder__oxdeladdinfo->value}]<br />
                [{else }]
                  	[{ $order->oxorder__oxbillcompany->getRawValue()}]<br />
					[{ $order->oxorder__oxbillfname->value}] [{ $order->oxorder__oxbilllname->value}]<br />
					[{ $order->oxorder__oxbillstreet->value}] [{ $order->oxorder__oxbillstreetnr->value}]<br />
					[{ $order->oxorder__oxbillzip->value}] [{ $order->oxorder__oxbillcity->value }]<br />
                    [{ $order->oxorder__oxbillcountry->getRawValue()}]<br />
					[{ $order->oxorder__oxbilladdinfo->value}]<br />
                [{/if }]
				
				</p>
			</div>
			<div class="col-xs-12 col-sm-6">
				<div class="u-text--bold">Rechnungsadresse</div>
				<p>
				
				[{if $order->oxorder__oxbilllname->value }]

                  	[{ $order->oxorder__oxbillcompany->getRawValue()}]<br />
					[{ $order->oxorder__oxbillfname->value}] [{ $order->oxorder__oxbilllname->value}]<br />
					[{ $order->oxorder__oxbillstreet->value}] [{ $order->oxorder__oxbillstreetnr->value}]<br />
					[{ $order->oxorder__oxbillzip->value}] [{ $order->oxorder__oxbillcity->value }]<br />
                    [{ $order->oxorder__oxbillcountry->getRawValue()}]<br />
					[{ $order->oxorder__oxbilladdinfo->value}]<br />
                [{/if }]
			
				</p>
			</div>
			<div class="col-xs-12 col-sm-4">

			</div>
		</div>
	</div>
    <div class="col-xs-12">


    [{if $smarty.get.esr == 1 }]
        <div class="c-esr payingslip esr">
            <div class="c-esr__heading u-12/12">
                <span class="c-esr__borderbox u-1/3 u-text--center">Einzahlung Giro</span>
                <span class="c-esr__borderbox u-1/3 u-text--center">Versement Virement</span>
                <span class="c-esr__borderbox u-1/3 u-text--center">Versamento Girata</span>
            </div>
            <div class="u-12/12">
                <div class="c-esr__borderbox c-esr__borderbox--padded u-5/12">
                    <div class="c-esr__caption">Einzahlung für/Versement pour/Versamento per</div>
                    <div class="c-esr__address">
                        <span class="u-text--block">[{$config->getConfigParam('sBankName')}]</span>
                        <span class="u-text--block">[{$config->getConfigParam('sBankCity')}]</span>
                        <div class="c-esr__caption">Zugunsten von/En faveur de/A favore di</div>
                        <span class="u-text--block">[{$config->getConfigParam('sRecipientName')}]</span>
                        <span class="u-text--block">[{$config->getConfigParam('sRecipientAdress')}]</span>
                        <span class="u-text--block">[{$config->getConfigParam('sRecipientCity')}]</span>
                    </div>
                    <div class="c-esr__caption">Konto/Compte/Conto</div>
                    <span class="u-text--block u-text--bold">[{$config->getConfigParam('sBankingAccount')}]</span>
                    <div class="c-esr__numberbox c-esr__numberbox u-text--align-right">CHF 145.70</div>
                    <div class="place-holder">&nbsp;</div>
                </div>
                <div class="c-esr__borderbox u-7/12">
                    <div class="u-12/12">
                        <div class="c-esr__borderbox c-esr__borderbox--padded u-7/12">
                            <div class="c-esr__caption">
                                <span>Bitte keine Mitteilungen anbringen</span> <span>Pas de communication s.v.p.</span> <span>Non aggiungete communicazioni p.f.</span>
                            </div>
                        </div>
                        <div class="c-esr__borderbox u-5/12">
                            <div class="c-esr__circle-wrapper">
                                <div class="c-esr__circle"></div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="c-esr__borderbox c-esr__borderbox--padded">
                            <div class="c-esr__caption">Referenz Nr./No de reference/No di riferimento</div>
                            <div class="c-esr__numberbox">[{$oView->getEsrRef()}]</div><br>
                            <div class="c-esr__caption">Einbezahlt von/Verse par/Versato da</div>
                            <div class="c-esr__address">
                                <span class="u-text--block">[{$order->oxorder__oxbillfname->value}] [{$order->oxorder__oxbilllname->value}]</span>
                                <span class="u-text--block">[{$order->oxorder__oxbillstreet->value}] [{$order->oxorder__oxbillstreetnr->value}]</span>
                                <span class="u-text--block">[{$order->oxorder__oxbillzip->value}] [{$order->oxorder__oxbillcity->value}]</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    [{/if}]

    </div>
    <div class="col-xs-12">
        <div>
        <h2>Bestellte Artikel</h2>
            [{foreach from=$order->getOrderArticles() item=orderitem name=testOrderItem}]

                [{assign var=sArticleId value=$orderitem->oxorderarticles__oxartid->value }]
                [{assign var=oArticle value=$orderitem->getArticle() }]

                <div class="row u-m-b-15">
                    <div class="col-sm-6">

                        <div class="media">
                            <div class="media-left u-p-r-15">
                                [{if $oArticle->oxarticles__oxid->value && $oArticle->isVisible() }]<a href="[{$oArticle->getLink()}]">[{/if}]
                                    <img class="media-object" src="[{$oArticle->getIconUrl() }]" >
                                [{if $oArticle->oxarticles__oxid->value && $oArticle->isVisible() }]</a>[{/if}]
                            </div>
                            <div class="media-body">
                                <div class="u-text--bold">[{$oArticle->getFirstTitleLine()}]</div>
                                <div>[{$oArticle->getSecondTitleLine()}]</div>
                                <div>[{$oArticle->getThirdTitleLine()}]</div>
                                <div>[{$oArticle->oxarticles__oxartnum->value}]</div>
                                [{if $orderitem->oxorderarticles__oxselvariant->value}]
                                <div class="u-text--bold">Grösse: [{$orderitem->oxorderarticles__oxselvariant->value}]</div>
                                [{/if}]
                            </div>
                        </div>

                    </div>
                    <div class="col-sm-6">
                        <div class="clearfix">
                            <div class="u-text--float-left">Anzahl: [{$orderitem->oxorderarticles__oxamount->value}]</div>

                            <div class="u-text--float-right u-text--bold">[{$order->oxorder__oxcurrency->value}] [{$orderitem->getBrutPriceFormated()}]</div>
                        </div>
                        <div class="u-text--float-left">
                            [{if $order->oxorder__oxstorno->value}]
                                <span class="u-text--red">
                                    [{oxmultilang ident="STATUS_CANCELED"}]
                                </span>
                            [{elseif $order->oxorder__oxsenddate->value !="-" }]
                                <span class="u-text--green">
                                    [{oxmultilang ident="STATUS_SHIPPED"}]
                                </span>
                            [{else}]
                                [{if $oArticle->getStockStatus() == -1}]

                                    [{if $oArticle->getDeliveryDate()}]
                                        <span class="u-text--blue">
                                            [{oxmultilang ident="AVAILABLE_ON"}] [{$oArticle->getDeliveryDate()}]
                                        </span>
                                    [{else}]
                                        <span class="u-text--red">
                                            [{if $oArticle->oxarticles__oxnostocktext->value}]
                                                [{$oArticle->oxarticles__oxnostocktext->value}]
                                            [{elseif $oViewConf->getStockOffDefaultMessage()}]
                                                [{oxmultilang ident="MESSAGE_NOT_ON_STOCK"}]
                                            [{/if}]
                                        </span>
                                    [{/if}]
                                [{elseif $oArticle->getStockStatus() == 1}]
                                    <span class="u-text--green">
                                        [{*oxmultilang ident="LOW_STOCK"*}]
                                        [{oxmultilang ident="READY_FOR_SHIPPING"}]
                                    </span>
                                [{elseif $oArticle->getStockStatus() == 0}]
                                    <span class="u-text--green">
                                        [{if $oArticle->oxarticles__oxstocktext->value}]
                                            [{$oArticle->oxarticles__oxstocktext->value}]
                                        [{elseif $oViewConf->getStockOnDefaultMessage()}]
                                            [{oxmultilang ident="READY_FOR_SHIPPING"}]
                                        [{/if}]
                                    </span>
                                [{/if}]
                            [{/if}]

                        </div>
                    </div>
                </div>
            [{/foreach}]
        </div>
        <div class="row u-m-b-15">
            <div class="col-sm-6 col-sm-offset-6">
                <table border="0" cellspacing="0" cellpadding="0" class="pull-right u-12/12">
                    [{block name="admin_order_overview_total"}]
                    <tr>
                        <td>[{ oxmultilang ident="SUBTOTAL" }]</td>
                        <td class="u-text--bold u-text--align-right">[{$order->oxorder__oxcurrency->value}] [{$order->getFormattedTotalBrutSum()}]</td>
                    </tr>

                    [{if $order->oxorder__oxdiscount->value}]
                    <tr>
                        <td>[{oxmultilang ident="DISCOUNT"}]</td>
                        <td class="u-text--bold u-text--align-right">- [{$order->oxorder__oxcurrency->value}] [{$order->getFormattedDiscount()}]</td>
                    </tr>
                    [{/if}]

                    [{if $order->oxorder__oxvoucherdiscount->value}]
                    <tr>
                        <td>[{oxmultilang ident="COUPON"}]</td>
                        <td class="u-text--bold u-text--align-right">- [{$order->oxorder__oxcurrency->value}] [{$order->getFormattedTotalVouchers()}]</td>
                    </tr>
                    [{/if}]
                    <tr>
                        <td>[{oxmultilang ident="SHIPPING_COST"}]</td>
                        <td class="u-text--bold u-text--align-right">[{$order->oxorder__oxcurrency->value}] [{$order->getFormattedeliveryCost()}]</td>

                    </tr>
                    <tr>
                        <td>[{if $oxcmp_basket->getPaymentCosts() >= 0}][{oxmultilang ident="SURCHARGE"}][{else}][{oxmultilang ident="DEDUCTION"}][{/if}] [{oxmultilang ident="PAYMENT_METHOD"}]</td>
                        <td class="u-text--bold u-text--align-right">[{$order->oxorder__oxcurrency->value}] [{$order->getFormattedPayCost()}]</b></td>
                    </tr>

                    <tr>
                        <td class="u-text--larger u-p-t-15">[{oxmultilang ident="GRAND_TOTAL" suffix="COLON"}]</td>
                        <td class="u-text--bold u-p-t-15 u-text--align-right">[{$order->oxorder__oxcurrency->value}] [{ $order->getFormattedTotalOrderSum() }]</td>
                    </tr>
                    [{/block}]
                </table>

            </div>
        </div>



    </div>

</div>

[{/if}]


[{block name="account_order_history"}]
[{if count($oOrders) > 0}]

    <div class="c-order-history-list">
        [{foreach from=$oOrders item=order}]
        <div class="c-account-order [{if $order->oxorder__oxstorno->value}]storno[{/if}]">

            <div class="c-account-order__ordernr">Bestellung Nr. [{ $order->oxorder__oxordernr->value }]</div>
            <div class="col-lg-3">
                <div>
                    <span class="u-text--bold">[{oxmultilang ident="ORDER_DATE" suffix="COLON"}]</span> <span class="u-text--float-right">[{ $order->oxorder__oxorderdate->value|date_format:"%d.%m.%Y" }]</span>
                </div>
                <div>
                    <span class="u-text--bold">[{oxmultilang ident="GRAND_TOTAL" suffix="COLON"}]</span> <span class="u-text--float-right">[{$order->oxorder__oxcurrency->value}] [{ $order->getFormattedTotalOrderSum() }]</span>
                </div>
            </div>
            <div class="col-lg-3 col-lg-offset-3">
                <div>
                    <span class="u-text--bold">[{oxmultilang ident="STATUS" suffix="COLON"}]</span>
                    [{if $order->oxorder__oxstorno->value}]
                        <span class="u-text--red u-text--float-right">[{oxmultilang ident="STATUS_CANCELED"}]</span>
                    [{elseif $order->oxorder__oxsenddate->value !="-" }]
                        <span class="u-text--green u-text--float-right">[{oxmultilang ident="STATUS_SHIPPED"}]</span>
                    [{else}]
                        <span class="u-text--orange u-text--float-right">[{oxmultilang ident="NOT_SHIPPED_YET"}]</span>
                    [{/if}]
                </div>
                <div>
                    [{if !$order->oxorder__oxstorno->value}]
                        <span class="u-text--bold">[{oxmultilang ident="PAYMENT" suffix="COLON"}]</span>
                        [{if $order->oxorder__oxpaid->value != "0000-00-00 00:00:00" }]
                            <span class="u-text--green u-text--float-right">Bezahlt am: [{ $order->oxorder__oxpaid->value|date_format:"%d.%m.%Y" }]</span>
                        [{else}]
                            <span class="u-text--orange u-text--float-right">Zahlung offen</span>
                        [{/if}]
                    [{/if}]
                </div>
            </div>
        	<div class="col-lg-12">
                <a class="btn btn-default u-m-t-15" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_ordersingle" params="order="|cat:$order->oxorder__oxordernr->value}]" >Details zur Bestellung [{ $order->oxorder__oxordernr->value }] »</a>
            </div>

        </div>
        [{if  1==2}] 
        <hr> 
            <li>
                <ul class="order-history-details">
                    <li>
                        <span id="accOrderDate_[{$order->oxorder__oxordernr->value}]" title="[{oxmultilang ident="ORDER_DATE"}]" >[{$order->oxorder__oxorderdate->value|date_format:"%d.%m.%Y"}]</span>
                        <strong>[{oxmultilang ident="ORDER_NUMBER"}]:</strong>
                        <span id="accOrderNo_[{$order->oxorder__oxordernr->value}]">[{$order->oxorder__oxordernr->value}]</span>
                    </li>
                    <li>
                        <strong>[{oxmultilang ident="STATUS"}]</strong>
                        <span id="accOrderStatus_[{$order->oxorder__oxordernr->value}]">
                            [{if $order->oxorder__oxstorno->value}]
                                <span class="note">[{oxmultilang ident="ORDER_IS_CANCELED"}]</span>
                            [{elseif $order->oxorder__oxsenddate->value !="-" }]
                                <span>[{oxmultilang ident="SHIPPED"}]</span>
                            [{else}]
                                <span class="note">[{oxmultilang ident="NOT_SHIPPED_YET"}]</span>
                            [{/if}]
                        </span>
                    </li>
                    [{if $order->getShipmentTrackingUrl()}]
                        <li>
                            <strong>[{oxmultilang ident="TRACKING_ID"}]</strong>
                            <span id="accOrderTrack_[{$order->oxorder__oxordernr->value}]">
                                <a href="[{$order->getShipmentTrackingUrl()}]">[{oxmultilang ident="TRACK_SHIPMENT"}]</a>
                            </span>
                        </li>
                    [{/if}]
                    <li>
                        <strong>[{oxmultilang ident="SHIPMENT_TO"}]</strong>
                        <span id="accOrderName_[{$order->oxorder__oxordernr->value}]">
                        [{if $order->oxorder__oxdellname->value }]
                            [{$order->oxorder__oxdelfname->value}]
                            [{$order->oxorder__oxdellname->value}]
                        [{else }]
                            [{$order->oxorder__oxbillfname->value}]
                            [{$order->oxorder__oxbilllname->value}]
                        [{/if}]
                        </span>
                    </li>
                </ul>
                <div class="order-history-articles">
             
                    [{foreach from=$order->getOrderArticles() item=orderitem name=testOrderItem}]
                        <div>
                            [{assign var=sArticleId value=$orderitem->oxorderarticles__oxartid->value }]
                            [{assign var=oArticle value=$oArticleList[$sArticleId] }]
                                <span class="order-history-article-quantity" title="[{oxmultilang ident="QNT"}]">[{$orderitem->oxorderarticles__oxamount->value}]</span>
                                [{if $oArticle->oxarticles__oxid->value && $oArticle->isVisible() }]
                                    <a  id="accOrderLink_[{$order->oxorder__oxordernr->value}]_[{$smarty.foreach.testOrderItem.iteration}]" href="[{$oArticle->getLink()}]">
                                [{/if}]
                                    [{$orderitem->oxorderarticles__oxtitle->value}]
                                    [{if $orderitem->oxorderarticles__oxselvariant->value}]
                                        <br /><span class="variants">[{$orderitem->oxorderarticles__oxselvariant->value}]</span>
                                    [{/if}]
                                [{if $oArticle->oxarticles__oxid->value && $oArticle->isVisible() }]</a>[{/if}]
                                [{* Commented due to Trusted Shops precertification. Enable if needed *}]
                                [{*
                                [{oxhasrights ident="TOBASKET"}]
                                [{if $oArticle->oxarticles__oxid->value && $oArticle->isBuyable() }]
                                    <a id="accOrderToBasket_[{$order->oxorder__oxordernr->value}]_[{$smarty.foreach.testOrderItem.iteration}]" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_order" params="fnc=tobasket&amp;aid=`$oArticle->oxarticles__oxid->value`&amp;am=1"}]" rel="nofollow">[{oxmultilang ident="TO_CART"}]</a>
                                [{/if}]
                                [{/oxhasrights}]
                                *}]

                        </div>
                    [{/foreach}]
                </div>
            </li>
            [{/if}]
              
        [{/foreach}]
    </div>
    [{include file="widget/locator/listlocator.tpl" locator=$oView->getPageNavigation() place="bottom"}]
[{else}]
    <div class="content">
        [{oxmultilang ident="ORDER_EMPTY_HISTORY"}]
    </div>
[{/if}]
[{/block}]
[{insert name="oxid_tracker" title=$template_title }]
</div>
[{/capture}]


[{include file="layout/page.tpl" sidebar="Left"}]