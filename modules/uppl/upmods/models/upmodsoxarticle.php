<?php
/**
 * Urbanpeople oxArticle class
 */
class upModsOxArticle extends upModsOxArticle_parent
{
    public function getInstagramCode(){
        $shortid = substr( $this->oxarticles__oxid->value , -7);
        return 'UPPL'.$shortid;
    }
    
    public function getInstagramPic($num){
        if(  $this->oxarticles__upinstapic->value ){
            return $this->oxarticles__upinstapic->value;
        }
        if($this->oxarticles__oxpic2->value){
            $baseurl = "/out/pictures/generated/product/".$num."/653_653_92/";
            $backupimage = $this->oxarticles__oxpic2->value;
        }else{
            $baseurl = "/out/pictures/generated/product/1/653_653_92/";
            $backupimage = $this->oxarticles__oxpic1->value;
        }
        return $baseurl.$backupimage;
    }
    
    protected function _curlprocess($url){
        $ch = curl_init();
        curl_setopt_array($ch, array(
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_SSL_VERIFYPEER => false,
        CURLOPT_SSL_VERIFYHOST => 2
        ));
 
        $result = curl_exec($ch);
        curl_close($ch);
        return $result;
    }
    
    public function refetchInstaPic(){
        
        $client_id = "1e37979d447945d08c3c9f736e579670";
    
        $url = 'https://api.instagram.com/v1/tags/'.$this->getInstagramCode().'/media/recent?client_id='.$client_id;
 
        $all_result  = $this->_curlprocess($url);
        $decoded_results = json_decode($all_result, true);
 
        // echo '<pre>';
        // print_r($decoded_results);
        // exit;
 
        //Now parse through the $results array to display your results... TODO late image gallery, for now one image is enough..
        foreach($decoded_results['data'] as $item){
            $image_link = $item['images']['standard_resolution']['url'];
            //echo '<img src="'.$image_link.'" />';
        }
        
        if($image_link){
            $this->oxarticles__upinstapic = new oxField( $image_link , oxField::T_RAW);
            $this->save();
            return '<h1>Einlesen OK</h1>';
        }
        
        //return true;
    }
    
    
    /**
     * stock handling for variant items, return 99
     *
     * @return bool
     */
    public function getVarStockStatus()
    {   
        //return $this->getStockStatus();
        
        if( $oVariants = $this->getVariants() ) {
           $check = 1000;
            foreach ($oVariants as $oVariant) {
                
				 if($check !== 1000 && $check != $oVariant->getStockStatus()){
				     	 //echo "<script>console.log('1')</script>";  
				     	 //echo "<script>console.log('".$oVariant->oxarticles__oxid->value."-". $oVariant->oxarticles__oxartnum->value ." / ".$check ." / ".$oVariant->getStockStatus()."')</script>";
				     
				    return 99;

				 }else{
				     //echo "<script>console.log('".$oVariant->oxarticles__oxid->value."-". $oVariant->oxarticles__oxartnum->value ." / ".$check ." / ".$oVariant->getStockStatus()."')</script>";
				 }

				 $check = $oVariant->getStockStatus();
                		 
			}
            return $check;
        }else{
            return $this->getStockStatus();
        }
       
    }
    
    public function getDeliveryDate()
    {
        if ($this->oxarticles__oxdelivery->value != '0000-00-00') {
            if (date('Y-m-d') < $this->oxarticles__oxdelivery->value) {
               return oxRegistry::get("oxUtilsDate")->formatDBDate($this->oxarticles__oxdelivery->value);
            } 
        }
        return false;
    }
    
    
    

    /**
     * First element of title
     *
     * @return float
     */
    public function getFirstTitleLine()
    {   

        $string = strstr( $this->oxarticles__oxtitle->value, ' - ', true);
        //fehlerabfrage ggf
        return $string;
    }
    
    /**
     * Second element of title
     *
     * @return float
     */
    public function getSecondTitleLine()
    {   
        $string = strstr( $this->oxarticles__oxtitle->value, '- ');
        
        if(strpos($string, ' (')){
             $string = strstr( $string, ' (', true);
        }
        //fehlerabfrage ggf
     
        return  substr( $string, 2);
    }
    /**
     * Third element of title
     *
     * @return float
     */
    public function getThirdTitleLine()
    {   
        $string = strstr(  $this->oxarticles__oxtitle->value, '(');
        
        $replace = array("(", ")");
        $string = str_replace($replace, "", $string);
        //fehlerabfrage ggf
        if(!$string){
            $string = "&nbsp;";
        }
        return  $string;
    }
    
    
    //Returns if Item is preorder or new.. def some calc things to improve here
    public function getBadge()
		{	
		 
		    $datum = date("d.m.Y");
		 	list ($tag, $monat, $jahr) = split('[.]', $datum);
			$_now = mktime(0,0,0,$monat,$tag,$jahr);
			
			$datum_a = $this->oxarticles__oxinsert->value;
			list ($jahr_a,$monat_a, $tag_a) = split('[-]', $datum_a);
			$_insertdate = mktime(0,0,0,$monat_a,$tag_a,$jahr_a);
			
			$timestamp_diff= $_now-$_insertdate;
			// how many days between those two date
			$days_diff = ($timestamp_diff/86400);
			
			
			$pdate = $this->oxarticles__oxdelivery->value;
			list ($jahr_a,$monat_a, $tag_a) = split('[-]', $pdate);
			$_preodate = mktime(0,0,0,$monat_a,$tag_a,$jahr_a);
			
			
			if($_preodate > ( $_now ) ){
				
				return "preoitem";
			}
			else{
				
				$timestamp_diff= $_now-$_insertdate;
				// how many days between those two date
				$days_diff = ($timestamp_diff/86400);
				
				if($days_diff <= 30){
					return "newitem";
				}
			}
			
	}
	
	 public function getSimilarCategoryProducts()
    {
	
	    $aSessionFilter = oxRegistry::getSession()->getVariable('session_attrfilter');
        $sActCat = oxRegistry::getConfig()->getRequestParameter('cnid');
        
       //if cat is manufacturer then get maincat or empty
       //echo $this->oxarticles__oxmanufacturerid->value;

        if( $this->oxarticles__oxmanufacturerid->value == $sActCat || !$aActCat ){
            $oCat = $this->getCategory();
           $sActCat = $oCat->oxcategories__oxid->value;
        }

        $oAcclist = oxNew( "oxarticlelist");
        $oAcclist->setSqlLimit( 0, 6);
        $oAcclist->setCustomSorting('RAND()');
        
        if( $_GET["dd"] == 1){
            echo "check";
            print_r($aSessionFilter);
            
        }
        
       $oAcclist->loadCategoryArticlesDetailsView($sActCat, $aSessionFilter);
        
        if ( $oAcclist->count()) {
            return $oAcclist;
        }
    }
	 /**
     * RDE EDIT getmanufacturerarts
     *
     * @return array
     */
    public function getSimilarManufacturerProducts()
    {
        $myConfig = $this->getConfig();

        
		//$rand = mt_rand(0,6);
        $oAcclist = oxNew( "oxarticlelist");
        $oAcclist->setSqlLimit( 0, 6);
        $oAcclist->setCustomSorting('RAND()');
        $oAcclist->loadManufacturerArticles( $this->oxarticles__oxmanufacturerid->value);

        if ( $oAcclist->count()) {
            return $oAcclist;
        }
    }
    
    
    /**
     * Checks if article has visible status. Returns TRUE if its visible
     *
     * @return bool
     */
    public function isVisible()
    {

        // admin preview mode
        if (($blCanPreview = oxRegistry::getUtils()->canPreview()) !== null) {
            return $blCanPreview;
        }

        // active ?
        $sNow = date('Y-m-d H:i:s');
        if (!$this->oxarticles__oxactive->value &&
            ($this->oxarticles__oxactivefrom->value > $sNow ||
             $this->oxarticles__oxactiveto->value < $sNow
            )
        ) {
            return false;
        }

        // stock flags
        if ($this->getConfig()->getConfigParam('blUseStock') && $this->oxarticles__oxstockflag->value == 2) {
            $iOnStock = $this->oxarticles__oxstock->value + $this->oxarticles__oxvarstock->value;
            if ($this->getConfig()->getConfigParam('blPsBasketReservationEnabled')) {
                $iOnStock += $this->getSession()->getBasketReservations()->getReservedAmount($this->getId());
            }
            if ($iOnStock <= 0) {
                //$this->_outOfStock = true; // isNotBuyable() regelt artikel handling
                //return false; // TODO RDE return true but set as legacy article
            }
        }

        return true;
    }
    
    //Filter Attribute getter
    protected function _getFitlerAttributeById($id = false){
        
        $oDb = oxDb::getDb();
       
        if($id){
            $sAttrViewName = getViewName('oxattribute');
            $sO2AViewName = getViewName('oxobject2attribute');
          
            $stmt = $oDb->getOne("SELECT `OXVALUE` FROM {$sO2AViewName} WHERE `OXATTRID` = '{$id}' AND `OXOBJECTID` = '{$this->oxarticles__oxid->value}' " );
            return $stmt;
        }else{
            return false;
        }
    }
    
    //Returns Array with Filter Color Values
    public function getFilterColor()
    {
        $filterid = "158ce3601c089be8a6d38d27bb8af0d3"; //am besten wenn config via admin...
        
        if( $filtervalue = $this->_getFitlerAttributeById($filterid) ){
            $filter= array();
            if (strpos($filtervalue,', ') !== false) {
                $filter = explode(", ", $filtervalue);
            }else{
                array_push($filter, $filtervalue);
            }
            return $filter;
        }else{ 
            return false;        
        }
    }
    
    
    // google shopping feed filter attrs handling
    public function getGsfColor(){
        if( $aColors = $this->getFilterColor() ){
            return implode("/", $aColors);
        }
    }
    
    public function getDispatchDuration(){
         
    }
    
}
