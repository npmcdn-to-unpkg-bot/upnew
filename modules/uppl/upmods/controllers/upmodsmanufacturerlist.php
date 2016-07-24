<?php 
/* 
Module to set Fast Sorting for Search and Manufacturers 
save as modules/list_presort.php 
Add this lines to Master Settings/Core Settings/System/Modules: 
search => list_presort 
manufacturerlist => list_presort 
*/ 

class upModsManufacturerList extends upModsManufacturerList_parent{ 
  
    public function getDefaultSorting( $sCnid ) 
    { 
    
        $aSorting = parent::getDefaultSorting( $sCnid ); 
        if ( !$aSorting ) { 
            $sArticleTable = getViewName('oxarticles');
            $sSortBy = $sArticleTable . '.' . 'OXINSERT';
            //Modify to desired list order 
            $aSorting = array ( 'sortby' => $sSortBy, 'sortdir' => 'DESC' ); 
        } 

        return $aSorting; 
        
    } 
    
    //Bug coming from Filter module
    public function getTitleSuffix()
    {
        if ($this->getActiveCategory()->oxcategories__oxshowsuffix->value || $this->getActManufacturer()->oxmanufacturers__oxshowsuffix->value) {
            return $this->getConfig()->getActiveShop()->oxshops__oxtitlesuffix->value;
         }
     }

  
}
