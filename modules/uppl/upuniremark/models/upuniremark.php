<?php
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */
class UpUniRemark extends oxBase
{

    
    /**
     * Current class name
     *
     * @var string classname
     */
    protected $_sClassName = 'UpUniRemark';


    /**
     * Order user
     *
     * @var oxUser
     */
    protected $_oUser = null;
 
    /**
     * Class constructor
     */
    public function __construct()
    {
        parent::__construct();
        $this->init('upuniremark'); //load db info
    }

    public function loadLatestFromParent($oxid){
         $oDb = oxDb::getDb();

         $res =  $oDb->getOne("select oxid from upuniremark where oxparentid=" . $oDb->quote( $oxid ). " order by oxtimestamp desc ");
      
         if($this->load($res)){
            return true;
        }else{
            return false;
        }
    }
    
    public function loadLatestExternal($oxid){
         $oDb = oxDb::getDb();

         $res =  $oDb->getOne("select oxid from upuniremark where oxparentid=" . $oDb->quote( $oxid ). " AND oxextern =" . $oDb->quote( 1 ). "order by oxtimestamp desc ");
      
         if($this->load($res)){
            return true;
        }else{
            return false;
        }
    }
    

    /**
     * Returns user object of Remark Author
     *
     * @return oxuser
     */
    public function getRemarkAuthor()
    {
        if ($this->_oUser === null) {
            $this->_oUser = oxNew("oxuser");
            $this->_oUser->load($this->upuniremark__oxuserid->value); 
        }

        return $this->_oUser;
    }



    public function getParentObject(){
       if( $this->_parentObject  === null) {
             $this->loadParentObject();
       }
       return  $this->_parentObject;
    }
    
    //lädt parent objekt
    public function loadParentObject(){

        $this->_parentType = $this->searchParentObject();

        if($this->_parentType == "oxarticles"){
           $this->_parentType = "oxarticle";
        }
        if($this->_parentType == "oxorderarticles"){
           $this->_parentType = "oxorderarticle";
        }

        if($this->_parentType){
                $o = oxNew( $this->_parentType );
                $o->load($this->upuniremark__oxparentid->value);
                $this->_parentObject = $o;
                
        }
    }

  
    //sucht nach objekt in vordefinierten tabellen
    public function searchParentObject(){
            $tbls = array("oxuser","oxmanufacturers", "oxorder", "oxarticles", "oxorderarticles");
            $oDb = oxDb::getDb();
            foreach($tbls as $tbl){

                $res =  $oDb->getOne("select oxid from $tbl where oxid=" . $oDb->quote( $this->upuniremark__oxparentid->value) );
                if($res){
                    break;
                    
                }
                $tbl = '';
            }
            
            return $tbl;        
    }

     public function getParentType(){
        return $this->_parentType;

    }
  

    public function getUniRemarkHistory(){
         // all remarks
        $oUniRemarkList = oxNew("oxlist");
        $oUniRemarkList->init("UpUniRemark");
        
         $sSelect = "select * from upuniremark where oxparentid=" .  oxDb::getDb()->quote( $this->upuniremark__oxparentid->value ) . " order by oxtimestamp desc";
    
        $oUniRemarkList->selectString($sSelect);


        return $oUniRemarkList;
    }

    public function getUniRemarkAuthors(){
         // all remarks
        $oUniRemarkList = oxNew("oxlist");
        $oUniRemarkList->init("UpUniRemark");
        
         $sSelect = "select * from upuniremark where oxparentid=" .  oxDb::getDb()->quote( $this->upuniremark__oxparentid->value ) . " group by oxuserid";
    
        $oUniRemarkList->selectString($sSelect);

        return $oUniRemarkList;
    }
  
   
    public function getCreateDate(){
        return date('d.m.Y', strtotime( $this->upuniremark__oxtimestamp->value));
    }
    
    public function getCreateTime(){
        return date('H:i', strtotime($this->upuniremark__oxtimestamp->value));
    }



}
