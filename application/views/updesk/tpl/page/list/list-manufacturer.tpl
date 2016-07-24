[{assign var="actCategory" value=$oView->getActiveCategory()}]

   [{assign var="listType" value=$oView->getListType()}]
 [{if !$listType=='manufacturer' || !$listType=='vendor'}]
[{assign var="parentCategory" value=$actCategory->getParentCategory()}]
[{/if}]
[{capture append="oxidBlock_content"}]

[{if 0}]
    <div id="subcat_list">
        <ul class="nav nav-list main-nav-list">
            <li>
                <a class="back" href="[{if $parentCategory}][{$parentCategory->getLink()}][{else}][{$oViewConf->getHomeLink()}][{/if}]">
                    <span>[{oxmultilang ident="BACK"}]</span>
                    <i class="glyphicon glyphicon-chevron-left"></i>
                </a>
            </li>
            [{if $oView->hasVisibleSubCats()}]
                [{foreach from=$oView->getSubCatList() item=category name=MoreSubCat}]
                    <li>
                        [{if $category->getIsVisible()}]
                            <a id="moreSubCat_[{$smarty.foreach.MoreSubCat.iteration}]" href="[{$category->getLink()}]">
                                <span>
                                    [{$category->oxcategories__oxtitle->value}]
                                    [{if $oView->showCategoryArticlesCount() && ($category->getNrOfArticles() > 0)}] ([{$category->getNrOfArticles()}])[{/if}]
                                </span>
                                <i class="glyphicon glyphicon-chevron-right"></i>
                            </a>
                        [{/if}]
                    </li>
                [{/foreach}]
            [{/if}]
        </ul>
    </div>
[{/if}]  

    [{if $actCategory}]
        <h1 class="page-head">[{ oxmultilang ident="BRAND" }] [{$actCategory->getTitle()}]</h1>

          <div class="featured icon">
                <img src="http://www.urbanpeople.com/out/pictures/icon/brand/[{$actCategory->oxmanufacturers__oxicon->value}][{*$actCategory->getIconUrl()*}]" alt="[{$actCategory->getTitle()}]">
                
            </div>
    [{/if}]

    [{***** MULTIFILTER MOD BEGIN *****}]
    [{* oxstyle include=$oViewConf->getModuleUrl('z_multifilter',"out/src/css/multifilter_mobile.css") *}]
    [{include file=$oViewConf->getModulePath('z_multifilter',"views/tpl/widget/multifilter/z_multifilter_list_mobile.tpl") attributes=$oView->getAttributes()}]
    [{if 0}]
    [{***** MULTIFILTER MOD END *****}]

    [{if $oView->getArticleList()|@count > 0}]
        [{include file="widget/locator/listlocator.tpl" locator=$oView->getPageNavigationLimitedTop() attributes=$oView->getAttributes() listDisplayType=true sort=true}]
        [{* List types: grid|line|infogrid *}]
        [{include file="widget/product/list.tpl" type=$oView->getListDisplayType() listId="productList" products=$oView->getArticleList() blDisableToCart=true}]
        [{include file="widget/locator/listlocator.tpl" locator=$oView->generatePageNavigation(5) place="bottom"}]
    [{/if}]

    [{***** MULTIFILTER MOD BEGIN *****}]
    [{/if}]
    [{***** MULTIFILTER MOD END *****}]
    
    
    [{insert name="oxid_tracker"}]
[{/capture}]
[{include file="layout/page.tpl" sidebar="Left" tree_path=$oView->getTreePath()}]
