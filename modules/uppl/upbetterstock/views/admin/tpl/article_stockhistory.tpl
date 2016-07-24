[{include file="up_headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" value="[{ $oxid }]">
    <input type="hidden" name="cl" value="upbetterstockarticle_stockhistory">
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
</form>



<div class="col-lg-12">
    [{if $showvariants}]
        [{if !$edit->isParentNotBuyable() }]
        <a href="Javascript:top.oxid.admin.editThis('[{ $parentarticle->oxarticles__oxid->value}]');" class="btn btn-default btn-block" role="button">Vaterartikel</a>
        [{/if}]<br>
        <ul class="nav nav-tabs nav-justified">
            [{foreach from=$mylist item=listitem}]
              <li role="presentation" [{if $listitem->oxarticles__oxid->value==$edit->oxarticles__oxid->value}]class="active"[{/if}]>
                <a href="Javascript:top.oxid.admin.editThis('[{ $listitem->oxarticles__oxid->value}]');">[{$listitem->oxarticles__oxvarselect->value}]</a>
              </li>
            [{/foreach}]
        </ul>
    [{/if}]<br>
</div>
<div class="col-lg-4 ">
[{if !$edit->isParentNotBuyable() }]

<form class="form">
    [{$oViewConf->getHiddenSid()}]
  <input type="hidden" name="oxid" value="[{$oxid}]">
  <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]">
  <input type="hidden" name="fnc" value="save">
  <input type="hidden" name="actshop" value="[{ $oViewConf->getActiveShopId() }]">

  <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
    
	<input type="hidden" class="editinput" size="32"   name="editval[oxid]" value="[{$edit->oxarticles__oxid->value}]">
  	<input type="hidden" class="editinput" size="32"  name="editval[oxparentid]" value="[{$edit->oxarticles__oxparentid->value}]">

  		<h4>Artikel: [{$edit->oxarticles__oxartnum->value}]</h4>
  		<div>[{$edit->devMethod()}]</div>
        <div class="form-group ">
            <label for="editval[oxstock]">Bestand</label>
            	<div class="row">
                	<div class="col-md-5">
                       <select name="editval[plusminus]" class="form-control" [{ $readonly }]>
                          <option value="" >+</option>
                          <option value="-" >-</option>                            
                    	</select>
                	</div>
                	<div class="col-md-7">
                  		<input type="text"  class="form-control" size="12" maxlength="[{$edit->oxarticles__oxstock->fldmax_length}]" name="editval[stock]" >
                  	</div>
                </div>                           
        </div>

        <div class="form-group">
            <label for="editval[oxbprice]">Einkaufspreis</label>
            <input type="text" class="form-control" size="20" name="editval[oxbprice]" placeholder="[{$edit->oxarticles__oxbprice->value}]">
        </div>
			<div class="form-group ">
				<label for="editval[type]">Typ</label>
				<select name="editval[type]"  class="form-control" > 
                  <option value="unassigned" selected="selected" >Undefiniert</option>
                  <option value="promo" >Promo</option>
                  <option value="defekt" >Defekt</option>
                  <option value="korrektur" >Korrektur</option>
                  <option value="lieferant_lieferung" >Lieferung von Lieferant</option>
                  <option value="retoure_von_handel" >Retoure von Handel</option>
                  <option value="retoure_an_lieferanten" >Retoure an Lieferant</option>
                </select>
			</div>

			<div class="form-group">
				 <label for="editval[oxarticles__oxvendorid]">Lieferant</label>
				 <select class="form-control" name="editval[oxvendorid]" [{ $readonly }]>
                        <option value="" selected>---</option>
                        [{foreach from=$oView->getVendorList() item=oVendor}]
                        <option value="[{$oVendor->oxvendor__oxid->value}]"[{if $parentarticle->oxarticles__oxvendorid->value == $oVendor->oxvendor__oxid->value}] selected[{/if}]>[{ $oVendor->oxvendor__oxtitle->value }]</option>
                        [{/foreach}]
                  </select>
			</div>
			<div class="form-group">
            <label for="editval[note]">Notiz</label>
            <input type="text" class="form-control" size="32" maxlength="499" name="editval[note]">
         </div>

        <input type="submit" class="btn btn-default" name="save" value="[{ oxmultilang ident="GENERAL_SAVE" }]" onClick="Javascript:document.myedit.fnc.value='save'">
</form>		
[{/if}]         
        
</div>

<div class="col-lg-8">
    [{if $oView->stockhistorylist()}]
     <table cellspacing="0" cellpadding="0" border="0" width="100%"  class="table">
                <colgroup>
                    <col width="20%">
                    <col width="10%">
                    <col width="10%">
                    <col width="20%">
                    <col width="20%">
                    <col width="40%">
                   
                </colgroup>
                <tr>
                   <th>&nbsp;Datum</th>
                    <th>Bestand</th>
                    <th>EK-Preis</th>
                    <th>Lieferant</th>
                    <th>Typ</th>
                    <th>Notiz</th>
                    
                </tr>
        
        	[{assign var="blWhite" value=""}]
            [{assign var="_cnt" value=0}]
          	[{foreach from=$oView->stockhistorylist() item=order}]
                [{assign var="_cnt" value=$_cnt+1}]
                <tr id="row.[{$_cnt}]" onclick="JavaScript:popuporder('&amp;cl=order_overview&amp;aoc=1&amp;oxid=[{$order.oxid}]');">
            
                    [{ if $listitem->blacklist == 1}]
                        [{assign var="listclass" value=listitem3 }]
                    [{ else}]
                        [{assign var="listclass" value=listitem$blWhite }]
                    [{ /if}]
                    [{ if $listitem->oxarticles__oxid->value == $oxid }]
                        [{assign var="listclass" value=listitem4 }]
                    [{ /if}]
                    <td valign="top" class="[{ $listclass}]" height="15">[{$order.DATE}]</td>
                    <td valign="top" class="[{ $listclass}]">[{$order.STOCK}]</td>
                    <td valign="top" class="[{ $listclass}]" height="15">[{$order.EKPRICE}]</td>
                    <td valign="top" class="[{ $listclass}]">[{* $oViewConf->getRandomOxtitle($order.LIEFERANT_FK, "oxvendor") *}]</td>
                    <td valign="top" class="[{ $listclass}]">[{$order.TYPE}]</td>
              		<td valign="top" class="[{ $listclass}]">[{$order.NOTE}]</td>
            	</tr>
            
            [{if $blWhite == "2"}]
            [{assign var="blWhite" value=""}]
            [{else}]
            [{assign var="blWhite" value="2"}]
            [{/if}]
            [{/foreach}]
            
            </table>
	[{else}]
-
	[{/if}]
    
</div>

[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]
