<style type="text/css">
.up-order-overview-table-td-edittext{
  height:20px;
  padding: 1px 0px 1px 5px;
}

.up-order-overview-table-edittext tr td{
  height:20px;
  padding: 1px 0px 1px 5px;
}
td.splitorder{
  position:relative;
  top: 15px;
  left: -15px;
  height:30px;
}
.button-pos{
  position:absolute;
  width:300px;
}
</style>
<tr> 
      <td valign="top" class="edittext">
        <table cellspacing="0" cellpadding="0" border="0">
            <form action="[{ $oViewConf->getSelfLink() }]" method="post">
              [{ $oViewConf->getHiddenSid() }]
              <input type="hidden" name="cl" value="order_overview">
              <input type="hidden" name="fnc" value="splitorder">
              <input type="hidden" name="oxid" value="[{ $oxid }]">
	            [{foreach from=$orderArticles item=listitem}]
	              <tr>
	               <td valign="top" class="edittext">
	               <input type="checkbox" name="articleRow[[{$listitem->oxorderarticles__oxid->value}]]" value="1" class="listedit">
	              
	             	</td>
	              </tr>
	            [{/foreach}]
                <tr>
                  <td valign="top" class="edittext splitorder">
                  <div class="button-pos">
                    <input type="submit" class="edittext" name="save" style="float:left;" value="Aufteilen">
                    </form> 
                    
                    <form action="[{ $oViewConf->getSelfLink() }]" method="post">
                            [{ $oViewConf->getHiddenSid() }]
                            <input type="hidden" name="cl" value="order_overview">
                            <input type="hidden" name="fnc" value="mergeorders">
                            <input type="hidden" name="oxid" value="[{ $oxid }]">
                            <input type="submit" class="edittext" name="save" style="float:left;" value="Zusammenfuehren">
                    </form> 
                  </div>
                  </td>
                </tr>
            



        </table>
      </td>
      <td valign="top" class="edittext">
        <table cellspacing="0" cellpadding="0" border="0" class="up-order-overview-table-edittext">
          [{$smarty.block.parent}]
         </table>    
      </td>
</tr>

