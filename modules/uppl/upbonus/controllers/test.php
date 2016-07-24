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
class upBonusCron extends oxUBase
{
  
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
    
			
	    return $this->_sThisTemplate;
    }

   
}

