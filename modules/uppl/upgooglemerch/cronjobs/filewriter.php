<?php
  define('CHUNK_SIZE', 1024*1024); // Size (in bytes) of tiles chunk
    
    function file_get_contents_curl($url) {
    $ch = curl_init();

    curl_setopt($ch, CURLOPT_AUTOREFERER, TRUE);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);       

    $data = curl_exec($ch);
    //curl_close($ch);
    if($data){
        return $data;
    }else{
        return false;
        }
    }

  // Here goes your code for checking that the user is logged in
  // ...
  // ...
    function getStreamData($step){
        
        $lang = $_GET['lang'];
        $exportmarket = $_GET['exportmarket'];

        echo $filename = 'https://www.urbanpeople.com/index.php?cl=upgooglemerchxml&limit='.$step.'-999&lang='.$lang.'&exportmarket='.$exportmarket;
        
        $data = file_get_contents_curl($filename);
        
       // print_r($data);
        return interForm( $data) ;
    }
    
    
    
    $lang = $_GET['lang'];
    $exportmarket = $_GET['exportmarket'];
    
    $file = 'out/googlemerch'.$lang;
    
    if($exportmarket){
        $file .= '_'.$exportmarket;
    }
    
    $file .= '.xml';
      
    $step = $_GET['step'];
    if( $_GET['laststep']){
        $laststep = true;
    }else{
        $laststep = false;
    }
    
    if($step >= 0){
        if($step !=0 ){
             // Öffnet die Datei, um den vorhandenen Inhalt zu laden
            $current = file_get_contents($file);
        }else{
            $current = getXMLHEADER();
            echo "\n Neues XML File angefangen... ".$file."  \n ";
        }
        
        // Fügt neue WErte hinzu
        $current .=  getStreamData( $step )."\n";
        
        if($step !=0 && $laststep){
             $current .= getXMLFOOTER();
             echo "\n XML File geschlossen \n ";
        }
        // Schreibt den Inhalt in die Datei zurück
        file_put_contents($file, $current);
    }
    
    function getXMLHEADER(){
        $xml = "<?xml version=\"1.0\"?>";
	    $xml .= "<rss xmlns:g=\"http://base.google.com/ns/1.0\" xmlns:s=\"https://merchants.siroop.ch/\" version=\"2.0\">";
	    $xml .= "<channel>";
		$xml .= "<title>urbanpeople.com - online bestellen | exklusive Brands und die beste Auswahl an urbaner Musik</title>";
		$xml .= "<link>http://www.urbanpeople.com</link>";
		$xml .= "<description>Product Feed from Urbanpeople.com for Google Shopping</description>";
        return $xml;
    }
    
    function getXMLFOOTER(){
        return "</channel></rss>";

    }
    
    /**
     * Replaces some special chars to HTML compatible codes, returns string
     * with replaced chars.
     *
     * @param string $nValue string to replace special chars
     * @param object $oObj   object
     *
     * @return string
     */
    function interForm($nValue, $oObj = null)
    { // thnx to Volker D�rk for this function and his help here

        

        //removing simple & (and not  &uuml; chars)
        //(not full just a simple check for existing customers for cases like Johnson&Johnson)

        //$oStr = getStr();
        
/*
        $nValue = str_replace("&nbsp;", " ", $nValue);
        $nValue = str_replace("&auml;", "�", $nValue);
        $nValue = str_replace("&ouml;", "�", $nValue);
        $nValue = str_replace("&uuml;", "�", $nValue);
        $nValue = str_replace("&Auml;", "�", $nValue);
        $nValue = str_replace("&Ouml;", "�", $nValue);
        $nValue = str_replace("&Uuml;", "�", $nValue);
        $nValue = str_replace("&szlig;", "�", $nValue);

        // usually & symbol goes (or should go) like that:
        // "& text...", so we predict that this is a rule
        // and replace it with special HTML code
        $nValue = str_replace("& ", "&amp; ", $nValue);

        $nValue = str_replace("\"", "'", $nValue);
        $nValue = str_replace("(", "'", $nValue);
        $nValue = str_replace(")", "'", $nValue);
        //$nValue = str_replace("\r\n", "", $nValue);
        //$nValue = str_replace("\n", "", $nValue);

      */

        return $nValue;
    }
    
 
?>