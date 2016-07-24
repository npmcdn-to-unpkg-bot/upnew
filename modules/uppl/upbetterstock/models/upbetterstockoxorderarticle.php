<?php
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */
class UpBetterStockOxOrderArticle extends UpBetterStockOxOrderArticle_parent
{
  

    public function getStockAvailable(){
        $oArt = $this->getArticle();
        return $oArt->getStockAvailable();
       
    }

     public function getStockReserved(){
        $oArt = $this->getArticle();
        return $oArt->getStockReserved();
       
    }

    public function getStockInShelf(){
        $oArt = $this->getArticle();
        return $oArt->getStockInShelf();
                 
    }

    public function devMethod(){
            $oArt = $this->getArticle();
        return $oArt->devMethod();


    }
//[{if $_stock4order >= 0}]<span style="color:green;">Lieferbar</span>[{elseif $_stock4order < 0 && ($_stock4order+$oViewConf->getReservation($listitem->oxorderarticles__oxartid->value) )>0}]<span style="color:orange;">Teilweise Lieferbar</span>

}
