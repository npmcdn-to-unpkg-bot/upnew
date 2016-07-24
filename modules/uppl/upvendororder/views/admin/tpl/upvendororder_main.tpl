[{include file="headitem.tpl" title="ORDER_PACKAGE_TITLE"|oxmultilangassign box=" "}]
<style type="text/css">
.listing{
	background-color: #FAFAFA;
	border-bottom: 1px solid white;
}

.inputfb{
	background-image: url(https://s-static.ak.facebook.com/rsrc.php/v1/yT/r/Ami4lrB-c2A.png);
	background-repeat: no-repeat;
	background-position: 0 -98px;
	background-color: #EEE;
	border: 1px solid #999;
	border-bottom-color: #888;
	height:22px;
	-webkit-box-shadow: 0 1px 0 rgba(0, 0, 0, .1);
	cursor: pointer;
	display: inline-block;
	font-size: 11px;
	font-weight: bold;
	line-height: 13px;
	padding: 2px 6px;
	text-align: center;
	text-decoration: none;
	vertical-align: top;
	white-space: nowrap;
	border-image: initial;
}
.inputfb:hover{
	
	background-position: 0 -104px;
	
}


.message{
	background-color: #FEF8CB;
	border: 1px solid #DEBE00;
	padding: 2px;
	margin: 10px;
	margin-left:5px;
	float:left;
	-webkit-box-shadow: 0 1px 0 rgba(0, 0, 0, .1);
	
}

.group{
	border: 1px solid #999;
	border-bottom-color: #888;
	padding:5px 5px;
	border-radius:5px;
}
</style>

[{ if $readonly }]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]





<div id="genimportpage">
    <form name="transfer" id="transfer" action="[{ $shop->selflink }]" method="post">
        [{ $shop->hiddensid }]
        <input type="hidden" name="oxid" value="1">
        <input type="hidden" name="cl" value="">
    </form>

   
    <h3>Lieferantenbestellung</h3>
    [{if $Errors.v11}]
    <div class="errorbox">
        [{foreach from=$Errors.v11 item=oEr key=key }]
            <p>[{ $oEr->getOxMessage()}]</p>
        [{/foreach}]
    </div>
    <br>
   [{/if}]


    <table border="0" cellpadding="2" cellspacing="10" width="890">
 
 
 			<tr>
            	<td>
            		
                            <table border="0" cellspacing="0" cellpadding="00" width="890" class="group">
                            <tr>
                                <td class="edittext" width="90">
                                <form name="myedit" id="myedit" method="post" action="[{ $shop->selflink }]">
                                    [{ $shop->hiddensid }]
                                    <input type="hidden" name="cl" value="upvendororder_main">
                                    <input type="hidden" name="fnc" value="setfilter">
                                    Lieferant: 
                                </td>
                                <td class="edittext" width="250">                                
                                   
                                    <select class="editinput" name="sfilter[vendor]">                        
                                        [{foreach from=$oView->getVendorList() item=oVendor}]
                                        <option value="[{$oVendor->oxvendor__oxid->value}]" [{if $oVendor->oxvendor__oxid->value == $sfilter.vendor}]selected="selected"[{/if}]>[{ $oVendor->oxvendor__oxtitle->value }]</option>
                                        [{/foreach}]
                                    </select>
                                    [{if 0}] [{if !$sfilter.vendor}][{else}]
                                        <input type="hidden" name="sfilter[vendor]" value="[{$sfilter.vendor}]">[{* $oViewConf->getRandomOxtitle($sfilter.vendor,"oxvendor") *}]
                                    [{/if}][{/if}]
                                   <td class="edittext" width="250">
                                       Lagerbestand von<input type="text" name="sfilter[from]" value="[{ if $sfilter.from}][{$sfilter.from}][{else}]-1000[{/if}]" size="6">
                                       bis <input type="text" name="sfilter[to]" value="[{ if $sfilter.to}][{$sfilter.to}][{else}]0[{/if}]" size="6">
                                   </td>
                                    <td class="edittext" width="140">
                                   	   Keyword: <input type="text" onfocus="this.value='';" name="sfilter[keyword]" value="[{ if $sfilter.keyword}][{$sfilter.keyword}][{else}][{/if}]" [{ if $sfilter.keyword}]style="background-color: #FEF8CB;
border: 1px solid #DEBE00;"[{/if}]size="10" maxlength="10">
                                   </td> 
                                   <td width="100">
                                     <input type="submit" class="edittext inputfb" style="width: 100px;" name="save" value="Anzeigen" [{ $readonly }]>
                                  </form>
                                    
                               
                                    </td>
                                    <td width="60" align="right">
                
                                    <form name="search" id="search" action="[{ $shop->selflink }]" method="post">
                                                [{ $shop->hiddensid }]
                                                <input type="hidden" name="cur" value="[{ $oCurr->id }]">
                                                <input type="hidden" name="cl" value="upvendororder_main">
                                                <input type="hidden" name="oxid" value="[{ $oxid }]">
                                                <input type="hidden" name="fnc" value="resetfilter">
                                                <input type="submit" class="edittext inputfb" name="save" style="width:50px;" value="Reset" [{ $readonly }]>
                                    </form>
                                    </td>
                           
                                <tr>
                          </table>
                          
                </td>
              </tr>
 
 
	 [{ if $vendorselected}]
              <tr>
                <td>
               <span class="message">[{$count_dbquerylist}] Artikel in der entsprechenden Suche</span>
 				</td>
              </tr>
              
              <form name="search" id="search" action="[{ $shop->selflink }]" method="post">
                [{ $shop->hiddensid }]
                <input type="hidden" name="cur" value="[{ $oCurr->id }]">
                <input type="hidden" name="cl" value="upvendororder_main">
                <input type="hidden" name="oxid" value="[{ $oxid }]">
                <input type="hidden" name="fnc" value="setVendororderlist">
    
    
              
               <tr>
                <td>
                
                  <table width="890" border="0" cellspacing="0" cellpadding="00" class="group">
                  
                      <tr>
                        <th width="20">&nbsp;</td>
                        <th width="100" class="edittext">Art. Nr.</td>
                        <th width="500" class="edittext" align="left">Titel</td>
                        <th width="50" class="edittext" align="right">Bestellt</td>
                        <th width="50" class="edittext" align="right">Lager</td>
                        <th width="100" class="edittext" align="right">Bestellung</td>
                        <th width="70">&nbsp;</td>
                      </tr>
                      
                      [{foreach from=$dbquerylist item=article key=k}]
                      <input type="hidden"  name="aOrderArticles[[{$article.OXID}]][oxartnum]" value="[{$article.OXARTNUM}]" />
                      <input type="hidden"  name="aOrderArticles[[{$article.OXID}]][oxtitle]" value="[{$article.OXTITLE}] [{if $article.OXVARSELECT != ""}]Size: [{$article.OXVARSELECT}][{/if}]" />
                      <input type="hidden"  name="aOrderArticles[[{$article.OXID}]][oxstock]" value="[{$article.OXSTOCK}]" />
                      <tr>
                        <td><input type="checkbox" name="aOrderArticles[[{$article.OXID}]][oxonlist]" value="1" checked = "checked"  [{if $oView->checkduplic($article.OXID)}]disabled="disabled" [{/if}]/></td>
                        <td class="edittext listing">[{$article.OXARTNUM}]</td>
                        <td class="edittext listing">[{$article.OXTITLE}] [{if $article.OXVARSELECT != ""}] Size: [{$article.OXVARSELECT}] [{/if}]</td>
                        <td class="edittext listing" align="right">[{$oView->getVendorOrderedAmount($article.OXID) }]</td>
                        <td class="edittext listing" align="right">[{$article.OXSTOCK}]</td>
                        <td class="edittext listing" align="right"><input type="text"  name="aOrderArticles[[{$article.OXID}]][orderamount]" size="6" value="[{$article.ORDERAMOUNT}]" /></td>
                        <td class="edittext listing" align="center">[{if $oView->checkduplic($article.OXID)}]&#10003;[{/if}]</td>
                      </tr>
                      [{/foreach}]
                      
                 </table>

                  
                   
                    
                    
                </td>
              </tr>
    		 
             <tr>
                <td>
               		<input type="submit" class="edittext inputfb" name="save" value="Add to list" [{ $readonly }]>
        		</td>
           	</tr> 
                
            </form>
       
    
     
     [{else}]
     		<tr>
                <td class="edittext" >
                 Keine Auswahl
        		</td>
           </tr>
           
           [{if $remainingvendors}]
           
           
           <tr>
                <td class="edittext" >
                <span class="message" style="padding:10px;">
                 <h3>Bei folgenden Lieferanten m&uuml;ssen Artikel bestellt werden:</h3>
                [{foreach from=$remainingvendors item=vendor key=k}]
                	[{$vendor.OXTITLE}]<br />
                [{/foreach}]
                </span>
        		</td>
           </tr>
           
           
           [{/if}]
           
	[{/if}]
			
            
			
           
           
      [{if $count_vlist > 0}]
      		<tr>
                <td class="edittext" >&nbsp;
                 
        		</td>
           </tr>  
           <tr>
                <td>
                 <table width="890" border="0" cellspacing="0" cellpadding="00">              
                         <tr>
                             <td  class="edittext" width="790">
                             <h3>Bestellung f&uuml;r [{* $oViewConf->getRandomOxtitle($vendorselected,"oxvendor") *}] ([{$count_vlist}] Artikel)</h3>
                             </td>
                             <td class="edittext" width="100" align="right">
                             <form name="search" id="search" action="[{ $shop->selflink }]" method="post">
                                [{ $shop->hiddensid }]
                                <input type="hidden" name="cur" value="[{ $oCurr->id }]">
                                <input type="hidden" name="cl" value="upvendororder_main">
                                <input type="hidden" name="oxid" value="[{ $oxid }]">
                                <input type="hidden" name="fnc" value="unsetvlist">
                                <input type="submit" class="edittext inputfb" name="save" value="Delete List" [{ $readonly }]>
                             </form>
                            </td>
                        </tr>
                </table>
           </tr>
           <tr>
                <td>
                 
                

                   <table width="890" border="0" cellspacing="0" cellpadding="00" class="group">
                                     
                      <tr>
                        <th width="20">&nbsp;</td>
                        <th width="100" class="edittext">Art. Nr.</td>
                        <th width="500" class="edittext" align="left">Titel</td>
                        <th width="100" class="edittext" align="right">Lager</td>
                        <th width="100" class="edittext" align="right">Bestellung</td>
                        <th width="70">&nbsp;</td>
                      </tr>
                      
                      
                     
                      
                      [{foreach from=$vlist item=article key=k}]   
                      <tr>
                        <td class="listing">&nbsp;</td>
                        <td class="edittext listing">[{$article.oxartnum}]</td>
                        <td class="edittext listing">[{$article.oxtitle}]</td>
                        <td class="edittext listing" align="right">[{$article.oxstock}]</td>
                        <td class="edittext listing" align="right">[{$article.orderamount}]</td>
                        <td class="edittext listing" align="center"><form name="search" id="search" action="[{ $shop->selflink }]" method="post">
                            [{ $shop->hiddensid }]
                            <input type="hidden" name="cur" value="[{ $oCurr->id }]">
                            <input type="hidden" name="cl" value="upvendororder_main">
                            <input type="hidden" name="oxid" value="[{ $oxid }]">
                            <input type="hidden" name="fnc" value="unsetvlistelement">
                            <input type="hidden" name="vlistkey" value="[{$k}]">
                            <input type="submit" class="edittext inputfb" style="width: 22px;margin-top: 2px;font: bold 11px Tahoma,Arial,sans-serif;" name="save" value="×" [{ $readonly }]>
                    	</form></td>
                      </tr>
                      [{/foreach}]
                      
                 </table>

                  
                  
        		</td>
           </tr>
           <tr>
                <td class="edittext" >&nbsp;
                 
        		</td>
           </tr>
           <tr>
                <td>
                [{if $vextends}]
                        <table border="0" cellspacing="0" cellpadding="00" width="390" class="group">
                                 <tr>
                                    <td class="edittext" width="400">
                                    <b>[{* $oViewConf->getRandomOxtitle($vendorselected,"oxvendor") *}]</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="edittext" width="400">
                                    [{$vextends.0.OXFNAME}] [{$vextends.0.OXLNAME}]
                                    </td>
                                </tr>
                                 <tr>
                                    <td class="edittext" width="400">
                                   <a href="[{$vextends.0.OXEMAIL}]">[{$vextends.0.OXEMAIL}]</a>
                                    </td>
                                </tr>
                                 <tr>
                                    <td class="edittext" width="400">
                                    [{$vextends.0.OXSTREET}] [{$vextends.0.OXSTREETNR}]
                                    </td>
                                </tr>
                                 <tr>
                                    <td class="edittext" width="400">
                                    CH - [{$vextends.0.OXZIP}] [{$vextends.0.OXCITY}]
                                    </td>
                                </tr>
                        </table>                              
                [{else}]
                	Keine Angaben zum Lieferant, es kann keine Bestellung erstellt werden.
                [{/if}]
                 
        		</td>
           </tr>
           
           [{if $vextends}]   
           <tr>
                <td>
                
                
                <table border="0" cellspacing="0" cellpadding="00" width="890" class="group">
                            <tr>
                                <td class="edittext" >
                                 <form name="search" id="search" action="[{ $shop->selflink }]" method="post">
                                    [{ $shop->hiddensid }]
                                    <input type="hidden" name="cl" value="upvendororder_main">
                                    Erwartetes Lieferdatum:
                                    <input type="text" class="editinput" size="20" maxlength="10" value="31-12-2011" name="deliverydate" value=""> <small>31-05-2012</small>  
                                    <input type="hidden" name="oxid" value="[{ $oxid }]">
                                    <input type="hidden" name="fnc" value="createVPDF">
                                    <input type="hidden" name="vendoroxid" value="[{$sfilter.vendor}]">
                                    <input type="hidden" name="pdftype" value="vorder"><!-- CASE muss in myorder.php pdf modul hinzugefügt werden-->
                            
                                    <input type="submit" class="edittext inputfb" name="save" value="Artikel bestellen" [{ $readonly }]>
                                </form>
                                    </td>
                           
                                <tr>
                          </table>
                
                
       
                
        		</td>
           </tr>
           [{/if}]
                
                
         [{/if}]

 </table>

 

</div>


<script type="text/javascript">
if (parent.parent)
{   parent.parent.sShopTitle   = "[{$actshopobj->oxshops__oxname->getRawValue()|oxaddslashes}]";
    parent.parent.sMenuItem    = "[{ oxmultilang ident="ORDER_PACKAGE_MENUITEM" }]";
    parent.parent.sMenuSubItem = "[{ oxmultilang ident="ORDER_PACKAGE_MENUSUBITEM" }]";
    parent.parent.sWorkArea    = "[{$_act}]";
    parent.parent.setTitle();
}
</script>
</body>
</html>
