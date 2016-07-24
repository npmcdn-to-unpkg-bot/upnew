[{* Documentation: http://www.bootcss.com/p/bootstrap-v3/javascript.html#carousel *}]
[{oxscript include="js/widgets/oxcarouselswipe.js"}]
[{oxscript include="js/libs/magnific-popup.js" }]
[{oxscript add="$('.thumbs').magnificPopup({delegate: 'a', type: 'image',gallery: {enabled:true,
  navigateByImgClick: true,

  arrowMarkup: '<button title=\"%title%\" type=\"button\" class=\"mfp-arrow mfp-arrow-%dir%\"></button>',

  tPrev: 'Previous (Left arrow key)',
  tNext: 'Next (Right arrow key)',
  tCounter: '<span class=\"mfp-counter\">%curr% of %total% test</span>' }});"}]


[{block name="details_productmain_pics"}]
        <div class="thumbs">
            [{if $oView->morePics()}]
                [{foreach from=$oView->getIcons() key=iPicNr item=oArtIcon name=sMorePics}]
                    <a class="item" id="morePics_[{$smarty.foreach.sMorePics.iteration}]" href="[{$oPictureProduct->getMasterZoomPictureUrl($iPicNr)}]">
                        <img src="[{$oPictureProduct->getPictureUrl($iPicNr)}]" alt="" />
						[{*}]<img src="[{$oPictureProduct->getMasterZoomPictureUrl($iPicNr)}]" width="100%" />[{*}]
                    </a>
                [{/foreach}]
            [{else}]
            yoyo?
            <a class="item" href="[{$oPictureProduct->getMasterZoomPictureUrl(1)}]">
                <img src="[{$oView->getActPicture()}]" alt="[{$oPictureProduct->oxarticles__oxtitle->value|strip_tags}] [{$oPictureProduct->oxarticles__oxvarselect->value|strip_tags}]">
            </a>
            [{/if}]
            ist hier jemand?
        </div>
[{/block}]