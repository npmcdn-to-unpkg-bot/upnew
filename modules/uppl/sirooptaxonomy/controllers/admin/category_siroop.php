<?php
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */

class Category_Siroop extends oxAdminView {
        
    protected $_sThisTemplate = 'category_siroop.tpl';
    public function render()
    {
        $this->_aViewData['edit'] = $oCategory = oxNew('oxcategory');

        $soxId = $this->getEditObjectId();

        if ($soxId != "-1" && isset($soxId)) {
            // load object
            $oCategory->load($soxId);
        }
        
        parent::render();
        return $this->_sThisTemplate;
       
    }


    /**
     * Saves ids into database
     *
     * @return mixed
     */
    public function save()
    {   
      
		$oDb = oxDb::getDb();
        $sOxId   =  oxRegistry::getConfig()->getRequestParameter("oxid");
        $aParams =  oxRegistry::getConfig()->getRequestParameter("editval");
        
        //taxonomy id
        $sTid = oxRegistry::getConfig()->getRequestParameter("tid");
        
        if($sTid){
            $sql = "REPLACE INTO `siroopcatextends` (`OXID`, `SIROOPTID`) VALUES ( ".$oDb->quote( $sOxId ).", ".$oDb->quote( $sTid ).");";
            $oDb->execute($sql);
            
            $this->_aViewData['saved'] = true;
            
        
        }

    }
    
   
}