/**
 * Property Robert Denus, @rdenus please dont steal it, I am not even finished with what I really want to do...
 *
 *
 * @link      http://www.dencodo.ch
 * @copyright (C) DENCODO 2016
 */
 
var SOLR_SEARCH_ONLY_API_KEY = '238e22c360fe7296f4396f1a71931be3';

//SOLR Client Functions
var SEARCH_CLIENT_RESULTS = solr_search_API_ARTICLESEARCH( SOLR_SEARCH_ONLY_API_KEY );
var SEARCH_FILTER_RESULTS = solr_search_API_FILTERHANDLER(SOLR_SEARCH_ONLY_API_KEY );
var SEARCH_PAGINATION_RESULTS = solr_search_API_PAGINATION( SOLR_SEARCH_ONLY_API_KEY );


(function( $ ) {
 
    $.fn.markSaleArticles = function() {

        this.find( ".hit" ).each(function() {
            
            var prod = $( this );
            var priceA = parseInt( prod.data("price") );
            var priceB = parseInt( prod.data("tprice") );
             
            var priceAXR = priceA * CUR_XR;
            var priceBXR = priceB * CUR_XR;
            
            var priceEL = $(this).find('.hit-price');
         
            if(priceB > priceA ){
                var saleMath = (priceA / priceB) * 100;
                var saleRedu = 100 - saleMath;
                prod.find('.hit-image').prepend('<div class="badge-sale">-'+saleRedu.toFixed()+'%</div>');
                
                priceEL.html( '<span class="op">' + priceBXR.toFixed(2) + '</span> <span class="sp">' + CUR_ISO + ' ' + priceAXR.toFixed(2) + '</span>' );
            }else{
              
                priceEL.html( CUR_ISO + ' ' + priceAXR.toFixed(2) );
            }
        });
        return this;
    };
 
}( jQuery ));
 


(function( $ ) {
    $.fn.markNewArticles = function() {
        // cache and initialize some values
        var config = {
          //zeitraum indem ein artikel 'neu' ist
          days : 20,
        };
    
        this.find( ".hit" ).each(function() {
          var prod = $( this );
          var prodTimestamp = new Date( prod.data( "ts" ) ).getTime();
          
          prod.removeAttr( "data-ts" );
          prod.removeData( "ts" );
          // timestamp in vergangenheit
          var timestamp = new Date().getTime() - ( config.days * 24 * 60 * 60 * 1000 );                    
            if( prodTimestamp > timestamp){
              prod.find('.hit-image').prepend('<div class="badge-new">New</div>');
            }
            else if(prodTimestamp < timestamp){
            // product is older      
            }
            else{
            // -Exact- same timestamps.
            }
        });
        return this;
    };
 
}( jQuery ));

$(document).ready(function() {
    
if( !$('body').hasClass('mob-a') ) {
         console.log('listener active');
     $('.a-listing').on( 'mouseenter','img', function(e) {
         
        var $parent = $(e.delegateTarget);
       
        
        var innerHeader = '<header>' + $parent.data('sizetip-title') + '</header>'; 
        
        var innerList = '<div>' + $(this).data('sizetip-sizes') + '</div>';
        
         $('<div class="size-tip-tooltip"></div>')
            .html(innerHeader + innerList)
            .appendTo($parent);
            
           
            var i =  $( 'i', innerList ).length;
            if(i){
                $('.size-tip-tooltip').width( $('.size-tip-tooltip i').outerWidth(true) * i );
                $('.size-tip-tooltip').fadeIn('fast');
            }
     })
     .on( 'mouseleave','img', function(e) {
        $('.size-tip-tooltip').remove();
     })
     .mousemove(function(e) {
            var mousex = e.pageX - $(this).offset().left + 15; //Get X coordinates
            var mousey = e.pageY - $(this).offset().top + 15; //Get Y coordinates
            $('.size-tip-tooltip').css({ top: mousey, left: mousex });
    });
    
     $('.size-tip-tooltip').on( 'mouseenter', function(e) {
        return false; 
     });
     
     
     $('.a-listing').on({
              mouseenter: function() {
                  if( !$(this).data('p1') ){
                      $(this).data('p1',  $( this ).attr('src') );
                  }
                  var src = $( this ).data('p2');

                  if (src.indexOf("nopic.jpg") < 0 && src.indexOf(".jpg") > -1){
                     $( this ).attr('src', src );
                  }
              },
              mouseleave: function(event) {
                    /*if( event.relatedTarget.id == 'powerTip'){ 
                       return false;
                    }*/
                    $( this ).attr('src', $( this ).data('p1') );
              }
    }, 'img'); 

}  
});



// INITIALIZATION
// ==============
var doclang = document.documentElement.lang;


var suffixnr = new Array();
suffixnr['de'] = 0;
suffixnr['en'] = 1;
suffixnr['fr'] = 2;


var INDEX_NAME = 'oxarticles_' + suffixnr[doclang];
var CUR_ISO = $('html').data('cur-iso');
var CUR_XR = $('html').data('cur-xr');

// Replace with your own values
var APPLICATION_ID = 'SJ9E0ELB77';
var SEARCH_ONLY_API_KEY = '238e22c360fe7296f4396f1a71931be3';



//that property's value is a string, not an object and therefore is not shared across all instances. 
//Only arrays and objects will be shared. Again, this is about JavaScript the language, not jQuery UI and the widget factory.


  var URLHistoryTimer = Date.now();
  var URLHistoryThreshold = 700;
( function ( $ ) {
    
    $.widget( "instalgo.base",{
      
        _algoliaOptions: {
            indexname : INDEX_NAME,
            //params: false,
        },
        _create: function(){
		   var self = this;
		   
		   
           self._algolia =  algoliasearch(APPLICATION_ID, SEARCH_ONLY_API_KEY);
		   self._algoliasearchHelper = algoliasearchHelper(self._algolia, self._algoliaOptions.indexname,  self._algoliaOptions.params);
		   self._result = {};
		   
		   
	       self._algoliasearchHelper
	       .on('result', function(content, state) {
	           self._result.content = content;
	           self._result.state = state;
	           self._handleResult();
	          
	       })
	       .on('change', function(state) {
	          if(self.widgetName == 'oxSearchList'){
	              self.setURLParams();
	          };
            });
            
              // AUTO INIT
              // ==============
              // check if something is in url params
              function hasUrlSearchParams(){
                  var url = window.location.href;
                  if (url.indexOf('q=') !=-1 || url.indexOf('FR[') !=-1 ) {
                    return true;
                  }
                  return false;
              }
              
              
              // Initial search
              var url = window.location.href;
              if ( hasUrlSearchParams() ) {
                self.initFromURLParams();
                 this._algoliasearchHelper.search();
                  self.algoliaShow();
              }
              
              //popstate  history init
              window.addEventListener('popstate', function() {
                
                if ( hasUrlSearchParams() ) { //popstate issue with safari
                    self.initFromURLParams();
                    this._algoliasearchHelper.search();
                }
              });
              
              
	    },
	    setAlgoliaOptionsParams: function(params){
	        this._algoliaOptions.params = params;
	    },
	    _handleResult: function(){

	      	this._renderTemplates();
	      	this.afterRenderFncs();
	    },
	    setURLParams: function () {
            var trackedParameters = ['attribute:*'];
            if (this._algoliasearchHelper.state.query.trim() !== '')  trackedParameters.push('query');
            if (this._algoliasearchHelper.state.page !== 0)           trackedParameters.push('page');
            if (this._algoliasearchHelper.state.index !== INDEX_NAME) trackedParameters.push('index');
            
            
            
            var URLParams = window.location.search.slice(1);

            var nonAlgoliaURLParams = algoliasearchHelper.url.getUnrecognizedParametersInQueryString(URLParams);
          
            var nonAlgoliaURLHash = window.location.hash;
            var helperParams = this._algoliasearchHelper.getStateAsQueryString({filters: trackedParameters, moreAttributes: nonAlgoliaURLParams});
        
            if (URLParams === helperParams) return;
            
            var now = Date.now();
            if (URLHistoryTimer > now) {
              window.history.replaceState(null, '', '?' + helperParams + nonAlgoliaURLHash);
            } else {
              window.history.pushState(null, '', '?' + helperParams + nonAlgoliaURLHash);
            }
            URLHistoryTimer = now+URLHistoryThreshold;
           
        },
        initFromURLParams: function() {
            var URLString = window.location.search.slice(1);
            var URLParams = algoliasearchHelper.url.getStateFromQueryString(URLString);
            if (URLParams.query) $('#search-input').val(URLParams.query);
            //if (URLParams.index) $sortBySelect.val(URLParams.index.replace(INDEX_NAME, ''));
            this._algoliasearchHelper.overrideStateWithoutTriggeringChangeEvent(this._algoliasearchHelper.state.setQueryParameters(URLParams));

        }
    });
})( jQuery );

( function ( $ ) {
    
    $.widget( "instalgo.listing", $.instalgo.base ,{
      
        listOptions: {
            //hitsPerLine : false,
            //hitsPerPage: false,
            //listStyle : 'twoinarow',
        },
        
        _create: function(){
            var self    = this,
            el      = self.element;
            
           this._tpl =  {
                target: {},
                src: {}
            };
            
		    this.setAlgoliaOptionsParams({
                hitsPerPage: self.listOptions.hitsPerPage, 
                maxValuesPerFacet: 100,
                facets: ['rootcat','filtergender','oxartnum','categories_id','manufacturer_id'],
                disjunctiveFacets: ['filtercolor','sizes','maincat','manufacturer'],
            
            });
            
      
            // MOBILE FACET FILTERS DESIGN / REALLY BAD THINGS HAPPENING HERE
            // ========================
            $(el).on('click', '.page-facetcontrol button', function(e) {
                
                var facetcontrol = Hogan.compile( $('#list-tophead-facetcontrol-template').text() );
                
                var data = {trigger: $(el).attr('id') };
                $('#tophead-target #facetcontrol').html( facetcontrol.render(data) );
                
                var title = $(this).data('facets-title');
            
                var facets = $(this).data('facets-class');
                
                
                var thname = '#jstophead_' + $(el).attr('id');
                
                var $head = $( thname ).find('.head-facetcontrol');
                $head.find('.th-title').html( title );
                
                $head.find('.th-count em').html( self._result.content.nbHits );
                
                $head.show();

                $('.facets-box').addClass( 'facets-' + facets + '-show' ).show();
                
                var offset = $(el).find('.facets-box').offset();
                var margin = (offset.top - 60) * -1;
                
                $(el).find('.facets-box').css('margin-top', margin );
                
                $('.hits-box').hide();
                $('footer').hide();
                $('#catLongDesc').hide();
                
                
            
            });
            
             
             $('#tophead-target').on('click', '.head-facetcontrol .th-back', function(e) {
                
                $('#tophead-target .head-facetcontrol').hide();
                $('.facets-box').hide().removeClass().addClass('facets-box').css('margin-top',0 );
                $('.hits-box').show();
                $('footer').hide();
                $('#catLongDesc').hide();
                 
                document.body.scrollTop = 0;
                
                self.recalcActiveFacets();
            });
            

            // EVENTS BINDING
            // ==============
            
            $(el).on('click', '.toggle-gender-refine', function(e) {
                e.preventDefault();
                
                 //reset to default index
                if( $(this).parent().hasClass('facet-refined') ){
                   self._algoliasearchHelper.clearRefinements('maincat');
                  //algoliaHelper.setIndex('oxarticles'); // reset index
                }
                
                if ( $(this).data('value') == 'q_male'){
                    //algoliaHelper.setIndex('oxarticles');
                     self._algoliasearchHelper.toggleRefine('filtergender', 'q_male' );
                 
                   
                  //algoliaHelper.addFacetExclusion('filtergender', 'qwq' ).search();
                }
                 if ( $(this).data('value') == 'q_female'){
                    //algoliaHelper.setIndex('test');
                     self._algoliasearchHelper.toggleRefine('filtergender', 'q_female' );
                   // algoliaHelper.setIndex('test').search();
                
                  //algoliaHelper.addFacetExclusion('filtergender', 'qmq' ).search();
                }
            
                 self._algoliasearchHelper.search();
            
            });
            
            $(el).on('click', '.rootcat .toggle-refine', function(e) {
                e.preventDefault();
                self._algoliasearchHelper.clearRefinements('maincat');
            });
            $(el).on('click', '.toggle-refine', function(e) {
                e.preventDefault();
                self._algoliasearchHelper.toggleRefine($(this).data('facet'), $(this).data('value')).search();
                self.recalcActiveFacets();
            });
            $(el).on('click', '.go-to-page', function(e) {
                e.preventDefault();
                //$('html, body').animate({scrollTop: 0}, '500', 'swing');
                self._algoliasearchHelper.setCurrentPage(+$(this).data('page') - 1).search();
            });
            $(el).on('touchend click', '.load-more button', function(e) {
                e.preventDefault();
                self.listOptions.loadMoreForce = true;
                self._algoliasearchHelper.setCurrentPage(+$(this).data('page') - 1).search();
            });
            /*
             this._tpl.target.sortBySelect.on('change', function(e) {
                e.preventDefault();
                self._algoliasearchHelper.setIndex(INDEX_NAME + $(this).val()).search();
            });*/
           
            $(el).on('click', '.remove-numeric-refine', function(e) {
                e.preventDefault();
                self._algoliasearchHelper.removeNumericRefinement($(this).data('facet'), $(this).data('value')).search();
            });
            $(el).on('click', '.clear-all', function(e) {
                e.preventDefault();
                
                self.clearAllRefinements();

            });

            
	        this._super();
	    },
	    setCoreTemplate: function(){
	        var $element = $(this.element);
	        this._tpl.src.listCoreTemplate = Hogan.compile($('#list-core-template').text());
            this._tpl.target.core = $element.find('#core-target');
            this._tpl.target.core.html( this._tpl.src.listCoreTemplate.render() );
	        
	    },
	    setListOptions: function(params){
	        this.listOptions = params;
	    },
	    
	    bindTemlates: function(){
	        //DOM TEMPLATE-TARGET BINDING
	        var $element = $(this.element);
            this._tpl.target.main = $element.find('main');
            this._tpl.target.sortBySelect = $element.find('#sort-by-select');
            this._tpl.target.hits = $element.find('#hits');
            this._tpl.target.stats = $element.find('#stats');
            this._tpl.target.facets = $element.find('#facets');
            this._tpl.target.activefacet = $element.find('#activefacet');
            this._tpl.target.pagination = $element.find('#pagination');

            this._tpl.target.noresults = $element.find('#noresults'); // for no-results
	    },
	    bindHoganTemplates: function(){
            // Hogan templates binding
            this._tpl.src.hitTemplate = Hogan.compile($('#hit-template').text());
            this._tpl.src.statsTemplate = Hogan.compile($('#stats-template').text());
            this._tpl.src.activeFacetTemplate = Hogan.compile($('#active-facet-template').text());
            this._tpl.src.facetTemplate = Hogan.compile($('#facet-template').text());
            this._tpl.src.facetGenderTemplate = Hogan.compile($('#facet-gender-template').text());
            this._tpl.src.sliderTemplate = Hogan.compile($('#slider-template').text());
            this._tpl.src.paginationTemplate = Hogan.compile($('#pagination-template').text());
            
            this._tpl.src.loadMoreTemplate = Hogan.compile($('#load-more-template').text());
            this._tpl.src.noResultsTemplate = Hogan.compile($('#no-results-template').text());
	    },
	    _renderTemplates: function(){
	        
	        this.renderStats();
            this.renderActiveFacet();
            this.renderHits();
            this.renderFacets();
           
            if(this.listOptions.pagination == 'loadmore'){
                 this.renderLoadMore();
            }else{
                this.renderPagination();
            }
            
           
            this.handleNoResults();
            
            this.recalcActiveFacets();
	    },
	   renderPagination: function(content) {
            var content = this._result.content;
            var pages = [];
            if (content.page > 3) {
              pages.push({current: false, number: 1});
              pages.push({current: false, number: '...', disabled: true});
            }
            for (var p = content.page - 3; p < content.page + 3; ++p) {
              if (p < 0 || p >= content.nbPages) continue;
              pages.push({current: content.page === p, number: p + 1});
            }
            if (content.page + 3 < content.nbPages) {
              pages.push({current: false, number: '...', disabled: true});
              pages.push({current: false, number: content.nbPages});
            }
            var pagination = {
              pages: pages,
              prev_page: content.page > 0 ? content.page : false,
              next_page: content.page + 1 < content.nbPages ? content.page + 2 : false
            };
            this._tpl.target.pagination.html( this._tpl.src.paginationTemplate.render(pagination) );
        },
	    renderLoadMore: function() {
	       
	        var content = this._result.content;

            var pagination = { next_page: content.page + 1 < content.nbPages ? content.page + 2 : false };

            if(pagination.next_page ){
                this._tpl.target.pagination.html( this._tpl.src.loadMoreTemplate.render(pagination) );
            }else{
                this._tpl.target.pagination.html('');
            }
        },
        renderHits: function () {
           var content = this._result.content;
        
            if( this.listOptions.loadMoreForce ){
                this._tpl.target.hits.append( this._tpl.src.hitTemplate.render(content) );
                this.listOptions.loadMoreForce = false; // load more is forced by button action
            }else{
                this._tpl.target.hits.html( this._tpl.src.hitTemplate.render(content) );
            }
      
        
        },
        handleNoResults: function() {
            var content = this._result.content;
            if (content.nbHits > 0) {
              this._tpl.target.main.removeClass('no-results');
              this._tpl.target.noresults.html('');
              return;
            }
            this._tpl.target.main.addClass('no-results');
            var filters = this.iterateFilters();
            this._tpl.target.noresults.html(this._tpl.src.noResultsTemplate.render({query: content.query, filters: filters}));
        },
        renderStats: function() {
            var content = this._result.content;
            var stats = {
              query: content.query,
              nbHits: content.nbHits,
              nbHits_plural: content.nbHits !== 1,
              processingTimeMS: content.processingTimeMS
            };
            
            $('.th-count em').html( content.nbHits );
            
            this._tpl.target.stats.html( this._tpl.src.statsTemplate.render(stats) );
        },
        renderFacets: function() {
            var content = this._result.content,
            state = this._result.state;
             
            
            var rootcatrefined = false;
            var facetsHtml = '';
            
            for (var facetIndex = 0; facetIndex < this.listOptions.FACETS_ORDER_OF_DISPLAY.length; ++facetIndex) {
              var facetName = this.listOptions.FACETS_ORDER_OF_DISPLAY[facetIndex];
              var facetResult = content.getFacetByName(facetName);
              if (!facetResult) continue;
              var facetContent = {};
              
              
              // Slider facets
              /*
              if ($.inArray(facetName, FACETS_SLIDER) !== -1) {
                facetContent = {
                  facet: facetName,
                  title: FACETS_LABELS[facetName]
                };
                facetContent.min = facetResult.stats.min;
                facetContent.max = facetResult.stats.max;
                var from = state.getNumericRefinement(facetName, '>=') || facetContent.min;
                var to = state.getNumericRefinement(facetName, '<=') || facetContent.max;
                facetContent.from = Math.min(facetContent.max, Math.max(facetContent.min, from));
                facetContent.to = Math.min(facetContent.max, Math.max(facetContent.min, to));
                facetsHtml += sliderTemplate.render(facetContent);
              } 
              else{
              
              }
              */
              
              if( facetName == 'sizes' ||  facetName == 'maincat' ||  facetName == 'manufacturer' ){ 
                var valuesorting = {sortBy: ['name:asc']};
              }else{
                var valuesorting = {sortBy: ['isRefined:desc', 'count:desc']};
              }
              
              facetContent = {
                facet: facetName,
                title: FACETS_LABELS[facetName],
                values: content.getFacetValues(facetName, valuesorting),
                disjunctive: $.inArray(facetName, this._algoliaOptions.params.disjunctiveFacets) !== -1,
                activeFilterCount: false
              };
              
              
              
              for (var i= 0; i < facetContent.values.length; ++i) {
                 facetContent.values[i].multilang = FACETELEMENTS_LABELS[facetContent.values[i].name]; 
                 if(facetContent.values[i].isRefined ){
                    facetContent.isRefinedParent = true;
                
                    if( facetName == 'rootcat'){
                      
                      rootcatrefined = true;
                    }
                  }
              };
              
              if(facetContent.isRefinedParent){
                if( state.disjunctiveFacetsRefinements[facetName] ){
                
                  facetContent.activeFilterCount = state.disjunctiveFacetsRefinements[facetName].length;
                }
                if( state.facetsRefinements[facetName] ){
                  console.log(state.facetsRefinements[facetName].length);
                  facetContent.activeFilterCount = state.facetsRefinements[facetName].length;
                }
              }
              
              
              if(rootcatrefined){
                facetContent.rootcatrefined = 'rootcatrefined';
              }
              
              
              if( facetName == 'filtergender'){
                facetsHtml += this._tpl.src.facetGenderTemplate.render(facetContent);
              }else{
                facetsHtml += this._tpl.src.facetTemplate.render(facetContent);
              }
              
            }
            this._tpl.target.facets.html(facetsHtml);
        },
        
	    renderActiveFacet: function() {
	        var state = this._result.state;
            var filters = this.iterateFilters(state);
            
            this._tpl.target.activefacet.html(this._tpl.src.activeFacetTemplate.render({filters: filters}));
        },
	    recalcActiveFacets: function(){
	        $element = $(this.element);
            // recalculate facet container
            var containerwidth = 0;
            
            
            $( "#active-facets .toggle-refine" ).each( function( index, element ){
               containerwidth += $(this).outerWidth( true );
            });
            
            $element.find('#active-facets').css('width',containerwidth + 200); // 200 because of .clear refinement width issues

	    },
	    iterateFilters: function(){
            var state = this._result.state;
            var filters = [];
            var i;
            var j;
            for (i in state.facetsRefinements) {
              if( FACETS_LABELS[i] ){
                filters.push({
                  class: 'toggle-refine',
                  facet: i, facet_value: state.facetsRefinements[i],
                  label: FACETS_LABELS[i] + ': ',
                  label_multilang_value: FACETELEMENTS_LABELS[state.facetsRefinements[i]],
                  label_value: state.facetsRefinements[i]
                });
              }
            }
            for (i in state.disjunctiveFacetsRefinements) {
              for (j in state.disjunctiveFacetsRefinements[i]) {
                filters.push({
                  class: 'toggle-refine',
                  facet: i,
                  facet_value: state.disjunctiveFacetsRefinements[i][j],
                  label: FACETS_LABELS[i] + ': ',
                  label_multilang_value: FACETELEMENTS_LABELS[state.facetsRefinements[i]],
                  label_value: state.disjunctiveFacetsRefinements[i][j]
                });
              }
            }
            for (i in state.numericRefinements) {
              for (j in state.numericRefinements[i]) {
                filters.push({
                  class: 'remove-numeric-refine',
                  facet: i,
                  facet_value: j,
                  label: FACETS_LABELS[i] + ' ',
                  label_value: j + ' ' + state.numericRefinements[i][j]
                });
              }
            }
            
            return filters;
        },
	        
        afterRenderFncs: function(){
            
            if($('body').hasClass('mob-a') ){
                 // Css Layout optimizations..
                var hitwidth = 100 /this.listOptions.hitsPerLine + '%' ;
    
                $(this.element).find('.hit').css('width', hitwidth );
            }
            
            $(this.element).find('.hit img').show(); //fadeIn('fast');
            
            
            $( ".hit" ).each( function( index, element ){
                
              
                
                
                
            });
            
            //afterrender plugins
            $( ".a-listing" ).markSaleArticles();
            $( ".a-listing" ).markNewArticles();
          
        },
    });
})( jQuery );
   
( function ( $ ) {    

    /**
     * Cookie note handler
     */
    oxCatList = {

        _categoryid : false,

        /**
         * Enable cookie note dismiss
         *
         * @return false
         */
        _create: function() {
           
            var self    = this,
            options = self.options,
            el      = self.element;
            

            self.setListOptions({
                hitsPerLine: $(el).data('hits-per-line'),
                hitsPerPage:  $(el).data('hits-per-page'),
                pagination: $(el).data('pagination'),
                listStyle : 'grid-two',
                FACETS_ORDER_OF_DISPLAY: ['filtergender','rootcat','maincat','sizes' ,'manufacturer']
            });
 
            this._super();
            
            self.setCoreTemplate();
            self.bindTemlates();
            self.bindHoganTemplates();
            
            self._categoryid =  $(el).data('oxid');
            self._algoliasearchHelper.addFacetRefinement( 'categories_id',  self._categoryid ).search();
             
        },
       
        clearAllRefinements: function(){
             this._algoliasearchHelper
                .clearRefinements()
                .addFacetRefinement( 'categories_id',  this._categoryid )
                .search();
        }
       
    };
    
    
    /**
     * CookieNote widget
     */
    $.widget("ui.oxCatList", $.instalgo.listing , oxCatList );
    

})( jQuery );

( function ( $ ) {    

    /**
     * Cookie note handler
     */
    oxManList = {

        _manufacturerid : false,

        /**
         * Enable cookie note dismiss
         *
         * @return false
         */
        _create: function() {
           
            var self    = this,
            options = self.options,
            el      = self.element;
            

            self.setListOptions({
                hitsPerLine: $(el).data('hits-per-line'),
                hitsPerPage:  $(el).data('hits-per-page'),
                pagination: $(el).data('pagination'),
                listStyle : 'grid-two',
                FACETS_ORDER_OF_DISPLAY: ['filtergender','rootcat','maincat','sizes']
            });
 
            this._super();
            
            self.setCoreTemplate();
            self.bindTemlates();
            self.bindHoganTemplates();
            
            self._manufacturerid =  $(el).data('oxid');
            self._algoliasearchHelper.addFacetRefinement( 'manufacturer_id',  self._manufacturerid ).search();
             
        },
       
        clearAllRefinements: function(){
             this._algoliasearchHelper
                .clearRefinements()
                .addFacetRefinement( 'manufacturer_id',  this._manufacturerid )
                .search();
        }
       
    };
    
    
    /**
     * CookieNote widget
     */
    $.widget("ui.oxManList", $.instalgo.listing , oxManList );
    

})( jQuery );


//--- INSTALGO SEARCH
( function ( $ ) {    

    /**
     * Cookie note handler
     */
    oxSearchList = {

        _categoryid : false,

        /**
         * Enable cookie note dismiss
         *
         * @return false
         */
        _create: function() {
           
            var self    = this,
            options = self.options,
            el      = self.element;
          
            self.setListOptions({
                hitsPerLine: $(el).data('hits-per-line'),
                hitsPerPage:  $(el).data('hits-per-page'),
                pagination: $(el).data('pagination'),
                listStyle : 'grid-two',
                FACETS_ORDER_OF_DISPLAY: ['filtergender','rootcat','maincat','sizes' ,'manufacturer']
            });
 
            this._super();
            
            self.setCoreTemplate();
            self.bindTemlates();
            self.bindHoganTemplates();
            
  
            self._categoryid =  $(el).data('oxid');
            
            //self._algoliasearchHelper.search();
            
            
            $searchInputMob =  $('.instalgo-fixed').find('#search-input-mob');
            
            $searchInputMob
              .on('input propertychange', function(e) {
                
                //bei enter taste schliessen
                if(e.keyCode == 13){
                  $(this).blur();
                }
                
                if( $(this).val().length > 0) { 
                    
                    var query = e.currentTarget.value;
                     self._algoliasearchHelper.setQuery(query).search();
                    
                   // algoliaShow();
            
                }else{
                   self._algoliasearchHelper.setQuery('').clearRefinements().search();
                }
                
              })
              .keyup(function(e){
                if(e.keyCode == 13){
                   $(this).blur();
                }
              })
              .focus(function(e) {

              })
              .blur(function() {
                $('#search-starter').show();
                $('.head-search').css('position','fixed').css('margin-top','0');
                $('#canvas-center').css('margin-top','60px');
                 //$('.head-search').hide();
              });
              
              
              $searchInput = $('#search-input');
              $searchInput
              .on('input propertychange', function(e) {
                
                if( $(this).val().length > 1) { 
            
                   
                    var query = e.currentTarget.value;
                    
                    self._algoliasearchHelper.setQuery(query).search();
                    self.algoliaShow();
                    
                } else if( $(this).val().length > 0 ){
                   //$('.visual-transition').show().css({'opacity':'0.8'});
                 
                }
                else{
                    if( $(this).val().length == 0) { 
                         $('#canvas-center').show();
                         $('.instalgo-fixed').slideUp();
                    }
        
                }
              })
              /*
                function algoliaShow(){
    
                    $('.instalgo-fixed').show();
                    
                    $('#canvas-center').hide();
                    
                    if( $('body').hasClass('mob-a') ){
                      $( '.head-search' ).show();
                    }
                    }
                    
                    $('.head-search').on('click', '.bl-x', function(e) {
                    $( '.head-search' ).hide();
                    $('.instalgo-fixed').hide();
                    $('#canvas-center').show();
                });
                */
                
                $( '.js-search-focus' ).click(function(e) {
                    document.body.scrollTop = 0;
                    var searchcontrol = Hogan.compile($('#list-tophead-searchcontrol-template').text() );

                    $('#tophead-target #searchcontrol').html( searchcontrol.render() );
                    $( '.head-searchcontrol' ).toggle(); 
                    self.launchEmptySearch();
                
                }); 
                
                $('#searchcontrol').on('click', '.th-back', function(e) {
                    $('.head-searchcontrol').hide();
                    
                    $('#canvas-center').show();
                    $('.instalgo-fixed').hide();
                     document.body.scrollTop = 0;
                     $searchInputMob.val('');
                   // $('.facets-box').hide().removeClass().addClass('facets-box');
                  
                });
                
                // hide keyboard quick on touch
                $(el).on('touchstart', 'main', function(e) {
                    $('#search-input-mob').blur();
                
                    $('.head-search').css('position','fixed').css('margin-top','0');
                    $('#canvas-center').css('margin-top','60px');
                
                
                  // $('.head-search').css('height','60px').find('.pos-wrapper').css('margin-top','0');
                });
                                
                $('#search-starter')
                .on('touchstart', function(e) {
                // TODO  body overflow blocking
                // $('.head-search-history').show();
                /*
                 if( navigator.userAgent.match('CriOS')  ){
                   if( document.body.scrollTop > 2){
                  
                    $('#canvas-center').css('margin-top','0');
                   }
                     
                  }else{
                    document.body.scrollTop = 0;
                  }
                  */
                    $('body').css('height','400px').css('overflow','hidden').css('background','red');
                 document.body.scrollTop = 0;
            
                
                })
                .on('touchend', function(e) {
                
                 if( document.body.scrollTop == 0 ){
                  $(this).hide();
                 }
                
                    //stupid shit chrome ios overlapping bar problem
                 //reset search elements
                if( navigator.userAgent.match('CriOS')  ){
                  
                } else{
                  
                 }
                  $searchInputMob.click();
                });


        },
        
        launchEmptySearch: function(){
              this._algoliasearchHelper.setQuery('').search();
              this.algoliaShow();
        },
        
        algoliaShow: function (){
            $('.instalgo-fixed').show();
            
            $('#canvas-center').hide();
            
            if( $('body').hasClass('mob-a') ){
              $( '.head-search' ).show();
            }
        },
    
        clearAllRefinements: function(){
             this._algoliasearchHelper
                .clearRefinements()
              
                .search();
            
        }
       
    };
    
    


    
    /**
     * CookieNote widget
     */
    $.widget("ui.oxSearchList", $.instalgo.listing , oxSearchList );
    
    
  


})( jQuery );



