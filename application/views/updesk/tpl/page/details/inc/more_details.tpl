<div class="col-lg-7 col-md-5">
    
    <div class="product-title-container">
        <div class="product-header-info">
            
            [{block name="details_productmain_title"}]
                <div class="product-title">
                    <h1 class="st">[{$oDetailsProduct->getFirstTitleLine()}]</h1>
                  
                    <div class="nd">[{$oDetailsProduct->getSecondTitleLine()}]</div>
                    <div class="rd">[{$oDetailsProduct->getThirdTitleLine()}]</div>
                    
                    <div class="artnum">Art.Nr.: [{$oDetailsProduct->oxarticles__oxartnum->value}] [{*$oDetailsProduct->oxarticles__oxvarselect->value *}]</div>
                    
                </div>
            [{/block}]
           
            [{block name="details_productmain_shortdesc"}]
                [{oxhasrights ident="SHOWSHORTDESCRIPTION"}]
                [{if $oDetailsProduct->oxarticles__oxshortdesc->value}]
                    <div class="product-description-short">[{$oDetailsProduct->oxarticles__oxshortdesc->value}]</div>
                [{/if}]
                [{/oxhasrights}]
            [{/block}]
            
        </div>
    </div>
    
    [{block name="details_longdescription"}]
                        [{oxhasrights ident="SHOWLONGDESCRIPTION"}]
                        [{assign var="oLongdesc" value=$oDetailsProduct->getLongDescription()}]
                        [{if $oLongdesc->value}]
                           [{oxeval var=$oLongdesc}]
                        [{/if}]
                        [{/oxhasrights}]
    [{/block}]
    
</div>
<div class="col-lg-5 col-md-5">

    <div class="more-details-img">
        [{if $smarty.get.instacode == "1"}]
            <h1>[{$oDetailsProduct->getInstagramCode()}]</h1>
            <a href="[{$oDetailsProduct->getLink()}]?instacode=1&refetchInstaPic=34">Bild einlesen</a>
            [{if $smarty.get.refetchInstaPic == "34"}]
                [{$oDetailsProduct->refetchInstaPic()}]
            [{/if}]    
        [{/if}]
        
         <img src="[{$oDetailsProduct->getInstagramPic(2)}]">
        
    </div>

</div>
