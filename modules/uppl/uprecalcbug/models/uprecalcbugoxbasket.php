<?php
class upRecalcBugOxBasket extends upRecalcBugOxBasket_parent{
       /**
     * Iterates through basket items and calculates its prices and discounts
     */
    protected function _calcItemsPrice()
    {
        // resetting
        $this->setSkipDiscounts(false);
        $this->_iProductsCnt = 0; // count different types
        $this->_dItemsCnt = 0; // count of item units
        $this->_dWeight = 0; // basket weight

        $this->_oProductsPriceList = oxNew('oxpricelist');
        $this->_oDiscountProductsPriceList = oxNew('oxpricelist');
        $this->_oNotDiscountedProductsPriceList = oxNew('oxpricelist');

        $oDiscountList = oxRegistry::get("oxDiscountList");

        foreach ($this->_aBasketContents as $oBasketItem) {
            $this->_iProductsCnt++;
            $this->_dItemsCnt += $oBasketItem->getAmount();
            $this->_dWeight += $oBasketItem->getWeight();

            if (!$oBasketItem->isDiscountArticle() && ($oArticle = $oBasketItem->getArticle(true))) {
                
                
                /***START MOD BACKEND ORDER Recalculate Article Price ***/
            
                if($this->getConfig()->isAdmin()){
                  
                    $tempBasketItem = clone $oBasketItem;
                    $tempBasketItem->setAmount(1);
                    //if($tempBasketItem->getPrice() == null || $this->getConfig()->getConfigParam( 'jbRecalculateOrderArticlePrice' )){
                    if($tempBasketItem->getPrice() == null || 1 == 2){
                        $oBasketPrice = $oArticle->getBasketPrice( $oBasketItem->getAmount(), $oBasketItem->getSelList(), $this );
                    }else{
                        $tempBasketItem->getPrice()->divide($oBasketItem->getAmount());
                        $oBasketPrice = $tempBasketItem->getPrice();
                    }
                }else{
                    $oBasketPrice = $oArticle->getBasketPrice( $oBasketItem->getAmount(), $oBasketItem->getSelList(), $this );
                }
                $oBasketItem->setPrice( $oBasketPrice );
                
                /***END MOD BACKEND ORDER Recalculate Article Price ***/
                //$oBasketPrice = $oArticle->getBasketPrice($oBasketItem->getAmount(), $oBasketItem->getSelList(), $this); //wird oben in schleife gemacht
                
                $oBasketItem->setRegularUnitPrice(clone $oBasketPrice);
                
                
                if (!$oArticle->skipDiscounts() && $this->canCalcDiscounts()) {
                    // apply basket type discounts for item
                    $aDiscounts = $oDiscountList->getBasketItemDiscounts($oArticle, $this, $this->getBasketUser());
                    reset($aDiscounts);
                    foreach ($aDiscounts as $oDiscount) {
                        $oBasketPrice->setDiscount($oDiscount->getAddSum(), $oDiscount->getAddSumType());
                    }
                    $oBasketPrice->calculateDiscount();
                } else {
                    $oBasketItem->setSkipDiscounts(true);
                    $this->setSkipDiscounts(true);
                }

                $oBasketItem->setPrice($oBasketPrice);
                $this->_oProductsPriceList->addToPriceList($oBasketItem->getPrice());

                //P collect discount values for basket items which are discountable
                if (!$oArticle->skipDiscounts()) {

                    $this->_oDiscountProductsPriceList->addToPriceList($oBasketItem->getPrice());
                } else {
                    $this->_oNotDiscountedProductsPriceList->addToPriceList($oBasketItem->getPrice());
                    $oBasketItem->setSkipDiscounts(true);
                    $this->setSkipDiscounts(true);
                }
            } elseif ($oBasketItem->isBundle()) {
                // if bundles price is set to zero
                $oPrice = oxNew("oxprice");
                $oBasketItem->setPrice($oPrice);
            }
        }
    }
}