[{capture append="oxidBlock_content"}]
    [{if $oxcmp_user}]
        [{assign var="force_sid" value=$oViewConf->getSessionId()}]
    [{/if}]

    [{ oxid_include_widget cl="oxwArticleDetails" _parent=$oView->getClassName() nocookie=0 force_sid=$force_sid _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId() }]
[{/capture}]
[{include file="layout/page.tpl" sidebar="Left"}]
