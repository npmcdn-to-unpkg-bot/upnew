/**
 * This file is part of OXID eSales mobile theme.
 *
 * OXID eSales mobile theme is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * OXID eSales mobile theme is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with OXID eSales mobile theme.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @link      http://www.oxid-esales.com
 * @copyright (C) OXID eSales AG 2003-2013
 */



( function ( $ ) {

    /**
     * Cookie note handler
     */
    oxReco = {

        _article : false,
      
        options: {
            closeButton : ".cookie-note-dismiss",
            assumedSize : false,
        },
        /**
         * Enable cookie note dismiss
         *
         * @return false
         */
        _create: function() {
            var self    = this,
            options = self.options,
            el      = self.element;
            
            
            console.log('as_size' + $.jStorage.get('assumedSizes') );
            
            
            
            var PARAMS = {
                hitsPerPage: $(el).data('hitsperpage'),
                maxValuesPerFacet: 1,
                facets: ['rootcat','filtergender','manufacturer_id','maincat','oxartnum','sizes'],
                disjunctiveFacets: ['filtercolor'],
 
             };
             
             if( $( window ).width() < 920){
                 PARAMS.hitsPerPage = 1;
             }
             
            var algolia = algoliasearch(APPLICATION_ID, SEARCH_ONLY_API_KEY);
            var algoliaHelper = algoliasearchHelper(algolia, INDEX_NAME, PARAMS);
            
              
            $('.tocartselector_container').on('mouseup', 'a', function(e) {
               
                self.options.assumedSize = $(this).html();
               
                algoliaHelper.clearRefinements('sizes').addFacetRefinement( 'sizes', self.options.assumedSize ).search();
                
                if( self._article ){
                    var as_keyname = 'assumedSize_' + self._article.rootcat;
                    $.jStorage.set( as_keyname, self.options.assumedSize );
                }
       
            });    
        
            var promise = self.getArticle( $(el).data('oxid') );
    
            promise.then(function(article) {
                //console.log(article.objectID); // "Stuff worked!"
                  
                self._article = article;
                options.as_keyname = 'assumedSize_' + self._article.rootcat;
                options.assumedSize =  $.jStorage.get(options.as_keyname);
                
                // Template Bindings
                $recoHits = $('#reco-hits');
                $recoArrows = $('#reco-arrows');
                $recoProgressBar = $('#reco-progress-bar');
                
                var recoHitsTemplate = Hogan.compile( $('#reco-hits-template').text() );
                var recoArrowsTemplate = Hogan.compile( $('#reco-arrows-template').text() );
                

                
                // Search results
                algoliaHelper.on('result', function(content, state) {
                    
                   //console.log( content.hits );
                    
                    // Pagination Settings
                    var pagination = {
                      currentpage: content.page + 1, 
                      pages: content.nbPages,
                      prev_page: content.page > 0 ? content.page : false,
                      next_page: content.page + 1 < content.nbPages ? content.page + 2 : false
                    };
                   
                    
                    /*
                    
                    // Custom Result handling----
                    if(content.nbHits < 6){
                            algoliaHelper.setQuery('').search();
                    }
                    
                    if(content.nbPages > 4){
                        if( algoliaHelper.hasRefinements('maincat') == false ){
                            algoliaHelper.addFacetRefinement( 'maincat', maincat ).search();
                        }
                    }
    
                   */
                
                    // Visual Rendering
                    if(content.nbHits < 50000){
                        
                        if(content.nbHits > 0){
                            $recoHits.html( recoHitsTemplate.render(content) );
                            $recoArrows.html(recoArrowsTemplate.render(pagination));
                            

                            // Progessbar calculation
                            var progress = Math.round( ( 100 / pagination.pages * pagination.currentpage ) );
                            $('#reco-progress-bar').animate({width: progress + '%' },300);
                            
                            $('#reco-progress-bar').animate({width: progress + '%' },300, 'swing');
                            
                            
                           
                            // Css Layout optimizations..
                            var hitwidth = 100 / PARAMS.hitsPerPage + '%' ;
                
                            $(el).find('.hit').css('width', hitwidth );
                            $(el).find('.hit img').show(); //fadeIn('fast');
                            
                            var recoheight = $(el).width() / PARAMS.hitsPerPage;
                            $recoHits.height(recoheight);
                            
                            $( ".hit-price" ).each( function( index, element ){
                                var price = $(this).data('price') * CUR_XR;
                                $(this).html( CUR_ISO + ' ' + price.toFixed(2) );
                                
                            });
                        }else{
                            //remove size assumption if too few results
                            algoliaHelper.clearRefinements('sizes').search();
                        }
                                    
                    }
                   
                });
                  
    
                //Pagination events
                $(document).on('click touchstart', '.reco-go-to-page', function(e) {
                   if( !$(this).hasClass('disabled') ){
                        e.preventDefault();
                        $(el).find('.hit').css('opacity', '0.5' );
                        algoliaHelper.setCurrentPage(+$(this).data('page') - 1).search();
                   }
                });
                
             
                
                //Umleitung via seourl
                $('#reco-hits').on('click', '.hit', function(e) {
                    window.location.href = $(this).attr("data-href");
                    return false;
                });
                  
                $('#reco-tabs').on('click', 'li', function(e) {
                    e.preventDefault();
    
                    $('#reco-tabs li').removeClass('active');
                    $(this).addClass('active');
                    
                    $(el).find('.hit').css('opacity', '0.5' );
                   
                    var facetid = $(this).data('tabfacetid');
                    
                    algoliaHelper.clearRefinements();
                 
                    switch (facetid)
                    {
                        case 'manufacturer_id':
                            algoliaHelper.addFacetRefinement( facetid, article.manufacturer_id )
                            .setQuery('');
                            
                        break;
                    
                        case 'maincat':
                            // PROXIMITY RANKING NEEDS TO BE SET BY CREATING OWN INDEX
                            algoliaHelper.addFacetRefinement( facetid, article.maincat )
                            .setQuery( article.oxtitle_1 + ' ' + article.oxtitle_2 + ' '+ article.oxtitle_3 + ' ' + article.oxpic_1 )
                            .setQueryParameter('removeWordsIfNoResults', 'allOptional');
                           
                        break;
                       
                        case 'flex': algoliaHelper.setQuery( article.oxartnum.substring(0,3) );
                        break;
                       
                        case 'colors':    
                             algoliaHelper.addFacetRefinement( 'rootcat', article.rootcat )
                            .setQuery( article.oxtitle_1 + ' ' + article.oxtitle_2 + ' ' + article.oxtitle_3 + ' ' + article.oxpic_1 )
                            .setQueryParameter('removeWordsIfNoResults', 'allOptional');
                           
                           /*
                            for (var i = 0; i < article.filtercolor.length; i++) {
                                algoliaHelper.addDisjunctiveFacetRefinement('filtercolor', article.filtercolor[i] );
                            }
                            */
                            //better results
                            algoliaHelper.addDisjunctiveFacetRefinement('filtercolor', article.filtercolor[0] );
                          
                        break;
    
                        default:  console.log('no facetid = no good');
                    }
                    
                    
                    if( options.assumedSize ){
                        algoliaHelper.addFacetRefinement( 'sizes', options.assumedSize );
                    }
                    
                    if( article.filtergender.length = 1){
                        algoliaHelper.addFacetRefinement( 'filtergender', article.filtergender );
                    }
                    
                    algoliaHelper
                    .addFacetExclusion( 'oxartnum', article.oxartnum )
                    .search();
    
                });
                
                /*
                var self = this;
                if( !$.cookie("displayedCookiesNotification") ) {
                    $.cookie("displayedCookiesNotification", 1, { path: '/', expires: 30 });
                } else {
                    self.element.remove();
                    return false;
                }
                $(self.options.closeButton, self.element).click(
                    function(){
                        self.element.fadeOut('slow').remove();
                        return false;
                    }
                );
                */
                
                // "init" :)
                $('#reco-tabs li').first().click();
                
                
                
             
                
            }, function(err) {
              console.log(err); // Error: "It broke"
            });         

        }, 
        
        /** 
         * Algolia Article getter
         */
        getArticle: function(oxid)
        {
            var PARAMS = {
                hitsPerPage: 1,
                maxValuesPerFacet: 1,
                facets: [],
                disjunctiveFacets: []
             };
            var algolia = algoliasearch(APPLICATION_ID, SEARCH_ONLY_API_KEY);
            var algoliaSingleArticle = algoliasearchHelper(algolia, 'oxarticles_0_oxidseo', PARAMS);
            algoliaSingleArticle.setQuery( oxid ).search();
            
            
            var promise = new Promise(function(resolve, reject) {
                    algoliaSingleArticle.on('result', function(content, state) {
                    
                      var article = content.hits[0];
                   
                      resolve( article );

                    });
            });
            
            
            return promise;
        }
    };
    
    
    

    function renderRecoHits(content) {
        $hits.html(hitTemplate.render(content));

    }

    
    /**
     * CookieNote widget
     */
    $.widget("ui.oxReco", oxReco );

})( jQuery );




/**
 * This file is part of OXID eSales mobile theme.
 *
 * OXID eSales mobile theme is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * OXID eSales mobile theme is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with OXID eSales mobile theme.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @link      http://www.oxid-esales.com
 * @copyright (C) OXID eSales AG 2003-2013
 */

( function( $ ) {
    oxRefineTreeNav = {
        options : {
            blShowFilter : true,
            dropdownItems    : '.dropdown-option'
        },

        _create: function(){
            var self = this;
            var element = self.element;
            var options = self.options;


            $(".js-off-canvas").on( "click", function() {
                  self.showNav( element );
            });
            
            $(element).on( 'touchstart', function(e) {
                  if(e.target != this) return; // only continue if the target itself has been clicked
                  self.hideNav( element );
            });

            $( element ).on( "click", '.js-close', function() {
                self.hideNav( element );
            });
            
            //n.Tree refining
            $('.n-tree').on('touchend', 'li', function(e) {
               
                e.stopPropagation();
                
                //reset everything when click on root cats
                if( $(this).parent().hasClass('l-1') ) {
                 $('.n-tree li *').removeClass('refined');
                }
               
                    
                if( $(this).hasClass('refined') ) {
                   e.preventDefault();
                   $(this).removeClass('refined').parent().removeClass('refined');
                }else{
                  
                  if( $(this).find('ul').length > 0 ) {
                    
                     e.preventDefault();
                     $(this).addClass('refined').parent().addClass('refined');
                  }
                }
            
            });
            
           
             
            //traverse tree and set active refined cats on load
            $('.n-tree').find('.act').addClass('refined').parentsUntil( ".js-sidetree" ).addClass('refined');
    
        },

        /**
         * hide nav box
         */
        hideNav: function( element )
        {
           $( element ).removeClass('open');
        },

        /**
         * Show nav box
         */
        showNav: function( element )
        {
            $( element ).addClass('open');
          
             bodyScrollBlock( '.canvas-nav-inner', '#canvas-nav');
        },

    }

    $.widget( "ui.oxRefineTreeNav", oxRefineTreeNav );

} )( jQuery );


 function bodyScrollBlock(allowedEl,blockedEl){
        
        // Uses document because document will be topmost level in bubbling
        $(document).on('touchmove',function(e){
          e.preventDefault();
        });
        
        var scrolling = false;
        
        // Uses body because jquery on events are called off of the element they are
        // added to, so bubbling would not work if we used document instead.
        $('body').on('touchstart',allowedEl,function(e) {
        
            // Only execute the below code once at a time
            if (!scrolling) {
                scrolling = true;   
                if (e.currentTarget.scrollTop === 0) {
                  e.currentTarget.scrollTop = 1;
                } else if (e.currentTarget.scrollHeight === e.currentTarget.scrollTop + e.currentTarget.offsetHeight) {
                  e.currentTarget.scrollTop -= 1;
                }
                scrolling = false;
            }
        });
        
        // Prevents preventDefault from being called on document if it sees a scrollable div
        $('body').on('touchmove',blockedEl,function(e) {
          e.stopPropagation();
        });
        
     /*
        $('body').css('top', $(window).scrollTop() * -1 );
        $('body').css('position','fixed');
        $('body').css('height','100vh');
        
 */

    }
    
     
    
    function bodyScrollUnBlock(){
         $(document).off('touchmove');
  
        /*
        $('body').scrollTop( $('body').css('top') * -1 );
        $('body').css('top','' );
        $('body').css('position','');
        */
   

    }
    
  



