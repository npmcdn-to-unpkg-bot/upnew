[{include file="up_headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" value="[{ $oxid }]">
    <input type="hidden" name="cl" value="upbetterstockarticle_pendingorders">
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


<div class="col-lg-6">
<h4>Bestellungen f&uuml;r [{$edit->oxarticles__oxartnum->value}]</h4>
[{capture assign="content"}]
	<table class="table">
		[{foreach from=$oOrderList item=oOrder}]
		<tr>
			<td>[{$oOrder.oxordernr}]</td>
			<td>[{$oOrder.oxbillfname}] [{$oOrder.oxbilllname}]</td>
			<td>[{$oOrder.oxorderdate|oxformdate:'datetime':true }]</td>
		</tr>
		[{/foreach}]
	</table>
[{/capture}]
[{$content}]
</div>



[{* bottom item*}]

</div>



</body>
</html>
