<?php
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */

class UpOrderOverviewOxUser extends UpOrderOverviewOxUser_parent
{
   
    /**
     * Returns object with ordering information (order articles list).
     *
     * @param int $iLimit how many entries to load
     * @param int $iPage  which page to start
     *
     * @return oxList
     */
    public function getOrdersByEmailAndId($iLimit = false, $iPage = 0)
    {
        $oOrders = oxNew('oxList');
        $oOrders->init('oxorder');
         $oDb = oxDb::getDb();
        
        if ($iLimit !== false) {
            $oOrders->setSqlLimit($iLimit * $iPage, $iLimit);
        }

        //P
        // Lists does not support loading from two tables, so orders
        // articles now are loaded in account_order.php view and no need to use blLoadProdInfo
        // forcing to load product info which is used in templates
        // $oOrders->aSetBeforeAssign['blLoadProdInfo'] = true;
        
        
        //loading order for registered user
        if ($this->oxuser__oxregister->value > 1  ) {
           
            $sQ = 'select * from oxorder where oxuserid = ' . $oDb->quote($this->getId() )  . ' and oxorderdate >= ' . $oDb->quote($this->oxuser__oxregister->value) . ' ';
            //#1546 - shopid check added, if it is not multishop
            $sQ .= ' order by oxorderdate desc ';
        }else{
            
            $sQ = 'select * from oxorder where oxbillemail = ' . $oDb->quote($this->oxuser__oxusername->value) ;
            //#1546 - shopid check added, if it is not multishop
            $sQ .= ' order by oxorderdate desc ';
        }
        
        $oOrders->selectString($sQ);
        return $oOrders;
    }



   
} 
 
 
 