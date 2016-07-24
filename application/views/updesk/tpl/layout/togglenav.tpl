[{* <header class="header"><span class="title">Navigation</span></header> *}]
[{if 0}]
<div class="container">
    <div class="js-maintree">
    [{ oxid_include_widget cl="oxwCategoryTree" cnid=$oView->getCategoryId() sWidgetType="header" _parent=$oView->getClassName() nocookie=1 }]
    </div>
</div>
[{/if}]
[{strip}]
   
<ul class="toptree left l-1">
[{assign var="iCatCnt" value=1}]
[{foreach from=$oxcmp_categories item=ocat key=catkey name=root}]
        [{if $ocat->getIsVisible() }]
            <li [{if $ocat->expanded}]class="current"[{/if}]>
                <a  [{if $homeSelected == 'false' && $ocat->expanded}]class="current"[{/if}] href="[{$ocat->getLink()}]">[{$ocat->oxcategories__oxtitle->value}] 
                 [{assign var="level2count" value=$ocat->getSubCats()|@count}]
              
                 [{assign var="level3count" value=0}] 
                 [{assign var=subcount" value="0"}]
                 [{foreach from=$ocat->getSubCats() item=osubcat }]
                    
                     [{assign var=subcount" value=$osubcat->getSubCats()|@count}]
                     [{assign var="level3count" value=$level3count+$subcount}]
                 [{/foreach}]
                [{assign var="subCntTotal" value=$level2count+$level3count}]
                [{assign var="sCThalf" value=$subCntTotal*0.5}]
                
                 [{ assign var="col" value=2}]
                [{* if $sCThalf > 11}]
                    [{ assign var="sCThalf" value=10}]
                    [{ assign var="col" value=3}]
                [{/if *}]
                    [{*}] [{$subCntTotal}] - [{ $sCThalf}] - [{ $level2count}] - [{$level3count}] [{*}]
                </a>
                [{if $ocat->getSubCats()}]
                 <div class="subcatlayer  clearfix">
                    <div class="col-[{$col}]">
                    <div class="parentcat-link"><a   href="[{$ocat->getLink()}]">Alle Artikel zu [{$ocat->oxcategories__oxtitle->value}] ansehen</a></div>
                    [{assign var="iCatCnt" value=0}]
                    <ul class="l-2">
                    
                    [{foreach from=$ocat->getSubCats() item=osubcat key=subcatkey name=SubCat }]
                        [{if $osubcat->getIsVisible() }][{assign var="iCatCnt" value=$iCatCnt+1 }]
                           
                            [{if $osubcat->getIsVisible() }]
                                <li><a href="[{$osubcat->getLink()}]">[{$osubcat->oxcategories__oxtitle->value}] [{* $iCatCnt *}]</a></li>
   
                                [{if $osubcat->getSubCats()}]
                                    <ul class="l-3">
                                    [{foreach from=$osubcat->getSubCats() item=osubcat2 key=subcatkey name=SubCa2 }]
                                        [{if $osubcat2->getIsVisible() }][{assign var="iCatCnt" value=$iCatCnt+1 }]
                                                <li ><a href="[{$osubcat2->getLink()}]">[{$osubcat2->oxcategories__oxtitle->value}] [{* $iCatCnt }] - [{$sCThalf *}]</a></li>
                                        [{/if}]
                                    [{/foreach}]
                                    </ul>
                                [{/if}]
     
                            [{/if}]
                        [{/if}]
                        
                     [{if $iCatCnt >= $sCThalf    && !$smarty.foreach.SubCat.last}] </ul><ul class="l-2">[{assign var="iCatCnt" value=0}][{/if}]
                    [{/foreach}]
                    </ul>
                    </div>
                  </div>
                [{/if}]
            </li>
      
      [{/if}]
    [{/foreach}]
    </ul>
    
    
        <ul class="toptree right l-1">
            
             <li class="js-sportssubcat-page">
                <a href="#" class="preventdefault">Sport-Teams</a>
                              
                                         
                                    
               
             </li>
             <li class="js-brandsubcat-page">
                <a href="#" class="preventdefault">[{oxmultilang ident="HEADER_BRANDS"}]</a>
                                
                 [{oxscript add="$( '.js-brandsubcat-page' ).click(function(e){  $('.scpsports' ).hide();  $('.scpbrands' ).slideToggle();    window.scrollTo(0,0);  });"}]
                 [{oxscript add="$( '.manufacturer-alphalist .close-button' ).click(function(e){ $('.scpbrands' ).slideToggle(); });" }] 
                 
 
                
             
                [{oxscript add="$( '.js-sportssubcat-page' ).click(function(e){ $('.scpbrands' ).hide();  $('.scpsports' ).slideToggle();      window.scrollTo(0,0);  });"}]
                [{oxscript add="$( '.sportslist .close-button' ).click(function(e){ $('.scpsports' ).slideToggle(); });"}]
             
             </li>
    </ul>
[{/strip}]