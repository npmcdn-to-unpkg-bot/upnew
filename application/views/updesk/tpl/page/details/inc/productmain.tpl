
    [{* Header *}]
    [{ *include file="page/details/inc/header.tpl" *}]
    [{* Pictures *}]
    <div class="col-lg-7 col-md-5" id="morePicsContainer">
        [{* include file="page/details/inc/pics.tpl" *}]   
           
        <div id="product-pictures">
            [{block name="details_productmain_pics"}]
            <div class="dots-vertical"></div>
            <div class="article-slider">
                [{if $oView->morePics()}]
                    [{foreach from=$oView->getIcons() key=iPicNr item=oArtIcon name=sMorePics}]
                        <a class="item" id="morePics_[{$smarty.foreach.sMorePics.iteration}]" data-hq="[{$oPictureProduct->getMasterZoomPictureUrl($iPicNr)}]" data-lq="[{$oPictureProduct->getPictureUrl($iPicNr)}]">
                            <img srcset="[{$oPictureProduct->getZoomPictureUrl($iPicNr)}] 2x" data-lazy="[{$oPictureProduct->getPictureUrl($iPicNr)}]" alt="" />
                        </a>
                    [{/foreach}]
                [{else}]
                        <a class="item" data-hq="[{$oPictureProduct->getMasterZoomPictureUrl(1)}]" data-lq="[{$oPictureProduct->getPictureUrl(1)}]">
                            <img src="[{$oView->getActPicture()}]" alt="[{$oPictureProduct->oxarticles__oxtitle->value|strip_tags}] [{$oPictureProduct->oxarticles__oxvarselect->value|strip_tags}]">
                        </a>
                [{/if}]
               
            </div>
             <meta itemprop="image" content="[{$oPictureProduct->getPictureUrl(1)}]" />
            <div class="cbp-toggler"><div class="glyphicon glyphicon-fullscreen"></div></div>
            <div class="dots-horizontal"></div>
            [{/block}]
            
            
            [{assign var=sThemeName value=$oViewConf->getTemplateDir()}]
            [{assign var=aThemeName value="application/views/"|explode:$sThemeName}]
            
            [{if $aThemeName.1 != "upmob/tpl/"}]
  
    
                [{oxscript add="
	        	var mylist = [];
        		$('#product-pictures').find('.article-slider a').each(function () {
        		    mylist.push({
        		        'lqsrc': $(this).attr('data-lq'),
        		        'hqsrc': $(this).attr('data-hq'),
        		        'id' : $(this).attr('id')
        		    });
        		});"}]
               
                <!-- cbp -->
                <script type="text/template" id="cbp-template">
                 <div id="cbp-viewport">
                
                	<div id="cbp-fbscroller" class="cbp-fbscroller">
                		<nav>
                		     {{#imgs}}
                    			<a href="#{{id}}">Section {{id}}</a>
                			 {{/imgs}}
                		</nav>
                		
                		<div class="controls-close bl bl-x"></div>
                		
                		<div class="controls-slide arrow-prev bl bl-slider-left"></div>
                		<div class="controls-slide arrow-next bl bl-slider-right"></div>
                		
                   
                        {{#imgs}}
                        <section id="{{id}}">
                            <img data-hq="{{hqsrc}}" src="{{lqsrc}}">
                        </section>
                        {{/imgs}}
            
                	</div>
                </div>
               
                </script>
                 [{oxscript include="https://www.urbanpeople.com/DEVS/ScrollingLayout/js/jquery.easing.min.js" priority=2}]
                 [{oxscript include="https://www.urbanpeople.com/DEVS/ScrollingLayout/js/jquery.debouncedresize.js" priority=2}]
                 [{oxscript include="https://www.urbanpeople.com/DEVS/ScrollingLayout/js/cbpFixedScrollLayout.js" priority=2}]
              
            [{/if}]

        </div>
        
    </div>
      [{* oxscript add="$('.article-slider').slick({ dots:true,infinite: true,fade:true,speed: 100,slidesToShow: 1,arrows:true});" *}]
        [{oxscript add="$('.article-slider').slick({ dots:true,infinite: true,slidesToShow: 1,arrows:true,customDots:true,lazyLoad: 'progressive'});"}]
        [{oxscript add="$('#product-pictures').show();"}]
        [{oxscript add="$( 'a.item').click(function(e) { e.preventDefault();});"}] [{* zoom deaktiviert *}]
        
    
    <div id="tocart-wrapper" class="col-lg-5 col-md-5">
    

        [{* Ratings *}]
        [{if $oView->ratingIsActive()}]
            [{block name="details_productmain_ratings"}]
            [{/block}]
        [{/if}]
    
        <div class="product-manufacturer-logo">
            [{block name="details_productmain_manufacturersicon"}]
               [{assign var="oManufacturer" value=$oView->getManufacturer()}]
                    [{if $oManufacturer->oxmanufacturers__oxicon->value}]
                    <div class="product-manufacturer-title">
                        <meta itemprop="brand" content="[{$oManufacturer->oxmanufacturers__oxtitle->value}]" />
                        <meta itemprop="manufacturer" content="[{$oManufacturer->oxmanufacturers__oxtitle->value}]" />
                        <meta itemprop="logo" content="[{$oManufacturer->getIconUrl()}]" />
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
                        <meta itemprop="name" content="[{$oDetailsProduct->oxarticles__oxtitle->value}] [{$oDetailsProduct->oxarticles__oxvarselect->value}]" />
                        <meta itemprop="sku" content="[{$oDetailsProduct->oxarticles__oxartnum->value}]" />
                        [{$oDetailsProduct->oxarticles__oxartnum->value}]
                        <div class="st">[{$oDetailsProduct->getFirstTitleLine()}]</div>
                        <div class="nd">[{$oDetailsProduct->getSecondTitleLine()}]</div>
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
        [{oxhasrights ident="SHOWARTICLEPRICE"}]
        <div class="product-price-container" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
          
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


    
                [{if $oDetailsProduct->getVarStockStatus() >= 0}]
                    <meta itemprop="availability" itemtype="http://schema.org/ItemAvailability" content="InStock">
                [{/if}]
                <meta itemprop="itemCondition" itemtype="http://schema.org/OfferItemCondition" content="NewCondition">
             
               
        </div>
        [{/oxhasrights}]
     
        <div class="tocartselector_container">
            [{ oxid_include_widget cl="oxwArticleToCartSelector" _parent=$oView->getClassName() variantsID="#variants" toBasketFormID="#toBasketForm" nocookie=1 force_sid=$force_sid _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId() }]
        </div>

        [{* shoesizeme start *}]
        <div>
            <span class="ShoeSizeMe"></span>
        </div>
        <script type="text/javascript"> (function(d, t, s, a, f) {
        	a = d.createElement(t);
        	f = d.getElementsByTagName(t)[0];
        	a.async = 1;
        	a.src = s;
        	a.text = '{ shopID: 1362260,  '  + // your shop_id as provided by ShoeSize.Me
        	         'shoeID: "[{$oDetailsProduct->oxarticles__oxartnum->value}]",     '  + // your webshop's id for the current shoe
        	         'locale: "[{$oView->getActiveLangAbbr()}]",      '  + // current locale (downcase)
        	         'scale: "eu",       '  + // size scale of the current product (downcase)
        	         'newRecommendation: function(recommendation) {ssm_select_size(recommendation)},' +
        	         'inCart: function(recommendation) {ssm_add_to_cart (recommendation)}}';
            f.parentNode.insertBefore(a, f) })(document, 'script', 'https://shoesize.me/assets/plugin/loader.js');
            
            //callback functions
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
            }

        </script> 
        
        [{* shoesizeme end *}]
        
        <div class="detail-section trustfield">
            <ul>[{oxcontent ident="updetailshoptrust" }]</ul>
        </div>
        [{if 0}]
        <div class="detail-section" role="tabpanel">
          <!-- Nav tabs -->
          <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#tab-details" aria-controls="home" role="tab" data-toggle="tab">[{oxmultilang ident="DETAIL_TAB_DETAILS"}]</a></li>
            <li role="presentation"><a href="#tab-sizechart" aria-controls="profile" role="tab" data-toggle="tab">[{oxmultilang ident="DETAIL_TAB_SIZECHART"}]</a></li>
           [{* <li role="presentation"><a href="#tab-shipping" aria-controls="settings" role="tab" data-toggle="tab">Versandinfos</a></li>*}]
          </ul>
    
            <!-- Tab panes -->
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="tab-details">
                    [{* Full description *}]
                    [{block name="details_longdescription"}]
                        [{oxhasrights ident="SHOWLONGDESCRIPTION"}]
                        [{assign var="oLongdesc" value=$oDetailsProduct->getLongDescription()}]
                        [{if $oLongdesc->value}]
                           [{oxeval var=$oLongdesc}]
                        [{/if}]
                        [{/oxhasrights}]
                    [{/block}]
                </div>
                <div role="tabpanel" class="tab-pane" id="tab-sizechart">[{block name="dcdetails_sizechart"}][{/block}]</div>
                <div role="tabpanel" class="tab-pane" id="tab-shipping">-</div>
            </div>
        </div>
        [{/if}]
        
        [{block name="instalgo_reco_details"}][{/block}]
    </div><!-- to cart wrapper-->


 


 [{oxscript include="js/widgets/oxtobasket.js" priority=10 }]
 [{oxscript add="$( '#toBasketForm' ).oxToBasket();"}]

[{* More pics block *}]
[{block name="mb_details_productmain_morepics"}]
[{/block}]

