<?php
/**
 * Poperty of urbanpeople.com - it is NOT Freeware.
 *
 * @link      http://www.urbanpeople.com
 * @copyright (C) Urbanpeople.com AG
 */
/**
 * oxViewConfig class wrapper for uniremark module.
 */
class UpUniRemarkOxViewConfig extends UpUniRemarkOxViewConfig_parent
{
  
    public function testABC(){
        return "hah";
    }

    public function getUniRemarkCount($oxid)
    {
          $oDb = oxDb::getDb();  
          return  $oDb->getOne("select count(*) from upuniremark where oxparentid=". $oDb->quote( $oxid) );
    }

    public function renderUniRemarkButton($oxid)
    {   
        //$sModuleUrl = $this->getModuleUrl('upuniremark');
        $imgpath= $sModuleUrl."out/admin/img/ico_note.png";

        $cnt = $this->getUniRemarkCount($oxid);
        if($cnt > 0){
            $active= "active";
        }

        $css= '<style>
            .uniremark{
                  
                
            }

            .uniremark_cnt.active{
                background-color: #ff3600;
                color:white;
            }

            .uniremark_cnt{
                background-color:#f0f0f0;
                color:#787878;
                padding: 0 5px;
                border-radius: 6px;
            }

        </style>';
        

        return $css.'<div class="uniremark"  onclick="JavaScript:showDialog(\'&cl=upuniremark_editor&oxid='.$oxid.'\');"><span class="uniremark_cnt '.$active.'"> '.$cnt.' </span></div>';

           

    }


  
  
}
