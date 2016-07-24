<?php
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */

class UpOrderOverviewOrder_Overview extends  UpOrderOverviewOrder_Overview_parent 
{
   
    public function render()
    {
        $sTemplate = parent::render();

        $oOrder = oxNew("oxOrder");
        $soxId = $this->getEditObjectId();
        if ($soxId != "-1" && isset($soxId)) {
            // load object
            $oOrder->load($soxId);
            $oUser = $oOrder->getUser();

            $aLang = oxRegistry::getLang()->getLanguageArray();
            $this->_aViewData["custlang"] = $aLang[$oOrder->getOrderLanguage()];

            //print_r( $oUser->getOrders() );
            $this->_aViewData["mylist"] = $oUser->getOrdersByEmailAndId(); 
            
            if(!isset($this->_aViewData["mylist"])){
                
            }
            
            
            if($oUser->oxuser__oxpassword->value){
                     $this->_aViewData["custaccount"] = true;
            }else{
                      $this->_aViewData["custaccount"] = false;
            }

        }
        return $sTemplate;
    }


     /**
     * Sends order.
     *
     * @return null
     */
    public function setsenddate()
    {
        $oOrder = oxNew( "oxorder" );
       
        if ( $oOrder->load($this->getEditObjectId())) {
            $oOrder->oxorder__oxsenddate = new oxField(date("Y-m-d H:i:s", oxRegistry::get("oxUtilsDate")->getTime()));
            if( oxRegistry::getConfig()->getRequestParameter("changefolder") == 1 ){
                $oOrder->oxorder__oxfolder = new oxField("ORDERFOLDER_FINISHED");
            }
            //wws setzt fortlaufende rechnungsnummer oxorder muss setrecordnumber reimplemntiert werden, bei oxbillnr zusàtzlich das feld auf int umstellen da varchar falsche max ergebniss liefert
            //$oOrder->_setRecordNumber( 'oxbillnr' );
            $oOrder->save();
        }
    }
    
    
    
    /**

     *
     * @param string $oOrder Order object
     *
     * @return oxUserPayment
     */
    public function getPaymentName($oOrder)
    {
        if (!($oUserPayment = $oOrder->getPaymentType()) && $oOrder->oxorder__oxpaymenttype->value) {
            $oPayment = oxNew("oxPayment");
            if ($oPayment->load($oOrder->oxorder__oxpaymenttype->value)) {
                // in case due to security reasons payment info was not kept in db
                $oUserPayment = oxNew("oxUserPayment");
                $oUserPayment->oxpayments__oxdesc = new oxField($oPayment->oxpayments__oxdesc->value);
            }
        }

        if($oUserPayment){
            return $oUserPayment->oxpayments__oxdesc->value;
        }
        return "unbekannt";
    }
    
     /**
     * overrides sendorder() removes set senddate functionality
  
    public function sendorder()
    {
        $oOrder = oxNew("oxorder");
        if ($oOrder->load($this->getEditObjectId())) {
        
            if ( $oOrder->oxorder__oxsenddate == "0000-00-00 00:00:00"){
                // #1071C
                $oOrderArticles = $oOrder->getOrderArticles();
                foreach ($oOrderArticles as $sOxid => $oArticle) {
                    // remove canceled articles from list
                    if ($oArticle->oxorderarticles__oxstorno->value == 1) {
                        $oOrderArticles->offsetUnset($sOxid);
                    }
                }

                if (($blMail = oxRegistry::getConfig()->getRequestParameter("sendmail"))) {
                    // send eMail
                    $oEmail = oxNew("oxemail");
                    $oEmail->sendSendedNowMail($oOrder);
                }

             }else{
                oxRegistry::get("oxUtilsView")->addErrorToDisplay("Kein Versanddatum");
             }
        }
    }
       */







   
}