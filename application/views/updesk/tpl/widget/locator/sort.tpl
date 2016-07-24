[{if $oView->showSorting()}]
[{*}]
    [{oxscript include="js/widgets/oxdropdown.js" priority=10}]
    [{oxscript add="$('div.dropdown').oxDropDown();"}]
    [{assign var="_listType" value=$oView->getListDisplayType()}]
    [{assign var="_additionalParams" value=$oView->getAdditionalParams()}]
    [{assign var="_artPerPage" value=$oViewConf->getArtPerPageCount()}]
    [{assign var="_sortColumnVarName" value=$oView->getSortOrderByParameterName()}]
    [{assign var="_sortDirectionVarName" value=$oView->getSortOrderParameterName()}]
    <div id="sortItems" class="sort-items">
        <label class="sort-title">[{oxmultilang ident="SORT_BY"}]</label>
        <div class="dropdown">
            <input type="hidden" name="sortValue" value="[{oxmultilang ident=$oView->getListOrderBy()|upper}][{$oView->getListOrderDirection()}]">
            <div class="dropdown-toggle" data-toggle="dropdown" data-target="#">
                <span>
                    [{if $oView->getListOrderBy() }]
                        [{oxmultilang ident=$oView->getListOrderBy()|upper}]
                    [{else}]
                        [{oxmultilang ident="CHOOSE"}]
                    [{/if}]
                </span>
                <i class="glyphicon-chevron-down"></i>
            </div>
            <ul class="dropdown-menu sort-menu">
                [{foreach from=$oView->getSortColumns() item=sColumnName}]
                    <li class="dropdown-option no-submit">
                        <span class="sort-name">[{oxmultilang ident=$sColumnName|upper}]</span>
                        <span class="sort-order">
                            <a data-title="[{oxmultilang ident=$sColumnName|upper}] <i class='glyphicon-arrow-down'></i>" data-selection-id="[{oxmultilang ident=$sColumnName|upper}]desc" href="[{$oView->getLink()|oxaddparams:"ldtype=$_listType&amp;_artperpage=$_artPerPage&amp;$_sortColumnVarName=$sColumnName&amp;$_sortDirectionVarName=desc&amp;pgNr=0&amp;$_additionalParams"}]" [{if $oView->getListOrderDirection() == 'desc' && $sColumnName == $oView->getListOrderBy()}] class="selected"[{/if}]>
                                <i class="glyphicon-arrow-down"></i>
                            </a>
                            <a data-title="[{oxmultilang ident=$sColumnName|upper}] <i class='glyphicon-arrow-up'></i>" data-selection-id="[{oxmultilang ident=$sColumnName|upper}]asc" href="[{$oView->getLink()|oxaddparams:"ldtype=$_listType&amp;_artperpage=$_artPerPage&amp;$_sortColumnVarName=$sColumnName&amp;$_sortDirectionVarName=asc&amp;pgNr=0&amp;$_additionalParams"}]" [{if $oView->getListOrderDirection() == 'asc' && $sColumnName == $oView->getListOrderBy()}] class="selected"[{/if}]>
                                <i class="glyphicon-arrow-up"></i>
                            </a>
                        </span>
                    </li>
                [{/foreach}]
            </ul>
        </div>
    </div>
 [{*}]   
 
 [{assign var="_listType" value=$oView->getListDisplayType()}]
    [{assign var="_additionalParams" value=$oView->getAdditionalParams()}]
    [{assign var="_artPerPage" value=$oViewConf->getArtPerPageCount()}]
    [{assign var="_sortColumnVarName" value=$oView->getSortOrderByParameterName()}]
    [{assign var="_sortDirectionVarName" value=$oView->getSortOrderParameterName()}]
<div class="filter-a">
  <div class="js-nano-filter filter-tgl-btn">
    <div><span>[{oxmultilang ident="SORT_BY"}]</span><span class="glyphicon glyphicon-menu-down"></span><span class="glyphicon glyphicon-menu-up"></span></div>
  </div>
  <div class="filter-container">
    <div class="filter-dropdown">
     
           <ul>
                [{foreach from=$oView->getSortColumns() item=sColumnName}]
                   
                    <li>
                        <span class="sort-name">
                            <a href="[{$oView->getBaseLink()|oxaddparams:"ldtype=$_listType&amp;_artperpage=$_artPerPage&amp;$_sortColumnVarName=$sColumnName&amp;$_sortDirectionVarName=asc&amp;pgNr=0&amp;$_additionalParams"}]" [{if $oView->getListOrderDirection() == 'asc' && $sColumnName == $oView->getListOrderBy()}] class="selected"[{/if}]>
                                [{*oxmultilang ident=$sColumnName|upper*}][{oxmultilang ident="`$sColumnName`DirectionAsc"}] 
                            </a>
                        </span>
                    </li>
                     <li>
                        <span class="sort-name">
                        
                            <a href="[{$oView->getBaseLink()|oxaddparams:"ldtype=$_listType&amp;_artperpage=$_artPerPage&amp;$_sortColumnVarName=$sColumnName&amp;$_sortDirectionVarName=desc&amp;pgNr=0&amp;$_additionalParams"}]" [{if $oView->getListOrderDirection() == 'desc' && $sColumnName == $oView->getListOrderBy()}] class="selected"[{/if}]>
                                [{*oxmultilang ident=$sColumnName|upper*}][{oxmultilang ident="`$sColumnName`DirectionDesc"}]
                                </a>
                           
                        </span>
                    </li>
                [{/foreach}]
            </ul>
       
      
    </div>
  </div>
</div>
  [{oxscript add="$( '.js-nano-filter' ).upZalFilter();"}]
    
[{/if}]

