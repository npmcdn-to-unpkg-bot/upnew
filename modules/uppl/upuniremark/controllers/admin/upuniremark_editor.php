<?php
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */

class UpUniRemark_Editor extends oxAdminDetails
{   
    //oxid der parent objects
    protected $_sOxId;
   
    public function render()
    {
        $myConfig = $this->getConfig();
        parent::render();

        $this->_sOxId = oxRegistry::getConfig()->getRequestParameter("oxid");
        $this->_aViewData["oxid"] = $this->_sOxId;

        if (isset($this->_sOxId)) {
    
            //moduluebergreifend auslagern?
            $oActiveAdmin = oxNew("oxuser");
            $oActiveAdmin->load( oxRegistry::getSession()->getVariable( 'auth' ) );
            $this->_aViewData["oActiveAdmin"] = $oActiveAdmin;
           
            $oUniRemark = oxNew( "UpUniRemark" );
           if( $oUniRemark->loadLatestFromParent($this->_sOxId) ){
            
                $this->_aViewData["oLatestRemark"] =  $oUniRemark;
                $this->_aViewData["oParentObject"] = $oUniRemark->getParentObject();
                $this->_aViewData["sParentType"] = $oUniRemark->getParentType();
            }else{
                 $this->_aViewData["blEmpty"] = true;  
            }
            
        }
             
        return "popups/uniremark_editor.tpl";
    }
   
    
    /**
     * Saves item
     */
    public function save()
    {
   
        if(oxRegistry::getConfig()->getRequestParameter("uniremark_text") ){
            $oRemark = oxNew("UpUniRemark");
            $oRemark->load();

            $oRemark->upuniremark__oxtext = new oxField( oxRegistry::getConfig()->getRequestParameter("uniremark_text") );
           
            $oRemark->upuniremark__oxparentid = new oxField(oxRegistry::getConfig()->getRequestParameter("oxid"));
            


            if(oxRegistry::getConfig()->getRequestParameter("extern") ){
                 $oRemark->upuniremark__oxextern = new oxField(1);
            }
           

            $oRemark->upuniremark__oxuserid = new oxField( oxRegistry::getSession()->getVariable( 'auth' ) );
            $oRemark->save();
        }
       
    }


    /**
     * Deletes uniremark history item.
     */
    public function delete()
    {
        $oRemark = oxNew("UpUniRemark");
        $oRemark->delete(oxRegistry::getConfig()->getRequestParameter("uniremark_oxid"));
    }

}
