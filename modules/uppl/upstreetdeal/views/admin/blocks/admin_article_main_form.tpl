[{$smarty.block.parent}]
<tr>
  <td class="edittext" width="120">
    
     <form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post"  style="padding: 0px;margin: 0px;height:0px;">
        [{$oViewConf->getHiddenSid()}]
        <input type="hidden" name="cl" value="article_main">
        <input type="hidden" name="fnc" value="exportstreetdeal">
        <input type="hidden" name="oxid" value="[{ $oxid }]">
        <input type="hidden" name="voxid" value="[{ $oxid }]">
        <input type="hidden" name="editval[oxarticles__oxid]" value="[{ $oxid }]">
      <b><button>Send to Streetdeal</button></b>
      </form>
  </td>
  <td class="edittext">
  </td>
</tr>