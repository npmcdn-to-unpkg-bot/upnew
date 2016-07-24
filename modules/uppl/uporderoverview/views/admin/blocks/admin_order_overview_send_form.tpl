<tr>
    <td class="edittext">
    </td>
    <td class="edittext" style="border : 1px #A9A9A9; border-style : solid solid solid solid; padding-top: 5px; padding-bottom: 5px; padding-right: 5px; padding-left: 5px;">
        <input type="submit" class="edittext" name="save" value="&nbsp;&nbsp;[{ oxmultilang ident="GENERAL_NOWSEND" }]&nbsp;&nbsp;" [{ $readonly }]><br>
       
    </td>
</tr>
</form>
<form name="sendorder" id="sendorder" action="[{ $oViewConf->getSelfLink() }]" method="post">
        [{ $oViewConf->getHiddenSid() }]
        <input type="hidden" name="cl" value="order_overview">
        <input type="hidden" name="fnc" value="setsenddate">
        <input type="hidden" name="oxid" value="[{ $oxid }]">
        <input type="hidden" name="editval[oxorder__oxid]" value="[{ $oxid }]">
<tr>
    <td class="edittext">
    </td>
    <td class="edittext" style="border : 1px #A9A9A9; border-style : solid solid solid solid; padding-top: 5px; padding-bottom: 5px; padding-right: 5px; padding-left: 5px;">
        <input type="submit" class="edittext" name="save" value="&nbsp;&nbsp;[{ oxmultilang ident="UPORDEROVERVIEW_SETSENDDATE" }]&nbsp;&nbsp;" [{ $readonly }]><br>
        [{ oxmultilang ident="UPORDEROVERVIEW_FINISHFOLDER" }]<input class="edittext" type="checkbox" name="changefolder" value='1' [{ $readonly }]>
    </td>
</tr>
</form>
<tr>
    <td class="edittext">
    </td>
    <td class="edittext" valign="bottom" style="border : 1px #A9A9A9; border-style : solid solid solid solid; padding-top: 5px; padding-bottom: 5px; padding-right: 5px; padding-left: 5px;"><br>
    [{if $oView->canResetShippingDate() }]
        <b>[{ oxmultilang ident="GENERAL_SENDON" }]</b><b>[{$edit->oxorder__oxsenddate|oxformdate:'datetime':true }]</b>
    [{else}]
        <b>[{ oxmultilang ident="GENERAL_NOSENT" }]</b>
    [{/if}]
    </td>
</tr>
