<?php
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */
class UpGoogleMerchOxArticleList extends UpGoogleMerchOxArticleList_parent
{
    /**
     * Depracted at the moment, moved to controller
     *
     * @return null
     */
    public function loadAllArticles()
    {
        $myConfig = $this->getConfig();
        
        if ( !$myConfig->getConfigParam( 'bl_perfLoadPriceForAddList' ) ) {
            $this->_blLoadPrice = false;
        }
       
		$limit = oxRegistry::getConfig()->getRequestParameter("limit");
		$limit = explode("-",$limit);
		
		if(!$limit[1]){
			$limit = 100;
		}else{
			$limit = $limit[0].",".$limit[1];
		}
		
	    $sArticleTable = getViewName('oxarticles');
       

        $sSelect  = "select * from $sArticleTable ";
        $sSelect .= "where  ( $sArticleTable.oxactive = 1 and ( $sArticleTable.oxstockflag != 2 or ($sArticleTable.oxstock + $sArticleTable.oxvarstock ) > 0 ) ) and $sArticleTable.oxissearch = 1 ";
		
        $sSelect .= "and $sArticleTable.oxparentid = '' "; // and $sArticleTable.oxsoldamountweek>0 ";
        $sSelect .= "order by oxinsert desc limit $limit";
		
        $this->selectString($sSelect);
            
        
    }
   
}