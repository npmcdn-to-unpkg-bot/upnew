<?php
/**
 */



class UpVendorOrder_Pending extends oxAdminView {
       
   /**
     * Loads article Inventory information, passes it to Smarty engine and
     * returns name of template file "article_stock.tpl".
     *
     * @return string
     */
    public function render()
    {
        
        parent::render();
		
		$sfilter = $_SESSION['sfilter'];
		 
		$svendoroxId = $sfilter["vendor"];
		
		
		$sfilter_date = $sfilter["date"];
		$sfilter_artnum = $sfilter["artnum"];
		
		
		
		$this->_aViewData["sfilter"] = $sfilter;
	
		
			$oDb = oxDb::getDb(oxDb::FETCH_MODE_ASSOC);
		
		if($svendoroxId){
        	//return "wws_vendorsorder.tpl";
			$this->_aViewData["vendorselected"] = $svendoroxId;
			
	
				//Liste azeigen mit allen Lieferanten bei denen ein Produkt nicht an lager ist.
		$sSql = "SELECT `oxvendororder2articles`.`OXID` AS OXID, `oxvendororder2articles`.`OXARTICLEID` AS OXARTICLEID, `oxvendororder2articles`.`OXDATE` AS OXDATE, `oxvendororder2articles`.`OXAMOUNT` AS OXAMOUNT, `oxarticles`.`OXARTNUM` AS OXARTNUM FROM `oxvendororder2articles`,`oxarticles` WHERE `oxvendororder2articles`.`OXVENDORID` = '".$svendoroxId."' AND `oxvendororder2articles`.`OXARTICLEID`= `oxarticles`.`OXID`";
		
		if($sfilter_artnum){
			$sSql .= " AND `oxarticles`.`OXARTNUM` like '%".$sfilter_artnum."%' ";
		}
		if($sfilter_date){
			$sSql .= " AND `oxvendororder2articles`.`OXDATE` like '%".$sfilter_date."%' ";
		}
		
		
		
		$sSql .= " ORDER BY `oxarticles`.OXARTNUM ASC;";
		//$sSql .= " ORDER BY `oxarticles`.OXTITLE ASC;";
			 	
		
			 	
				 $result = $oDb->Execute($sSql);
				
					if ($result != false && $result->recordCount() > 0) { 
							while (!$result->EOF) {
								 $result->fields["OXTITLE"] = $this->_getOxtitle( $result->fields["OXARTICLEID"] ) ;
								 $articles[]=$result->fields;
								// $articles["OXTITLE"] = "test";
							$result->moveNext();
						}
						
						 $this->_aViewData["vendororders"] = $articles;
						 $this->_aViewData["count_dbquerylist"] = count($articles);
        			}
						
		}
		
		
				
		
		//$this->_aViewData["count_vlist"] = count($_SESSION['sessionvlist']);
		
		return "upvendororder_pending.tpl";
    }


		// zb so:[{$oViewConf->getRandomOxtitle($oxid,"oxvendor")}]
		protected function _getOxtitle($oxid)
		{
	
			$sSql=("SELECT `OXTITLE` FROM `oxarticles` WHERE oxid =   '".$oxid."' ;");
			
			 $result = oxDb::getDb(oxDb::FETCH_MODE_ASSOC)->GetOne( $sSql);
			 
			 //Variant Handling
			 if($result == ""){
				 	$sSql=("SELECT `OXPARENTID` FROM `oxarticles` WHERE oxid =   '".$oxid."' ;");
					$parentid = oxDb::getDb(oxDb::FETCH_MODE_ASSOC)->GetOne( $sSql);
					
					$sSql=("SELECT `OXVARSELECT` FROM `oxarticles` WHERE oxid =   '".$oxid."' ;");
					$varselect = oxDb::getDb(oxDb::FETCH_MODE_ASSOC)->GetOne( $sSql);
					
					$sSql=("SELECT `OXTITLE` FROM `oxarticles` WHERE oxid =   '".$parentid."' ;");
					$title = oxDb::getDb(oxDb::FETCH_MODE_ASSOC)->GetOne( $sSql);
				 	
					$result = $title." - ".$varselect;				 
				}
			 
			return $result; 			
		}
	
	
	/** 
     * Löscht die Bestellliste
     *
     * @return null
     */
	 public function unsetvlist()
    {
       
 		unset($_SESSION['sessionvlist']);
	}
	
	/** 
     * Löscht eine Array in vlsit
     *
     * @return null
     */
	 public function unsetvlistelement()
    {
       $index= oxRegistry::getConfig()->getRequestParameter( "vlistkey" );
 		unset($_SESSION['sessionvlist'][$index]); 
	}
	
	
	/** 
     * Setzt filter für Artikelauswahl
     *
     * @return null
     */
	 public function setfilter()
    {
      
 		$_SESSION['sfilter'] = oxRegistry::getConfig()->getRequestParameter('sfilter' );
		 
	}
	/** 
     * Setzt filter für Artikelauswahl
     *
     * @return null
     */
	 public function resetfilter()
    {
       
 		unset($_SESSION['sfilter']);
		$this->unsetvlist();
		 
	}
	

	/** 
     * Überprüft ob eine oxid in array, wow das funktioniert sogar
     *
     * @return 1 on true
     */
	 public function checkduplic($soxid)
    {
		   if($_SESSION['sessionvlist']){
			   
			foreach($_SESSION['sessionvlist'] as $key=>$subarray){
				
				if (in_array($soxid, $subarray)) {
					return true;
				}
				
			 }
		   }
	}
	
	
	
	 /**
     * Sets and/or Updates the Vlist
     *
     * @return null
     */
    public function setVendororderlist()
    {
       
	   $selection_array = oxRegistry::getConfig()->getRequestParameter( 'aOrderArticles' );
	
	   if( count( $selection_array ) >0 ){
				 
		   foreach($selection_array as $key=>$value){
				$value["orderamount"] = $value["orderamount"] - 0;
				if($value["oxonlist"] == 1 && $value["orderamount"]>0){
					$value["OXID"] = $key; //oxid array setzen, könnte man auch im formular, egal..
					$temp_array[] = $value;
				}
			}
				   
			if($temp_array){ //check ob überhautp ein temparray erstellt wurde, wenn nicht oxonlist dann logischerweise nicht..
				
				if($_SESSION['sessionvlist']){
					$result = array_merge($_SESSION['sessionvlist'], $temp_array);
				}else{
					$result =  $temp_array;
				}
			}else{
				return false;
			}
			
			$_SESSION['sessionvlist'] = $this->_vlistasort( $result, 'oxartnum');
		
		}
		
    }
	
	
	/**
     * Sortiert Array nach Alphabet
     * @return Sortiertes Array
     */
    protected function _vlistasort( $a,$subkey )
    {
		foreach($a as $k=>$v) {
			$b[$k] = strtolower($v[$subkey]);
		}
		asort($b);
		foreach($b as $key=>$val) {
			$c[] = $a[$key];
		}
		return $c;
    }
	
	


		
    /**
     * Returns shop manufacturers list
     *
     * @return oxmanufacturerlist
     */
    public function getVendorList()
    {
        $oVendorlist = oxNew( "oxvendorlist" );
        $oVendorlist->loadVendorList();

        return $oVendorlist;
    }

  
	 
	 
	 /**
     * Gets Vendorextends..geclont. original in wws_vendor_extends.php
     *
     * @return null
     */
    public function deleteorder()
    {		
		  $oDb = oxDb::getDb(oxDb::FETCH_MODE_ASSOC);

			$soxId = oxRegistry::getConfig()->getRequestParameter( "orderoxid" );

		  if ( $soxId != "-1"){
			  	$sSql=( "DELETE FROM `oxvendororder2articles`  WHERE OXID = '".$soxId."' ;");					
				$rs = $oDb->Execute( $sSql);
					
			
		  }
	}
	
	
		 /**
     * Gets Vendorextends..geclont. original in wws_vendor_extends.php
     *
     * @return null
     */
    public function editorder()
    {		
		  $oDb = oxDb::getDb(oxDb::FETCH_MODE_ASSOC);

			$soxId = oxRegistry::getConfig()->getRequestParameter( "orderoxid" );

		  if ( $soxId != "-1"){
			  	
				
				$newamount = oxRegistry::getConfig()->getRequestParameter("orderedamount" ) - oxRegistry::getConfig()->getRequestParameter( "receivedamount" );
				
				$sSql=( "UPDATE `oxvendororder2articles` SET OXAMOUNT='".$newamount."' WHERE OXID = '".$soxId."' ;");					
				$rs = $oDb->Execute( $sSql);
				
				
				$sSql=("SELECT `OXARTICLEID` FROM `oxvendororder2articles` WHERE oxid =   '".$soxId."' ;");
				$articleid = oxDb::getDb(oxDb::FETCH_MODE_ASSOC)->GetOne( $sSql);
				
				//----------------------------------
				
			
				 
				  $sSql=("SELECT * FROM `oxarticles` WHERE oxid =   '".$articleid."' ;");
				  $article = $oDb->Execute( $sSql);
				 
				
				  
				  $newstock = $article->fields["OXSTOCK"] + oxRegistry::getConfig()->getRequestParameter("receivedamount" );
				 
				  $oDb->execute( 'update oxarticles set oxarticles.oxstock = '.$oDb->quote( $newstock ).' where oxarticles.oxid = '.$oDb->quote( $articleid ) );
				  
				  
				  
				  
				  $note = "Auto-Verbuchung vom: ".date( 'd.m.Y', mktime( 0, 0, 0, date ( 'm' ), date ( 'd' ), date( 'Y' ) )) ;
				  
				  $newrowoxid = oxUtilsObject::getInstance()->generateUID();
		
				 $sQi = "INSERT INTO `up_stockhistory` ( `OXID` ,`OXARTICLE_OXID` , `OXARTICLE_OXPARENT` ,  `EKPRICE` , `NOTE` , `STOCK` , `LIEFERANT_FK` , `EXPENSED`,`TYPE` )
							VALUES (
							'".$newrowoxid."','".$article->fields["OXID"]."', '".$article->fields["OXPARENTID"]."', '".$article->fields["OXBPRICE"]."', '".$note."', '".oxRegistry::getConfig()->getRequestParameter("receivedamount" )."', '".$article->fields["OXVENDORID"]."', '1', 'lieferant_lieferung'
							);";

		 		  $oDb->execute($sQi);
				  
				  
				  
				  
				  //Wenn mehr erhalten als bestellt, oder wenn bestellt = erhalten. wird der eintrag in der datenbank gelöscht, da nicht mehr benötigt.
				  if( oxRegistry::getConfig()->getRequestParameter( "orderedamount" ) <= oxRegistry::getConfig()->getRequestParameter( "receivedamount" ) ){
					  	$sSql=( "DELETE FROM `oxvendororder2articles`  WHERE OXID = '".$soxId."' ;");	
						$oDb->execute($sSql);
				  }
				 //------------------------------------
					
			
		  }
	}
 
}
