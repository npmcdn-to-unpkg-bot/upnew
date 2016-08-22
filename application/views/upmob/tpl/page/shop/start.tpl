[{capture append="oxidBlock_content"}]
    [{* oxid_include_widget cl="oxwCategoryTree" cnid=$oView->getCategoryId() sWidgetType="header" _parent=$oView->getClassName() nocookie=1 *}]

   [{if 0}]
    <div class="start-hero">
    		<img src="http://www.urbanpeople.com/out/pictures/12/spring_last_seaon.jpg">
    		[{*<div class="content-wrapper">
    			<div class="title">Spring Sale</div>
    			<div class="cta">Zum Sale <span class="glyphicon glyphicon-triangle-right" aria-hidden="true"></span></div>
    		</div> *}]
    </div>
    [{/if}]
    <div class="start-cats" style="display:none;">
    	[{*oxid_include_widget cl="oxwCategoryTree" cnid=$oView->getCategoryId() sWidgetType="header" _parent=$oView->getClassName() nocookie=1 *}]
    	

    	[{oxscript add="$( '.js-maintree' ).clone().appendTo( '.start-cats' );"}]
    </div>
    <div class="js-dom-load"><div class="spinner"></div></div>
    <div class="start-welt clearfix">
    
   [{ oxcontent ident="oxstartwelt" }]
       
    </div>

    [{ oxcontent ident="oxstartseotext" }]



    [{/capture}]
[{include file="layout/page.tpl" sidebar="Right" footernav="false"}]