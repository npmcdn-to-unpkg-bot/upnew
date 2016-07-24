[{strip}]
[{assign var="iManufacturerLimit" value="5"}]
[{assign var="i" value=-1}]
[{assign var="manufacturers" value=$oView->getFlaggedManufacturerList()}]
[{if $manufacturers|count}]
    [{block name="up_manufacturers"}]
        <div class="manufacturer-alphalist">
             <ul>
            [{foreach from=$manufacturers item=_mnf name=manufacturers}]
                   
                   [{if $_mnf->getFirstLetter()}]
                        [{assign var="i" value=$i+1}]
                       [{if ($i % $iManufacturerLimit) == 0 && $i !=0}]</ul><ul>[{/if}]
                       <li class="firstletter">[{$_mnf->getFirstLetter()}]</li>
                      
                    [{/if}]
                   
                    <li><a href="[{$_mnf->getLink()}]" [{if $_mnf->expanded}]class="exp"[{/if}]>[{$_mnf->oxmanufacturers__oxtitle->value}]</a></li>
            [{/foreach}] 
            </ul>
            <div class="close-button"><span class="glyphicon glyphicon-menu-up"></span></div>
        </div>
       
    [{/block}]
[{/if}]
[{/strip}]