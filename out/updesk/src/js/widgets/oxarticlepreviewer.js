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

    var oxArticlePreviewer = {

        /**
         * Initiating article variants selector
         * @private
         */
        _create: function () { 
           var self = this;
            
   
            $(window).scroll( $.debounce( 10, true, function(){
                $('body').addClass('scrolling');
            }) );
            $(window).scroll($.debounce( 200, function(){
                $('body').removeClass('scrolling');
            }));
     
            
            
            //$(".instalgo-fixed").on("touchend", ".hit", previewSubmit  );
            
            $(".instalgo-fixed").on("click", ".hit", previewSubmit );
            
            $(".qpv").on("click", ".hit", previewSubmit );
            
            
            $(".qpv").on("touchend", "article", previewSubmit );
            
            // dirty trick but genius at the same time
            $("article").on("click", ".aqv", function(){
                $(this).parents('article').trigger('touchend');
                return false;
            });
            
            
            $('.articlepreviewer-modal').on("click", ".js-close-preview", function(){
               self.resetContainer();
                return false;
            });
            
            
            /* coverflow hold on reload*/
            $('.articlepreviewer-modal').on("mouseleave", ".controls-preview", function(){
               $('.articlepreviewer-modal').removeClass('js-enterhold-next').removeClass('js-enterhold-prev');
            });
            
                /* coverflow hold on reload*/
            $('.articlepreviewer-modal').on("click", ".js-control-pushdown-preview", function(){
               $('.articlepreviewer-modal').toggleClass('controls-pushdown-preview');
               $(this).toggleClass('rot180');
               return false;
            });
            
           
            
            $('.articlepreviewer-modal').on("click", "#toBasket", function(){
                console.log("to cart clicked");
                 bodyScrollUnBlock();
                $('.articlepreviewer-modal').hide();
                
                //nicht reset sonst formular weg
                //self.resetContainer();
                
            });
            
            $('.articlepreviewer-modal').on("touchstart click", ".next-preview", function(){
                
                //enterhold gibt status das weitergeswitcht wird
                $('.articlepreviewer-modal').addClass('js-enterhold-next');
                
                if( $('.previewed').next().length > 0 ){
                    if( $('.previewed').parents('.qpv').hasClass('article-list') ){
                        $('.previewed').next().trigger('touchend');
                    }else{
                        $('.previewed').next().click();
                    }
                }else{
                    
                    self.resetContainer();
                }
                
                
                
          
                
                return false;
            });
            
           
            
            $('.articlepreviewer-modal').on("touchstart click", ".prev-preview", function(){
                $('.articlepreviewer-modal').addClass('js-enterhold-prev');
                if( $('.previewed').prev().length > 0 ){
                    if( $('.previewed').parents('.qpv').hasClass('article-list') ){
                        $('.previewed').prev().trigger('touchend');
                    }else{
                        $('.previewed').prev().click();
                    }
                    
                    
                }else{
                    self.resetContainer();
                }
                return false;
            });
            
            $(document).click( function( e ){
                if( !$(e.target).parents("div").hasClass('articlepreviewer') ){
                   self.resetContainer();
                }
            });
            
            $(document).keydown( function( e ) {
               if( e.which == 27) {
                     self.resetContainer();
               }
            });
            
            
            window.addEventListener('popstate', function() {
                // closing the whole thing... skipping back through articles.. should be done by arrows
                self.resetContainer();
            });
            
             
              /*     
            document.ontouchmove =  function disableScrolling(){
              alert(1);
                var x=window.scrollX;
                var y=window.scrollY;
                window.onscroll=function(){window.scrollTo(x, y);};
            }
            
            function enableScrolling(){
                window.onscroll=function(){};
            }
            */
            
            
            
            // note ... when opening previewer... set algo url to parent and use seo linking from articles...
            
            // TODO Init from URL function... check if url contains previewid, if yes.. open window..
             /*
             
             var url = window.location.href;
                
                if (url.indexOf('previewid') !=-1) {
                    self.resetContainer();
                    
                }else{
                    
                }
             */
           
            
        },
        URL_add_parameter: function ( param, value){
           // var stateObj = { foo: "bar" };
            var url = window.location.href;
            
            // overwrite existing parameters indem wir cleanen..
            
            url =  oxArticlePreviewer.URL_get_cleaned_url( param );
            var previewerParam = '?' + param + '=' + value;
            
            var targetUrl = url + previewerParam;
            
            //window.history.replaceState( {} , "page 2", targetUrl);
            
            window.history.pushState({url: "" + targetUrl + ""}, "page 2" + Math.random().toString(36).substring(7), targetUrl);
        },
        
        URL_get_cleaned_url: function ( param){
          
          
           var url = window.location.href;
    
            var fields = url.split( '?' + param );
            
            //  TODO zweitersplit um danach alles zu retten und hinten ansetzen... 
            var cleanedurl = fields[0];
            
            return cleanedurl;
        },
        
        URL_remove_parameter: function ( param){
            var cleanedurl =   oxArticlePreviewer.URL_get_cleaned_url( param );
            
            //issues with history back :()
            window.history.replaceState( {} , "page 2", cleanedurl);
            //window.history.pushState( {} , "page 2", cleanedurl);
        },
        resetContainer: function(){
            
            oxArticlePreviewer.URL_remove_parameter('previewid');
            
          
            $('.articlepreviewer-modal').removeClass('[class^="js-enterhold-"]');
            
            $('.articlepreviewer-modal').addClass('transform-hidden');
            
            $('.articlepreviewer-modal').empty();
            
            bodyScrollUnBlock();
            
        },

        reload: function ( activator, contentTarget ) {
           
            preAjaxCaller();
       
            //this.resetContainer();
            
            oxAjax.ajax(
                activator, {//targetEl, onSuccess, onError, additionalData
                
                    'onSuccess' : function(r) {
                        
                       
                        $( contentTarget ).html( r );
                    

                        $('.previewer-article-slider').slick({ dots:true,infinite: true,arrows:true, lazyLoad: 'progressive'}); 
                        
                        if(window.innerWidth < 920){
                            $('#product-pictures').css('width', window.innerWidth );
                            $('#morePicsContainer').css('padding-bottom', window.innerWidth ); // for god sake 1:1 ratio
                            //$('.articlepreviewer-modal').scrollTop(20);
                            
                        }
                       
                        $('#product-pictures').fadeIn();
                        $('.previewer-article-slider').slick('setPosition'); 
                        $('.articlepreviewer-modal').removeClass('loading');
                        
                        
                        //$('.articlepreviewer-modal').removeClass('[class^="transform-from-"]');
                        $('.articlepreviewer-modal').removeClass('transform-from-right');
                        $('.articlepreviewer-modal').removeClass('transform-from-bottom');
                        
                       
                        bodyScrollBlock( '.articlepreviewer', '.articlepreviewer-modal');
                    
                        
                        if ( typeof WidgetsHandler !== 'undefined') {
                            WidgetsHandler.reloadWidget('oxarticlepreviewer');
                        } else {
                           
                            oxAjax.evalScripts(contentTarget);
                        }
                        
                         
                        if( $('.previewed').prev().length > 0 ){
                            var imgtoclone = $('.previewed').prev().find("img");
                            var imgclone =  imgtoclone.clone().prependTo( '.prev-preview' );
                        }else{
                            $('.prev-preview').detach();
                        } 
                        
                        if( $('.previewed').next().length > 0 ){
                            var imgtoclone = $('.previewed').next().find("img");
                            var imgclone =  imgtoclone.clone().prependTo( '.next-preview' );
                        }else{
                            $('.next-preview').detach();
                        }  
        
                        
                    }
                }
            );
   
            return false;
        }
  
    }

    /**
     * Handles form submit
     *
     * @returns {*}
     */
    function previewSubmit() {
        $.debounce( 10, true,function(){
        });
        
        $.powerTip.hide();
           
        if( !$('.instalgo-fixed').hasClass('scrolling') ) { }
        
        var anid = $(this).data('anid');
        var target =   ("form.js-oxArticlePreviewer");
        $('.previewed').removeClass('previewed');
        //set anid to form
        $( "input[name=anid]", target ).val( anid );
        $(this).addClass('previewed'); // marking previewed item
        
        
        //load more hits ahead
        if( $(this).index('.hit') + 1  ==  $(this).parent('.qpv').find('.hit').length ){
            $('.load-more button').trigger('touchend');
            //console.log( $(this).index('.hit') + 1  + ' - ' +  $(".qpv > .hit").length + 'amk'    );
        }
        
        //move this to success response
        oxArticlePreviewer.URL_add_parameter('previewid', anid );
        
       
        // location.href = oxArticlePreviewer.URL_add_parameter(location.href, 'apvid', $(this).data('anid') );
        
        //zoomOutMadafaka(this);
        return oxArticlePreviewer.reload( $(target),$(".articlepreviewer-modal"));
      
        
       
    }
   
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
    
    function zoomOutMadafaka(hit) {
        var imgtodrag = $(hit).find("img");
        if (imgtodrag) {
            var imgclone =  imgtodrag.clone()
                            .css({
                                    'opacity': '0.4',
                                    'position': 'absolute',
                                    'height': '150px',
                                    'width': '150px',
                                   
                                   
                                    'top': 0,
                                    'left': 0,
                                    'bottom': 0,
                                    'right': 0,
                                    'margin': 'auto',
                            })
                            .prependTo($('.articlepreviewer-modal'));
           
               
            imgclone.animate({
                'width':$(window).height() * 0.9,
                'height': $(window).height() * 0.9,
                'opacity': '0',
            }, function () {
                $(this).detach();
            });
        }
     }
    
    /**
     * Runs defined scripts inside the method, before ajax is called
     */
    function preAjaxCaller() {
        


        
        //only add class on initial load
        if ( !$('.articlepreviewer-modal').hasClass('js-enterhold-next') && !$('.articlepreviewer-modal').hasClass('js-enterhold-prev')) {
           
           
            if(window.innerWidth < 920){
                $('.articlepreviewer-modal').addClass('transform-from-right'); //added and released with response!
                 $('.articlepreviewer-modal').addClass('transform-from-bottom'); 
            }
        }
        
        $('.articlepreviewer-modal').css('display', ''); //reset hiding from to cart process
        $('.articlepreviewer-modal').addClass('loading');
       
        $('.articlepreviewer-modal').removeClass('transform-hidden');

    }

    $.widget("ui.oxArticlePreviewer", oxArticlePreviewer );

})( jQuery );