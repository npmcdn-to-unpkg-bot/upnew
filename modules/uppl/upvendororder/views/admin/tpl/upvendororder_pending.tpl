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

   
    <h3>Bestellung bearbeiten</h3>
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
                                    <input type="hidden" name="cl" value="upvendororder_pending">
                                    <input type="hidden" name="fnc" value="setfilter">
                                    Lieferant: 
                                </td>
                                <td class="edittext" width="250">                                
                                    [{if !$sfilter.vendor}]
                                    <select class="editinput" name="sfilter[vendor]">                        
                                        [{foreach from=$oView->getVendorList() item=oVendor}]
                                        <option value="[{$oVendor->oxvendor__oxid->value}]" [{if $oVendor->oxvendor__oxid->value == $sfilter.vendor}]selected="selected"[{/if}]>[{ $oVendor->oxvendor__oxtitle->value }]</option>
                                        [{/foreach}]
                                    </select>
                                    [{else}]
                                        <input type="hidden" name="sfilter[vendor]" value="[{$sfilter.vendor}]">!?!?[{* $oViewConf->getRandomOxtitle($sfilter.vendor,"oxvendor") *}]
                                    [{/if}]
                                   <td class="edittext" width="250">
                                      Datum: <input type="text"  name="sfilter[date]" value="[{ if $sfilter.date}][{$sfilter.date}][{else}][{/if}]" [{ if $sfilter.date}]style="background-color: #FEF8CB;
border: 1px solid #DEBE00;"[{/if}]size="10" maxlength="10"> 2012-03-26
                                       		
                                   </td>
                                    <td class="edittext" width="140">
                                   	  Art-Nr.: <input type="text"  name="sfilter[artnum]" value="[{ if $sfilter.artnum}][{$sfilter.artnum}][{else}][{/if}]" [{ if $sfilter.artnum}]style="background-color: #FEF8CB;
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
                                                <input type="hidden" name="cl" value="upvendororder_pending">
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
              
               <tr>
                <td>
                
                  <table width="890" border="0" cellspacing="0" cellpadding="00" class="group">
                  
                   
                      
                      [{foreach from=$vendororders item=order key=k}]
                      <input type="hidden"  name="aOrderArticles[[{$article.OXID}]][oxartnum]" value="[{$article.OXARTNUM}]" />
                      <input type="hidden"  name="aOrderArticles[[{$article.OXID}]][oxtitle]" value="[{$article.OXTITLE}] Grösse: [{$article.OXVARSELECT}]" />
                      <input type="hidden"  name="aOrderArticles[[{$article.OXID}]][oxstock]" value="[{$article.OXSTOCK}]" />
                      <tr>
                       
                    
                         <td class="edittext listing" align="left">[{$order.OXDATE}]&nbsp;&nbsp;&nbsp;&nbsp;</td>
                         <td class="edittext listing"><b>[{$order.OXARTNUM}]</b></td>
                        <td class="edittext listing" align="left">[{*$order.OXARTICLEID*}][{$order.OXTITLE}]</td>
                        <form name="validate" id="search" action="[{ $shop->selflink }]" method="post">
                        [{ $shop->hiddensid }]
                        	<input type="hidden" name="cl" value="upvendororder_pending">
                            <input type="hidden" name="fnc" value="editorder">
                            <input type="hidden" name="orderoxid" value="[{$order.OXID}]">
                            <td class="edittext listing">Bestellt: <input type="text"  name="orderedamount" value="[{$order.OXAMOUNT}]"  size="5"/></td>
                            <td class="edittext listing">Erhalten: <input type="text"  name="receivedamount" value="[{$order.OXAMOUNT}]" size="5" /></td>
                            <td class="edittext listing">[{$order.OXSTATUS}]  <input type="submit" class="edittext inputfb" style="width: 22px;margin-top: 2px;font: bold 11px Tahoma,Arial,sans-serif;" name="save" value="&#8730;" [{ $readonly }]></td>
                        </form>
                        <form name="validate" id="search" action="[{ $shop->selflink }]" method="post">
                         [{ $shop->hiddensid }]
                        	<input type="hidden" name="cl" value="upvendororder_pending">
                            <input type="hidden" name="fnc" value="deleteorder">
                            <input type="hidden" name="orderoxid" value="[{$order.OXID}]">
                            <td class="edittext listing"><input type="submit" class="edittext inputfb" style="width: 22px;margin-top: 2px;font: bold 11px Tahoma,Arial,sans-serif;" name="save" value="×" [{ $readonly }]></td>
                        </form>
                      
                       
                      </tr>
                      [{/foreach}]
                      
                 </table>

                </td>
              </tr>
    		 
            

       
    
     
   
     		
           
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
