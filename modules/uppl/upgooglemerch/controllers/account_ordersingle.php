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

/**
 * config to fetch paths
 */
$myConfig = oxRegistry::getConfig();

/**
 * needed libraries location
 */
$sIncPath = $myConfig->getConfigParam('sShopDir');



/**
 * including libraries
 */
require_once "$sIncPath/core/uppl/ezs/class.einzahlungsschein.php";

//echo "$sIncPath/core/upplezs/class.einzahlungsschein.php";

class Account_OrderSingle extends Account_Order
{
    protected $_sOrderOxid = false;
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
         
        if( $this->_sOrderOxid = $this->getOxidfromOrderNr() ){
			 $orders = $this->getOrderList();
			 $this->_aViewData['order'] = $orders[$this->_sOrderOxid];
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


    protected function getEzObject(){
        // load object
        $oOrder = oxNew( "oxorder" );
        if ( $oOrder->load( $this->_sOrderOxid  ) ) {


            $myConfig = oxRegistry::getConfig();

            $amount = $oOrder->oxorder__oxtotalordersum->value;
            $ref = $oOrder->oxorder__oxordernr->value;
            $ez = new createEinzahlungsschein();


            $ez->setBankData($myConfig->getConfigParam("sBankName"), $myConfig->getConfigParam("sBankCity"), $myConfig->getConfigParam("sBankingAccount"));
            $ez->setRecipientData($myConfig->getConfigParam("sRecipientName"), $myConfig->getConfigParam("sRecipientAdress"), $myConfig->getConfigParam("sRecipientCity"), $myConfig->getConfigParam("sBankingCustomerIdentification"));


            $z_name = $oOrder->oxorder__oxbillfname->value . " " . $oOrder->oxorder__oxbilllname->value;
            $z_strasse = $oOrder->oxorder__oxbillstreet->value . " " . $oOrder->oxorder__oxbillstreetnr->value;
            $z_ort = $oOrder->oxorder__oxbillzip->value . " " . $oOrder->oxorder__oxbillcity->value;
            $z_firma = "";
            $z_firma = $oOrder->oxorder__oxbillcompany->value;


            $ez->setPayerData($z_firma, $z_name, $z_strasse, $z_ort);
            $ez->setPaymentData($amount, $ref);

            return $ez;

        }
    }

    public function getEsrRef(){
        $ez = $this->getEzObject();
        return $this->breakStringIntoBlocks($ez->getCreateCompleteReferenceNumber());
    }

    public function getCodeLine(){
        $ez = $this->getEzObject();
        return $ez->getCreateBottomLineString();
    }

    /**
     * Displays a string in blocks of a certain size.
     * Example: 00000000000000000000 becomes more readable 00000 00000 00000

     * @param string $string
     * @param int $blocksize
     * @return int
     */
    private function breakStringIntoBlocks($string, $blocksize=5) {

        //lets reverse the string (because we want the block to be aligned from the right)
        $newString = strrev($string);

        //chop it into blocks
        $newString = chunk_split($newString, $blocksize);

        //re-reverse
        $newString = strrev($newString);

        return $newString;

    }//function
 
   
}
