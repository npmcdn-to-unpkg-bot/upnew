<?php
/**
 * Property of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */

class UpOrderSplitOrder_Overview extends  UpOrderSplitOrder_Overview_parent 
{
   
   /**
   * splitorder. Funktion um Bestellungen zu Splitten.
   *
   * @return null
   */
    
    public function splitorder()
    {
        //ausgewählte artikel
        $aOrderArticles = oxRegistry::getConfig()->getRequestParameter("articleRow");
        
        // check ob überhaupt etwas markiert
        if( count( $aOrderArticles )>0 ){
        
            $soxId = $this->getEditObjectId();
            $oOrder = oxNew( "oxorder" );
            
            if ( $oOrder->load( $soxId ) ) {
              //artikel der alten bestellung
              $oOrderArticles = $oOrder->getOrderArticles();
          
            
              //ueberpruefen ob in alter bestellung mehr als ein artikel && und nicht alle artikel gewaehlt sind
              if( count($oOrderArticles)>1 && count($oOrderArticles) != count($aOrderArticles ) ){
                  
                // oxid für die neue Bestellung generieren 
                $sNewOrderId = oxUtilsObject::getInstance()->generateUID();
                
                $oDb = oxDb::getDb();
                
                //Bestelldaten Klon Magic
                //note: create temporary table funktioniert nicht auf jedem server
                $sQuery1 = "CREATE TEMPORARY TABLE tmp SELECT * FROM oxorder WHERE OXID = ".$oDb->quote( $soxId ).";";
                $sQuery2 = "UPDATE tmp SET OXID = ".$oDb->quote( $sNewOrderId ).", OXORDERDATE = ".$oDb->quote(date( "Y-m-d H:i:s", oxRegistry::get("oxUtilsDate")->getTime() )).";";
                $sQuery3 = "INSERT INTO oxorder SELECT * FROM tmp;";
                $sQuery4 = "ALTER TABLE tmp;";
                    
                $oDb->Execute($sQuery1);
                $oDb->Execute($sQuery2);
                $oDb->Execute($sQuery3);
                $oDb->Execute($sQuery4);
                //-> transanction ?
                
            
                $sQ = "SELECT `OXORDERNR` FROM `oxorder` WHERE `OXID` = '".$soxId."';";
                $oxremark = "Teil von Bestellnummer ".$oDb->getOne( $sQ );
                
                $sQuery = "UPDATE oxorder SET OXREMARK = '".$oxremark."' WHERE OXID = '".$sNewOrderId."'"; 
                $oDb->Execute($sQuery);
                
               
                //artikel aus alten bestellung auf neue bestellung setzen
                foreach ( $oOrderArticles as $oOrderArticle ) {
                    $sItemId = $oOrderArticle->getId();
                    if ( isset( $aOrderArticles[$sItemId] ) && $aOrderArticles[$sItemId]==1 ) {
                        $sQuery = "UPDATE oxorderarticles SET OXORDERID = '".$sNewOrderId."' WHERE OXID = '".$sItemId."'"; 
                        $oDb->Execute($sQuery);
                    }
                }
                
                //alte bestellung neu berechnen
                $oOrderOld = oxNew( "oxorder" );
                $oOrderOld->load( $soxId );
                $oOrderOld->recalculateOrder();

                //neue bestellung neu berchnen und neue bestellnummer setzen
                $oOrderNew = oxNew( "oxorder" );
                $oOrderNew->load(  $sNewOrderId );
                $oOrderNew->setNewNumber();
                $oOrderNew->recalculateOrder(); 
                $sNewOrderNr = $oOrderNew->oxorder__oxordernr->value; //ausgeben der neuen bestellnummer in der Meldung im Admin

                oxRegistry::get("oxUtilsView")->addErrorToDisplay("Neu erstellt: <span style='text-decoration: underline;'>Bestellnr. ". $oOrderNew->oxorder__oxordernr->value."</span> <a href=\"Javascript:top.oxid.admin.editThis('".$oOrderNew->oxorder__oxid->value."');\" >Zur Bestellung wechseln</a>");             
                $this->_aViewData["updatelist"] =  "1";

              } 
              else{ 
                oxRegistry::get("oxUtilsView")->addErrorToDisplay( "Eine Aufteilung dieser Bestellung ist nicht nötig.");   
              }
            }
            
        }else{
                    
            oxRegistry::get("oxUtilsView")->addErrorToDisplay("Keine Auswahl getroffen");
                    
        }
    }

   /**
   * Fügt alle bestellungen in "wartet ordner" in aktuelle bestellung
   *
   * @return null
   */
    public function mergeorders()
    {     
        $soxId = $this->getEditObjectId();
        //aktuelle bestellung muss geladen werden, da user oxid hier drin ist
        $oOrder = oxNew( "oxorder" );
      
        if( $oOrder->load( $soxId ) ) {
        //userid, wird gebraucht um alle bestellungen abzufragen
        $oOrder->oxorder__oxuserid->value;
      
        $oDb = oxDb::getDb();
    
        $oUser = $oOrder->getUser();
        $oOrderList = $oUser->getOrders();

        foreach( $oOrderList as $oUserOrder){
          if($oUserOrder->oxorder__oxfolder->value == "ORDERFOLDER_WAITING"){ 

            $sQuery = "UPDATE oxorderarticles SET OXORDERID = '".$soxId."' WHERE OXORDERID = '".$oUserOrder->oxorder__oxid->value." AND OXSTORNO != 1 '"; 

            $oDb->Execute($sQuery);
            $oUserOrder->cancelOrder();

            $textresponse .= $komma.$oUserOrder->oxorder__oxordernr->value;
            $komma = ", ";
          }

        }
        
        $oOrder->recalculateOrder();

        oxRegistry::get("oxUtilsView")->addErrorToDisplay("Zusammenf&uuml;hren folgender Bestellungen: <span style='font-style:italic;'>".$textresponse."</span>");
        $this->_aViewData["updatelist"] =  "1";
        
      }else{
        oxRegistry::get("oxUtilsView")->addErrorToDisplay("Für diesen Kunden befinden sich keine Bestellungen im Ordner 'Wartet'");
      }
    
    }
   
   
}