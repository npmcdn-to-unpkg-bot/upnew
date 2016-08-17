[{assign var="template_title" value="LOGIN"|oxmultilangassign }]
[{capture append="oxidBlock_content"}]
    <div class="col-lg-2 sidebar-left">
      [{oxid_include_widget cl="oxwServiceList" noscript=1 nocookie=1}]
      [{oxid_include_widget cl="oxwInformation" noscript=1 nocookie=1}]
    </div>
    <div class="col-lg-6">
        
        <div class="c-box c-box--grey">
            <h3 class="c-box__title">[{oxmultilang ident="LOGIN"}]</h3>
       
             <p>[{oxmultilang ident="LOGIN_ALREADY_CUSTOMER"}]</p>
             
            [{include file="form/login_account.tpl"}]
        </div>
    </div>
     <div class="col-lg-4">
         [{include file="widget/address/shop_info_address.tpl" }]
    </div>
    [{insert name="oxid_tracker" title=$template_title }]
[{/capture}]

[{include file="layout/page.tpl"}]
