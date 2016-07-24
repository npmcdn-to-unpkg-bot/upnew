<div class="sportslist">

[{defun name="brand_tree" tree=$oxcmp_categories->getSpecificRoot("b7c2032321ea3854c8e3ccbc20ac64e7") class="sport-teams" }]  
[{strip}]

<ul class="[{$class}]">
 
  
    [{foreach from=$tree item=ocat key=catkey name=$test_catName}]
      
        <li>
            <a href="[{$ocat->getLink()}]" >[{$ocat->oxcategories__oxtitle->value}]</a>
            [{if $ocat->getSubCats()}]
                [{fun name="brand_tree" tree=$ocat->getSubCats() class=$ccnt }]
            [{/if}]
        </li>
        
   
    [{/foreach}]
</ul> 

[{/strip}]
[{/defun}]
 <div class="close-button"><span class="glyphicon glyphicon-menu-up"></span></div>
</div>