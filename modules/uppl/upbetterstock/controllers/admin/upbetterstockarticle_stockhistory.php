<?php
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */

class UpBetterStockArticle_StockHistory extends oxAdminView {
        
    protected $_sThisTemplate = 'upbetterstockarticle_stockhistory.tpl';
    protected $_blVariants = false;
    public function render()
    {

        /*
        $sTemplate = parent::render();

        $oOrder = oxNew("oxOrder");
        $soxId = $this->getEditObjectId();
        if ($soxId != "-1" && isset($soxId)) {
            // load object
            $oOrder->load($soxId);
            $oUser = $oOrder->getUser();

            $aLang = oxRegistry::getLang()->getLanguageArray();
            $this->_aViewData["custlang"] = $aLang[$oOrder->getOrderLanguage()];

            //print_r( $oUser->getOrders() );
             $this->_aViewData["mylist"] = $oUser->getOrders(); 
            if($oUser->oxuser__oxpassword->value){
                     $this->_aViewData["custaccount"] = true;
            }else{
                      $this->_aViewData["custaccount"] = false;
            }

        }*/


      /*  foreach (get_class_methods($this) as $method_name) {
            echo "$method_name\n";
        }*/

        
        
        $this->_aViewData["edit"] = $oArticle = oxNew( "oxarticle");

        $soxId =  oxRegistry::getConfig()->getRequestParameter("oxid");


        // load object
        $oArticle->load( $soxId );

      // variant handling
        if ( $oArticle->oxarticles__oxparentid->value) {
            $oParentArticle = oxNew( "oxarticle");
            $oParentArticle->load( $oArticle->oxarticles__oxparentid->value);

            $oVariants = $oParentArticle->getAdminVariants();
            $this->_aViewData["mylist"] =  $oVariants;

            $this->_aViewData["parentarticle"] =  $oParentArticle;
            $this->_aViewData["oxparentid"] =  $oArticle->oxarticles__oxparentid->value;
            
        }else{
            $this->_aViewData["parentarticle"] = $oArticle;
            $oVariants = $oArticle->getAdminVariants();
            $this->_aViewData["mylist"] =  $oVariants;
        }

        if($oArticle->oxarticles__oxparentid->value ||  $oArticle->oxarticles__oxvarcount->value){
            $this->_blVariants  = true;
          }
        $this->_aViewData["showvariants"] = $this->_blVariants;

         // $this->_aViewData["test"] = parent::parent::testr();
       // echo $this->getViewId();
                
        parent::render();
         // echo oxViewConfig::testr();
       return "article_stockhistory.tpl";
    }

    /**
     * Returns shop manufacturers list
     *
     * @return oxmanufacturerlist
     */
    public function getVendorList()
    {
        $oVendorlist = oxNew("oxvendorlist");
        $oVendorlist->loadVendorList();

        return $oVendorlist;
    }


    /**
     * Saves article Inventori information changes.
     *
     * @return mixed
     */
    public function save()
    {
		$oDb = oxDb::getDb();
        $soxId   =  oxRegistry::getConfig()->getRequestParameter("oxid");
        $aParams =  oxRegistry::getConfig()->getRequestParameter("editval");
        

        // checkbox handling
        if ( !isset( $aParams['oxarticles__oxremindactive'])) {
            $aParams['oxarticles__oxremindactive'] = 0;
        }
		
          // shopid
            //$sShopID = oxSession::getVar( "actshop");
           // $aParams['oxarticles__oxshopid'] = $sShopID;

        $oArticle = oxNew( "oxarticle");
        $oArticle->loadInLang( $this->_iEditLang, $soxId );
	    
		$stockmovement = $aParams['plusminus'].$aParams['stock'];
		$newstock =  $oArticle->oxarticles__oxstock->value + $stockmovement;
		
		$newrowoxid = oxUtilsObject::getInstance()->generateUID();
		
		$sQi = "INSERT INTO `up_stockhistory` ( `OXID` ,`OXARTICLE_OXID` , `OXARTICLE_OXPARENT` ,  `EKPRICE` , `NOTE` , `STOCK` , `LIEFERANT_FK` , `EXPENSED`, `TYPE` )
				VALUES (
				'".$newrowoxid."','".$oArticle->oxarticles__oxid->value."', '".$oArticle->oxarticles__oxparentid->value."', '".$oArticle->oxarticles__oxbprice->value."', '".$aParams['note']."', '".$stockmovement."', '".$aParams['lieferant_fk']."', '1', '".$aParams['type']."'
				);";

		 
	     $oDb->execute(	$sQi);
		 $oDb->execute( 'update oxarticles set oxarticles.oxstock = '.$oDb->quote( $newstock ).' where oxarticles.oxid = '.$oDb->quote( $soxId ) );
		 $oArticle->onChange(ACTION_UPDATE_STOCK);
		 
        //$oArticle->save();
    }
    
    public function stockhistorylist()
		{   
		    $soxId   =  oxRegistry::getConfig()->getRequestParameter("oxid");
		    $sSql=("SELECT * 
					FROM  `up_stockhistory` 
					WHERE  `OXARTICLE_OXID` = '". $soxId ."'
					ORDER BY  `DATE` DESC ;");
		
			$rs = oxDb::getDb(oxDb::FETCH_MODE_ASSOC)->Execute( $sSql);

			if ($rs != false && $rs->recordCount() > 0) {
           		 while (!$rs->EOF) {
					$arr[]=$rs->fields;
			
					$rs->moveNext();
	            }
        	}
			return $arr;
		}
}