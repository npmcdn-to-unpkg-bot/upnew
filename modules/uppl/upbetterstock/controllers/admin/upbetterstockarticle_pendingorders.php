<?php
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */

class UpBetterStockArticle_PendingOrders extends oxAdminView {
        
    protected $_sThisTemplate = 'upbetterstockarticle_stockhistory.tpl';

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

     
            $this->_aViewData["oOrderList"] = $this->pendingorderlist(); 
  /**/
             parent::render();

       return "article_pendingorders.tpl";
    }

    /*
    public function pendingorderlist()
        {
            
                $oOrderList = oxNew("oxlist");
                $oOrderList->init("oxorder");

                $sSelect="SELECT  *
                    FROM  `oxorder` ,  `oxorderarticles` 
                    WHERE ( 
                           oxorder.oxfolder =  'ORDERFOLDER_WAITING' 
                        OR oxorder.oxfolder =  'ORDERFOLDER_PREPAY'
                        OR oxorder.oxfolder =  'ORDERFOLDER_PREPAY_0' 
                        OR oxorder.oxfolder =  'ORDERFOLDER_RETOUR'
                        OR oxorder.oxfolder =  'ORDERFOLDER_PROBLEMS'
                        OR oxorder.oxfolder =  'ORDERFOLDER_PICKUP'
                        OR 1 = 1
                        )
                    AND oxorder.oxid = oxorderarticles.oxorderid
                    AND oxorderarticles.oxartid !=  '' 
                    ORDER BY  `OXORDERNR` DESC ;";


                
                // $sSelect = "select * from upuniremark where oxparentid=" .  oxDb::getDb()->quote( $this->upuniremark__oxparentid->value ) . " order by oxtimestamp desc";
            
                $oOrderList->selectString($sSelect);


               // return $oOrderList;
        }*/
        
        
        public function pendingorderlist()
		{
		    
		    $articleid  =  oxRegistry::getConfig()->getRequestParameter("oxid");
			$sSql=("SELECT  `oxorder`.`OXID` AS oxid, `oxorder`.`OXORDERDATE` AS oxorderdate,`oxorder`.`OXORDERNR` AS oxordernr,`oxorder`.`OXBILLFNAME` AS oxbillfname,`oxorder`.`OXBILLLNAME` AS oxbillname,`oxorder`.`OXBILLEMAIL` AS oxbillemail,  `oxorderarticles`.`OXAMOUNT` as oxamount
					FROM  `oxorder` ,  `oxorderarticles` 
					WHERE ( 
						oxorder.oxfolder =  'ORDERFOLDER_WAITING' 
						OR oxorder.oxfolder =  'ORDERFOLDER_PREPAY'
						OR oxorder.oxfolder =  'ORDERFOLDER_PREPAY_0' 
						OR oxorder.oxfolder =  'ORDERFOLDER_RETOUR'
						OR oxorder.oxfolder =  'ORDERFOLDER_PROBLEMS'
						OR oxorder.oxfolder =  'ORDERFOLDER_PICKUP' 
						)
					AND oxorder.oxid = oxorderarticles.oxorderid
					AND oxorderarticles.oxartid =  '".$articleid."' 
					ORDER BY  `OXORDERNR` DESC ;");
			
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