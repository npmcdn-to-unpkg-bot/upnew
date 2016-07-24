[{capture append="oxidBlock_content"}]
    [{assign var="oContent" value=$oView->getContent()}]
    [{assign var="tpl" value=$oViewConf->getActTplName()}]
    [{assign var="oxloadid" value=$oViewConf->getActContentLoadId()}]
    [{assign var="template_title" value=$oView->getTitle()}]
    [{if !fullwidth || 1==1}]
    <div class="col-lg-2 sidebar-left">
      [{oxid_include_widget cl="oxwServiceList" noscript=1 nocookie=1}]
      [{oxid_include_widget cl="oxwInformation" noscript=1 nocookie=1}]
    </div>
    <div class="col-lg-6">
    <h1 class="page-head">[{$template_title}]</h1>
        <div class="content">
            [{$oView->getParsedContent()}]
        </div>
    </div>
     <div class="col-lg-4">
         [{include file="widget/address/shop_info_address.tpl" }]
    </div>
    [{else}] 
          [{$oView->getParsedContent()}]
    [{/if}]
    [{insert name="oxid_tracker" title=$template_title }]
[{/capture}]
[{include file="layout/page.tpl" sidebar="Left"}]