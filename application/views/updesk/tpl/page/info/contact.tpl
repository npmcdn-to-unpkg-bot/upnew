[{capture append="oxidBlock_content"}]


<div class="row">
   
    
  
    <div class="col-lg-2 sidebar-left">
        
         
      [{oxid_include_widget cl="oxwServiceList" noscript=1 nocookie=1}]
        
      [{oxid_include_widget cl="oxwInformation" noscript=1 nocookie=1}]
    </div>
    
    
   
    
    
    <div class="col-lg-10">
    [{if $oView->getContactSendStatus() }]
        [{assign var="_statusMessage" value="PAGE_INFO_CONTACT_THANKYOU1"|oxmultilangassign:$oxcmp_shop->oxshops__oxname->value}]
        [{include file="message/success.tpl" statusMessage=$_statusMessage}]
    [{/if }]
  
    <div class="content" id="contacts">
        <div class="col-lg-8">
               <div class="checkout-section">
               <h3 class="section-heading">[{$template_title}]</h3>
                [{include file="form/contact.tpl"}]
                </div>
        </div>
        <div class="col-lg-4">
             [{include file="widget/address/shop_info_address.tpl" }]
        </div>
         
        [{insert name="oxid_tracker" title=$template_title}]
    </div>
    </div>
[{/capture}]

[{include file="layout/page.tpl" sidebar="Left"}]
