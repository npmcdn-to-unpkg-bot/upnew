[{assign var="currency" value=$oView->getActCurrency()}]
[{foreach from=$oArt item=actionproduct name=test_articleList}]
  		[{assign var="error" value=0}]

        [{if $actionproduct->oxarticles__oxcustomtyp->value == 2 && $actionproduct->oxarticles__oxean->value == '' }]
            [{assign var="error" value="1"}]
        [{/if}]
        
        [{if $error !=1}][{include file=$itemTemplate iter=$smarty.foreach.test_articleList.iteration product=$actionproduct grid=$grid }]
        [{/if}]
    
[{/foreach}]
