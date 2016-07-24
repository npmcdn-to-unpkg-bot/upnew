[{assign var="oxcmp_categories" value=$oxcmp_categories}]
[{if 0}]
<div id="cat_list">
    <ul class="main-nav-list nav nav-list" >
        [{foreach from=$oxcmp_categories item=ocat key=catkey name=root}]
        [{if $ocat->getIsVisible()}]
        <li>
            <a href="[{$ocat->getLink()}]">
                        <span>
                            [{$ocat->oxcategories__oxtitle->value}]
                            [{if $oView->showCategoryArticlesCount() && ($ocat->getNrOfArticles() > 0)}] ([{$ocat->getNrOfArticles()}])[{/if}]
                        </span>
                <i class="glyphicon-chevron-right"></i>
            </a>
        </li>
        [{/if}]
        [{/foreach}]
    </ul>
</div>
[{/if}]
[{*
[{if $oxcmp_categories }]

[{assign var="class" value="tree" }]

[{assign var="iter" value=0}]
[{defun name="category_tree" tree=$oxcmp_categories act=$oxcmp_categories->getClickCat() iter=0 class=$class level=1}]
<h1>[{$act->getId()}]a</h1>
    <ul class="[{$class}] l-[{$level}]">
      
    [{foreach from=$tree item=ocat key=catkey name=$test_catName}]
        [{if $ocat->getIsVisible() }]
        <li class="[{if isset($act) && $act->getId()==$ocat->getId() && !$oContentCat }]act[{/if}]">
            <a href="[{$ocat->getLink()}]" class="">[{$ocat->oxcategories__oxtitle->value}] [{$level}] [{$iter}]</a>
            
            [{if $ocat->getSubCats() }]
                [{fun name="category_tree" tree=$ocat->getSubCats() act=$act class="" level=$level+1 }]
            [{/if}]
        </li>
        [{/if}]
    [{assign var="iter" value=$iter+1}]
    [{/foreach}]
    </ul>

[{/defun}]
[{/if}]
*}]




[{if $oxcmp_categories }]
[{assign var="oContentCat" value=$oView->getContentCategory() }]
[{assign var="class" value="cat-tree n-tree" }]
[{defun name="category_tree" tree=$oxcmp_categories act=$oxcmp_categories->getClickCat() class=$class round=1}]
[{strip}]
    <ul class="[{$class}] l-[{$round}]">
    [{if $round > 1}]<li><a href="[{$ocat->getLink()}]">Alles in [{$ocat->oxcategories__oxtitle->value}] ansehen</a></li>[{/if}]
    [{foreach from=$tree item=ocat key=catkey name=$test_catName}]
        [{if $ocat->getIsVisible() }]
        <li class="[{if isset($act) && $act->getId()==$ocat->getId() && !$oContentCat }]act[{/if}]">
            <a href="[{$ocat->getLink()}]">[{$ocat->oxcategories__oxtitle->value}] <i class="bl bl-x"></i></a>
            [{if $ocat->getSubCats() }]
                [{fun name="category_tree" tree=$ocat->getSubCats() act=$act class="" round=$round+1 }]
            [{/if}]
        </li>
        [{/if}]
    
    [{/foreach}]
    </ul>
[{/strip}]
[{/defun}]
[{/if}]

[{if 0}]


[{if $oxcmp_categories }]
[{assign var="oContentCat" value=$oView->getContentCategory() }]
[{assign var="class" value="tree" }]
[{defun name="category_tree" tree=$oxcmp_categories act=$oxcmp_categories->getClickCat() class=$class round=1}]
[{strip}]
    <ul class="[{$class}] l-[{$round}]">
    [{if $round==3}]<li><a class="last" href="[{$ocat->getLink()}]">Alle</a></li>[{/if}]
    [{foreach from=$tree item=ocat key=catkey name=$test_catName}]
        [{if $ocat->getIsVisible() }]
        <li>
            <a href="[{$ocat->getLink()}]" class="[{if $ocat->isTopCategory()}]root [{/if}][{if $ocat->hasVisibleSubCats}][{if $ocat->expanded }]exp [{/if}]has [{else}]last [{/if}][{if isset($act) && $act->getId()==$ocat->getId() && !$oContentCat }]act [{/if}]">[{$ocat->oxcategories__oxtitle->value}]</a>
            [{if $ocat->getSubCats() }]
                [{fun name="category_tree" tree=$ocat->getSubCats() act=$act class="" round=$round+1 }]
            [{/if}]
        </li>
        [{/if}]
    
    [{/foreach}]
    </ul>
[{/strip}]
[{/defun}]
[{/if}]

[{/if}]