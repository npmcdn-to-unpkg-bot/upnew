<?php

/**
 * Shop RSS page.
 */
class upStreetDealJSONP extends oxUBase
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
            
             $oVars = $oProduct->getAdminVariants();
            
            if($oVars){ 
                $variants = array();
                foreach($oVars as $var){
                    $variant = array(
                          'oxid' => $var->oxarticles__oxid->value,
                          'varselect' => $var->oxarticles__oxvarselect->value,
                          'stock' => $var->oxarticles__oxstock->value
                          //'stock' => $oProduct->getVarStockStatus()
                          
                    );
                    array_push($variants, $variant);
                }
            }
        }
        
        //$oProduct->oxarticles__oxsockflag->value
        
        $stockStatus = $oProduct->getVarStockStatus(); 
        
        
        
        $stockdata = array(
            'parentid' => $oProduct->oxarticles__oxid->value,
            'stock' => $oProduct->oxarticles__oxstock->value + $oProduct->oxarticles__oxvarstock->value, // combining stock with varstock, less logic
            'vartype' =>  $oProduct->oxarticles__ovarname->value,
            'variants' => $variants
        );
        
        $jsondata = json_encode($stockdata);
        
        echo 'angular.callbacks._'.$_GET['counter'].'('.$jsondata.');';
        
        /*echo 'angular.callbacks._0(
        {
        	"nameid": "size",
        	"variants": [
        		{
        			"oxid": "4657481ghrt64",
        			"name": "XL",
        			"stock": 610
        		},
        		{
        			"oxid": "1157481grbt64",
        			"name": "L",
        			"stock": 0
        		},
        		{
        			"oxid": "2257481grbt64",
        			"name": "M",
        			"stock": 3
        		},
        		{
        			"oxid": "2dff7481grbt64",
        			"name": "S",
        			"stock": 1
        		}
        	]
        }
        );';
 */
        
        parent::init();
    }

}

