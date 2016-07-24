[{oxscript include="js/widgets/oxdropdown.js" priority=10 }]
[{assign var="oSelections" value=$oSelectionList->getSelections()}]
[{assign var="oActiveSelection" value=$oSelectionList->getActiveSelection()}]
[{if $oSelections}]
    <div class="dropdown">
            
        [{if $editable !== false}]
            <input type="hidden" name="[{$sFieldName|default:"varselid"}][[{$iKey}]]" value="[{if $oActiveSelection }][{$oActiveSelection->getValue()}][{/if}]">
            <ul class="varboxes [{$sSelType|default:"vardrop"}]" role="menu" aria-labelledby="dLabelSelectBox_[{$sFieldName|default:"varselid"}]_[{$iKey}]">
                [{if $oActiveSelection && !$blHideDefault}]
                    [{*<li class="dropdown-option"><a tabindex="-1" data-selection-id="" href="#">
                            [{$oSelectionList->getLabel()}] [{if $sFieldName == "sel"}][{oxmultilang ident="PLEASE_CHOOSE"}][{else}][{oxmultilang ident="CHOOSE_VARIANT"}][{/if}]
                    </a></li> *}]
                [{/if}]
                [{foreach from=$oSelections item=oSelection}]
                    <li class="dropdown-option [{if $oSelection->isDisabled()}]js-disabled disabled[{/if}] [{if $oActiveSelection }][{if $oSelection->getValue() == $oActiveSelection->getValue()}]selected[{/if}][{/if}]">
                        <a tabindex="-1" data-selection-id="[{$oSelection->getValue()}]" href="#">[{$oSelection->getName()}]</a>
                    </li>
                [{/foreach}]
            </ul>
        [{/if}]
    </div>
  
[{else}]
    <a href="[{$_productLink}]" class="product-variants-message">
        [{if $sFieldName == "sel" }]
            [{oxmultilang ident="PLEASE_CHOOSE"}]
        [{else}]
            [{oxmultilang ident="CHOOSE_VARIANT"}]
        [{/if}]
    </a>
[{/if}] 