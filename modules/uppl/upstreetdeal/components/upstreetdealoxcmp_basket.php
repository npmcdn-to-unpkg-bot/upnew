<?
/**
 * Basket component
 */
class upStreetDealOxcmp_Basket extends upStreetDealOxcmp_Basket_parent {
		

	public function tobasket($sProductId = null, $dAmount = null, $aSel = null, $aPersParam = null, $blOverride = false)
	{	
	    
	    if( oxRegistry::getConfig()->getRequestParameter( 'dealsource') ){
    	    oxRegistry::getSession()->setVariable('dealsource', true );
	    }
	    
	    return parent::tobasket($sProductId = null, $dAmount = null, $aSel = null, $aPersParam = null, $blOverride = false);
	    
    }
    
    
    //TODO init function that sets dealsource

	
}