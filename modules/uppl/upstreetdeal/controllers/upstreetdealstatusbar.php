<?php

/**
 * Shop Stock Checker
 */
class upStreetDealStatusBar extends oxUBase
{   
    
    protected $accesstoken = 'dbb9cca8fd6275322f97fc196c3e64fb434e8ba64efa214bbf8ed4b4d3b1e8b6';
    protected $spaceid = 'kdhh4ikczjzh';
    
    /**
     * initializes objects
     *
     * @access public
     * @return void
     */
    public function init()
    {
        //take complete array via get instead of calling contenful 100 times.. saves 300ms
        // $array = array("269d443447319bcb7ab4af5a0d55b543", "e430be7e687ac19df0081d07b7d9f9a3", "8742a95744b130b0b820c7d75d4bf92f");
        
        $dealdate = $_GET['dealdate'];
        $oDeal = $this->curlGetContentful('content_type=deal&fields.dealdate='.$dealdate);
        
        $initialstock = $oDeal->initialstock;
        
        $oProduct = oxNew('oxArticle');
        
        foreach( $oDeal->articles as $linkitem){
        
            $oArticle = $this->curlGetContentful('sys.id='.$linkitem->sys->id);

            if ( $oProduct->load($oArticle->oxid) ) {
               $stock = $stock + $oProduct->oxarticles__oxstock->value + $oProduct->oxarticles__oxvarstock->value;
            }
           
        }

        $remaining= floor( $stock / $initialstock * 100 );
        
        $stockdata = array(
            'status' => 'ok',
            'remaining' =>  $remaining
        );
        
        $jsondata = json_encode($stockdata);
        
        echo 'angular.callbacks._'.$_GET['counter'].'('.$jsondata.');';
        
        
        parent::init();
    }
    

    protected function curlGetContentful($params){
        
        $ch = curl_init();
            
        curl_setopt($ch, CURLOPT_URL, 'https://cdn.contentful.com/spaces/'.$this->spaceid.'/entries?access_token='.$this->accesstoken.'&'.$params);
      
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        curl_setopt($ch, CURLOPT_HEADER, FALSE);
        
        $response = curl_exec($ch);
        curl_close($ch);
        
        return json_decode($response)->items[0]->fields;
        
    }

}

