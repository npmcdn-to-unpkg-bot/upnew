<?php
/**
 * Urbanpeople oxArticle class
 */
class upModsOxBasketItem extends upModsOxBasketItem_parent
{
    /**
     * Check if Product is virtual: is non material and is downloadable
     *
     * @return bool
     */
    public function getCleanFloatPrice()
    {
        $oPrice = $this->getUnitPrice();
        
        if( $oPrice instanceof oxPrice ){
            $sPrice = $oPrice->getPrice();
            $sPrice = number_format(  $sPrice, 2, '.', '' );
        }
        
        return $sPrice;
        
    }
    
    /**
     * Get Parent if var or set own iD if novars
     *
     * @return bool
     */
    public function getMainArticleId()
    {
    	$oArticle = $this->getArticle();
        
        if( $oArticle->oxarticles__oxparentid->value ){
            $sOxid = $oArticle->oxarticles__oxparentid->value;
        }else{
            $sOxid = $oArticle->oxarticles__oxid->value;
        }
        
        return $sOxid;
    }

    /**
     * Get Parent article
     *
     * @return bool
     */
    public function getParentArticle()
    {
    	$oArticle = $this->getArticle();
        
        if( $oArticle->oxarticles__oxparentid->value ){
            if( $oParent = $oArticle->getParentArticle() ){
                
                return $oParent;
            }
        }
       
    }
   
}
