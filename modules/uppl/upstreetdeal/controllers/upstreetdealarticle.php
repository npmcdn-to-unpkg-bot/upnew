<?php


class upStreetDealArticle extends oxUBase
{
    /**
     * initializes objects
     *
     * @access public
     * @return void
     */
    public function init()
    {
        
        $sOxid = $_GET['oxid'];
  
        $oProduct = oxNew('oxArticle');
        if ( $oProduct->load($sOxid) ) {
            //$this->_processProduct($oProduct);
            //$this->_oParentProd = $oProduct;
            // $oVars = $oProduct->getAdminVariants();
            
          
            $data = array(
                'oxid' =>  array( 'en-US' =>  $oProduct->oxarticles__oxid->value ),
                'title' =>  array( 'en-US' =>  $oProduct->oxarticles__oxtitle->value ),
                'description' =>  array( 'en-US' => $oProduct->getLongDescription()->value ),
                'price' =>  array( 'en-US' => (float) $oProduct->oxarticles__oxpricec->value ),
                'oldprice' => array( 'en-US' => (float) $oProduct->oxarticles__oxprice->value),
            );
            
            if( $oMan = $oProduct->getManufacturer() ){
                $data['manufacturerTitle'] = array( 'en-US' => $oMan->oxmanufacturers__oxtitle->value );
                $data['manufacturerUrl'] = array( 'en-US' => $oMan->getLink() );
                $data['manufacturerIcon'] = array( 'en-US' => $oMan->getIconUrl() );
            }
            
            
            $aPics = $oProduct->getPictureGallery();
            
            $data['imagesJson'] = array( 'en-US' => $aPics );
            
            $aContentful = array( 'fields' => $data);
        
           
            $jsondata = json_encode($aContentful);
            
            print_r($data);
            $response = $this->curlContenful($jsondata);
            var_dump($response);
        }
        
     
        parent::init();
    }
    
    protected function curlContenful($jsondata){
        $ch = curl_init();
        
        //entries/meineoxid would set custom id, but setting oxid might be useless in case of wanted double entries..
        curl_setopt($ch, CURLOPT_URL, "https://api.contentful.com/spaces/kdhh4ikczjzh/entries/" );
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        curl_setopt($ch, CURLOPT_HEADER, FALSE);

        curl_setopt($ch, CURLOPT_POST, TRUE);

        curl_setopt($ch, CURLOPT_POSTFIELDS, $jsondata );

        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
          "Authorization: Bearer 155d45eb92be5fe694b33c455f2d2b8c527a323468d417c43cd7384392a60e7d",
          "Content-Type: application/vnd.contentful.management.v1+json",
          "X-Contentful-Content-Type: product",
        ));
        
        $response = curl_exec($ch);
        curl_close($ch);
        
        return $response;
    }
    
  

}

