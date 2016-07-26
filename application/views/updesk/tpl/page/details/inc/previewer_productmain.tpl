[{strip}]
<div class="col-md-7" id="morePicsContainer">
        <div id="product-pictures">
            <div class="previewer-article-slider">
                [{if $oView->morePics()}]
                    [{foreach from=$oView->getIcons() key=iPicNr item=oArtIcon name=sMorePics}]
                        <a class="item preventdefault" id="morePics_[{$smarty.foreach.sMorePics.iteration}]" href="[{$oPictureProduct->getMasterZoomPictureUrl($iPicNr)}]">
                            <img srcset="[{$oPictureProduct->getZoomPictureUrl($iPicNr)}] 2x" data-lazy="[{$oPictureProduct->getPictureUrl($iPicNr)}]" [{if $iPicNr == 1}]src="[{$oPictureProduct->getPictureUrl($iPicNr)}]" [{/if}]/>
    					
                        </a>
                    [{/foreach}]
                [{else}]
                        <a class="item preventdefault" href="[{$oPictureProduct->getMasterZoomPictureUrl(1)}]">
                            <img src="[{$oView->getActPicture()}]" alt="[{$oPictureProduct->oxarticles__oxtitle->value|strip_tags}] [{$oPictureProduct->oxarticles__oxvarselect->value|strip_tags}]">
                        </a>
                [{/if}]
                  
            </div>
        </div>
        [{* oxscript add="$('.previewer-article-slider').slick({ dots:true,infinite: true,arrows:true, lazyLoad: 'progressive'});" *}]
</div>

<div id="tocart-wrapper" class="col-md-5">
       <div class="product-manufacturer-logo">
        [{block name="details_productmain_manufacturersicon"}]
           [{assign var="oManufacturer" value=$oView->getManufacturer()}]
                [{if $oManufacturer->oxmanufacturers__oxicon->value}]
                <div class="product-manufacturer-title">
                    [{*}][{$oManufacturer->oxmanufacturers__oxtitle->value}][{*}]
                    <a href="[{$oManufacturer->getLink()}]">
                    <img src="[{$oManufacturer->getIconUrl()}]" alt="[{$oManufacturer->oxmanufacturers__oxtitle->value}]">
                    </a>
                </div>
                [{/if}] 
        [{/block}]
        </div>
        [{* Title/sShortDesc *}]
        <div class="product-title-container">
            <div class="product-header-info">
                [{block name="details_productmain_title"}]
                <div class="product-title">
                    <div class="st">[{$oDetailsProduct->getFirstTitleLine()}]</div>
                    <div class="nd">[{$oDetailsProduct->getSecondTitleLine()}]</div>
                    <div class="rd">[{$oDetailsProduct->getThirdTitleLine()}]</div>
                    
                    [{*<div class="artnum">Art.Nr.: [{$oDetailsProduct->oxarticles__oxartnum->value}]</div>*}]
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

        [{*Price Info*}]
        [{if 1==2}]
        <!-- Moved to tocart widget -->
        [{oxhasrights ident="SHOWARTICLEPRICE"}]
        <div class="product-price-container">
                [{block name="details_productmain_tprice"}]
                    [{oxhasrights ident="SHOWARTICLEPRICE"}]
                    [{if $oDetailsProduct->getFTPrice()}]
                        [{assign var=tprice value=$oDetailsProduct->getTPrice()}]
                        [{assign var=price  value=$oDetailsProduct->getPrice()}]
                        [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                            <div class="product-price-old ">
                                 [{assign var=reducedclass value="reduced" }]
                                  <strong><del>[{oxprice price=$tprice currency=$currency}]</del></strong> 
                            </div>
                        [{/if}]
                    [{/if}]
                    [{/oxhasrights}]
                [{/block}]

                [{block name="details_productmain_watchlist"}][{/block}]

                [{block name="details_productmain_price"}]
                    [{if $oDetailsProduct->getPrice()}]
                        <div class="product-price price [{$reducedclass}]">
                            [{assign var="sFrom" value=""}]
                            [{assign var="oPrice" value=$oDetailsProduct->getPrice()}]
                            [{* if $oDetailsProduct->isParentNotBuyable() }]
                                [{assign var="oPrice" value=$oDetailsProduct->getVarMinPrice()}]
                                [{if $oDetailsProduct->isRangePrice() }]
                                    [{assign var="sFrom" value="PRICE_FROM"|oxmultilangassign}]
                                [{/if}]
                            [{/if *}]
                            <strong>
                                <span>[{$sFrom}] [{oxprice price=$oPrice currency=$currency}]</span>
                                [{* if $oView->isVatIncluded() }]
                                    <span>*</span>
                                [{/if *}]
                            </strong>
                        </div>
                    [{/if}]
                [{/block}]
        </div>
        [{/oxhasrights}]
        [{/if}]
   
        <div class="tocartselector_container">
            [{ oxid_include_widget cl="oxwArticleToCartSelector" _parent=$oView->getClassName() nocookie=1 force_sid=$force_sid _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId() }]
        </div> 
        [{oxscript include="js/widgets/oxtobasket.js" priority=10 }]
        [{oxscript add="$( '#toBasketForm' ).oxToBasket();"}]
        
        [{if $smarty.get.shoesize == 1 || 1==1 }]
        <div class="shoesizeHIDDEN" style="">
            <span class="ShoeSizeMe"></span>
        </div>


        <script type="text/javascript"> (function(d, t, s, a, f) {
        	a = d.createElement(t);
        	f = d.getElementsByTagName(t)[0];
        	a.async = 1;
        	a.src = s;
        	a.text = '{ shopID: 1362260,  '  + 
        	         'shoeID: "[{$oDetailsProduct->oxarticles__oxartnum->value}]",     '  + 
        	         'locale: "[{$oView->getActiveLangAbbr()}]",      '  + 
        	         'scale: "eu",       '  + 
        	         'newRecommendation: function(recommendation) {ssm_select_size(recommendation)},' +
        	         'inCart: function(recommendation) {ssm_add_to_cart (recommendation)}}';
            f.parentNode.insertBefore(a, f) })(document, 'script', 'https://shoesize.me/assets/plugin/loader.js');
            
         
            function ssm_select_size(recommendation) {
                
                if(recommendation.size.eu){
                    var recommended_size = recommendation.size.eu;
                    recommended_size = recommended_size.replace('.66', ' 2/3');
                    recommended_size = recommended_size.replace('.33', ' 1/3');
                    recommended_size = recommended_size.replace('.0', '');
                	 
                    console.log("cleaned up: " + recommended_size);
                    
                    $('.dropdown-option a').filter(function() {
                       return $(this).text() == recommended_size;
                    }).trigger("click");
                }


            } 
            
            function ssm_add_to_cart(recommendation) {
            	$(".tocartselector_container").find('#toBasket').trigger("click");
            	ShoeSizeMe.close();
                //ShoeSizeMe = null;
            }


        </script>
        
        [{/if}]

</div> 
 



[{/strip}]



