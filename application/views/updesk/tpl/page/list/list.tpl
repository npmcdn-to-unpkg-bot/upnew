[{assign var="actCategory" value=$oView->getActiveCategory()}]
[{assign var="parentCategory" value=$actCategory->getParentCategory()}]
[{assign var="listType" value=$oView->getListType()}]

[{capture append="oxidBlock_sidebar"}]
     [{*  
 
    [{if $listType=='manufacturer' || $listType=='vendor'}]
        [{if $actCategory && $actCategory->getIconUrl()}]
        <div class="box">
            <h3>
                [{if $listType=='manufacturer'}]
                    [{ oxmultilang ident="BRAND" }]
                [{elseif $listType=='vendor'}]
                    [{ oxmultilang ident="VENDOR" }]
                [{/if}]
            </h3>
            <div class="featured icon">
                <img src="[{$actCategory->getIconUrl()}]" alt="[{$actCategory->getTitle()}]">
            </div>
        </div>
        [{/if}]
    [{/if}] *}]
[{/capture}]

[{capture append="oxidBlock_content"}]
    [{if $listType=='manufacturer'}]
    <div class="col-lg-2 col-md-2 sidebar-left">
        
        [{oxid_include_widget cl="oxwManufacturerList" _parent=$oView->getClassName() noscript=1 nocookie=1}]
    </div>
    
    [{else}]
        [{if $oxcmp_categories }]
        <div class="col-lg-2 col-md-2">
        [{defun name="category_tree" tree=$oxcmp_categories->getClickRoot() act=$oxcmp_categories->getClickCat() iter=0 class="$class"sidetree" level=1}]
        
            <ul class="sidetree l-[{$level}]">
              
            [{foreach from=$tree item=ocat key=catkey name=$test_catName}]
                [{if $ocat->getIsVisible() }]
                <li>
                    <a href="[{$ocat->getLink()}]" class="[{if $ocat->hasVisibleSubCats}][{if $ocat->expanded }]exp [{/if}]has [{else}]last [{/if}][{if isset($act) && $act->getId()==$ocat->getId() && !$oContentCat }]act [{/if}]">[{$ocat->oxcategories__oxtitle->value}] </a>
                    
                    [{if $ocat->getSubCats() }]
                        [{fun name="category_tree" tree=$ocat->getSubCats() act=$act class="" level=$level+1 }]
                    [{/if}]
                </li>
                [{/if}]
            [{assign var="iter" value=$iter+1}]
            [{/foreach}]
            </ul>
        
        [{/defun}]
        </div>
        [{/if}]
    [{/if}]
    
    
    <div class="col-lg-10 col-md-10">
       [{block name="page_list_listhead"}]
         [{if $listType=='manufacturer'}]
          <div class="listhead">
        
              [{if $actCategory->getThumbUrl()}]
               <div class="list-cover">
                    <img src="[{$actCategory->getThumbUrl()}]" alt="[{$actCategory->oxcategories__oxtitle->value}]" class="categoryPicture">
                </div>
                [{/if}]
             
                [{if $actCategory->getManufacturerDescription() }]
                <div class="list-description">
                    [{$actCategory->getManufacturerDescription()}]
                </div>
                [{/if}]
            </div>
        [{else}]
        <div class="listhead">
      
            [{if $actCategory->oxcategories__oxthumb->value && $actCategory->getThumbUrl()}]
                 <div class="list-cover">
                <img src="[{$actCategory->getThumbUrl()}]" alt="[{$actCategory->oxcategories__oxtitle->value}]" class="categoryPicture">
                </div>
            [{/if}]
    
           
            [{if $actCategory->oxcategories__oxlongdesc->value }]
                <div class="list-description" id="catLongDesc">[{oxeval var=$actCategory->oxcategories__oxlongdesc}]</div>
            [{/if}]
        </div>
         [{/if}]
         
          
         <h1 class="page-head">[{$actCategory->getTitle()}]</h1>
        [{if $oView->hasVisibleSubCats() && 0}]
            [{assign var="iSubCategoriesCount" value=0}]
            [{oxscript include="js/widgets/oxequalizer.js" priority=10 }]
            [{oxscript add="$(function(){oxEqualizer.equalHeight($( '.subcatList li .content' ));});"}]
            <ul class="subcatList clear">
                <li>
                [{foreach from=$oView->getSubCatList() item=category name=MoreSubCat}]
                    [{if $category->getContentCats() }]
                        [{foreach from=$category->getContentCats() item=ocont name=MoreCms}]
                            [{assign var="iSubCategoriesCount" value=$iSubCategoriesCount+1}]
                            <div class="box">
                            <h3>
                                <a id="moreSubCms_[{$smarty.foreach.MoreSubCat.iteration}]_[{$smarty.foreach.MoreCms.iteration}]" href="[{$ocont->getLink()}]">[{ $ocont->oxcontents__oxtitle->value }]</a>
                            </h3>
                            <ul class="content"></ul>
                            </div>
                        [{/foreach}]
                    [{/if}]
                    [{if $iSubCategoriesCount%4 == 0}]
                    </li><li>
                    [{/if}]
                    [{if $category->getIsVisible()}]
                        [{assign var="iSubCategoriesCount" value=$iSubCategoriesCount+1}]
                        [{assign var="iconUrl" value=$category->getIconUrl()}]
                            <div class="box">
                                <h3>
                                    <a id="moreSubCat_[{$smarty.foreach.MoreSubCat.iteration}]" href="[{ $category->getLink() }]">
                                        [{$category->oxcategories__oxtitle->value }][{if $oView->showCategoryArticlesCount() && ($category->getNrOfArticles() > 0) }] ([{ $category->getNrOfArticles() }])[{/if}]
                                    </a>
                                </h3>
                                [{if $category->getHasVisibleSubCats()}]
                                    <ul class="content">
                                        [{if $iconUrl}]
                                            <li class="subcatPic">
                                                <a href="[{ $category->getLink() }]">
                                                    <img src="[{$category->getIconUrl() }]" alt="[{$category->oxcategories__oxtitle->value}]">
                                                </a>
                                            </li>
                                        [{/if}]
                                        [{foreach from=$category->getSubCats() item=subcategory}]
                                            [{if $subcategory->getIsVisible()}]
                                                [{foreach from=$subcategory->getContentCats() item=ocont name=MoreCms}]
                                                    <li>
                                                        <a href="[{$ocont->getLink()}]"><strong>[{ $ocont->oxcontents__oxtitle->value }]</strong></a>
                                                    </li>
                                                [{/foreach}]
                                                <li>
                                                    <a href="[{ $subcategory->getLink() }]">
                                                        <strong>[{ $subcategory->oxcategories__oxtitle->value }]</strong>[{if $oView->showCategoryArticlesCount() && ($subcategory->getNrOfArticles() > 0) }] ([{ $subcategory->getNrOfArticles() }])[{/if}]
                                                    </a>
                                                </li>
                                             [{/if}]
                                        [{/foreach}]
                                    </ul>
                                [{else}]
                                    <div class="content catPicOnly">
                                        <div class="subcatPic">
                                        [{if $iconUrl}]
                                            <a href="[{ $category->getLink() }]">
                                                <img src="[{$category->getIconUrl() }]" alt="[{ $category->oxcategories__oxtitle->value }]">
                                            </a>
                                         [{/if}]
                                        </div>
                                    </div>
                                [{/if}]
                            </div>
                    [{/if}]
                [{if $iSubCategoriesCount%4 == 0}]
                </li>
                <li>
                [{/if}]
                [{/foreach}]
            </li>
            </ul>
        [{/if}]
    [{/block}]
     

    [{block name="page_list_listbody"}]
    [{if $oView->getArticleList()|@count > 0}]
        [{include file="widget/locator/listlocator.tpl" locator=$oView->getPageNavigationLimitedBottom() place="bottom"}]
    [{/if}]
    [{/block}]
    </div>

     [{insert name="oxid_tracker"}]
[{/capture}]


[{capture append="oxidBlock_content_EXCLUDED"}]

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
<div class="row">

<div class="col-lg-10">
    
    [{if $actCategory}]
        <h1 class="page-head">[{$actCategory->getTitle()}]</h1>
    [{/if}]



    [{if $oView->getArticleList()|@count > 0}]
        [{include file="widget/locator/listlocator.tpl" locator=$oView->getPageNavigationLimitedTop() attributes=$oView->getAttributes() listDisplayType=true sort=true}]
        [{* List types: grid|line|infogrid *}]
        [{include file="widget/product/list.tpl" type=$oView->getListDisplayType() listId="productList" products=$oView->getArticleList() blDisableToCart=true}]
        [{include file="widget/locator/listlocator.tpl" locator=$oView->generatePageNavigation(5) place="bottom"}]
    [{/if}]

  
   </div> 
</div>    
   
[{/capture}]

[{include file="layout/page.tpl" sidebar="Left" tree_path=$oView->getTreePath()}]
