<?php
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */
class UpGoogleMerchOxCategory extends UpGoogleMerchOxCategory_parent
{
    /**
     * Get article long description
     *
     * @return object $oField field object
     */
    public function getGoogleCategory()
    {
        if ($this->_gmgooglecategory === null) {
            // initializing
            $this->_gmgooglecategory  = new oxField();

            // choosing which to get..
            $sOxid = $this->getId();
            $sViewName = getViewName('exonn_googlem', $this->getLanguage());

            $oDb = oxDb::getDb();
            $sDbValue = $oDb->getOne("select googlecategory from {$sViewName} where oxid = " . $oDb->quote($sOxid));

            if ($sDbValue != false) {
                $this->_gmgooglecategory->setValue($sDbValue, oxField::T_RAW);
            }else{
                 return false;
            }
        }

        return htmlspecialchars($this->_gmgooglecategory);
    }
    
    /**
     * Get article long description
     *
     * @return object $oField field object
     */
    public function getGoogleGender()
    {
       
        if ($this->_gmgender === null) {
            // initializing
            $this->_gmgender  = new oxField();


            // choosing which to get..
            $sOxid = $this->getId();
            $sViewName = getViewName('exonn_googlem', $this->getLanguage());

            $oDb = oxDb::getDb();
            $sDbValue = $oDb->getOne("select gender from {$sViewName} where oxid = " . $oDb->quote($sOxid));

            if ($sDbValue != false) {
                $this->_gmgender->setValue($sDbValue, oxField::T_RAW);
            }else{
                return false;
            }
        }

        return $this->_gmgender;
    }
    
    /**
     * Get Siroop Taxonomy Id 
     *
     * @return object $oField field object
     */
    public function getSiroopTid()
    {
        if ($this->_sSiroopTid === null) {
            // initializing
            $this->_sSiroopTid = new oxField();
            // choosing which to get..
            $sOxid = $this->getId();
            $sViewName = getViewName('siroopcatextends', $this->getLanguage());

            $oDb = oxDb::getDb(); //SELECT sirooptid FROM `siroopcatextends` WHERE `OXID` = '0r7381b8a204c8557463fa8b5762940c'
            $sDbValue = $oDb->getOne("SELECT sirooptid FROM {$sViewName} WHERE `OXID` = " . $oDb->quote($sOxid) );
            
        
            if ($sDbValue != false) {
                $this->_sSiroopTid->setValue($sDbValue, oxField::T_RAW);
            }
      
        }

        return $this->_sSiroopTid->value;
    }

}