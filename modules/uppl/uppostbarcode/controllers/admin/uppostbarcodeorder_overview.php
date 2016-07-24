<?php
/**
 * Property of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */

class UpPostBarcodeOrder_Overview extends  UpPostBarcodeOrder_Overview_parent 
{
   
    /**
     * Returns full generator file path.
     *
     * @return string
     */
    protected function _getGeneratorFilePath()
    {
        return getShopBasePath() . 'modules/uppl/uppostbarcode/3rdparty/post/wsbc-generate.php';
    }
    
    public function removeTrackCode(){
		$soxId = oxRegistry::getConfig()->getRequestParameter("oxid");
        if ( $soxId != "-1" && isset( $soxId ) ) {
            // load object
            $oOrder = oxNew( "oxorder" );
            if ( $oOrder->load( $soxId ) ) {
				if($oOrder->oxorder__oxtrackcode->value){
					
						$tc = oxRegistry::getConfig()->getRequestParameter( "trackcode" );

                    
						$newtc = str_replace($tc, "", $oOrder->oxorder__oxtrackcode->value);
						
						$newtc = str_replace(",,", ",", $newtc); //clean up doppelkomma
						
						$newtc = trim($newtc, ","); // erstes oder letztes komma entfernen
					
						$oOrder->oxorder__oxtrackcode->setValue( $newtc );
						$oOrder->save();
                    
					}
			}
		}
				
           
	}
    
    public function render()
    {
        $sTemplate = parent::render();


      
       // echo getcwd() . "\n";
       // echo realpath(dirname(__FILE__));
       // include($this->_getGeneratorFilePath());



      

        return $sTemplate;
    }

      /* Performs PDF export to user (outputs file to save).
     *
     * @return null
     */
    public function createPostBarcode()
    {
         $soxId = $this->getEditObjectId();
        if ( $soxId != "-1" && isset( $soxId ) ) {
            // load object
            $oOrder = oxNew( "oxorder" );
            if ( $oOrder->load( $soxId ) ) {
        
            $myConfig = $this->getConfig();

            include($this->_getGeneratorFilePath());
            
            $generator = new Generator2();
             
            if( $generator->_requestEtiq($oOrder) ){
        			if($oOrder->oxorder__oxtrackcode->value){
                   		$oOrder->oxorder__oxtrackcode->setValue( $oOrder->oxorder__oxtrackcode->value.",".$generator->trackcode );
        			}else{
        				$oOrder->oxorder__oxtrackcode->setValue( $generator->trackcode );
        			}
	
                    $oOrder->save();
                    $this->_aViewData["postbarcode_url"] =  "modules/uppl/_archive/wsbc/Label_".$oOrder->oxorder__oxid->value.$generator->trackcode.".pdf";
            }
            
            }
        }
    }
  
   
   
}