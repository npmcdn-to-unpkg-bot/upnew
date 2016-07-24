[{capture append="oxidBlock_pageBody"}]
<div id="viewport">
   
    [{if 0}]
    <div id="off-canvas-top">
        <div class="container">
             [{include file="widget/header/search.tpl"}]
        </div>
    </div>
      [{/if}]

        [{include file="layout/header.tpl"}]
         
  
     [{*<div id="canvas-navline">
        [{include file="layout/togglenav.tpl"}]
        
    </div> *}]
    
     
  



 
    
[{block name="algolia"}]
      
[{capture assign="FACETELEMENTSLABELS"}]
  var FACETELEMENTS_LABELS = {
    q_female:'[{oxmultilang ident="INSTALGO_FCT_QWQ"}]',
    q_male:'[{oxmultilang ident="INSTALGO_FCT_QMQ"}]'
    }
[{/capture}]
[{oxscript add=$FACETELEMENTSLABELS}]

[{capture assign="FACETSLABELS"}]
  var FACETS_LABELS = {
    filtergender:'[{oxmultilang ident="INSTALGO_FCT_FILTERGENDER"}]',
    rootcat:'[{oxmultilang ident="INSTALGO_FCT_MAINCAT"}]',
    maincat:'Noch genauer',
    manufacturer:'[{oxmultilang ident="INSTALGO_FCT_MANUFACTURER"}]',
    sizes:'[{oxmultilang ident="INSTALGO_FCT_SIZES"}]'};
[{/capture}]
[{oxscript add=$FACETSLABELS}]
     
   
     
     
<div>
  <div class="articlepreviewer-modal transform-hidden"><!-- Where the magic happens :)) --></div>
  <form class="js-oxArticlePreviewer" action="[{$oView->getWidgetLink()}]" method="get">
      <div>
          [{$oViewConf->getHiddenSid()}]
          [{$oViewConf->getNavFormParams()}]
          <input type="hidden" name="cl" value="oxwarticlepreviewer">
          <input type="hidden" name="anid" value="02214bdc677026237f624013a604fe14">
      </div>
  </form>
  [{oxscript include="js/widgets/oxarticlepreviewer.js" priority=10 }]
  [{oxscript add="$( '.js-oxArticlePreviewer' ).oxArticlePreviewer();"}]
  
  [{oxscript include="js/widgets/oxtobasket.js" priority=10 }]
  [{oxscript add="$( '.js-oxArticlePreviewer #toBasketForm' ).oxToBasket();"}]
  
  [{oxscript include="js/widgets/oxarticlevariant.js" priority=10 }]
  [{oxscript add="$( '.js-oxArticlePreviewer #variants' ).oxArticleVariant();"}]
</div>





[{if $smarty.get.algolia == 1111}]

    [{if 0}]
       <div class="instalgo-fixed fixed-modal-ofl-y" id="ia-searchlisting" data-oxid="[{$actCategory->oxcategories__oxid->value}]" data-hits-per-page="28" data-pagination="loadmore" data-hits-per-line="2">
                [{block name="instalgo_list_listhead"}]
                <div class="searchinput resp-sm-hidden">
                  <div class="search-wrapper">
                   <input type="text" autocomplete="off" tabindex="1" id="search-input-mob" name="q" placeholder="Suche eingeben …" value="" maxlength="128">  
                  [{* <div id="search-starter"></div> <i class="bl bl-x"></i> *}]
                   <button class="searchinput-btn"><i class="glyphicon glyphicon-search"></i></button>
                  </div>
                </div> 
                [{/block}]
                <div id="core-target"></div>
        </div>
       [{oxscript add="$( '.instalgo-fixed' ).oxSearchList();"}] 
    [{/if}]
 
 
 <div class="mob-a tophead head-searchcontrol resp-sm-hidden">
  <i class="glyphicon glyphicon-menu-left"></i>
  <span class="th-title">Suche</span>
  <span class="th-count"><em></em> Artikel</span>
  <span class="th-back">[{oxmultilang ident="INSTALGO_BACK"}]</span>
</div>
<div class="mob-a tophead head-facetcontrol resp-sm-hidden">
  <i class="glyphicon glyphicon-menu-left"></i>
  <span class="th-title"></span>
  <span class="th-count"><em></em> Artikel</span>
  <span class="th-back">[{oxmultilang ident="INSTALGO_FILTERBACK"}]</span>
</div>
[{*<div class="head-search-history"></div>*}]



         
<div class="instalgo-fixed fixed-modal-ofl-y">
[{* <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/jquery.ion.rangeslider/2.0.12/css/ion.rangeSlider.css">
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/jquery.ion.rangeslider/2.0.12/css/ion.rangeSlider.skinFlat.css">
    *}]
    
  <div class="searchinput resp-sm-hidden">
  <div class="search-wrapper">
   <input type="text" autocomplete="off" tabindex="1" id="search-input-mob" name="q" placeholder="Suche eingeben …" value="" maxlength="128">  
  [{* <div id="search-starter"></div> <i class="bl bl-x"></i> *}]
   <button class="searchinput-btn"><i class="glyphicon glyphicon-search"></i></button>
  </div>
</div>  
  
  <main>
  
    <div class="head-box resp-xs-hidden">
      <div class="container">
        <!-- Header -->
        <div id="stats"></div>
        <!-- /Header -->
      </div>
    </div>
    <div class="page-facetcontrol resp-sm-hidden">
      <div class="col-xs-6"><button class="btn" data-facets-class="category" data-facets-title="Kategorien">Kategorien</button></div>
      <div class="col-xs-6"><button class="btn" data-facets-class="filter" data-facets-title="Filter">Filter</button></div>
    </div>
    <div class="container">
          <div class="row">
              <div class="facets-box col-md-2">
                  <div id="facets"></div>
              </div>
              <div class="hits-box col-md-10">
                    <div id="noresults"></div>
                    <div id="activefacet"></div>
                    <div id="hits" class="a-listing" data-sizetip-title="Verfügbare Grössen"></div>
                    <div id="pagination"></div>
              </div>
          </div>
    </div>
  </main>
</div> <!-- /instalgo -->
[{/if}]    
<div>
  <!-- Hit template -->
  <script type="text/template" id="hit-template">
    {{#hits}}
   
    <div class="hit" data-anid="{{objectID}}" data-ts="{{oxinsert}}" data-price="{{ price }}" data-tprice="{{ tprice }}">
      <div class="hit-image">
        <img src="/out/pictures/generated/product/1/304_304_92/{{ oxpic1 }}" data-p2="/out/pictures/generated/product/2/304_304_92/{{ oxpic2 }}" data-sizetip-sizes="{{#sizes}}<i>{{.}}</i>{{/sizes}}" >
      </div>
       <div class="hit-title">{{ oxtitle_1 }}</div>
      <div class="hit-price"></div>
    </div>

    {{/hits}}
  </script>

  <!-- Stats template -->
  <script type="text/template" id="stats-template">
    <span id="nbhits">{{ nbHits }}</span> [{oxmultilang ident="INSTALGO_RESULT_SINGULAR"}]{{#nbHits_plural}}[{oxmultilang ident="INSTALGO_RESULT_PLURALEND"}]{{/nbHits_plural}} [{oxmultilang ident="INSTALGO_FOR"}] <em>"{{ query }}"</em>  <span class="found-in">{{processingTimeMS}}</span>
  </script>
   
    <!-- Facet-Gender template -->
  <script type="text/template" id="facet-gender-template">
    <div class="facet gendercat">
      <h5>{{ title }}</h5>
      <ul class="filtergender {{#isRefinedParent}}facet-parent-refined{{/isRefinedParent}}">
        {{#values}}
        {{#multilang}}
        <li class="{{#isRefined}}facet-refined{{/isRefined}}">
          <a href="" class="facet-link toggle-gender-refine {{#isRefined}}facet-refined{{/isRefined}} {{#disjunctive}}facet-dis{{/disjunctive}}" data-facet="{{ facet }}" data-value="{{ name }}">
             {{ multilang }} <span class="facet-count">{{ count }}</span>
          </a>
        </li>
        {{/multilang}}
        {{/values}}
      </ul>
    </div>
  </script>
  
  <!-- Facet template -->
  <script type="text/template" id="facet-template">
    <div class="facet {{ facet }} {{ rootcatrefined }}">
      <h5>{{ title }} {{#activeFilterCount}}<i>{{activeFilterCount}} [{oxmultilang ident="INSTALGO_FILTERACTIVE"}]</i>{{/activeFilterCount}}</h5>
      <ul>
        {{#values}}<li>
          <a href="" class="facet-link toggle-refine {{#disjunctive}}facet-dis{{/disjunctive}} {{#isRefined}}facet-refined{{/isRefined}}" data-facet="{{ facet }}" data-value="{{ name }}">
             {{#multilang}}{{ multilang }}{{/multilang}}{{^multilang}}{{ name }}{{/multilang}} <i class="bl bl-x"></i><span class="facet-count">{{ count }}</span>
          </a>
        </li>{{/values}}
      </ul>
    </div>
  </script>

  <!-- Slider template -->
  <script type="text/template" id="slider-template">
    <div class="facet">
      <h5>{{ title }}</h5>
      <input type="text" id="{{ facet }}-slider" data-min="{{ min }}" data-max="{{ max }}" data-from="{{ from }}" data-to="{{ to }}"/>
    </div>
  </script>

  <!-- Pagination template -->
  <script type="text/template" id="pagination-template">
    <ul>
      <li {{^prev_page}}class="disabled"{{/prev_page}}><a href="#" {{#prev_page}}class="go-to-page" data-page="{{ prev_page }}"{{/prev_page}}>&#60;</a></li>
      {{#pages}}
      <li class="{{#current}}active{{/current}} {{#disabled}}disabled{{/disabled}}"><a href="#" {{^disabled}} class="go-to-page" data-page="{{ number }}" {{/disabled}}>{{ number }}</a></li>
      {{/pages}}
      <li {{^next_page}}class="disabled"{{/next_page}}><a href="#" {{#next_page}}class="go-to-page" data-page="{{ next_page }}"{{/next_page}}>&#62;</a></li>
    </ul>
  </script>
  
  <!-- Pagination template -->
  <script type="text/template" id="load-more-template">
    <div class="load-more">
      <button class="btn-dark" data-page="{{ next_page }}">[{oxmultilang ident="INSTALGO_LOADMORE"}]</button>
    </div>
  </script>


  <!-- No-Results template -->
  <script type="text/template" id="no-results-template">
    <div id="no-results-message">
      <p>[{oxmultilang ident="INSTALGO_NORESULTS"}]: <em>"{{ query }}"</em>.</p>
  </script>
  
   <!--  Facets template -->
  <script type="text/template" id="active-facet-template">
 {{#filters.length}}
    <div>
      <ul id="active-facets">
        {{#filters}}
        <li class="{{ class }}" data-facet="{{ facet }}" data-value="{{ facet_value }}">
          <i>{{ label }}</i><span class="value">{{#label_multilang_value}}{{ label_multilang_value }}{{/label_multilang_value}}{{^label_multilang_value}}{{ label_value }}{{/label_multilang_value}}</span><a class="remove"><span class="glyphicon glyphicon-remove-circle"></span></a>
        </li>
        {{/filters}}
        {{#filters.length}}
        <li class="clear-all">[{oxmultilang ident="INSTALGO_CLEARFACETS"}]<a class="remove"><span class="glyphicon glyphicon-remove-circle"></span></a></li>
        {{/filters.length}}
      </ul>
    </div>
  {{/filters.length}}
  </script>
  
  
  [{capture assign="instalgo_list_core"}]
  <main>
      <div class="head-box resp-xs-hidden">
        <div class="container">
          <!-- Header -->
          <div id="stats"></div>
          <!-- /Header -->
        </div>
      </div>
      <div class="page-facetcontrol resp-sm-hidden">
        <div class="col-xs-6"><button class="btn" data-facets-class="category" data-facets-title="Kategorien">Kategorien</button></div>
        <div class="col-xs-6"><button class="btn" data-facets-class="filter" data-facets-title="Filter">Filter</button></div>
      </div>
      <div class="container">
            <div class="row">
                <div class="facets-box col-md-2">
                    <div id="facets"></div>
                </div>
                <div class="hits-box col-md-10">
                      <div id="noresults"></div>
                      <div id="activefacet"></div>
                      <div id="hits" class="a-listing qpv" data-sizetip-title="Verfügbare Grössen"></div>
                      <div id="pagination"></div>
                </div>
            </div>
      </div>
  </main>
  [{/capture}]

  <script type="text/template" id="list-core-template">
      [{$instalgo_list_core}]
  </script>


[{/block}]


  
    <div id="canvas-center">
        <div id="canvas-blocker"></div>
          [{if $oView->getClassName() ne "start" && !$blHideBreadcrumb}]
         
          <div class="container breadCrumb-container">
            [{block name="layout_breadcrumb"}]
               [{ include file="widget/breadcrumb.tpl"}]
            [{/block}]
        </div>
        [{/if}]
      
        <div id="page">
            <div class="container">
                [{if $oView->getClassName()=='start' && $oView->getBanners()|@count > 0 }]
                    [{include file="widget/promoslider.tpl" }]
                [{/if}]
                [{include file="message/errors.tpl"}]
                <div class="row">
                [{foreach from=$oxidBlock_content item="_block"}]
                    [{$_block}]
                [{/foreach}]
                </div>
            </div>
        </div>
     
        [{include file="layout/footer.tpl"}]  
    </div>
    
   
   
</div>
 [{if $oView->getClassName() != "details"}]
        [{insert name="oxid_tracker" title=$template_title }]
    [{/if}]
[{/capture}]
[{include file="layout/base.tpl"}]