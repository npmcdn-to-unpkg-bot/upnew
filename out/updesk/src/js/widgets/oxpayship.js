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

    oxPayShip = {

        options: {
            label            : '.dropdown-toggle span',
            input            : 'input',
            dropdownItems    : '.payship .option',
            form             : false
        },

         _create: function() {

            var self = this;
            this.head               = this.element;
            this.selectedValueLabel = $( self.options.label, this.head );
            this.selectedValue      = $( self.options.input, this.head );
            this.dropDownOptions    = $( self.options.dropdownItems, this.head );

            

            $(this.head).on("click", self.options.dropdownItems, function() {
                if ( !$(this).hasClass( 'selected' ) ) {
                    self.select($(this));
                }
            });
        },

        /**
         * set selected value
         *
         * @return null
         */
        select : function( oSelectLink ) {
           
          
            if (oSelectLink.href && oSelectLink.href != "#") {
                window.location = oSelectLink.href;
            }
            
            //this.selectedValueLabel.html(this.getTitle(oSelectLink));
           // this.selectedValue.val( $(oSelectLink).data('selection-id')).trigger( 'change' );
            this.dropDownOptions.removeClass('selected');
            oSelectLink.addClass('selected');
            oSelectLink.children('input').prop('checked', true);

            if (this.options.form) {
                $(this.options.form).submit();
            }
        },

        /**
         * Returns given item title
         * @param oItem
         * @returns string
         */
        getTitle : function( oItem ) {
            var title = $(oItem).data("title");
            if (!title) {
                title = $(oItem).text();
            }
            return title;
        }
    }

   $.widget("ui.oxPayShip", oxPayShip );

})( jQuery );
