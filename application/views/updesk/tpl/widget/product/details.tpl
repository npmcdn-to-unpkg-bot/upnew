[{assign var="oDetailsProduct" value=$oView->getProduct()}]
[{assign var="oPictureProduct" value=$oView->getPicturesProduct()}]
[{assign var="currency" value=$oView->getActCurrency()}]
[{assign var="sPageHeadTitle" value=$oDetailsProduct->oxarticles__oxtitle->value|cat:' '|cat:$oDetailsProduct->oxarticles__oxvarselect->value}]

    [{if $oView->getSearchTitle()}]
        [{assign var="detailsLocation" value=$oView->getSearchTitle()}]
    [{else}]
        [{foreach from=$oView->getCatTreePath() item=oCatPath name="detailslocation"}]
            [{if $smarty.foreach.detailslocation.last}]
                [{assign var="detailsLocation" value=$oCatPath->oxcategories__oxtitle->value}]
            [{/if}]
        [{/foreach}]
    [{/if}]

    [{* details locator *}]
    [{if 0}]
    [{assign var="actCategory" value=$oView->getActiveCategory()}]
    <div class="row">
        <div class="col-xs-12">
            <a class="btn btn-block btn-default" href="[{$actCategory->toListLink}]">
                <i class="glyphicon glyphicon-chevron-left"></i>
                <span>[{oxmultilang ident="BACK"}]</span>
            </a>
        </div>
    </div>
    [{/if}]

    [{* RDFa offering *}]
    <div class="productmain" itemscope itemtype="http://schema.org/Product">
        [{include file="page/details/inc/productmain.tpl"}]
    </div>
    
    
   </div><!-- row -->
   </div><!-- container -->
  
   <div class="section-light-grey footer-indent">
        <div class="container">
        <div class="row">
        [{ include file="page/details/inc/more_details.tpl" }]
        </div>[{* -- careful, section/container are closed in layout main template !!!! -- *}]

[{insert name="oxid_tracker" title="PRODUCT_DETAILS"|oxmultilangassign product=$oDetailsProduct cpath=$oView->getCatTreePath() }]
[{oxscript widget=$oView->getClassName()}]
