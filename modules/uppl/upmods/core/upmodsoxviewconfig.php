<?php
/**
 * 
 */
class UpModsOxViewConfig extends UpModsOxViewConfig_parent
{
    
    /**
     * Converts input paramater according to active shop currency
     * 
     *
     * @return 
     */
	public function getConvert($num)
	{	
		$oCur = $this->getConfig()->getActShopCurrencyObject();

       	$oLang = oxRegistry::getLang();

        return $oLang->formatCurrency( $num * $oCur->rate, $oCur);

		 
	}
	
	 /**
     * Returns active currency object, wieso nicht immer so
     * 
     *
     * @return 
     */
	public function getActShopCurrencyObject(){
	    return $this->getConfig()->getActShopCurrencyObject();
    }
	

  
}
