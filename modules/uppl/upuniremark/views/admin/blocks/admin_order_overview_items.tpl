  <tr>
      <td valign="top" class="edittext">
      	<table cellspacing="0" cellpadding="0" border="0">
      		[{$smarty.block.parent}]
      	 </table>    
      </td>
      <td valign="top" class="edittext">
	        <table cellspacing="0" cellpadding="0" border="0">
	            [{foreach from=$orderArticles item=listitem}]
	              <tr>
	               <td valign="top" class="edittext">
	                [{ $oViewConf->renderUniremarkButton($listitem->oxorderarticles__oxid->value) }] 
	             	</td>
	              </tr>
	            [{/foreach}]      
          </table>
        </td>
  </tr>
  