<header class="checkout-header">
    <div class="row">
            <div class="col-lg-5">
                [{block name="layout_header_logo"}]
                <div class="logo" >
                    <a href="[{$oViewConf->getHomeLink()}]" title="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]">
                        <img src="[{$oViewConf->getImageUrl('logo-wide.png')}]">
                    </a>
                </div>
                <div class="header-cart js-checkout-cart resp-lg-hidden">
                     <img src="[{$oViewConf->getImageUrl('fi-128-cart.png') }]">
                </div>
                [{/block}]
            </div>
            <div class="col-lg-7 resp-xs-hidden trusticons">
                <div class="delivery"><img src="[{$oViewConf->getImageUrl('fi-128-delivery.png') }]"><div>[{ oxmultilang ident="CHECKOUT_HEADER_TRUST_DELIVERY" }]</div></div>
                <div class="return"><img src="[{$oViewConf->getImageUrl('fi-128-return.png') }]"><div>[{ oxmultilang ident="CHECKOUT_HEADER_TRUST_RETURNDAYS" }]</div></div> 
            </div>
    </div>
</header>