<?php
/**
 *    This file is part of OXID eShop Community Edition.
 *
 *    OXID eShop Community Edition is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    OXID eShop Community Edition is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with OXID eShop Community Edition.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @link      http://www.oxid-esales.com
 * @package   views
 * @copyright (C) OXID eSales AG 2003-2011
 * @version OXID eShop CE
 * @version   SVN: $Id: rss.php 26674 2010-03-19 12:05:19Z sarunas $
 */

/** 
 * Shop RSS page.
 */
class upGoogleMerchXml extends oxUBase
{
    /**
     * current rss object
     * @var oxRssFeed
     */
    protected $_oRss = null;

    /**
     * Current rss channel
     * @var object
     */
    protected $_oChannel = null;

    /**
     * Xml start and end definition
     * @var array
     */
    protected $_aXmlDef = null;
    
    /**
     * Base Language
     * @var int
     */
    protected $_iLang = 0;

    /**
     * Current class template name.
     * @var string
     */
    protected $_sThisTemplate = 'upgooglemerchxml.tpl';
    
    
    /**
     * Current class template name.
     * @var string
     */
    protected $_sItemTemplate = 'inc/googledefault_item.tpl';
    
    protected $_sExportMarket = false;

    /**
     * initializes objects
     *
     * @access public
     * @return void
     */
    public function init()
    {
        if ( null !== ( $iLang =  oxRegistry::getConfig()->getRequestParameter('lang') ) ) {
          $this->_iLang = (int) $iLang;
        }
        
        if( oxRegistry::getConfig()->getRequestParameter('exportmarket') =='siroop' ){
            $this->_sExportMarket = 'siroop';
            $this->_sItemTemplate = 'inc/'.$this->_sExportMarket.'_item.tpl';
            $this->_sHeadTemplate = 'inc/'.$this->_sExportMarket.'_head.tpl';
        }else{
            $this->_sExportMarket = 'googledefault';
            $this->_sItemTemplate = 'inc/'.$this->_sExportMarket.'_item.tpl';
            $this->_sHeadTemplate = 'inc/'.$this->_sExportMarket.'_head.tpl';
        }
      
        parent::init();
    }

   

    /**
     * 
     *
     * Template variables:
     * <b>rss</b>
     *
     * @return  string  $this->_sThisTemplate   current template file name
     */
    public function render()
    {   
        parent::render();
        
        
        $iLang =  $this->_iLang;
        oxRegistry::getLang()->setBaseLanguage($iLang);
        oxRegistry::getLang()->setTplLanguage($iLang);
    
        $oSmarty = oxRegistry::get("oxUtilsView")->getSmarty();

        // #2873: In demoshop for RSS we set php_handling to SMARTY_PHP_PASSTHRU
        // as SMARTY_PHP_REMOVE removes not only php tags, but also xml
        if ($this->getConfig()->isDemoShop()) {
            $oSmarty->php_handling = SMARTY_PHP_PASSTHRU;
        }

        foreach (array_keys($this->_aViewData) as $sViewName) {
            $oSmarty->assign_by_ref($sViewName, $this->_aViewData[$sViewName]);
        }
        // $oSmarty->assign('channel', $this->getChannel());
        // $oSmarty->assign('xmldef', $this->getXmlDef());
		
		 $oSmarty->assign('oArt', $this->getAllArticles() );
		 $oSmarty->assign('headTemplate', $this->_sHeadTemplate );
		 $oSmarty->assign('itemTemplate', $this->_sItemTemplate );
		
        // return rss xml, no further processing
        // return rss xml, no further processing
        $sCharset = oxRegistry::getLang()->translateString("charset");
        oxRegistry::getUtils()->setHeader("Content-Type: text/xml; charset=" . $sCharset);
     
        /*oxUtils::getInstance()->showMessageAndExit(
                    $this->_processOutput( 
                            $oSmarty->fetch('xml.tpl', $this->getViewId())
                    )
                );*/
			
	    return $this->_sThisTemplate;
    }

    /**
     * Processes xml before outputting to user
     *
     * @param string $sInput input to process
     *
     * @return string
     */
    protected function _processOutput( $sInput )
    {
        return getStr()->recodeEntities( $sInput );
    }



    
    public function getPhpXml()
    {
        $sCharset = $this->_getCharset();
        $sExport = "<?xml version=\"1.0\" encoding=\"{$sCharset}\"?>";
        $sExport .= "<rss xmlns:g=\"http://base.google.com/ns/1.0\" version=\"2.0\">";
        $sExport .= "<description>Product Feed from Urbanpeople.com for Google Shopping</description>";
    }
    
    protected function _getCharset()
    {
        return oxRegistry::getLang()->translateString('charset');
    }
    

 

    /**
     * Template variable getter. Returns xml start and end definition
     *
     * @return array
     */
    public function getXmlDef()
    {
        if ( $this->_aXmlDef === null ) {
            $this->_aXmlDef = false;
            $this->_aXmlDef = array('start'=>'<?xml', 'end'=>'?>');
        }
        return $this->_aXmlDef;
    }
    
    
	
	  /**
     * Template variable getter. Returns category's article list
     *
     * @return array
     */
    public function getArticleList()
    {
        if ( $this->_aArticleList === null ) {
            if  ( $oCategory = $this->getActCategory() )  {
                $aArticleList = $this->_loadArticles( $oCategory );
                if ( count( $aArticleList ) ) {
                    $this->_aArticleList = $aArticleList;
                }
            }
        }
        return $this->_aArticleList;
    }
    /**
     * Loads and returns article list of active category.
     *
     * @param string $oCategory category object
     *
     * @return array
     */
    protected function _loadArticles( $oCategory )
    {
        $myConfig = $this->getConfig();

        $iNrofCatArticles = (int) $myConfig->getConfigParam( 'iNrofCatArticles' );
        $iNrofCatArticles = $iNrofCatArticles?$iNrofCatArticles:1;

        // load only articles which we show on screen
        $oArtList = oxNew( 'oxarticlelist' );
       // $oArtList->setSqlLimit( $iNrofCatArticles * $this->getActPage(), $iNrofCatArticles );
        $oArtList->setCustomSorting( $this->getSortingSql( $oCategory->getId() ) );

        if ( $oCategory->isPriceCategory() ) {
            $dPriceFrom = $oCategory->oxcategories__oxpricefrom->value;
            $dPriceTo   = $oCategory->oxcategories__oxpriceto->value;

            $this->_iAllArtCnt = $oArtList->loadPriceArticles( $dPriceFrom, $dPriceTo, $oCategory );
        } else {
            $aSessionFilter = oxSession::getVar( 'session_attrfilter' );
            $sActCat = oxConfig::getParameter( 'cnid' );
            $this->_iAllArtCnt = $oArtList->loadCategoryArticles( $sActCat, $aSessionFilter );
        }

        $this->_iCntPages = round( $this->_iAllArtCnt/$iNrofCatArticles + 0.49 );

        return $oArtList;
    }
	
	
	/**
     * Template variable getter. Returns newest article list
     *
     * @return array
     */
    public function getAllArticles()
    {
         // newest articles
        $oArtList = oxNew( 'oxarticlelist' );
        //$oArtList->setLanguage(0);
    
       
		$limit = oxRegistry::getConfig()->getRequestParameter("limit");
		$limit = explode("-",$limit);
		
		if(!$limit[1]){
			$limit = 100;
		}else{
			$limit = $limit[0].",".$limit[1];
		}
		
	    $sArticleTable = getViewName('oxarticles');
       

        $sSelect  = "select $sArticleTable.* from $sArticleTable ";
         
        $sSelect .= $this->_getCustomArticleJoin();
        
        $sSelect .= "where  $sArticleTable.oxactive = 1 ";
        
        $sSelect .= $this->_getCustomArticleSelect();
		
        $sSelect .= "and $sArticleTable.oxissearch = 1 and $sArticleTable.oxparentid = '' "; 
        
        $sSelect .= "order by oxinsert desc limit $limit";
        
        
        $oArtList->selectString($sSelect);
    
        //print_r( $oArtList );
        
        //SELECT oxarticles.* FROM oxarticles LEFT JOIN oxmanufacturers ON oxarticles.OXMANUFACTURERID = oxmanufacturers.OXID WHERE oxmanufacturers.siroopactive = 1
        
        if ( $oArtList->count() ) {   
			return $oArtList;
        }
    }
    
    protected function _getCustomArticleSelect(){
        
        $sArticleTable = getViewName('oxarticles');
        $sManufacturerTable = getViewName('oxmanufacturers');
        
        //siroop query$_sExportMarket
        if( $this->_sExportMarket == 'siroop' ){
            $sSelect = "and ( ( $sArticleTable.oxstock + $sArticleTable.oxvarstock ) > 0 or ( $sArticleTable.oxstockflag != 2 and $sArticleTable.oxnostocktext = '' ) ) and $sManufacturerTable.siroopactive = 1 ";
        //Default query
        }else{
            $sSelect = "and (  ($sArticleTable.oxstock + $sArticleTable.oxvarstock ) > 0 or $sArticleTable.oxstockflag != 2  ) ";
        }
        
        return $sSelect;
    }
    
    protected function _getCustomArticleJoin(){
        
        $sArticleTable = getViewName('oxarticles');
        $sManufacturerTable = getViewName('oxmanufacturers');
        
        //siroop query$_sExportMarket
        if( $this->_sExportMarket == 'siroop' ){
            $sSelect = "LEFT JOIN $sManufacturerTable ON $sArticleTable.oxmanufacturerid = $sManufacturerTable.oxid ";
        //Default query
        }else{
            $sSelect = " ";
        }
        
        return $sSelect;
    }
	
	/**
     * Template variable getter. Returns newest article list
     *
     * @return array
     */
    public function getGoogleCats($seo)
    {		
			 $cats = explode(".com/", substr($seo, 0, -1) ); // http// .. com/
		
			 
			 return str_replace( "/"," &gt; ", $cats[1] );
    }
	
	public function cleanHtmlTags(){
	}
}

