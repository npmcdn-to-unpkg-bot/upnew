[{oxscript include="js/widgets/oxsearch.js" priority=10 }]
[{oxscript add="$( '#search' ).oxSearch();"}]
[{oxscript include="js/libs/modernizr.custom.min.js" priority=10}]
[{oxscript include="js/widgets/oxplaceholderfallback.js" priority=10 }]
[{oxscript add="$('form').oxPlaceholderFallback();"}]

[{block name="widget_header_search_form"}]
[{if $oView->showSearch() }]
    <div class="search-box-container">
       <div class="search-box">
           
         <input name="searchparam" type="search" class="searchParamModule" id="search-input" value="" autocomplete="off" placeholder="[{oxmultilang ident="SEARCH"}]"><button class="searchbox-btn"><i class="glyphicon glyphicon-search"></i></button>
        [{if 0}] 
        <form  action="[{$oViewConf->getSelfActionLink()}]" method="get" name="search">
            [{$oViewConf->getHiddenSid()}]
            <input type="hidden" name="cl" value="search" >
            
            [{block name="header_search_field"}]
                <input name="searchparam" type="search" class="searchParamModule" id="[{* if $smarty.get.algolia == 1}]search-input[{else}]searchParam[{/if *}]search-input" value="[{$oView->getSearchParamForHtml()}]" autocomplete="off" placeholder="[{oxmultilang ident="SEARCH"}]">
                
            [{/block}]
            <button class="searchbox-btn"><i class="glyphicon glyphicon-search"></i></button>
        </form>
        [{/if}]
       </div>
    </div>
    [{*}]<div class="col-xs-10 col-xs-offset-1">Beliebt: Nike Wmns, Air max 1</div>  [{*}]

   
[{/if}]
[{/block}]