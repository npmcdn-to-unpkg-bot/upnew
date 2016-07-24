<?php
/**
 * Random Footer Trust Pic
 */
class upModsRandomFooterPic extends oxWidget
{
    /**
     * Current class template name.
     *
     * @var string
     */
    protected $_sThisTemplate = 'widget/footer/trustpic.tpl';
    

    /**
     * Gets beta note link
     *
     * @return string
     */
    protected function _getRandomNr()
    {
        return rand(1, 2);
    }

    /**
     * Sets beta note link
     *
     * @param string $sLink link to set
     */
    public function getTrustedPic()
    {
        return 'trustpic_'.$this->_getRandomNr().'.jpg';
    }
   


}