<?php
/**
 * This file is part of OXID eSales PayPal module.
 *
 * OXID eSales PayPal module is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * OXID eSales PayPal module is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OXID eSales PayPal module.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @link      http://www.oxid-esales.com
 * @copyright (C) OXID eSales AG 2003-2015
 */

/**
 * Basket component
 */
class upModsOxcmp_Basket extends upModsOxcmp_Basket_parent {
		
	//Liefert im header die differenz zu den versandkosten. 
	public function getDiffToFreeDelCost($freeamount)
	{	
			$o_cur = $this->getConfig()->getActShopCurrencyObject();
			$freeamount = $freeamount * $o_cur->rate;
			
		 if ( $this->_oProductsPriceList ) {
			$diff = $freeamount - $this->_oProductsPriceList->getBruttoSum()  ;
       	 return oxLang::getInstance()->formatCurrency( $diff, $this->getBasketCurrency() );
    	}
    	return null;
		 
	}
	
	//Liefert im header die differenz zu den versandkosten. 
	public function getConvert($num)
	{	
		$o_cur = $this->getConfig()->getActShopCurrencyObject();
       	return oxLang::getInstance()->formatCurrency( $num * $o_cur->rate, $this->getBasketCurrency() );
    	
		 
	}



	
	
}