<?php
/**
 */



class UpVendorOrder_Main extends oxAdminView {
       
    protected $_sThisTemplate = 'upvendororder_main.tpl';
    protected $_hasMessage = 0;
    protected $_message = null;
    protected $_fileCounter = 0;
    protected $_fileCountStart = 0;
    protected $_selectionCounter = array();

    public function render() {
        parent::render();


         //$test = oxNew('rdeTest');

        // echo $test->getPost();
        // echo $test->getTest();
        //$this->_aViewData['cleanTemp'] = $this;
     
      

   
        
    
		 $sfilter = $_SESSION['sfilter'];
		 
		 $svendoroxId = $sfilter["vendor"];
		
		
		
		$sfilter_to = $sfilter["to"];
		$sfilter_from = $sfilter["from"];
		$sfilter_keyword = $sfilter["keyword"];
		
		
		
		$this->_aViewData["sfilter"] = $sfilter;
	
		
		$oDb = oxDb::getDb(oxDb::FETCH_MODE_ASSOC);
		
	
		if($svendoroxId){
		    
		     $_SESSION['vextends'] = $this->_getVendorextends($svendoroxId);
        	//return "wws_vendorsorder.tpl";
			$this->_aViewData["vendorselected"] = $svendoroxId;
			
	
			
			
			$sSql=("SELECT * 
					FROM  `oxarticles` 
					WHERE  `OXVENDORID` = '".$svendoroxId."'
					AND `OXVARCOUNT` = 0
					AND `OXPARENTID` = ''
					AND `OXSTOCK` < '".$sfilter_to."'
					AND `OXSTOCK` > '".$sfilter_from."'				
					AND `OXTITLE` like '%".$sfilter_keyword."%'
				
					;");
			
		
			
			 $rs = $oDb->Execute( $sSql);
			 if ($rs != false && $rs->recordCount() > 0) {
           		 while (!$rs->EOF) {
					 
					 if($rs->fields["OXSTOCK"]<0){
						$rs->fields["ORDERAMOUNT"] = 0 - $rs->fields["OXSTOCK"]; // ergibt positiven bestellwert
					}else{
						$rs->fields["ORDERAMOUNT"] = 0;
					}
					
					//echo $rs->fields["OXVARCOUNT"]."xx<br";
					
					if(!$rs->fields["OXVARCOUNT"]){ // so wird verhindert dass das Parent Product in die Liste kommt
						$arr[]=$rs->fields;
						//echo "no varcount<br>";
					}
					
					
					
					$rs->moveNext();
	            }
        	}
			

			//Produkte mit varianten
			
			$sSql=("SELECT * 
					FROM  `oxarticles` 
					WHERE  `OXVENDORID` = '".$svendoroxId."'				
					AND `OXVARCOUNT` > 0
					AND `OXPARENTID` = ''
					AND `OXTITLE` like '%".$sfilter_keyword."%'
					
					;");
			
			
			 $rs = $oDb->Execute( $sSql);
			 if ($rs != false && $rs->recordCount() > 0) {
           		 while (!$rs->EOF) {
					 
					 
					
				
					
					//Varianthandling, problem wenn Stock von Parent -99 
					//ist oxvarcount die korrekte/sichere abfrage? oder dochlieber ein durch If( select * from oxarticles where oxparentid
					if ($rs->fields["OXVARCOUNT"] > 0){
								
											$sSql=("SELECT * 
													FROM  `oxarticles` 
													WHERE  `OXPARENTID` = '".$rs->fields["OXID"]."'
													AND `OXSTOCK` < '".$sfilter_to."'
													AND `OXSTOCK` > '".$sfilter_from."'
													AND `OXACTIVE` = '1'
													;");
											 
											 
											 $subrs = $oDb->Execute( $sSql);
											 
											 if ($subrs != false && $subrs->recordCount() > 0) {
												 while (!$subrs->EOF) {
													 
													if($subrs->fields["OXSTOCK"]<0){
													 	$subrs->fields["ORDERAMOUNT"] = 0 - $subrs->fields["OXSTOCK"];
													}else{
														$subrs->fields["ORDERAMOUNT"] = 0;
													}
													
													$subrs->fields["OXTITLE"] = $rs->fields["OXTITLE"]; //setzt bei allen titel vom vater artikel da dieser bei varianten leer ist  IN DER REGEL
													
													
													$arr[]=$subrs->fields;
													
													$subrs->moveNext();
												 }
											 }					
					}
					
					$rs->moveNext();
	            }
        	}
				
				
				$this->_aViewData["dbquerylist"] = $arr;
				$this->_aViewData["count_dbquerylist"] = count($arr);
				
						
				
		}else{
			
				//Liste azeigen mit allen Lieferanten bei denen ein Produkt nicht an lager ist.
				$sSql=("SELECT  `oxvendor`.`OXTITLE`, `oxvendor`.`OXID`
							FROM  `oxvendor` ,  `oxarticles` 
							WHERE  `oxarticles`.`OXVENDORID` =  `oxvendor`.`OXID` 
							AND  `oxarticles`.`OXSTOCK` < 0
							AND `oxarticles`.`OXACTIVE` = '1'
							GROUP BY  `oxarticles`.`OXVENDORID` 
							ORDER BY  `oxvendor`.`OXTITLE` ASC 					
					;");
			 
				 $result = $oDb->Execute($sSql);
				
					if ($result != false && $result->recordCount() > 0) { 
							while (!$result->EOF) {
								 $remainingvendors[]=$result->fields;
							$result->moveNext();
						}
						
						 $this->_aViewData["remainingvendors"] = $remainingvendors;
        			}
						
		}
		
		
		$this->_aViewData["vlist"] = $_SESSION['sessionvlist'];
		
		
  	  
		$this->_aViewData["vextends"] = $_SESSION['vextends'];
		
		
		$this->_aViewData["count_vlist"] = count($_SESSION['sessionvlist']);
		
		  return $this->_sThisTemplate;
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
       $index = oxRegistry::getConfig()->getRequestParameter('vlistkey');
 		unset($_SESSION['sessionvlist'][$index]); 
	}
	
	
	/** 
     * Setzt filter für Artikelauswahl
     *
     * @return null
     */
	 public function setfilter()
    {
       
 		$_SESSION['sfilter'] = oxRegistry::getConfig()->getRequestParameter('sfilter');
		 
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
       
	   $selection_array = oxRegistry::getConfig()->getRequestParameter('aOrderArticles');
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
     * Performs PDF export to user (outputs file to save).
     *
     * @return null
     */
    public function createVPDF()
    {
        $soxId = $_SESSION['sfilter']['vendor'];
        if ( $soxId != "-1" && isset( $soxId ) ) {
            // load object
            $oVendor = oxNew( "oxvendor" );
            if ( $oVendor->load( $soxId )  ) {
				if ($_SESSION['sessionvlist']) {
					$nowdate = date("Y-m-d H:i:s"); 
				 	
				 	
				 	
				 	$stack = array( array("Art.Num", "Titel", "Anz") );
					
			        // product list
			        foreach ( $_SESSION['sessionvlist'] as $key => $article ) {
			        	
						$sQinner .= $komma."('".oxUtilsObject::getInstance()->generateUID()."', '".$oVendor->oxvendor__oxid->value."', '".$article["OXID"]."', '".$article["orderamount"]."', '".$nowdate."' )";
						
						$komma = " ,";
						array_push($stack, array( $article["oxartnum"], $article["oxtitle"], $article["orderamount"] ) );
			        }
			        
			        $oDb = oxDb::getDb();
					$sQ = "INSERT INTO `oxvendororder2articles` (`OXID`, `OXVENDORID`, `OXARTICLEID`, `OXAMOUNT`,`OXDATE` ) VALUES ".$sQinner." ;";
					$oDb->Execute($sQ);
					unset($_SESSION['vorderoxid']);
			        
			        
			        ob_start();
			        $fp = fopen('php://output', 'w');
			        foreach ($stack as $fields) {
					   fputcsv($fp, $fields, ";");
					   
					}
					
				    $e = ob_get_clean();
					//$fp = "test";
					/*echo "<pre>";
			    	print_r($e);
					echo "</pre>";*/
				
					$name = "order_".preg_replace('/\D/', '', $nowdate);
				
			
					$oUtils = oxRegistry::getUtils();
		            $oUtils->setHeader("Pragma: public");
		            $oUtils->setHeader("Cache-Control: must-revalidate, post-check=0, pre-check=0");
		            $oUtils->setHeader("Expires: 0");
		            $oUtils->setHeader("Content-type: application/x-download");
		            $oUtils->setHeader("Content-Length: " . strlen($e));
		            $oUtils->setHeader("Content-Disposition: attachment; filename=".$name.".csv");
		            $oUtils->showMessageAndExit($e);
				
					fclose($e);
				

					
					
				}

            }
        }
    }
	 
	 
	 /**
     * Gets Vendorextends..geclont. original in wws_vendor_extends.php
     *
     * @return null
     */
    public function _getVendorextends($soxId)
    {		
		  $oDb = oxDb::getDb(oxDb::FETCH_MODE_ASSOC);
	
		  if ( $soxId != "-1"){
			  
		 	$sSql=("SELECT * FROM  `oxvendorextends` WHERE  `OXID` = '".$soxId."' ;");
											
				$rs = $oDb->Execute( $sSql);
					if ($rs != false && $rs->recordCount() > 0) {
														
							$arr[]=$rs->fields;
							
						
					}else{
						$arr = NULL;
					}
				
				return $arr;
		  }
	}
	
	 public function getVendorOrderedAmount($soxId)
     {
     
     	    $oArticle = oxNew( "oxarticle" );
            if ( $oArticle->load( $soxId )  ) {
            	return $oArticle->getVendorOrderedAmount();
            }
     }
 
}
