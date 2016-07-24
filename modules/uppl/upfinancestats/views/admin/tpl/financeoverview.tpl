<!DOCTYPE html>
<html lang="de">
    <head>
        <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">
        <link href="//netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="[{$oViewConf->getModuleUrl('eins_shopseopack')}]out/admin/src/css/eins_shopseopack.css?v=1.0.0&t=[{$smarty.now}]" />
        <link href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.1/css/bootstrap-datepicker3.standalone.min.css" rel="stylesheet">
        
    
    
        <script type="text/javascript" src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <script type="text/javascript" src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="//cdn.datatables.net/1.10.0/js/jquery.dataTables.min.js"></script>
        
         <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.1/js/bootstrap-datepicker.js"></script>
        
        <script type="text/javascript" src="[{$oViewConf->getModuleUrl('eins_shopseopack')}]out/admin/src/js/eins_shopseopack.js"></script>
    </head>
    <body >

<style type="text/css">

.financestats-table{
    width:100%;
	background-color: #FAFAFA;
	border-bottom: 1px solid white;
}
.uppl-customadmin-fullpage{
    padding:30px;
    width:50%;
}

</style>

[{ if $readonly }]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]

<script type="text/javascript">
function popuporder (sParams) {
 fenster = window.open('[{ $shop->selflink }]'+sParams, "Popupfenster", "width=1010,height=580,scrollbars=no,resizable=no");
 

 fenster.focus();
 return false;
}
</script>




<div class="uppl-customadmin-fullpage">
    <form name="transfer" id="transfer" action="[{ $shop->selflink }]" method="post">
        [{ $shop->hiddensid }]
        <input type="hidden" name="oxid" value="1">
        <input type="hidden" name="cl" value="">
    </form>

   
    <h3>Finance Stats</h3>
    [{if $Errors.v11}]
    <div class="errorbox">
        [{foreach from=$Errors.v11 item=oEr key=key }]
            <p>[{ $oEr->getOxMessage()}]</p>
        [{/foreach}]
    </div>
    <br>
   [{/if}]

<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" value="[{ $oxid }]">
    <input type="hidden" name="cl" value="upfinancestatsfinanceoverview">
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
</form>


 		<table border="0" cellspacing="0" cellpadding="00" width="100%" class="group">
                            <tr>
                                
                                <form name="myedit" id="myedit" method="post" action="[{$oViewConf->getSelfLink()}]">
                                    [{$oViewConf->getHiddenSid()}]
                                    <input type="hidden" name="cl" value="upfinancestatsfinanceoverview">
                                    <input type="hidden" name="fnc" value="setfilter">
                                    <input type="hidden" name="page" value="[{$page}]">
                        
                                   
                                   <td class="edittext" width="350">
                                      
                                    <table class="table">
                                            <thead>
                                              <tr>
                                                <th>Datum von: <input type="text" class="span2" name="sfilter[from]" value="[{ if $sfilter.from}][{$sfilter.from}][{else}][{$today}][{/if}]"  id="dpd1"></th>
                                                <th>bis: <input type="text" class="span2" name="sfilter[to]" value="[{ if $sfilter.to}][{$sfilter.to}][{else}][{$today}][{/if}]" id="dpd2"></th>
                                              </tr>
                                            </thead>
                                    </table>
                                   </td>
                                    <td class="edittext" width="1">
                                   	  <input type="hidden" onfocus="this.value='';" name="sfilter[minorder]" value="[{if $sfilter.minorder}][{$sfilter.minorder}][{else}]13007[{/if}]" [{ if $sfilter.keyword}]style="background-color: #FEF8CB;
border: 1px solid #DEBE00;"[{/if}]size="10" maxlength="10">
                                   </td> 
                                   <td width="100">
                                     <input type="submit" class="edittext inputfb" style="width: 100px;" name="save" value="Anzeigen" [{ $readonly }]>
                                  
                                    </form>
                               
                                    </td>
                                    <td width="60" align="right">
              
                                    </td>
                           
                             <tr>
        </table>
  <br><br>
            

                [{*  <a href="[{ $shop->selflink }]&page=1&cl=wws_financestats">�bersicht</a>&nbsp;&nbsp;<a href="[{$oViewConf->getSelfLink()}]page=3&cl=upfinancestatsfinanceoverview">Grafiken</a> *}]
         
        
          
            [{if $page == 1 }]
		            
                    <table border="0" cellpadding="1" cellspacing="10"  class="financestats-table table">
                        <tr>
                            <td colspan="4"><h4>Eingegange Bestellungen</h4></td>                    
                        </tr>
                        <tr>
                            <td>Kundenbestellungen:</td>
                            <td align="right">[{$allcleaned_ordersum|number_format:2:".":"'"}] CHF</td>
                            <td align="right">Anzahl:</td>
                            <td align="right">[{$allcleaned_totalcount}]</td>
                        </tr>
                        <tr>
                            <td>Barverkauf:</td>
                            <td align="right">[{$shopadmin_ordersum|number_format:2:".":"'"}] CHF</td>
                            <td align="right">Anzahl:</td>
                            <td align="right">[{$shopadmin_totalcount}]</td>
                        </tr>
                         <tr>
                            <td><b>Total Urbanpeople.com:</b></td>
                            <td align="right"><b>[{$shopall_ordersum|number_format:2:".":"'"}] CHF</b></td>
                            <td align="right"><b>Anzahl:</b></td>
                            <td align="right"><b>[{$shopall_totalcount}]</b></td>
                        </tr>
                        
                        <tr>
                            <td colspan="4"></td>
                        </tr>
                        <tr>
                            <td>Alter Shop Haendler:</td>
                            <td align="right">[{$haendler_ordersum|number_format:2:".":"'"}] CHF</td>
                            <td align="right">Anzahl:</td>
                            <td align="right">[{$haendler_totalcount}]</td>
                        </tr>
                         <tr>
                            <td colspan="4"></td>
                        </tr>

                        <tr>
                            <td><b>Total:</b></td>
                            <td align="right"><b>[{$all_ordersum|number_format:2:".":"'"}] CHF</b></td>
                            <td align="right"><b>Anzahl:</b></td>
                            <td align="right"><b>[{$all_totalcount}]</b></td>
                        </tr>
                        
                    </table>
           
                    <table border="0" cellpadding="1" cellspacing="10"  class="financestats-table table">
                        <tr>
                            <td colspan="4"><h4>Versendete Bestellungen</h4></td>                    
                        </tr>
                        <tr>
                            <td>Kundenbestellungen:</td>
                            <td align="right">[{$allcleaned_ordersum_sent|number_format:2:".":"'"}] CHF</td>
                            <td align="right">Anzahl:</td>
                            <td align="right">[{$allcleaned_totalcount_sent}]</td>
                        </tr>
                        <tr>
                            <td>Barverkauf:</td>
                            <td align="right">[{$shopadmin_ordersum_sent|number_format:2:".":"'"}] CHF</td>
                            <td align="right">Anzahl:</td>
                            <td align="right">[{$shopadmin_totalcount_sent}]</td>
                        </tr>
                         <tr>
                            <td><b>Total Urbanpeople.com:</b></td>
                            <td align="right"><b>[{$shopall_ordersum_sent|number_format:2:".":"'"}] CHF</b></td>
                            <td align="right"><b>Anzahl:</b></td>
                            <td align="right"><b>[{$shopall_totalcount_sent}]</b></td>
                        </tr>
                        
                        <tr>
                            <td colspan="4"></td>
                        </tr>
                        <tr>
                            <td>Alter Shop Haendler:</td>
                            <td align="right">[{$haendler_ordersum_sent|number_format:2:".":"'"}] CHF</td>
                            <td align="right">Anzahl:</td>
                            <td align="right">[{$haendler_totalcount_sent}]</td>
                        </tr>
                         <tr>
                            <td colspan="4"></td>
                        </tr>

                        <tr>
                            <td><b>Total:</b></td>
                            <td align="right"><b>[{$all_ordersum_sent|number_format:2:".":"'"}] CHF</b></td>
                            <td align="right"><b>Anzahl:</b></td>
                            <td align="right"><b>[{$all_totalcount_sent}]</b></td>
                        </tr>
                        
                        
                    </table>
                  
            
                     
                    <table border="0" cellpadding="1" cellspacing="10"  class="financestats-table table">
                        <colgroup>
                            <col width="60">
                            <col width="100">
                        </colgroup>
                        <tr>
                            <td colspan="2"><h4>Zahlungen</h4></td>                    
                        </tr>
                        <tr>
                            <td><b>Alle:</b></td>
                            <td align="right"><b>[{$paid_all|number_format:2:".":"'"}] CHF</b></td>
                        </tr>
                        <tr>
                            <td>Rechnung:</td><td align="right">[{$paid_esr|number_format:2:".":"'"}] CHF</td>
                        </tr>
                        <tr>
                            <td>Nachnahme:</td><td align="right">[{$paid_nachnahme|number_format:2:".":"'"}] CHF</td>
                        </tr>
                        <tr>
                            <td>Vorauskasse:</td><td align="right">[{$paid_voraus|number_format:2:".":"'"}] CHF</td>
                        </tr>
                        <tr>
                            <td>Paypal:</td><td align="right">[{$paid_paypal|number_format:2:".":"'"}] CHF</td>
                        </tr>
                        <tr>
                            <td>Postfinance:</td><td align="right">[{$paid_postfinance|number_format:2:".":"'"}] CHF</td>
                        </tr>
                        <tr>
                            <td>Kreditkarte Online:</td><td align="right">[{$paid_creditcard|number_format:2:".":"'"}] CHF</td>
                        </tr>
                        <tr>
                            <td>Bezahlt bei Abholung:</td><td align="right">[{$paid_pickup|number_format:2:".":"'"}] CHF</td>
                        </tr>
                        
                    </table>
            [{/if}]
            
            
          
     		
            [{if $page == 3}]
            <tr>
            	<td class="group" align="center">
                <h3>Eingegangene Bestellungen</h3>
							<script type="text/javascript" src="https://www.google.com/jsapi"></script>
							<script type="text/javascript">
                              google.load('visualization', '1', {packages: ['corechart']});
                            </script>
                            <script type="text/javascript">
                              function drawVisualization() {
                                // Some raw data (not necessarily accurate)
                                var data = google.visualization.arrayToDataTable([
                                  ['Tag', 'Privat'],
								  [{foreach from=$day_sum item=day key=k}]
                                  ['[{$day.datum}]', [{$day.privat_sum}] ],
                                  [{/foreach}]
								
                                ]);
                        
                                var options = {
                                  vAxis: {title: "Betrag"},
                                  hAxis: {title: "Tage"},
                                  seriesType: "bars",
                                  series: {2: {type: "line"}}
                                };
                        
                               [{*}] var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
                                chart.draw(data, options);[{*}]
								
								
								var options2 = {
											  vAxis: {title: "Betrag"},
											  hAxis: {title: 'Tage'}
											};
								var chart2 = new google.visualization.AreaChart(document.getElementById('chart2_div'));
        						chart2.draw(data, options2);
                              }
                              google.setOnLoadCallback(drawVisualization);
                            </script>
                            [{*}]<div id="chart_div" style="width: 900px; height: 500px;"></div>[{*}]
                            <div id="chart2_div" style="width: 900px; height: 500px;"></div>
                </td>
            </tr>
            <tr>
              <td class="group" align="center">
              <h3>Eingegangene Bestellungen einzeln aufgelistet</h3>
                <table border="0" cellpadding="1" cellspacing="1" width="700">
                  
                    [{foreach from=$getorders item=order}]
                     <tr class="[{$oViewConf->usergroup($order.OXUSERID)}]">
                        <td>&nbsp;[{$order.OXORDERDATE}]</td><td style="cursor:pointer;" onclick="JavaScript:popuporder('&amp;cl=order_overview&amp;aoc=1&amp;oxid=[{$order.OXID}]');">Bestellung [{$order.OXORDERNR}]</td><td align="left">[{$order.OXORDERNAME}]</td><td align="right">[{$order.OXTOTALORDERSUM}] [{$order.OXCURRENCY}]&nbsp;</td>
                     </tr>
                     [{/foreach}]
                      
                   
                    </table>
                </td>
            </tr>
            [{/if}]
           
            

</div>





<script>
$(function() {
    console.log( "ready!" );

var nowTemp = new Date();
var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
 
var checkin = $('#dpd1').datepicker({
                format:'yyyy-mm-dd'
                })
                .on('onRender', function(date) {
                    alert('amk');
                
                    return date.valueOf() < now.valueOf() ? 'disabled' : '';
                  })
                .on('changeDate', function(ev) {
                      alert(checkout.date.valueOf());
                  if (ev.date.valueOf() > checkout.date.valueOf()) {
                    var newDate = new Date(ev.date)
                    newDate.setDate(newDate.getDate() + 1);
                    checkout.setValue(newDate);
                  }
                  checkin.hide();
                  $('#dpd2')[0].focus();
                }).data('datepicker');
             
var checkout = $('#dpd2').datepicker({
                format:'yyyy-mm-dd'
                })
                .on('onRender', function(date) {
                    alert('amk');
                
                    return date.valueOf() <= checkin.date.valueOf() ? 'disabled' : '';
                 })
                .on('changeDate', function(ev) {
                  checkout.hide();
                }).data('datepicker');


});
</script>

