<?php
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */

class UpFinanceStatsFinanceOverview extends oxAdminView
{
    
    /**
     * Loads article Inventory information, passes it to Smarty engine and
     * returns name of template file "article_stock.tpl".
     *
     * @return string
     */
    public function render()
    {

        	
        
        parent::render();
		
		/* abusing controller to generate a bunch of oxids
		for($i = 0;$i < 800; $i++){
			echo oxUtilsObject::getInstance()->generateUID()."<br>";
		}
		*/
		
		 $sfilter = $_SESSION['wws_financestats_sfilter'];
		 
		 $svendoroxId = $sfilter["vendor"];

		$sfilter_from = $sfilter["from"];
		$sfilter_to = $sfilter["to"];
		$sfilter_minorder = $sfilter["minorder"];
		$sfilter_company = $sfilter["company"];
		
		$mo = $sfilter_minorder;
		
	
		$d = $sfilter_from;
		$d2 = $sfilter_to;
		
		
		
		$page = oxRegistry::getConfig()->getRequestParameter('page');
		
		
		if(!$page){
			$page=1;
		}


		if($page == 1){
		
				$this->_aViewData["all_ordersum"] = $this->_rndfr( $this->_all_ordersum($d,$d2, $mo) );
				$this->_aViewData["haendler_ordersum"] = $this->_rndfr( $this->_usergroup_ordersum($d,$d2, $mo, "oxiddealer") );
				$this->_aViewData["shopadmin_ordersum"] = $this->_rndfr( $this->_usergroup_ordersum($d,$d2, $mo, "oxidadmin") );
				$this->_aViewData["shopall_ordersum"] = $this->_rndfr( $this->_aViewData["all_ordersum"] - $this->_aViewData["haendler_ordersum"] );
				$this->_aViewData["allcleaned_ordersum"] = $this->_rndfr( $this->_aViewData["all_ordersum"] - $this->_aViewData["haendler_ordersum"] - $this->_aViewData["shopadmin_ordersum"]);
		

				//$this->_aViewData["aight_ordersum"] = $this->_rndfr( $this->_usergroup_ordersum($d,$d2, $mo, "44f806313095dd54e9fec07b11f6aa48") );
				//$this->_aViewData["booking_ordersum"] = $this->_rndfr( $this->_usergroup_ordersum($d,$d2, $mo, "cd3a0e5fae14c0468365f0d309770273") );
				//$this->_aViewData["privat_ordersum"] = $this->_rndfr( $this->_aViewData["all_ordersum"] - $this->_aViewData["haendler_ordersum"] - $this->_aViewData["aight_ordersum"] -$this->_aViewData["booking_ordersum"] );
			
			
				$this->_aViewData["all_totalcount"] = $this->_all_totalcount($d,$d2, $mo);
				$this->_aViewData["haendler_totalcount"] = $this->_usergroup_totalcount($d,$d2, $mo, "oxiddealer");
				$this->_aViewData["shopadmin_totalcount"] = $this->_usergroup_totalcount($d,$d2, $mo, "oxidadmin");
				//$this->_aViewData["aight_totalcount"] = $this->_usergroup_totalcount($d,$d2, $mo, "44f806313095dd54e9fec07b11f6aa48");
				//$this->_aViewData["booking_totalcount"] = $this->_usergroup_totalcount($d,$d2, $mo, "cd3a0e5fae14c0468365f0d309770273");
				//$this->_aViewData["privat_totalcount"] = $this->_aViewData["all_totalcount"] - 	$this->_aViewData["haendler_totalcount"] - $this->_aViewData["aight_totalcount"] - $this->_aViewData["booking_totalcount"];
				
				$this->_aViewData["shopall_totalcount"] = $this->_aViewData["all_totalcount"] - $this->_aViewData["haendler_totalcount"];
				$this->_aViewData["allcleaned_totalcount"] = $this->_aViewData["all_totalcount"] - $this->_aViewData["haendler_totalcount"] - $this->_aViewData["shopadmin_totalcount"];
				
				
				
				
				//--------
				$this->_aViewData["all_ordersum_sent"] = $this->_rndfr( $this->_all_ordersum($d,$d2, $mo,'OXSENDDATE') );
				$this->_aViewData["haendler_ordersum_sent"] = $this->_rndfr( $this->_usergroup_ordersum($d,$d2, $mo, "oxiddealer",'OXSENDDATE') );
				$this->_aViewData["shopadmin_ordersum_sent"] = $this->_rndfr( $this->_usergroup_ordersum($d,$d2, $mo, "oxidadmin", 'OXSENDDATE') );
				$this->_aViewData["shopall_ordersum_sent"] = $this->_rndfr( $this->_aViewData["all_ordersum_sent"] - $this->_aViewData["haendler_ordersum_sent"] );
				$this->_aViewData["allcleaned_ordersum_sent"] = $this->_rndfr( $this->_aViewData["all_ordersum_sent"] - $this->_aViewData["haendler_ordersum_sent"] - $this->_aViewData["shopadmin_ordersum_sent"]);
		

				//$this->_aViewData["aight_ordersum"] = $this->_rndfr( $this->_usergroup_ordersum($d,$d2, $mo, "44f806313095dd54e9fec07b11f6aa48") );
				//$this->_aViewData["booking_ordersum"] = $this->_rndfr( $this->_usergroup_ordersum($d,$d2, $mo, "cd3a0e5fae14c0468365f0d309770273") );
				//$this->_aViewData["privat_ordersum"] = $this->_rndfr( $this->_aViewData["all_ordersum"] - $this->_aViewData["haendler_ordersum"] - $this->_aViewData["aight_ordersum"] -$this->_aViewData["booking_ordersum"] );
			
			
				$this->_aViewData["all_totalcount_sent"] = $this->_all_totalcount($d,$d2, $mo,'OXSENDDATE');
				$this->_aViewData["haendler_totalcount_sent"] = $this->_usergroup_totalcount($d,$d2, $mo, "oxiddealer",'OXSENDDATE');
				$this->_aViewData["shopadmin_totalcount_sent"] = $this->_usergroup_totalcount($d,$d2, $mo, "oxidadmin",'OXSENDDATE');
				//$this->_aViewData["aight_totalcount"] = $this->_usergroup_totalcount($d,$d2, $mo, "44f806313095dd54e9fec07b11f6aa48");
				//$this->_aViewData["booking_totalcount"] = $this->_usergroup_totalcount($d,$d2, $mo, "cd3a0e5fae14c0468365f0d309770273");
				//$this->_aViewData["privat_totalcount"] = $this->_aViewData["all_totalcount"] - 	$this->_aViewData["haendler_totalcount"] - $this->_aViewData["aight_totalcount"] - $this->_aViewData["booking_totalcount"];
				
				$this->_aViewData["shopall_totalcount_sent"] = $this->_aViewData["all_totalcount_sent"] - $this->_aViewData["haendler_totalcount_sent"];
				$this->_aViewData["allcleaned_totalcount_sent"] = $this->_aViewData["all_totalcount_sent"] - $this->_aViewData["haendler_totalcount_sent"] - $this->_aViewData["shopadmin_totalcount_sent"];
				//--------
		
				$this->_aViewData["all_sent"] = $this->_rndfr( $this->_all_sent($d,$d2, $mo) );
				//$this->_aViewData["haendler_sent"] = $this->_rndfr( $this->_usergroup_sent($d,$d2, $mo, "oxiddealer") );
				//$this->_aViewData["aight_sent"] = $this->_rndfr( $this->_usergroup_sent($d,$d2, $mo, "44f806313095dd54e9fec07b11f6aa48") );
				//$this->_aViewData["booking_sent"] = $this->_rndfr( $this->_usergroup_sent($d,$d2, $mo, "cd3a0e5fae14c0468365f0d309770273") );
				
				//$this->_aViewData["privat_sent"] = $this->_rndfr( $this->_aViewData["all_sent"]-$this->_aViewData["haendler_sent"]-$this->_aViewData["aight_sent"]-$this->_aViewData["booking_sent"] );
				
				
				
				$this->_aViewData["all_sentcount"] = $this->_all_sentcount($d,$d2, $mo);
				//$this->_aViewData["haendler_sentcount"] = $this->_usergroup_sentcount($d,$d2, $mo, "oxiddealer");
				//$this->_aViewData["aight_sentcount"] = $this->_usergroup_sentcount($d,$d2, $mo, "44f806313095dd54e9fec07b11f6aa48");
				//$this->_aViewData["booking_sentcount"] = $this->_usergroup_sentcount($d,$d2, $mo, "cd3a0e5fae14c0468365f0d309770273");
				
				$this->_aViewData["privat_sentcount"] = $this->_aViewData["all_sentcount"]-$this->_aViewData["haendler_sentcount"]-$this->_aViewData["aight_sentcount"]-$this->_aViewData["booking_sentcount"];
				
				
				
				
				$this->_aViewData["paid_all"] = $this->_rndfr( $this->_paid_all($d,$d2, $mo) );
				
				
				$this->_aViewData["paid_esr"] =  $this->_paid_bypaymenttype($d,$d2, $mo, "oxidinvoice");
				$this->_aViewData["paid_nachnahme"] =  $this->_paid_bypaymenttype($d,$d2, $mo, "oxidcashondel");
				$this->_aViewData["paid_voraus"] =  $this->_paid_bypaymenttype($d,$d2, $mo, "oxidpayadvance");
				$this->_aViewData["paid_paypal"] =  $this->_paid_bypaymenttype($d,$d2, $mo, "oxidpaypal");
				$this->_aViewData["paid_postfinance"] =  $this->_paid_bypaymenttype($d,$d2, $mo, "tpf_method_post_card");
				$this->_aViewData["paid_creditcard"] =  $this->_paid_bypaymenttype($d,$d2, $mo, "tpf_method_credit_card");
				
				
				$this->_aViewData["paid_pickup"] =  $this->_paid_bypaymenttype($d,$d2, $mo, "0f3a2346acc95a6c0b4565e95c14ed7d") + $this->_paid_bypaymenttype($d,$d2, $mo, "62b16c1883261ef51b79af87d18a79b0");
				
				
			
								
		}
		
		
		
		if($page == 2){
						
				$this->_aViewData["media_sent"] =  $this->_selectedhaendler_sent($d,$d2, $mo, "media");
				$this->_aViewData["media_recieved"] =  $this->_selectedhaendler_recieved($d,$d2, $mo, "media");
			
				$this->_aViewData["exlibrisonline_sent"] =  $this->_selectedhaendler_sent($d,$d2, $mo, "82aed900bace6c65a0d80412eb96f219");
				$this->_aViewData["exlibrisonline_recieved"] =  $this->_selectedhaendler_recieved($d,$d2, $mo, "82aed900bace6c65a0d80412eb96f219");
				
				$this->_aViewData["exlibris_sent"] =  $this->_selectedhaendler_sent($d,$d2, $mo, "82a5a13d9dc892b9792e718866877bac");
				$this->_aViewData["exlibris_recieved"] =  $this->_selectedhaendler_recieved($d,$d2, $mo, "82a5a13d9dc892b9792e718866877bac");
				
				$this->_aViewData["discodispo_sent"] =  $this->_selectedhaendler_sent($d,$d2, $mo, "82a9244d32b563f62ad0e5a9dfcf1653");
				$this->_aViewData["discodispo_recieved"] =  $this->_selectedhaendler_recieved($d,$d2, $mo, "82a9244d32b563f62ad0e5a9dfcf1653");
				
				$this->_aViewData["disconco_sent"] =  $this->_selectedhaendler_sent($d,$d2, $mo, "82a9cc8dfb871f671412551a615508d4");
				$this->_aViewData["disconco_recieved"] =  $this->_selectedhaendler_recieved($d,$d2, $mo, "82a9cc8dfb871f671412551a615508d4");
				
				$this->_aViewData["cede_sent"] =  $this->_selectedhaendler_sent($d,$d2, $mo, "82a321e2168a795c4f5f9c21fcbd5ec4");
				$this->_aViewData["cede_recieved"] =  $this->_selectedhaendler_recieved($d,$d2, $mo, "82a321e2168a795c4f5f9c21fcbd5ec4");
		}
		
		$this->_aViewData["today"] = date("Y-m-d");
			
		
		if($page == 3){
			
			$startTime = strtotime($d);
			$endTime = strtotime($d2);
			
			$iter=0;
			
			// Loop between timestamps, 24 hours at a time
			for ($i = $startTime; $i <= $endTime; $i = $i + 86400) {
				
			 $thisDate = date('Y-m-d', $i); // 2010-05-01, 2010-05-02, etc -> datumformatierung f�r berechnungsfunktionen
			 
			 $day_sum[$iter]["datum"]   = date('D d.m.y', $i); //Datum verk�rtz ausgegen
			
			 $day_sum[$iter]["haendler_sum"]  =  $this->_rndfr( $this->_usergroup_ordersum($thisDate,$thisDate, $mo, "oxiddealer") );
			 $day_sum[$iter]["aight_sum"]  =  $this->_rndfr( $this->_usergroup_ordersum($thisDate,$thisDate, $mo, "44f806313095dd54e9fec07b11f6aa48") );
			 $day_sum[$iter]["booking_sum"]  =  $this->_rndfr( $this->_usergroup_ordersum($thisDate,$thisDate, $mo, "cd3a0e5fae14c0468365f0d309770273") );
			 
			 //hier die weiteren stellen enf�gen...
			 $day_sum[$iter]["privat_sum"]  = $this->_rndfr( $this->_all_ordersum($thisDate,$thisDate, $mo) ) - $day_sum[$iter]["haendler_sum"] - $day_sum[$iter]["aight_sum"] - $day_sum[$iter]["booking_sum"] ;
			 
			 $iter++;
			}
				
			$this->_aViewData["day_sum"] = $day_sum;
			
			
			$this->_aViewData["getorders"] = $this->_getOrders($d,$d2, $mo);
		
		}
		
		$this->_aViewData["sfilter"] = $sfilter;
		
		$this->_aViewData["page"]=$page;
		
		return "financeoverview.tpl";
    }


	
	/** 
     * L�scht eine Array in vlsit
     *
     * @return null
     */
	 public function _rndfr($price)
    {
      $er = (round(20*$price))/20;
	  
	  return number_format($er, 2, '.', "");
	  
	  
	}
	
	
	/** 
     * Setzt filter f�r Artikelauswahl
     *
     * @return null
     */
	 public function setfilter()
    {
       
 		$_SESSION['wws_financestats_sfilter'] = oxRegistry::getConfig()->getRequestParameter('sfilter');
		 
	}
	/** 
     * Setzt filter f�r Artikelauswahl
     *
     * @return null
     */
	 public function resetfilter()
    {
       
 		unset($_SESSION['wws_financestats_sfilter']);
	
		 
	}
	


	
	
	 /**
     * Sets and/or Updates the Vlist
     *
     * @return null
     */
    public function setVendororderlist()
    {
       
	   $selection_array = oxConfig::getParameter( 'aOrderArticles' );
	
	   if( count( $selection_array ) >0 ){
				 
		   foreach($selection_array as $key=>$value){
				$value["orderamount"] = $value["orderamount"] - 0;
				if($value["oxonlist"] == 1 && $value["orderamount"]>0){
					$value["OXID"] = $key; //oxid array setzen, k�nnte man auch im formular, egal..
					$temp_array[] = $value;
				}
			}
				   
			if($temp_array){ //check ob �berhautp ein temparray erstellt wurde, wenn nicht oxonlist dann logischerweise nicht..
				
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
	
	



  
	
	 protected function _sendLog( $subject, $body )
	{
			$mail = new PHPMailer(true); //defaults to using php "mail()"; the true param means it will throw exceptions on errors, which we need to catch
			
			try {
			  $mail->AddReplyTo('robert_test@nationmusic.ch', 'No Reply');
			  $empfaenger="denus.robert@gmail.com";
			  $mail->AddAddress($empfaenger, 'Katarina Soldo');
			  $mail->SetFrom('robert_test@nationmusic.ch', 'Urbanpeople Shop');
			
			  $mail->Subject = $subject;
			  
			  $mail->AltBody = 'To view the message, please use an HTML compatible email viewer!'; // optional - MsgHTML will create an alternate automatically
			  //$mail->MsgHTML(file_get_contents('contents.html'));
			  $mail->MsgHTML($body);
			  //$mail->AddAttachment('images/phpmailer.gif');      // attachment
			  //$mail->AddAttachment('images/phpmailer_mini.gif'); // attachment
			  $mail->Send();
			  
			
              oxUtilsView::getInstance()->addErrorToDisplay("Import abgeschlossen. Best�tigungsmail an $empfaenger abgeschickt. ");
			  
			 
			} catch (phpmailerException $e) {
			  echo $e->errorMessage(); //Pretty error messages from PHPMailer
			} catch (Exception $e) {
			  echo $e->getMessage(); //Boring error messages from anything else!
			}
	}

  
	 

	
	
	/** Summer aller eingegangen Bestellungen **/
    public function _all_ordersum($day, $day2, $minorder, $datefield = 'OXORDERDATE')
    {		
    	$datefield;
        $sSelect = "SELECT SUM(OXTOTALORDERSUM) as total_geschrieben_heute
							FROM oxorder
							WHERE $datefield >= '$day 00:00:00' AND $datefield <= '$day2 23:59:59' AND OXSTORNO = '0' AND OXORDERNR > '".$minorder."'
							 ";
							 
         return ( double ) oxDb::getDb()->getOne( $sSelect ); 
	}
	
	/** Summer aller eingeganger H�ndler-Bestellungen **/
    public function _usergroup_ordersum($day, $day2, $minorder, $usergroup,  $datefield = 'OXORDERDATE')
    {		
         $sSelect = "SELECT SUM(OXTOTALORDERSUM) as total_geschrieben_heute
							FROM oxorder, oxuser, oxobject2group
							WHERE oxorder.$datefield >= '".$day." 00:00:00' AND oxorder.$datefield <= '".$day2." 23:59:59' AND oxuser.OXID = oxorder.OXUSERID AND oxuser.OXID = oxobject2group.oxobjectid AND oxobject2group.oxgroupsid = '".$usergroup."' AND oxorder.OXSTORNO = '0' AND oxorder.OXORDERNR > '".$minorder."'";
														 
         return ( double ) oxDb::getDb()->getOne( $sSelect ); 
	}
	
	
	
	
		/** Anzahl aller eingeganger Bestellungen **/
    public function _all_totalcount($day, $day2, $minorder,  $datefield = 'OXORDERDATE')
    {		
          $sSelect = "SELECT COUNT( oxid ) AS total_geschrieben_heute FROM oxorder WHERE $datefield >= '".$day." 00:00:00' AND $datefield <= '".$day2." 23:59:59' AND OXSTORNO = '0' AND OXORDERNR > '".$minorder."';";
														 
         return ( double ) oxDb::getDb()->getOne( $sSelect ); 
	}
	
			/** Anzahl aller eingeganger H�ndler-Bestellungen **/
    public function _usergroup_totalcount($day, $day2, $minorder, $usergroup,  $datefield = 'OXORDERDATE')
    {		
        $sSelect = "SELECT COUNT(oxorder.oxid ) AS total_geschrieben_heute
FROM oxorder, oxuser, oxobject2group
WHERE oxorder.$datefield >= '".$day." 00:00:00' AND oxorder.$datefield <= '".$day2." 23:59:59' AND oxuser.OXID = oxorder.OXUSERID AND oxuser.OXID = oxobject2group.oxobjectid AND oxobject2group.oxgroupsid = '".$usergroup."' AND oxorder.OXSTORNO = '0' AND oxorder.OXORDERNR > '".$minorder."';";
														 
         return ( double ) oxDb::getDb()->getOne( $sSelect ); 
	}
	
		/** Anzahl aller versendeten Bestellungen **/
    public function _all_sent($day, $day2, $minorder)
    {		
        $sSelect = "SELECT SUM(OXTOTALORDERSUM) as total_geschrieben_heute FROM oxorder WHERE OXSENDDATE >= '".$day." 00:00:00' AND OXSENDDATE <= '".$day2." 23:59:59' AND OXSTORNO = '0' AND OXORDERNR > '".$minorder."';";
														 
        return ( double ) oxDb::getDb()->getOne( $sSelect ); 
	}
	
	
			/** Anzahl aller versendeten Haendler-Bestellungen **/
    public function _usergroup_sent($day, $day2, $minorder, $usergroup)
    {		
        $sSelect = "SELECT SUM(OXTOTALORDERSUM) as total_geschrieben_heute
FROM oxorder, oxuser, oxobject2group
WHERE oxorder.OXSENDDATE >= '".$day." 00:00:00' AND oxorder.OXSENDDATE <= '".$day2." 23:59:59' AND oxuser.OXID = oxorder.OXUSERID AND oxuser.OXID = oxobject2group.oxobjectid AND oxobject2group.oxgroupsid = '".$usergroup."' AND oxorder.OXSTORNO = '0' AND oxorder.OXORDERNR > '".$minorder."';";
														 
        return ( double ) oxDb::getDb()->getOne( $sSelect ); 
	}
	
	
				/** Anzahl aller versendeten Bestellungen **/
    public function _all_sentcount($day, $day2, $minorder)
    {		
        $sSelect = "SELECT COUNT( oxid ) AS total_geschrieben_heute FROM oxorder WHERE OXSENDDATE >= '".$day." 00:00:00' AND OXSENDDATE <= '".$day2." 23:59:59' AND OXSTORNO = '0' AND OXORDERNR > '".$minorder."';";
														 
        return ( double ) oxDb::getDb()->getOne( $sSelect ); 
	}
	
	/** Anzahl aller versendeten Haendler-Bestellungen **/
    public function _usergroup_sentcount($day, $day2, $minorder, $usergroup)
    {		
        $sSelect = "SELECT COUNT(oxorder.oxid ) AS total_geschrieben_heute FROM oxorder, oxuser, oxobject2group WHERE oxorder.OXSENDDATE >= '".$day." 00:00:00' AND oxorder.OXSENDDATE <= '".$day2." 23:59:59' AND oxuser.OXID = oxorder.OXUSERID AND oxuser.OXID = oxobject2group.oxobjectid AND oxobject2group.oxgroupsid = '".$usergroup."' AND oxorder.OXSTORNO = '0' AND oxorder.OXORDERNR > '".$minorder."';";
														 
        return ( double ) oxDb::getDb()->getOne( $sSelect ); 
	}
	
	/** Betrag aller Einzahlungen **/
	 public function _paid_all($day, $day2, $minorder)
    {		
        $sSelect = "SELECT SUM(OXTOTALORDERSUM) as total_geschrieben_heute
FROM oxorder
WHERE OXPAID >= '".$day." 00:00:00' AND OXPAID <= '".$day2." 23:59:59' AND OXSTORNO = '0' AND OXORDERNR > '".$minorder."'
;";
														 
        return ( double ) oxDb::getDb()->getOne( $sSelect ); 
	}
	
	
	/**Betrag aller Haenlder Einzahlungen **/
		 public function _paid_haendler($day, $day2, $minorder)
    {		
        $sSelect = "SELECT SUM( OXTOTALORDERSUM ) AS total_geschrieben_heute
						FROM oxorder, oxuser, oxobject2group
						WHERE oxorder.OXPAID >=  '".$day." 00:00:00'
						AND oxorder.OXPAID <= '".$day2." 23:59:59'
						AND oxuser.OXID = oxorder.OXUSERID
						AND oxuser.OXID = oxobject2group.oxobjectid
						AND oxobject2group.oxgroupsid =  'oxiddealer'
						AND oxorder.OXSTORNO =  '0'
						AND oxorder.OXORDERNR >  '".$minorder."'
						;";
														 
        return ( double ) oxDb::getDb()->getOne( $sSelect ); 
	}
	
	
	
	
	
	/* universelle funtkion f�r verschiede zahlungsarten */
		 public function _paid_bypaymenttype($day,$day2, $minorder, $paymenttype)
    {		
        $sSelect = "SELECT SUM(OXTOTALORDERSUM) as total_geschrieben_heute FROM oxorder WHERE OXPAID >= '".$day." 00:00:00' AND OXPAID <= '".$day2." 23:59:59' AND OXSTORNO = '0' AND OXORDERNR > '".$minorder."' AND OXPAYMENTTYPE = '".$paymenttype."'
;";
														 
        return $this->_rndfr( ( double ) oxDb::getDb()->getOne( $sSelect ) ); 
	}
	
	
	/* Funktionen f�r H�ndler */////////////////////////
	
 		/* universelle funtkion f�r verschiede zahlungsarten */
		 public function _selectedhaendler_sent($day,$day2, $minorder, $company)
    {		
        $sSelect = "SELECT SUM(OXTOTALORDERSUM) as total_geschrieben_heute
						FROM oxorder
						WHERE OXSENDDATE >= '".$day." 00:00:00' AND OXSENDDATE <= '".$day2." 23:59:59' AND OXSTORNO = '0' ";

		
		if($company == "media"){			
			$sSelect .=	"AND (OXBILLCOMPANY like 'Media Markt%' OR OXBILLCOMPANY like 'Saturn %') ";
		}else{
			$sSelect .=	"AND OXUSERID like '".$company."' ";			
		}
		
		$sSelect .= "AND OXORDERNR > '".$minorder."'";	
				
				
        return $this->_rndfr( ( double ) oxDb::getDb()->getOne( $sSelect ) ); 
	}
	
		/* universelle funtkion f�r verschiede zahlungsarten */
		 public function _selectedhaendler_recieved($day,$day2, $minorder, $company)
    {		
        $sSelect = "SELECT SUM(OXTOTALORDERSUM) as total_geschrieben_heute
						FROM oxorder
						WHERE OXORDERDATE >= '".$day." 00:00:00' AND OXORDERDATE <= '".$day2." 23:59:59' AND OXSTORNO = '0' ";
						
		if($company == "media"){			
			$sSelect .=	"AND (OXBILLCOMPANY like 'Media Markt%' OR OXBILLCOMPANY like 'Saturn %') ";
		}else{
			$sSelect .=	"AND OXUSERID like '".$company."' ";			
		}
		
		$sSelect .= "AND OXORDERNR > '".$minorder."' ";
					
											 
        return $this->_rndfr( ( double ) oxDb::getDb()->getOne( $sSelect ) ); 
	}
	
	
	 public function _getOrders($day,$day2, $minorder)
    {		
		  $oDb = oxDb::getDb(true);
		  
		 	$sSql=("SELECT * FROM oxorder WHERE OXORDERDATE >= '".$day." 00:00:00' AND OXORDERDATE <= '".$day2." 23:59:59' AND OXSTORNO = '0' ORDER BY OXORDERNR ASC ;");
					
				 $result = $oDb->Execute($sSql);
				if ($result != false && $result->recordCount() > 0) { 
							while (!$result->EOF) {
								
								if($result->fields["OXBILLCOMPANY"]!=""){
									$result->fields["OXORDERNAME"]  = $result->fields["OXBILLCOMPANY"];
								}
								else{
									$result->fields["OXORDERNAME"] = $result->fields["OXBILLFNAME"]." ".$result->fields["OXBILLLNAME"];
								}
								
								$result->fields["OXTOTALORDERSUM"] = $this->_rndfr( $result->fields["OXTOTALORDERSUM"]);
								
								$arr[]=$result->fields;
							$result->moveNext();
						}
						
						 
        			}
				return $arr;
		
	}
	
	 
    
}