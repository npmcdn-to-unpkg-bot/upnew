[{$smarty.block.parent}]
[{if $edit && $oView->canExport() }]
    <br>
    <form name="myedit2" id="myedit2" action="[{$oViewConf->getSelfLink() }]" method="post" [{*target="expPDF"*}]>
        [{$oViewConf->getHiddenSid() }]
        <input type="hidden" name="cl" value="order_overview">
        <input type="hidden" name="fnc" value="createPostBarcode">
        <input type="hidden" name="oxid" value="[{$oxid }]">
        <table cellspacing="0" cellpadding="0"
               style="padding-top: 5px; padding-left: 5px; padding-right: 5px; padding-bottom: 5px; border : 1px #A9A9A9; border-style : solid solid solid solid;"
               width="220">

          
           <tr>
                <td valign="top" class="edittext" align="right">
                Eingeschrieben: <input type="checkbox" name="prisi" value="1"><br>
                </td>
              </tr>
            <tr>
                <td align="right" class="edittext"><br/>
                    <input type="submit" class="edittext" name="save"
                           value="Post Barcode">
                    <iframe name="expPDF" width="0" height="0" border="0" style="display:none;"></iframe>
                </td>
            </tr>
            </form>
             [{if $edit->oxorder__oxtrackcode->value}]
              <tr>
             	 <td>
                 [{assign var="trackcodes" value=","|explode:$edit->oxorder__oxtrackcode->value}]
                 [{foreach from=$trackcodes item=trackcode name=tcodes}]
                 [{if $trackcode}]
                 <a href="[{$oViewConf->getModuleUrl('uppl')}]_archive/wsbc/Label_[{$oxid}][{$trackcode}].pdf" target="_blank">[{$trackcode}]</a><br />
                 [{/if}]
                 [{/foreach}]
                 </td>
               </tr>
               
               <tr>
                  <td>
                      
                     
                <form name="myedit2" id="myedit2" action="[{ $shop->selflink }]" method="post">
              [{ $shop->hiddensid }]
              <input type="hidden" name="cl" value="order_overview">
              <input type="hidden" name="fnc" value="removeTrackCode">
              <input type="hidden" name="oxid" value="[{ $oxid }]">
                 [{assign var="trackcodes" value=","|explode:$edit->oxorder__oxtrackcode->value}]
                 <select name="trackcode">
                 [{foreach from=$trackcodes item=trackcode name=tcodes}]
                     [{if $trackcode}]
                        <option value="[{$trackcode}]">[{$trackcode}]</option>
                     [{/if}]
                 [{/foreach}]
                 </select><br />
                    <input type="submit" class="edittext" name="save" value="Entfernen">
                 </form>
                 </td>
              </tr>
              [{/if}]
              
              
             
        </table>
    </form>
   
    [{if $postbarcode_url}]
    <script type="text/javascript">
   
        function pdfdocumentpopup (sParams) {
         var fenster = window.open('[{ $shop->selflink }]'+sParams, "urbanepeople.com", "width=380,height=400,scrollbars=no,resizable=no");
         fenster.focus();
         return false;
        }

       pdfdocumentpopup('[{$oViewConf->getBaseDir()}][{$postbarcode_url}]');
       
    </script>
    [{/if}]
[{/if}]