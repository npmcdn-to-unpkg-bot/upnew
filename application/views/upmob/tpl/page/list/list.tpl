[{assign var="actCategory" value=$oView->getActiveCategory()}]
[{assign var="parentCategory" value=$actCategory->getParentCategory()}]




[{capture append="oxidBlock_content"}]


    
    [{if $listType=='manufacturer'}]

    [{else}]
       
    [{/if}]
    
    
    <div class="col-lg-10">
      
     
  
    
     

         <div class="instalgo-listing" id="ia-catlisting" data-oxid="[{if $actCategory->oxcategories__oxidmanlegacy}][{$actCategory->oxcategories__oxidmanlegacy}][{else}][{$actCategory->oxcategories__oxid->value}][{/if}]" data-hits-per-page="28" data-pagination="loadmore" data-hits-per-line="2">
            [{block name="instalgo_list_listhead"}]
                <header>
                    <div class="col-xs-12">
                        <h1 class="page-head">[{$actCategory->getTitle()}]</h1>
                        <div class="th-count"><em></em> Artikel</div>
                    </div>
                    [{if $actCategory->getThumbUrl()}]
                        <div class="list-cover">
                            <img src="[{$actCategory->getThumbUrl()}]" alt="[{$actCategory->oxcategories__oxtitle->value}]" class="categoryPicture">
                        </div>
                    [{/if}]
                </header>
            [{/block}]
            <div id="core-target"></div>
        </div>
        
        [{* oxscript include="js/widgets/oxcatlist.js" priority=10 *}]
        
        [{if $oView->getListType() == 'manufacturer'}]
            [{oxscript add="$( '.instalgo-listing' ).oxManList();"}]
        [{else}]
            [{oxscript add="$( '.instalgo-listing' ).oxCatList();"}]
        [{/if}]
        
     
        

    [{if $smarty.get.algolia == 1}]
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

                [{if 0}][{if $actCategory->oxcategories__oxlongdesc->value }]
                    <div class="list-description" id="catLongDesc">[{oxeval var=$actCategory->oxcategories__oxlongdesc}]</div>
                [{/if}]
                 [{/if}]
            </div>
            [{/if}]
             
              
             <h1 class="page-head">[{$actCategory->getTitle()}]</h1>
             <button class="btn btn-block btn-default js-catBoxFilter">Filter <span class="glyphicon glyphicon-plus pull-right" aria-hidden="true"></span></button>
             [{oxscript add="$( '.js-catBoxFilter').click(function(e) { $( '.categoryBox' ).toggle(); });"}] 

         
        [{/block}]
        [{block name="page_list_listbody"}]
        [{if $oView->getArticleList()|@count > 0}]
            [{include file="widget/locator/listlocator.tpl" locator=$oView->getPageNavigationLimitedBottom() place="bottom"}]
        [{/if}]
        [{/block}]
    [{/if}]
    </div>
    
    [{if $actCategory->oxcategories__oxlongdesc->value }]
        <div class="col-lg-12" id="catLongDesc">[{oxeval var=$actCategory->oxcategories__oxlongdesc}]</div>
    [{/if}]
    [{if $actCategory->getManufacturerDescription() }]
        <div class="col-lg-12">[{$actCategory->getManufacturerDescription()}]</div>
    [{/if}]

     [{insert name="oxid_tracker"}]
[{/capture}]




[{include file="layout/page.tpl" sidebar="Left" tree_path=$oView->getTreePath()}]
