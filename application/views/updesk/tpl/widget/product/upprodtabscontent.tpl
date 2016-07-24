
[{assign var="currency" value=$oView->getActCurrency()}]
<div class="box" [{if $_boxId}]id="[{$_boxId}]"[{/if}]>
    [{if $_sHeaderIdent}]
       [{* <h3 class="clear [{if $_sHeaderCssClass}] [{$_sHeaderCssClass}][{/if}]">
           Mehr von Nike
        </h3>*}]
    [{/if}]
    <div id="grid" class="article-list grid list-six">
        [{foreach from=$_oBoxProducts item=_oBoxProduct name=_sProdList}]
            [{assign var="iProdCount" value=$smarty.foreach._sProdList.first}]
           <article>
            [{oxid_include_widget cl="oxwArticleBox" _parent=$oView->getClassName() _navurlparams=$oViewConf->getNavUrlParams() iLinkType=$_oBoxProduct->getLinkType() anid=$_oBoxProduct->getId() currencySign=$currency->sign isVatIncluded=$oView->isVatIncluded() iProdCount=$iProdCount nocookie=1 sWidgetType=product sListType=uplistitem}]
            </article>
        [{/foreach}]
    </div>
</div>