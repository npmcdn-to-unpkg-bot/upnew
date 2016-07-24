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
    oxMiniBasketLoader = {
        options:{
             jStorageKey: "minibasketeditmode",
        },
        /**
         * Initiating article variants selector
         * @private
         */
        _create: function () {
           
         
            
            $(".js-openMiniBasket").click( redirect );
            
            
            /*
            $(".js-openMiniBasket").mouseenter( function(){
                
                $this = $(this);
                $this.data("delay", setTimeout( function () {
                    redirect();
                }, 130)
                ).mouseleave(function () {
                    $this = $(this);
                    
                    clearTimeout($this.data("delay"));
                    
                });
              
                
              });
              */
            /*
            $(".js-openMiniBasket").parent().mouseeleave( function(){
                 $(".basketFlyout").hide();
            }
            */
           
           
           
            $("form.js-oxMiniBasketLoader").submit( formSubmit );
            
            //$(".minibasket-a").mouseenter( redirect );
            
            /*$(".minibasket-a").mouseleave(function(){
                $("#minibasket_container").removeClass('open');
               
            });*/
            

        },

        /**
         * Reloads block
         *
         * @param activator
         * @param highlightTargets
         * @param contentTarget
         * @param aOptions
         * @returns {boolean}
         */
        reload: function ( activator, highlightTargets, contentTarget, aOptions ) {
            preAjaxCaller();

 
                 oxAjax.ajax(
                            activator, {//targetEl, onSuccess, onError, additionalData
                                'targetEl'  : highlightTargets,
                                'iconPosEl' : $("#variants .dropdown"),
                                'additionalData' : aOptions,
                                'onSuccess' : function(r) {
                                    $( contentTarget ).html( r );
                                        if ( typeof WidgetsHandler !== 'undefined') {
                                            WidgetsHandler.reloadWidget('oxminibasket');
                                        } else {
                                            oxAjax.evalScripts(contentTarget);
                                        }
                                        afterAjaxCaller();
                                  
                                }
                            }
                        );
  
           
            return false;
        }
    }

 
  
     /**
     * Redirects from other selectors
     *
     * @returns {*}
     */
    function redirect(){
        $("form.js-oxMiniBasketLoader").submit();
    }

    /**
     * Handles form submit
     *
     * @returns {*}
     */
    function formSubmit() {
       
        var aOptions = {}, target = $(this);
        
        return oxMiniBasketLoader.reload( $(target),$("#minibasket_container"),$("#minibasket_container")[0], aOptions);
    }

    /**
     * Runs defined scripts inside the method, before ajax is called
     */
    function preAjaxCaller() {
        
        scroll(0,0);
      
       $.jStorage.set("minibasketeditmode", false);
       /* $('html, body').animate({
        scrollTop: 0
        },500, 'easeOutExpo');*/
        
        // $('#bootbox').html('<div class="ajax-loading"></div>');
         
    }

     /**
     * Runs defined scripts inside the method, before ajax is called
     */
    function afterAjaxCaller() {

        //$('#bootbox').html('<div class="ajax-loading"></div>');
        
         $('#minibasket_container').addClass('open');
    }

    $.widget( "ui.oxMiniBasketLoader", oxMiniBasketLoader );

} )( jQuery );