<?php
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */
class UpOrderOverviewOxOrder extends UpOrderOverviewOxOrder_parent
{
   /**
     * Assigns data, stored in DB to oxorder object
     *
     * @param mixed $dbRecord DB record
     *
     * @return null
     */
    public function assign($dbRecord){

        oxBase::assign($dbRecord);

        $oUtilsDate = oxRegistry::get("oxUtilsDate");

        //senddatereal setzen, da oxid das datum formatiert
        $this->oxorder__oxsenddatereal = new oxField($this->oxorder__oxsenddate->value);

        // convert date's to international format
        $this->oxorder__oxorderdate = new oxField($oUtilsDate->formatDBDate($this->oxorder__oxorderdate->value));
        $this->oxorder__oxsenddate = new oxField($oUtilsDate->formatDBDate($this->oxorder__oxsenddate->value));

    }

    public function paymentDiff(){
       
        if( $this->oxorder__oxsenddatereal->value =="0000-00-00 00:00:00"){
            return "-";
       }else{
            $dStart = new DateTime( $this->oxorder__oxsenddatereal->value );
            if($this->oxorder__oxpaid->value == "0000-00-00 00:00:00"){
                $dEnd  = new DateTime( date("Y-m-d H:i:s") );
            }else{
                $dEnd  = new DateTime( $this->oxorder__oxpaid->value );
            }
            $dDiff = $dStart->diff($dEnd);
            return $dDiff->days;
       }

    }
    
    public function getUser()
    {
            $this->_oActiveUser = oxNew( "oxuser" );
            //$sOxId = $this->oxorder__oxuserid->value;

            //bcuz of stupid oxid guest accounts oxid changes..
            if(!$sOxId){
                  $sOxId = $this->_oActiveUser->getIdByUserName($this->oxorder__oxbillemail->value);
            }
      
            
            if ( $sOxId != "-1" && isset( $sOxId)) {
                // load object
                
                 $this->_oActiveUser->load( $sOxId);
                  return $this->_oActiveUser;
            }
       
       
    }
    
}
