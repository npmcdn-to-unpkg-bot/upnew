[{block name="footer_main"}]
    <footer>
        <div class="prefooter">
            <div class="container">
                  <div class="row">
                    <div class="col-lg-6">[{oxcontent ident="upprefootercustomerservice" }]</div>
                    <div class="col-lg-6 newsletter-teaser">[{oxcontent ident="upprefooternewsletter" }]</div>
               </div>
            </div>
        </div>
        <div class="footer">
        <div class="container">
            <div class="row top-line">
              
                 <div class="col-lg-6"></div>
                 <div class="col-lg-6">
                    [{if $oView->showNewsletter()}]
                        [{include file="widget/footer/newsletter.tpl"}]
                    [{/if}]
                </div>
            </div>
            
            [{*}] <div id="panel">
               
                <ul class="nav nav-pills nav-justified footer-nav">
                    [{if $oxcmp_user->oxuser__oxpassword->value}]
                        <li><a href="[{$oViewConf->getLogoutLink()}]">[{oxmultilang ident="LOGOUT"}]</a></li>
                    [{else}]
                        <li><a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account"}]">[{oxmultilang ident="LOGIN"}]</a></li>
                    [{/if}]
                    <li [{if $oView->getClassName() == "account"}]class="active"[{/if}]><a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account"}]">[{oxmultilang ident="MY_ACCOUNT"}]</a></li>
                    <li><a href="[{$oViewConf->getHomeLink()}]">[{oxmultilang ident="HOME"}]</a></li>
                </ul>

                <ul class="nav nav-list footer-nav">
                    <li>
                        <form action="[{oxgetseourl ident=$oViewConf->getSelfLink()}]" method="post">
                            <input type="hidden" name="themeType" value="desktop" />
                            <button class="btn">[{oxmultilang ident="STANDARD_WEBSITE"}]</button>
                        </form>
                    </li>
                </ul>

                [{oxid_include_widget cl="oxwServiceList" noscript=1 nocookie=1}]

                [{oxid_include_widget cl="oxwInformation" noscript=1 nocookie=1}]

            </div>[{*}]
            [{*<div id="copyright">
                <img src="[{$oViewConf->getImageUrl('logo_small.png')}]" alt="[{oxmultilang ident="OXID_ESALES_URL_TITLE"}]">
            </div>
            [{oxid_include_widget cl="oeThemeSwitcherWPaymentList" noscript=1 nocookie=1}]*}]
            
            <div class="row mid-line">
                <div class="col-lg-2">
                     [{oxid_include_widget cl="oxwServiceList" noscript=1 nocookie=1}]
                </div>
                <div class="col-lg-2">
                     [{oxid_include_widget cl="oxwInformation" noscript=1 nocookie=1}]
                </div>
                <div class="col-lg-2">
                    [{oxcontent ident="upfooteraddress" }]
                </div>
                <div class="col-lg-5 col-lg-offset-1">
                    [{oxid_include_widget cl="upModsRandomFooterPic" noscript=1 nocookie=1}]
                  
                </div>
            </div>
            
            <div class="row low-line">
                <div class="col-lg-4 col-xs-12">
                    <div class="h4">[{oxmultilang ident="FOOTER_PAYMENT_METHODS"}]</div>
                     <ul class="list-content-links inline-box">

                        <li><a href="[{oxgetseourl ident="oxagb" type="oxcontent"}]"><img src="[{$oViewConf->getImageUrl('footer/footer-payment-mastercard.png')}]" alt="Mastercard"></a></li>
                        <li><a href="[{oxgetseourl ident="oxagb" type="oxcontent"}]"><img src="[{$oViewConf->getImageUrl('footer/footer-payment-visa.png')}]" alt="Visa"></a></li>
                        <li><a href="[{oxgetseourl ident="oxagb" type="oxcontent"}]"><img src="[{$oViewConf->getImageUrl('footer/footer-payment-paypal.png')}]" alt="PayPal"></a></li>
                        <li class="last-child"><a href="[{oxgetseourl ident="oxagb" type="oxcontent"}]">[{oxmultilang ident="FOOTER_PAYMENT_INVOICE"}]</a>
                        <li><a href="[{oxgetseourl ident="oxagb" type="oxcontent"}]">[{oxmultilang ident="FOOTER_PAYMENT_PREPAYMENT"}]</a>
                        <li><a href="[{oxgetseourl ident="oxagb" type="oxcontent"}]">[{oxmultilang ident="FOOTER_PAYMENT_COD"}]</a>
                        
                    </ul>
                </div>
                <div class="col-lg-3 col-xs-12">
                     <div class="h4">[{oxmultilang ident="FOOTER_SHIPPING_METHODS"}]</div>
                     <ul class="list-content-links inline-box">
                        <li><a href="[{oxgetseourl ident="oxdeliveryinfo" type="oxcontent"}]"><img src="[{$oViewConf->getImageUrl('footer/footer-shipping-post.png')}]" alt="Post"></a></li>
                        <li><a href="[{oxgetseourl ident="oxdeliveryinfo" type="oxcontent"}]"><img src="[{$oViewConf->getImageUrl('footer/footer-shipping-ups.png')}]" alt="UPS"></a></li>
                        <li class="last-child"><a href="[{oxgetseourl ident="oxdeliveryinfo" type="oxcontent"}]">[{oxmultilang ident="FOOTER_PICKUP}]</a></li>
                    </ul>
                </div>
                <div class="col-lg-5 col-xs-12">
                    <div class="h4">[{oxmultilang ident="FOOTER_FOLLOWUS"}]</div>
                    <ul class="list-content-links inline-box">
                        <li><a href="https://www.facebook.com/urbanpeopleshop" target="_blank"><img src="[{$oViewConf->getImageUrl('footer/footer-social-fb.png')}]" alt="Facebook"></a></li>
                        <li><a href="http://www.instagram.com/urbanpeople" target="_blank"><img src="[{$oViewConf->getImageUrl('footer/footer-social-in.png')}]" alt="Instagram"></a></li>
                        <li><a href="https://twitter.com/urbanpeopleshop/" target="_blank"><img src="[{$oViewConf->getImageUrl('footer/footer-social-tw.png')}]" alt="Twitter @urbanpeopleshop"></a></li>
                        <li class="last-child"><a href="https://plus.google.com/111902835580770800233" target="_blank"><img src="[{$oViewConf->getImageUrl('footer/footer-social-gp.png')}]" alt="Google Plus"></a></li>
                    </ul>
                </div>
            </div>
            
        
        </div>
        </div>
    </footer>
[{/block}]
