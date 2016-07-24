<?php
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */
class UpBetterStockOxArticle extends UpBetterStockOxArticle_parent
{
  

    public function devMethod(){
       
        //return $this->oxarticles__oxstock->value;
        return "Reserviert: ".$this->getStockReserved()." Verfuegbar: ". $this->getStockAvailable()." Liegt im Lager: ".$this->getStockInShelf();
       
    }

    public function getStockAvailable(){
       
        return $this->oxarticles__oxstock->value;
       
    }

     public function getStockReserved(){
             
        $sSelect  = "select sum(oxorderarticles.oxamount) from  oxorderarticles, oxorder ";
        $sSelect .= "where oxorder.oxsenddate = 0 and oxorderarticles.oxstorno != '1' and oxorderarticles.oxartid='".$this->oxarticles__oxid->value."' ";
        $sSelect .= "and oxorder.oxid =oxorderarticles.oxorderid";
        //$sSelect .= "and oxorder.oxfolder !='ORDERFOLDER_PREPAY_0'";
        //$sSelect .= "and oxorder.oxfolder !='ORDERFOLDER_STORNO'";
        
      
     
        $result = oxDb::getDb(true)->GetOne( $sSelect);
        
        if(!$result){
            $result = 0;
        }
    
        return $result; 
       
    }

    public function getStockInShelf(){

              return $this->getStockAvailable() + $this->getStockReserved(); 
                 
    }
    
    public function getVendorOrderedAmount( )
    {	
		$oDb = oxDb::getDb();
		
		$sQ ="SELECT SUM( oxvendororder2articles.`OXAMOUNT` ) AS oxtotalamount FROM oxvendororder2articles WHERE  oxvendororder2articles.`OXARTICLEID` ='".$this->oxarticles__oxid->value."' ;";
		
		$result = $oDb->getOne( $sQ );
		
		if(!$result){
			$result = "-";
		}
		return $result;
    }





    public function getPartTitle($i){

       $aParts = explode($this->oxarticles__oxtitle->value,"-");
       if( isset($aParts[$i]) ){
        return $aParts[$i];
       }
       return $this->oxarticles__oxtitle->value;
    }



}
