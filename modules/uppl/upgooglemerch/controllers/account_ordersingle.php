<?php
/**
 * This file is part of OXID eShop Community Edition.
 *
 * OXID eShop Community Edition is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * OXID eShop Community Edition is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OXID eShop Community Edition.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @link      http://www.oxid-esales.com
 * @copyright (C) OXID eSales AG 2003-2015
 * @version   OXID eShop CE
 */

/**
 * Current user order history review.
 * When user is logged in order review fulfils history about user
 * submitted orders. There is some details information, such as
 * ordering date, number, recipient, order status, some base
 * ordered articles information, button to add article to basket.
 * OXID eShop -> MY ACCOUNT -> Newsletter.
 */
class Account_OrderSingle extends Account_Order
{

    /**
     * If user is not logged in - returns name of template account_order::_sThisLoginTemplate,
     * or if user is allready logged in - returns name of template
     * account_order::_sThisTemplate
     *
     * @return string $_sThisTemplate current template file name
     */
    public function render()
    {
        parent::render();

        // is logged in ?
        $oUser = $this->getUser();
        if (!$oUser) {
            return $this->_sThisTemplate = $this->_sThisLoginTemplate;
        }

        $oConfig = $this->getConfig();
         
        if( $sOxid = $this->getOxidfromOrderNr() ){
			 $orders = $this->getOrderList();
			 $this->_aViewData['order'] = $orders[$sOxid];
			 $this->_aViewData["paymentType"] = $this->_aViewData['order']->getPaymentType();
		}else{
		    oxRegistry::getUtils()->redirect($oConfig->getShopHomeURL() . 'cl=account_order', false, 302);
		}

        return $this->_sThisTemplate;
    }
    
    protected function getOxidfromOrderNr(){
        
		$sOrderNr = oxRegistry::getConfig()->getRequestParameter("order");
		
		$oDb = oxDb::getDb();
        $sOrderNrQuoted = $oDb->quote($sOrderNr);
    
		
		if ( $oUser = $this->getUser() ) {
    		$sSelect  = "select oxid from oxorder where oxordernr = {$sOrderNrQuoted} and oxuserid =".$oDb->quote($oUser->oxuser__oxid->value).";";
    		$oxid = oxDb::getDb()->getOne( $sSelect );
            return $oxid;
    	}
	}

    public function getEsrUrl(){

        $order = $this->_aViewData['order'];

        $type_folder = "esr/";


        $oModule = oxNew("oxmodule");
        $sModulePath = $oModule->getModulePath('uppl');
        $path = oxRegistry::getConfig()->getModulesDir() . $sModulePath . '/_archive/' . $type_folder;

        $url = str_replace(
            rtrim(oxRegistry::getConfig()->getConfigParam('sShopDir'), '/'),
            rtrim(oxRegistry::getConfig()->getCurrentShopUrl( false ), '/'),
            $path
        );

        //echo $path;

        //check if esr exisits??  -> senddate
        if( $order->oxorder__oxorderdate->value != "-" && 1 == 1 ){

            $d = new DateTime( $order->oxorder__oxorderdate->value );

            $m = $d->format( 'm' );
            $y = $d->format( 'y' );
            
            $sFilePath = $y."/".$m."/".$order->oxorder__oxordernr->value."_ez_".$order->oxorder__oxid->value.".pdf";


            if (file_exists( $path.$sFilePath)) {
                return $url.$sFilePath;
            } else {
                return false;
            }



        }
    }
 
   
}