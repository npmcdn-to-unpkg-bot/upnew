[{assign var="product"  value=$oView->getProduct()}]
[{assign var="oCat" value=$product->getCategory() }]
[{assign var="oManufacturer" value=$oView->getManufacturer()}]

<div class="reco a-listing" data-sizetip-title="Verfügbare Grössen" data-oxid="[{$product->oxarticles__oxid->value}]" data-hitsperpage="3" >
    
    <div class="reco-head">Das könnte dir auch gefallen</div>
    <div class="reco-tabs-wrapper">
        <ul id="reco-tabs">
          <li data-tabfacetid="maincat">[{$oCat->oxcategories__oxtitle->value}]</li>
          <li data-tabfacetid="manufacturer_id">[{* [{ oxmultilang ident="DETAIL_MOREFROM" }] [{$oManufacturer->oxmanufacturers__oxtitle->value}] *}]Marke</li>
          <li data-tabfacetid="colors">Farbe</li>
        </ul>
    </div>
    <div class="reco-progress-bar-wrapper"><div id="reco-progress-bar"></div></div>
    <div class="reco-hits-wrapper">
        <div id="reco-hits"></div>
        <div id="reco-arrows"></div>
    </div>
</div>
    
    
<!-- Hit template -->
<script type="text/template" id="reco-hits-template">
{{#hits}}
<a class="hit" data-anid="{{objectID}}" href="{{seourl}}">
  <div class="hit-image">
    <img class="size-tip" src="/out/pictures/generated/product/1/304_304_92/{{ oxpic1 }}" data-p2="/out/pictures/generated/product/2/304_304_92/{{ oxpic2 }}" data-sizetip-sizes="{{#sizes}}<i>{{.}}</i>{{/sizes}}">
  </div>
  <div class="hit-title">{{ oxtitle_1 }}</div>
  <div class="hit-price" data-price="{{ price }}"></div>
</a>
{{/hits}}
</script>

<!-- Pagination template -->
<script type="text/template" id="reco-arrows-template">

  <div class="reco-go-to-page bl bl-slider-left {{^prev_page}}disabled{{/prev_page}}" {{#prev_page}}data-page="{{ prev_page }}"{{/prev_page}}></div>
 
  <div class="reco-go-to-page bl bl-slider-right {{^next_page}}disabled{{/next_page}}" {{#next_page}}data-page="{{ next_page }}"{{/next_page}}></div>

</script>
[{oxscript include="js/widgets/oxreco.js" priority=10 }]
[{oxscript add="$( '.reco' ).oxReco();"}]
 