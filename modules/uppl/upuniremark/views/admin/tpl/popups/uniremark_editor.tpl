[{include file="popups/upextadmin_headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]
<style>
    .extern{
        border-color:#ff3600;
    }
</style>
    <div class="container">
            <div class="col-md-12">
            <h3>Eintragsmanager</h3>

            [{if $sParentType =="oxorder"}]
                    [{ assign var="oOrder" value=$oParentObject}]  
                    Bestellung: [{$oOrder->oxorder__oxordernr->value}]<br>   
                    Name: [{$oOrder->oxorder__oxbillfname->value}] [{$oOrder->oxorder__oxbilllname->value}]  
                      
            [{/if}]
            [{if $sParentType =="oxarticle"}]
                    [{ assign var="oArticle" value=$oParentObject}] 
                    Artikel: [{$oArticle->oxarticles__oxtitle->value }]<br>   
                    Artnum: [{$oArticle->oxarticles__oxartnum->value }]
                    
                      
            [{/if}]
            [{if $sParentType =="oxorderarticle"}]
                    [{ assign var="oArticle" value=$oParentObject}] 
                    Titel: [{$oArticle->oxorderarticles__oxtitle->getRawValue()}]<br>
                    [{if $oArticle->oxorderarticles__oxselvariant->value }]
                    Variante: [{$oArticle->oxorderarticles__oxselvariant->value }]<br>
                    [{/if}]
                    Artnum: [{$oArticle->oxorderarticles__oxartnum->value }]<br>
                    Anzahl: [{$oArticle->oxorderarticles__oxamount->value }]<br>
                    Preis: [{$oArticle->getTotalBrutPriceFormated() }]                
            [{/if}]
            </div>
            <div class="col-md-6">
                <h3>Neuer Eintrag</h3>
                 [{ assign var="oUser" value=$oActiveAdmin}]   
                <div class="panel panel-default">
                    <div class="panel-heading"><b>[{$oUser->oxuser__oxfname->value}] [{$oUser->oxuser__oxlname->value}]</b> </div>
                      <div class="panel-body">
                            <form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post" >
                            [{ $oViewConf->getHiddenSid() }]
                            <input type="hidden" name="cl" value="upuniremark_editor">
                            <input type="hidden" name="fnc" value="save">
                            <input type="hidden" name="oxid" value="[{$oxid}]">
                            
                          <div class="form-group">
                            <label class="sr-only" for="uniremark_text">Neue Notiz</label>
                            <textarea class="form-control" id="uniremark_text" name="uniremark_text" rows="3"></textarea>
                          </div>
                           <div class="checkbox">
                                          <label>
                                            <input type="checkbox" name="extern">
                                           Extern
                                          </label>
                                    </div>
                          <button type="submit" class="btn btn-success">Erfassen</button>
                        <hr>
                          Per Mail Benachrichtigen:
                          [{if !$blEmpty}]
                            [{foreach from=$oLatestRemark->getUniRemarkAuthors() item=oUitem}]
                                  [{ assign var="oUser" value=$oUitem->getRemarkAuthor()}]
                                  <div class="checkbox">
                                          <label>
                                            <input type="checkbox" value="" name="mail[]">
                                            [{$oUser->oxuser__oxfname->value}] [{$oUser->oxuser__oxlname->value}]
                                          </label>
                                    </div>
                            [{/foreach}]
                          [{/if}]
                        </form>     
                    </div>
                </div>
            </div>
            [{if !$blEmpty}]
            <div class="col-md-6">
            <h3>History</h3>
            [{foreach from=$oLatestRemark->getUniRemarkHistory() item=oUitem}]
                [{ assign var="oUser" value=$oUitem->getRemarkAuthor()}]
                    
                <div class="panel panel-default [{if $oUitem->upuniremark__oxextern->value ==1 }]extern[{/if}]">
                    <div class="panel-heading">
                        <h3 class="panel-title "><b>[{$oUser->oxuser__oxfname->value}] [{$oUser->oxuser__oxlname->value}]</b> schrieb am [{ $oUitem->getCreateDate() }] um [{ $oUitem->getCreateTime() }]</h3>
                    </div>
                    <div class="panel-body">
                        <p>[{ $oUitem->upuniremark__oxtext->value }]</p>
                        <form name="myedit" id="myedit"  style="margin:0;" action="[{ $oViewConf->getSelfLink() }]" method="post" >
                            [{ $oViewConf->getHiddenSid() }]
                            <input type="hidden" name="cl" value="upuniremark_editor">
                            <input type="hidden" name="fnc" value="delete">
                            <input type="hidden" name="oxid" value="[{$oxid}]">
                            <input type="hidden" name="uniremark_oxid" value="[{$oUitem->upuniremark__oxid->value}]">
                            <button type="submit" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>Entfernen</button>
                        </form>
                    
                        
                    </div>
                </div>

            [{/foreach}]
            </div>
            [{/if}]
    </div>
</body>
</html>
