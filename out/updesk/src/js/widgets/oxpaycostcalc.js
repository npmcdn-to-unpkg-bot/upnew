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

(function ($) {

    oxPayCostCalc = {

        options: {
            paymentList:        '.payship',
            activePaymentClass: '.selected'
        },

        _create: function () {
            var self = this;
            
           
            $(this.element).on("click", '.option', function () {
                self.calc();
            });
            
            //first calc on init
            self.calc();
            

        },

        /**
         * activate selected payment method
         *
         * @return null
         */
        calc: function () {
           
           // $(this.getPaymentOption(sSelectionId)).addClass(this.options.activePaymentClass);
           // $(this.getPayment(sSelectionId)).prop('checked', true);
            
            var paycostpreset = $('.sidebar-minibasket').data('paycostpreset');
            var paycost = this.getActivePayment().data('paycost');
            var paytitle = this.getActivePayment().data('paytitle');
            
            var basketsum =  $('.sidebar-minibasket').data('basket');
            
            var newbasketsum = basketsum - paycostpreset + paycost;
            
           
            if(paycost > 0){
                $('.sidebar-minibasket').find('.totals.paymentcosts').html('<span class="item">'+ paytitle +'</span><strong class="price pull-right">'+ CUR_ISO + ' ' + paycost.toFixed(2)  +'</strong>');
            }else{
                $('.sidebar-minibasket').find('.totals.paymentcosts').html('');
            }
            $('.sidebar-minibasket').find('.totals.basketsum .price').html( CUR_ISO + ' ' + newbasketsum.toFixed(2) );
            
        },
                 
       

        /**
         * Get payment form
         *
         * @return object
         */
        getPaymentList: function () {
            return $(this.options.paymentList);
        },

        /**
         * Get active payment
         *
         * @return object
         */
        getActivePayment: function () {
            return $('.option' + this.options.activePaymentClass, this.element);
           
        },

        /**
         * Get payment
         *
         * @return object
         */
        getPayment: function (sSelectionId) {
            return $('#payment_' + sSelectionId, this.getPaymentForm());
        },

        /**
         * Get payment option
         *
         * @return object
         */
        getPaymentOption: function (sSelectionId) {
            return $('#paymentOption_' + sSelectionId, this.getPaymentForm());
        }
    }

    $.widget("ui.oxPayCostCalc", oxPayCostCalc);

})(jQuery);
