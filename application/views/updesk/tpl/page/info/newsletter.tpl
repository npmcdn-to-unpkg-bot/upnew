[{capture append="oxidBlock_content"}]

   <div class="col-lg-2 sidebar-left">
      [{oxid_include_widget cl="oxwServiceList" noscript=1 nocookie=1}]
      [{oxid_include_widget cl="oxwInformation" noscript=1 nocookie=1}]
    </div>
    
    
   
    
    
      <div class="col-lg-10">
          
         
        <div class="col-lg-8">
          <div class="checkout-section">
          [{if $oView->getNewsletterStatus() == 4 || !$oView->getNewsletterStatus()}]
            <h3 class="page-head">[{oxmultilang ident="NEWSLETTER"}]</h3>
            [{oxifcontent ident="oxnewstlerinfo" object="oCont"}]
                 [{$oCont->oxcontents__oxcontent->value}]
            [{/oxifcontent}]
            <br>
            [{include file="form/newsletter.tpl"}]
          [{elseif $oView->getNewsletterStatus() == 1}]
            <h3 class="page-head">[{oxmultilang ident="MESSAGE_THANKYOU_FOR_SUBSCRIBING_NEWSLETTERS"}]</h3>
            [{oxmultilang ident="MESSAGE_SENT_CONFIRMATION_EMAIL"}]<br><br>
          [{elseif $oView->getNewsletterStatus() == 2}]
            <h3 class="page-head">[{oxmultilang ident="MESSAGE_NEWSLETTER_CONGRATULATIONS"}]</h3>
            [{oxmultilang ident="MESSAGE_NEWSLETTER_SUBSCRIPTION_ACTIVATED"}]<br><br>
          [{elseif $oView->getNewsletterStatus() == 3}]
            <h3 class="page-head">[{oxmultilang ident="SUCCESS"}]</h3>
            [{oxmultilang ident="MESSAGE_NEWSLETTER_SUBSCRIPTION_CANCELED"}]<br><br>
          [{/if}]
          </div>
        </div>
         <div class="col-lg-4">
          <img src="http://46.101.190.11/updev/campaign-imgs/nl_banner_test.jpg">
           </div>
        
    </div>
    [{insert name="oxid_tracker"}]
[{/capture}]

[{include file="layout/page.tpl"}]