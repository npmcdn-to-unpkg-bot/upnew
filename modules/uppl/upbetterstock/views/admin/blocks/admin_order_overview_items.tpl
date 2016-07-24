<style type="text/css">
.up-order-overview-table-td-edittext{
  height:20px;
  padding: 1px 0px 1px 5px;
}

.up-order-overview-table-edittext tr td{
  height:20px;
  padding: 1px 0px 1px 5px;
}
</style>

<tr>
    <td valign="top" >
    	<table cellspacing="0" cellpadding="0" border="0" class="up-order-overview-table-edittext">
    		[{$smarty.block.parent}]
    	 </table>    
    </td>
    <td valign="top" class="edittext">
        <table cellspacing="0" cellpadding="0" border="0">
            [{foreach from=$orderArticles item=listitem}]
              <tr>
               <td valign="top" class="up-order-overview-table-td-edittext" >
               	[{* $listitem->getStockAvailable()*}]
               	  [{assign var='_stock4order' value=$listitem->getStockAvailable()}]
              
               	 <a href="#" title="[{ $listitem->devMethod()}]">
                 [{if $_stock4order >= 0}]<span style="color:green;">Lieferbar</span>[{elseif $_stock4order < 0 && $listitem->getStockInShelf() >0}]<span style="color:orange;">Teilweise Lieferbar</span>[{elseif $_stock4order < 0}]<span style="color:red;">Nicht Lieferbar</span>[{/if}]
                  </a>
             	</td>
              </tr>
            [{/foreach}]      
        </table>
      </td>
</tr>
  