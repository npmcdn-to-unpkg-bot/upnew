<?php
/**
 * Urbanpeople oxArticle class
 */
class upModsOxUser extends upModsOxUser_parent
{
    /**
     * First element of title
     *
     * @return float
     */
    public function justutest()
    {   
        return  $this->oxuser__oxid->value;
    }
    
    /**
     * Overrides Parent method
     *
     * @param string $sUser     User
     * @param string $sPassword Password
     * @param string $sShopID   Shop id
     *
     * @throws object
     */
    protected function _dbLogin($sUser, $sPassword, $sShopID)
    {
        $blOldHash = false;
        $oDb = oxDb::getDb();
        
        if ($this->_isDemoShop() && $this->isAdmin()) {
            $sUserOxId = $oDb->getOne($this->_getDemoShopLoginQuery($sUser, $sPassword));
        } else {
            $sUserOxId = $oDb->getOne($this->_getLoginQuery($sUser, $sPassword, $sShopID, $this->isAdmin()));
            if (!$sUserOxId) {
                $sUserOxId = $oDb->getOne($this->_getLoginQueryHashedWithMD5($sUser, $sPassword, $sShopID, $this->isAdmin()));
                $blOldHash = true;
            }
        }
        
        //case no reg user wants to log in, setting random password and handling as reg user
        if (!$sUserOxId) {
                $sFakeUserOxid = $oDb->getOne($this->_getLoginQueryNoAccount($sUser));
    
                if ($this->load($sFakeUserOxid)) {
                    $sPassword = oxUtilsObject::getInstance()->generateUId();
                    $this->setPassword($sPassword);
                    $this->save();
                    
                    //random password saved and throw as wrong login
                    
                    /** @var oxUserException $oEx */
                    $oEx = oxNew('oxUserException');
                    $oEx->setMessage('ERROR_MESSAGE_USER_NOVALIDLOGIN');
                    throw $oEx;
                 }
        }
        
         //check if email exists in database, 
        if (!$sUserOxId) {
                $sOxidExists = $oDb->getOne($this->_getLoginQueryCheckIfExists($sUser) );
                if (!$sOxidExists) {

                    /** @var oxUserException $oEx */
                    $oEx = oxNew('oxUserException');
                    $oEx->setMessage('ERROR_MESSAGE_USER_INEXISTS');
                    throw $oEx;
                 }
        }
        
      

        if ($sUserOxId) {
            if (!$this->load($sUserOxId)) {
                /** @var oxUserException $oEx */
                $oEx = oxNew('oxUserException');
                $oEx->setMessage('ERROR_MESSAGE_USER_NOVALIDLOGIN');
                throw $oEx;
            } elseif ($blOldHash && $this->getId()) {
                $this->setPassword($sPassword);
                $this->save();
            }
        }
    }
    
    /**
     * Builds and returns user without account query
     *
     * @param string $sUser     login name
     * @param string $sShopID   shopid
     * @param bool   $blAdmin   admin/non admin mode
     *
     * @throws object
     *
     * @return string
     */
    protected function _getLoginQueryNoAccount($sUser )
    {
        $myConfig = $this->getConfig();
        $oDb = oxDb::getDb();

        $sUserSelect = "oxuser.oxusername = " . $oDb->quote($sUser);
        $sPassSelect = " AND oxuser.oxpassword = ''"; // Search for empty pass -> no reg user
        $sShopSelect = "";

        $sSelect = "SELECT `oxid` FROM `oxuser` WHERE  " . $sUserSelect . $sPassSelect;
        
        
        //$sSelect = "select `oxid` from oxuser where oxuser.oxactive = 1 and {$sPassSelect} and {$sUserSelect} {$sShopSelect} ";
        
        return $sSelect;
    }
    
    /**
     * Builds and returns user without account query
     *
     * @param string $sUser     login name
     * @param string $sShopID   shopid
     * @param bool   $blAdmin   admin/non admin mode
     *
     * @throws object
     *
     * @return string
     */
    protected function _getLoginQueryCheckIfExists($sUser )
    {
 $oDb = oxDb::getDb();
        $sUserSelect = "oxuser.oxusername = " . $oDb->quote($sUser);
       

        $sSelect = "SELECT `oxid` FROM `oxuser` WHERE  " . $sUserSelect;

        return $sSelect;
    }
    
}
