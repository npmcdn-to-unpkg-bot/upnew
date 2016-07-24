<?php
/**
 * Urbanpeople oxArticle class
 */
class upStreetDealOxArticle extends upStreetDealOxArticle_parent
{   
    //setting C-price to articles for streetdeal users
    public function getBasketPrice($dAmount, $aSelList, $oBasket)
    {
        
        $oBasketPrice = parent::getBasketPrice($dAmount, $aSelList, $oBasket);
       
        // setting price
        //todo later: if request von contenful api ob artikel zu einem deal gehört der aktiv ist...
       
        //dealsource is set in oxcmp_basket tobasket()
        if( oxRegistry::getSession()->getVariable('dealsource') ){
            
            // Get C Price from article or parent
            if( $this->oxarticles__oxparentid->value ) {
                $dPrice = $this->getParentArticle()->oxarticles__oxpricec->value;
            }else{
                $dPrice = $this->oxarticles__oxpricec->value;
            }
            
            //only set if over 0 
            if($dPrice > 0){
                $oBasketPrice->setPrice($dPrice);
                $dVat = oxRegistry::get("oxVatSelector")->getBasketItemVat($this, $oBasket);
                $oBasketPrice = $this->_calculatePrice($oBasketPrice, $dVat);
            }
        }
  
        // returning final price object
        return $oBasketPrice;
    }
    
    
}