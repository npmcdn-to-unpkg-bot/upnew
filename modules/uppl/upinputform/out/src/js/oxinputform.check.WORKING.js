// use https://javascriptobfuscator.com/Javascript-Obfuscator.aspx

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
 
  //SOLR Client Functions
  var SEARCH_CLIENT_RESULTS = solr_search_API_ARTICLESEARCH( SEARCH_ONLY_API_KEY );
  var SEARCH_FILTER_RESULTS = solr_search_API_FILTERHANDLER( SEARCH_ONLY_API_KEY );
  var SEARCH_PAGINATION_RESULTS = solr_search_API_PAGINATION( SEARCH_ONLY_API_KEY );
  

  var PARAMS = {
    hitsPerPage: 36,
    maxValuesPerFacet: 100,
    facets: ['rootcat','filtergender','price'],
    disjunctiveFacets: [ 'maincat','sizes','manufacturer']
  };
  // var FACETS_SLIDER = ['price'];
  var FACETS_ORDER_OF_DISPLAY = ['filtergender','rootcat','maincat','sizes' ,'manufacturer',];
  //var FACETS_LABELS in template
  //var FACETELEMENTS_LABELS  in template
  
  
  //CSS STYLES
  var algolia = algoliasearch(APPLICATION_ID, SEARCH_ONLY_API_KEY);
  var algoliaHelper = algoliasearchHelper(algolia, INDEX_NAME, PARAMS);
  
  // Hogan templates binding
  var hitTemplate = Hogan.compile($('#hit-template').text());
  var statsTemplate = Hogan.compile($('#stats-template').text());
  var activeFacetTemplate = Hogan.compile($('#active-facet-template').text());
  var facetTemplate = Hogan.compile($('#facet-template').text());
  var facetGenderTemplate = Hogan.compile($('#facet-gender-template').text());
  var sliderTemplate = Hogan.compile($('#slider-template').text());
  var paginationTemplate = Hogan.compile($('#pagination-template').text());
  var noResultsTemplate = Hogan.compile($('#no-results-template').text());

 

  // RENDER FUNCTIONS
  // ========================

  function renderStats(content) {
    var stats = {
      query: content.query,
      nbHits: content.nbHits,
      nbHits_plural: content.nbHits !== 1,
      processingTimeMS: content.processingTimeMS
    };
    
    $('.th-count em').html( content.nbHits );
    
    $stats.html(statsTemplate.render(stats));
  }

  function renderHits(content) {
   
      $hits.html( hitTemplate.render(content) );

    
  }

  function renderFacets(content, state) {
    var rootcatrefined = false;
    var facetsHtml = '';
    for (var facetIndex = 0; facetIndex < FACETS_ORDER_OF_DISPLAY.length; ++facetIndex) {
      var facetName = FACETS_ORDER_OF_DISPLAY[facetIndex];
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
      
      if( facetName == 'sizes' ||  facetName == 'maincat'){ //maincat evtl nicht, aber das weiss marc sicher besser...
        var valuesorting = {sortBy: ['name:asc']};
      }else{
        var valuesorting = {sortBy: ['isRefined:desc', 'count:desc']};
      }
      
      facetContent = {
        facet: facetName,
        title: FACETS_LABELS[facetName],
        values: content.getFacetValues(facetName, valuesorting),
        disjunctive: $.inArray(facetName, PARAMS.disjunctiveFacets) !== -1,
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
        facetsHtml += facetGenderTemplate.render(facetContent);
      }else{
        facetsHtml += facetTemplate.render(facetContent);
      }
      
    }
    $facets.html(facetsHtml);
  }

  function bindSearchObjects(state) {
    // Bind Sliders
    /*
    for (facetIndex = 0; facetIndex < FACETS_SLIDER.length; ++facetIndex) {
      var facetName = FACETS_SLIDER[facetIndex];
      var slider = $('#' + facetName + '-slider');
      var sliderOptions = {
        type: 'double',
        grid: true,
        min: slider.data('min'),
        max: slider.data('max'),
        from: slider.data('from'),
        to: slider.data('to'),
        prettify: function(num) {
          return '$' + parseInt(num, 10);
        },
        onFinish: function(data) {
          var lowerBound = state.getNumericRefinement(facetName, '>=');
          lowerBound = lowerBound && lowerBound[0] || data.min;
          if (data.from !== lowerBound) {
            algoliaHelper.removeNumericRefinement(facetName, '>=');
            algoliaHelper.addNumericRefinement(facetName, '>=', data.from).search();
          }
          var upperBound = state.getNumericRefinement(facetName, '<=');
          upperBound = upperBound && upperBound[0] || data.max;
          if (data.to !== upperBound) {
            algoliaHelper.removeNumericRefinement(facetName, '<=');
            algoliaHelper.addNumericRefinement(facetName, '<=', data.to).search();
          }
        }
      };
      slider.ionRangeSlider(sliderOptions);
    }  */
  }

  function renderPagination(content) {
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
    $pagination.html(paginationTemplate.render(pagination));
  }
  
  function renderLoadMore(content) {
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
    $pagination.html(loadMoreTemplate.render(pagination));
  }

  // NO RESULTS
  // ==========

  function handleNoResults(content) {
    if (content.nbHits > 0) {
      $main.removeClass('no-results');
      $noresults.html('');
      return;
    }
    $main.addClass('no-results');
    var filters = iterateFilters();
    $noresults.html(noResultsTemplate.render({query: content.query, filters: filters}));
  }
  

  
  function renderActiveFacet(state) {
    var filters = iterateFilters(state);
    $activefacet.html(activeFacetTemplate.render({filters: filters}));

  }
  
  function recalcActiveFacets(){
   // recalculate facet container
   var containerwidth = 0;

   $( "#active-facets .toggle-refine" ).each( function( index, element ){
       containerwidth += $(this).outerWidth( true );
    });
    $('#active-facets').css('width',containerwidth + 200); // 200 because of .clear refinement width issues
  }
  
  function iterateFilters(state){
    
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
  }

$(document).ready(function() {


  // DOM BINDING
  $searchInputMob =  $('#search-input-mob');
  $searchInput = $('#search-input');
  $searchInputIcon = $('#search-input-icon');
  $main = $('main');
  $sortBySelect = $('#sort-by-select');
  $hits = $('#hits');
  $stats = $('#stats');
  $facets = $('#facets');
  $activefacet = $('#activefacet');
  $pagination = $('#pagination');
  
  $noresults = $('#noresults'); // for no-results



  

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
  
  
  $( '.js-search-focus' ).click(function(e) {
    document.body.scrollTop = 0;
    $( '.head-searchcontrol' ).toggle(); 
    launchEmptySearch();
  
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
  
  
  // hide keyboard quick on touch
  $('.instalgo-fixed').on('touchstart', 'main', function(e) {
    $('#search-input-mob').blur();
    
      $('.head-search').css('position','fixed').css('margin-top','0');
        $('#canvas-center').css('margin-top','60px');
    
    
      // $('.head-search').css('height','60px').find('.pos-wrapper').css('margin-top','0');
  });
  
  


 
  function launchEmptySearch(){
    
        algoliaHelper.setQuery('').search();
        algoliaShow();

  }
  

  $searchInputMob
  .on('input propertychange', function(e) {
    
    //bei enter taste schliessen
    if(e.keyCode == 13){
      $(this).blur();
    }
    
    if( $(this).val().length > 0) { 
      
         
        var query = e.currentTarget.value;
        //ttoggleIconEmptyInput(query);
        algoliaHelper.setQuery(query).search();
        
        algoliaShow();

    }else{
      algoliaHelper.setQuery('').clearRefinements().search();
    }
    
  })
  .keyup(function(e){
    if(e.keyCode == 13){
       $(this).blur();
    }
  })
  .focus(function(e) {
    
  
     if( navigator.userAgent.match('CriOS') && document.body.scrollTop == 0 ){
     // $('.head-search').find('.pos-wrapper').css('margin-top','55px').find('input').css('height','40px').css('top','10px');
     }

  })
  .blur(function() {
     $('#search-starter').show();
 
     
       $('.head-search').css('position','fixed').css('margin-top','0');
      $('#canvas-center').css('margin-top','60px');
       //$('.head-search').hide();
  });


  
 
  
  // SEARCH BINDING
  // ==============
  $('.instalgo-fixed').after('<div class="visual-transition"><div class="square-spinner"></div>');
  // Input binding
  $searchInput
  .on('input propertychange', function(e) {
      $('.visual-transition').hide();
    
    if( $(this).val().length > 1) { 
        //$('.instalgolia-fixed').slideDown('slow');
       
        var query = e.currentTarget.value;
        toggleIconEmptyInput(query);
        algoliaHelper.setQuery(query).search();
        
        algoliaShow();

        //algoliaHelper.addDisjunctiveFacetRefinement('filtergender', 'qwq');


        
    } else if( $(this).val().length > 0 ){
       //$('.visual-transition').show().css({'opacity':'0.8'});
     
    }
    else{
        if( $(this).val().length == 0) { 
         $('#canvas-center').show();
         $('.instalgo-fixed').slideUp();
       
        }
       // alert("hide");
    }
  })
  .focus(function() {
     // $('.visual-transition').show();
    //$("html, body").animate({ scrollTop: 0 }, 1);
  })
  .blur(function() {
      //$('.visual-transition').hide();
    //$("html, body").animate({ scrollTop: 0 }, 1);
  })

  // Search errors
  algoliaHelper.on('error', function(error) {
    console.log(error);
  });

  // Update URL
  algoliaHelper.on('change', function(state) {
    setURLParams();
    
    console.log(algoliaHelper);
  });

  // Search results
  algoliaHelper.on('result', function(content, state) {
    renderStats(content);
    renderActiveFacet(content);
    renderHits(content);
    renderFacets(content, state);
    bindSearchObjects(state);
    renderPagination(content);
    handleNoResults(content);
    
    
   $( ".hit-price" ).each( function( index, element ){
        var price = $(this).data('price') * CUR_XR;
        $(this).html( CUR_ISO + ' ' + price.toFixed(2) );
        
    });
    recalcActiveFacets();

  });
  
 

  function cloneFacets(target){
  
    $( target ).empty();

   // $( $( "#facets .facet" ).get().reverse() ).each( function( index, element ){
    
    
    $(target).append( '<div class="facetinfos">' + $('#stats #nbhits').html() + '</div>');
    
    
    
    $( "#facets .facet" ).each( function( index, element ){
      var facetclass = $( this).attr('class').replace('facet', '');
      var clone = $( this).clone();  
      
       clone.find( 'h5' ).append('...');
      
      var step = index + 1;
      var steps = $('#facets .facet').length;
      $( target ).append( '<div data-fcs="' + index + '" class="facetslide '+facetclass+' facetslide-' + index + '"><div class="slidehead">Artikel Suche<span class="pull-right">Schritt <b>'+step+'</b> / <b>'+steps+'</b></span></div>'+ clone.html() +'<div class="slidefooter"><div class="prev i-' + index + '"><span class="glyphicon glyphicon-menu-left"></span> Zurück</div><div class="skip">Schritt überspringen <span class="glyphicon glyphicon-menu-right"></span></div></div></div>');
      
      
    });
    
    /*
 
     //add questionmark, ellipsis oder colon to questions
    $( ".facetslide .facet-refined" ).each( function( index, element ){
      $('.facetinfos').prepend( $( this).html());
    }); 
    
    */
    
    
   //slide-control
    var slidenum = $(target).attr('data-fcs');
    if( $( '.facetslide-'+ slidenum ).length ){
      $( '.facetslide-'+ slidenum ).addClass( "fcs-active" );
      $( target ).show();
    }else{
      $('.quickselect').attr('data-fcs', -1);
      $('.quickselect').detach();
      $( "#viewport" ).removeClass('blurred');
      $('.instalgo-fixed').show();
      
    }
 
  }

  $(document).on('click', '.skip', function(e) {  
       var slide = $(this).closest( '.facetslide' );
      
      if( slide.next().length > 0 ){
          slide.removeClass('fcs-active');
          slide.next().addClass('fcs-active');
          
           var nextslidenum = parseInt( $('.quickselect').attr('data-fcs') ) + 1;
          $('.quickselect').attr('data-fcs', nextslidenum );
           $('.facetslide').addClass('pushed-left');
      }else{
        $( "#viewport" ).removeClass('blurred');
         $('.quickselect').detach();
          
          
          
      }
       
  });
  
   $(document).on('click', '.prev', function(e) {  
       var slide = $(this).closest( '.facetslide' );
      
      if( slide.prev().length > 0 ){
          slide.removeClass('fcs-active');
          slide.prev().addClass('fcs-active');
          
           var nextslidenum = parseInt( $('.quickselect').attr('data-fcs') ) - 1;
          $('.quickselect').attr('data-fcs', nextslidenum );
      }else{
        $( "#viewport" ).removeClass('blurred');
        $('.quickselect').detach();
        
       

      }
       
  });
  
  $(document).on('click', ' .facet-link', function(e) {
    
    var slidenum = parseInt( $('.quickselect').attr('data-fcs') );
    
    if( !$(this).hasClass("facet-refined") ){
     // if has class disjunctive...
      slidenum++;
   
    } 
    $('.quickselect').attr('data-fcs', slidenum );
 
  });
    
     
  // start event  
  //$( "#search-input" ).dblclick(function(e) {
    $( ".glyphicon-envelope" ).click(function(e) {
    
     $('body').addClass('mob-a');
     
      
      $('#canvas-center').hide();
      var query = e.currentTarget.value;
     //toggleIconEmptyInput(query);
      //algoliaHelper.setQuery(query).search();
       
     
      algoliaHelper.setQuery('').clearRefinements().search();
      
      //$( "#viewport" ).addClass('blurred');
     
      var t = $('<div class="quickselect"></div>');
      $('body').prepend(t);

      $('.quickselect').attr('data-fcs', '0');

      
      algoliaHelper.on('result', function(content, state) {
     
        cloneFacets('.quickselect');
      });
     
      
     
      
  });
  
  
  // MOBILE FACET FILTERS DESING
  // ========================
  /*
  $('.page-facetcontrol').on('click', 'button', function(e) {
    
   
    var facets = $(this).data('facets-class');
    
    var title = $(this).data('facets-title');
      
    $('.head-facetcontrol .th-title').html( title );
    
    $('.head-facetcontrol').show();
    $('.facets-box').addClass( 'facets-' + facets + '-show' ).show();
    
   var offset = $('.facets-box').offset();
   var margin = (offset.top - 60) * -1;
   
   $('.facets-box').css('margin-top', margin );
    
    $('.hits-box').hide();

  });*/
  
  
  
  $('.head-facetcontrol').on('click', '.th-back', function(e) {
    $('.head-facetcontrol').hide();
    $('.facets-box').hide().removeClass().addClass('facets-box').css('margin-top',0 );
  
    $('.hits-box').show();
    document.body.scrollTop = 0;
    
    recalcActiveFacets();

  
  });

  $('.head-searchcontrol').on('click', '.th-back', function(e) {
    $('.head-searchcontrol').hide();
    
    $('#canvas-center').show();
    $('.instalgo-fixed').hide();
    
   // $('.facets-box').hide().removeClass().addClass('facets-box');
  
  });

    




  // EVENTS BINDING
  // ==============
  
  $(document).on('click', '.toggle-gender-refine', function(e) {
    e.preventDefault();
    
    
     //reset to default index
    if( $(this).parent().hasClass('facet-refined') ){
      algoliaHelper.clearRefinements('maincat');
      //algoliaHelper.setIndex('oxarticles'); // reset index
    }
    
    if ( $(this).data('value') == 'q_male'){
        //algoliaHelper.setIndex('oxarticles');
        algoliaHelper.toggleRefine('filtergender', 'q_male' );
     
       
      //algoliaHelper.addFacetExclusion('filtergender', 'qwq' ).search();
    }
     if ( $(this).data('value') == 'q_female'){
        //algoliaHelper.setIndex('test');
        algoliaHelper.toggleRefine('filtergender', 'q_female' );
       // algoliaHelper.setIndex('test').search();
    
      //algoliaHelper.addFacetExclusion('filtergender', 'qmq' ).search();
    }
    

   
    algoliaHelper.search();

    
  });
 
  $(document).on('click', '.rootcat .toggle-refine', function(e) {
    e.preventDefault();
    algoliaHelper.clearRefinements('maincat');
  });
  $(document).on('click', '.toggle-refine', function(e) {
    e.preventDefault();
    algoliaHelper.toggleRefine($(this).data('facet'), $(this).data('value')).search();
    recalcActiveFacets();
  });
  $(document).on('click', '.go-to-page', function(e) {
    e.preventDefault();
    $('html, body').animate({scrollTop: 0}, '500', 'swing');
    algoliaHelper.setCurrentPage(+$(this).data('page') - 1).search();
  });
  $sortBySelect.on('change', function(e) {
    e.preventDefault();
    algoliaHelper.setIndex(INDEX_NAME + $(this).val()).search();
  });
  $searchInputIcon.on('click', function(e) {
    e.preventDefault();
    $searchInput.val('').keyup().focus();
  });
  $(document).on('click', '.remove-numeric-refine', function(e) {
    e.preventDefault();
    algoliaHelper.removeNumericRefinement($(this).data('facet'), $(this).data('value')).search();
  });
  $(document).on('click', '.clear-all', function(e) {
    e.preventDefault();
    //$searchInput.val('').focus();
    algoliaHelper.clearRefinements().setQuery( $searchInput.val() ).search();
    //algoliaHelper.setIndex('oxarticles');
    //algoliaHelper.setQuery('').clearRefinements().search();
  });

  


  // URL MANAGEMENT
  // ==============

  function initFromURLParams() {
    var URLString = window.location.search.slice(1);
    var URLParams = algoliasearchHelper.url.getStateFromQueryString(URLString);
    if (URLParams.query) $searchInput.val(URLParams.query);
    if (URLParams.index) $sortBySelect.val(URLParams.index.replace(INDEX_NAME, ''));
    algoliaHelper.overrideStateWithoutTriggeringChangeEvent(algoliaHelper.state.setQueryParameters(URLParams));
    
    
    if($('body').hasClass('mob-a')){
       $('.head-searchcontrol').show();
    }
    algoliaShow();
  }

  var URLHistoryTimer = Date.now();
  var URLHistoryThreshold = 700;
  
  function setURLParams() {
    var trackedParameters = ['attribute:*'];
    if (algoliaHelper.state.query.trim() !== '')  trackedParameters.push('query');
    if (algoliaHelper.state.page !== 0)           trackedParameters.push('page');
    if (algoliaHelper.state.index !== INDEX_NAME) trackedParameters.push('index');

    var URLParams = window.location.search.slice(1);
    
    var nonAlgoliaURLParams = algoliasearchHelper.url.getUnrecognizedParametersInQueryString(URLParams);
    var nonAlgoliaURLHash = window.location.hash;
    var helperParams = algoliaHelper.getStateAsQueryString({filters: trackedParameters, moreAttributes: nonAlgoliaURLParams});
    if (URLParams === helperParams) return;

    var now = Date.now();
    if (URLHistoryTimer > now) {
      window.history.replaceState(null, '', '?' + helperParams + nonAlgoliaURLHash);
    } else {
      window.history.pushState(null, '', '?' + helperParams + nonAlgoliaURLHash);
    }
    URLHistoryTimer = now+URLHistoryThreshold;
  }


  
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
    initFromURLParams();
    algoliaHelper.search();
  }
  
  //popstate  history init
  window.addEventListener('popstate', function() {
    
    if ( hasUrlSearchParams() ) { //popstate issue with safari
          initFromURLParams();
          algoliaHelper.search();
    }
  });
  



  // HELPER METHODS
  // ==============

  function toggleIconEmptyInput(query) {
    $searchInputIcon.toggleClass('empty', query.trim() !== '');
  }


});
