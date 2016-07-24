[{if $products|@count gt 0}]
    [{oxscript include="js/widgets/oxarticlelist.js" priority=10}]
    [{oxscript add="$('.article-list').oxArticleList();"}]
     
        [{capture assign="upptipjs"}]
                     $('.image-wrap.h-v').powerTip({ followMouse: true, intentSensitivity: 1,intentPollInterval:1, offset:15 });
        [{/capture}]
        [{ oxscript add=$upptipjs }]
    <div id="grid" class="article-list grid list-[{$oView->getListDisplayType()}] qpv" >
        [{assign var="currency" value=$oView->getActCurrency()}]
        [{foreach from=$products item=_product name=productlist}]
            [{assign var="_sProductListId" value=$listId|cat:"_"|cat:$smarty.foreach.productlist.iteration}]
            <article data-anid="[{$_product->oxarticles__oxid->value}]">[{oxid_include_widget cl="oxwArticleBox" _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() iLinkType=$_product->getLinkType() anid=$_product->getId() sWidgetType=product sListType=uplistitem iIndex=$_sProductListId blDisableToCart=$blDisableToCart currencySign=$currency->sign isVatIncluded=$oView->isVatIncluded() showMainLink=$showMainLink recommid=$recommid owishid=$owishid toBasketFunction=$toBasketFunction removeFunction=$removeFunction altproduct=$altproduct}]
            </article>
        [{/foreach}]
    </div>
[{/if}]
