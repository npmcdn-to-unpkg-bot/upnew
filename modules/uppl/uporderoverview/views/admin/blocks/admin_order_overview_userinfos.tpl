[{$smarty.block.parent}]

   <br>
   <b>[{ oxmultilang ident="UPORDEROVERVIEW_LANGUAGE" }]:</b> [{if $custlang->id!=0}]<span style="color:white;background:#ff3600;font-size:larger;padding:2px;">[{$custlang->name}]</span>[{else}][{$custlang->name}][{/if}] <br>
   <b>[{ oxmultilang ident="UPORDEROVERVIEW_ACCOUNT" }]:</b> [{if $custaccount}][{ oxmultilang ident="UPORDEROVERVIEW_YES" }][{else}]<span style="color:white;background:red;font-size:larger;padding:2px;">[{ oxmultilang ident="UPORDEROVERVIEW_NO" }]</span>[{/if}] <br>
   <br>
   <br>

<style type="text/css">
.storno td{
	text-decoration: line-through;
}
.paid td{
	color:green;
}
.oxpaddingframe{
	border: 1px #A9A9A9;
	border-style: solid solid solid solid;
	padding-top: 5px;
	padding-bottom: 5px;
	padding-right: 5px;
	padding-left: 5px;
}
.oxpaddingframe th{
	font-weight: bold;
	text-align: left;
}
</style>
<table style="width:100%" class="oxpaddingframe">
	  <tr>
	    <th>[{ oxmultilang ident="UPORDEROVERVIEW_NR" }]</th>
	    <th>[{ oxmultilang ident="UPORDEROVERVIEW_ORDERDATE" }]</th>
	    <th>[{ oxmultilang ident="UPORDEROVERVIEW_ORDERFOLDER" }]</th> 
	    <th>[{ oxmultilang ident="UPORDEROVERVIEW_PAYMENTTYPE" }]</th> 
	    <th>[{ oxmultilang ident="UPORDEROVERVIEW_AMOUNT" }]</th>
	    <th>[{ oxmultilang ident="UPORDEROVERVIEW_SENDDATE" }]</th>
	    <th>[{ oxmultilang ident="UPORDEROVERVIEW_PAIDDATE" }]</td> 
	    <th>[{ oxmultilang ident="UPORDEROVERVIEW_DAYS" }]</th>
	  </tr>
	[{foreach from=$mylist item=listitem}]
	  
	<tr  class="[{ if $listitem->oxorder__oxstorno->value == 1 }]storno[{/if}] [{if $listitem->oxorder__oxpaid->value!="0000-00-00 00:00:00" }]paid[{/if}]">
	    <td>[{ $listitem->oxorder__oxordernr->value }]</td>
	    <td>[{ $listitem->oxorder__oxorderdate->value }]</td> 
	    <td>[{ oxmultilang ident=$listitem->oxorder__oxfolder->value noerror=true }]</td> 
	     <td>[{ $oView->getPaymentName($listitem) }]</td> 
	    
	    <td>[{ $listitem->getFormattedTotalOrderSum() }] [{ $listitem->oxorder__oxcurrency->value}]</td>
	    <td>[{if $listitem->oxorder__oxsenddatereal->value!="0000-00-00 00:00:00" }] [{ $listitem->oxorder__oxsenddatereal->value|date_format:"%d.%m.%Y"}][{else}]-[{/if}]</td>
	    <td>[{if $listitem->oxorder__oxpaid->value!="0000-00-00 00:00:00" }] [{ $listitem->oxorder__oxpaid->value|date_format:"%d.%m.%Y"}][{else}]-[{/if}]</td> 
	    <td>[{ $listitem->paymentDiff()}]</td>
	  </tr>
	[{/foreach}]
</table>





