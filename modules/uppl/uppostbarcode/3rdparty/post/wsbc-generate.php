<?php

/*****************************************************************
 * Example for calling Webservice Barcode Operation GenerateLabel
 *****************************************************************/


class Generator2 {
		
	  /*Settings */
	  private $frankinglicense;
	  
	  
	  /* post response */
	  public $filename;
	  public $trackcode;
	  
	  
	  /*Empfaengerdaten */
	  private $sal;
	  private $vorname;
	  private $nachname;
	  private $firma;
	  private $str;
	  private $strnr;
	  private $plz;
	  private $stadt;
	  private $email;
	  
	  private $addinfo;
	  
	 
	  
	  private $labelrequest;
	  

public function __construct() {
//public function __construct($config) {

   		$this->frankinglicense = "60075622";
		
		
      
}

private function getLabelName(){
	$name = $this->vorname." ".$this->nachname;
	
	if($this->vorname){
		return $name;
	}else{
		// nothing..
		
	}
}

//Setzt zusätzliche additonaldata ins array zb für BLN 
private function _pushAdditionalData($type,$value){
	array_push($this->labelrequest['Envelope']['Data']['Provider']['Sending']['Item'][0]['AdditionalINFOS']['AdditionalData'],
								array(
							 		'Type' => $type,
									'Value' => $value
								)					
	);
	
}

//Setzt zusätzliche additonaldata ins array PRZL
private function _pushPRZL($przl){
	array_push($this->labelrequest['Envelope']['Data']['Provider']['Sending']['Item'][0]['Attributes']['PRZL'],$przl);	
}

private function getAddInfo(){
   return $this->addinfo;
}

private function setRecipient($oOrder){
	
	//$this->vorname = "jebote";
		
		
		
	
	    if ((  $oOrder->oxorder__oxdelcompany->value || $oOrder->oxorder__oxdelfname->value ) && 1==1) {
						
						
						$this->sal = $oOrder->oxorder__oxdelsal->value;
						$this->firma = $oOrder->oxorder__oxdelcompany->getRawValue();
						$this->vorname = $oOrder->oxorder__oxdelfname->value;
						$this->nachname = $oOrder->oxorder__oxdellname->value;
						
						
						$this->str =  $oOrder->oxorder__oxdelstreet->value;
						$this->strnr = $oOrder->oxorder__oxdelstreetnr->value;
						$this->plz = $oOrder->oxorder__oxdelzip->value;
						$this->stadt =  $oOrder->oxorder__oxdelcity->value; 
						$this->addinfo =  $oOrder->oxorder__oxdeladdinfo->value;
						
					}else{
						
						$this->sal = $oOrder->oxorder__oxbillsal->value;
						
						$this->firma = $oOrder->oxorder__oxbillcompany->getRawValue();
						$this->vorname = $oOrder->oxorder__oxbillfname->value;
						$this->nachname = $oOrder->oxorder__oxbilllname->value;
						
						
						$this->str =  $oOrder->oxorder__oxbillstreet->value;
						$this->strnr = $oOrder->oxorder__oxbillstreetnr->value;
						$this->plz = $oOrder->oxorder__oxbillzip->value;
						$this->stadt =  $oOrder->oxorder__oxbillcity->value; 
						$this->addinfo =  $oOrder->oxorder__oxbilladdinfo->value;
					}
	
								if($this->sal == "MR"){
									$this->sal = 'Herr';
								}else{
									$this->sal = 'Frau';
								}
						$this->email =  $oOrder->oxorder__oxbillemail->value; 
								
						
}


public function _requestEtiq($oOrder){
	
	$this->setRecipient($oOrder);

	include("wsbc-init.php");
	
	include("wsbc-utils.php");
	
  	$filename = '/home/httpd/vhosts/urbanpeople.com/httpdocs/uplogo_wsbc.gif';
	$logo = file_get_contents($filename);



// Franking License Configuration
// TODO: you have to set this to a valid franking license for your barcode web service user account!


//$imgfile = 'default_logo.gif';
//$logo_binary_data = fread(fopen($imgfile, "r"), filesize($imgfile));

// 1. Define Label Request
// (see documentation of structure in "Handbuch Webservice Barcode", section 4.3.1)
$this->labelrequest = array(
    'Language' => 'de',
    'Envelope' => array(
       	'LabelDefinition' => array(
	       	'LabelLayout' => 'A6',
	        'PrintAddresses' => 'RecipientAndCustomer',
	        'ImageFileType' => 'PDF',
	        'ImageResolution' => 300,
			'PrintPreview' => false
        ),
        'FileInfos' => array(
	         'FrankingLicense' => $this->frankinglicense,
			 'PpFranking' => false,
	         'Customer' => array(
		         'Name1' => 'urbanpeople.com AG',
         		 // 'Name2' => 'Generalagentur',
		         'Street' => 'Friedaustrasse 17',
		         // 'POBox' => 'Postfach 600',
		         'ZIP' => '8003',
		         'City' => 'Zürich',
		         // 'Country' => 'CH',
		         //'Logo' => $logo,
         		 'LogoFormat' => 'GIF',
		         'DomicilePostOffice' => '3000 Bern' // ???
      		 ),
			 'CustomerSystem' => 'PHP Client System'
   		),
	    'Data' => array(
	        'Provider' => array(
	            'Sending' => array(
	            	//'SendingID' => 'auftragsreferenz',
					'Item' => array(
						array( // 1.Item ...
							'ItemID' => $oOrder->oxorder__oxordernr->value,
							// 'ItemNumber' => '12345678',
							// 'IdentCode' => '1234',
							'Recipient' => array(
								//'PostIdent' => 'IdentCodeUser',
								
								'Title' => $this->sal,

								'Vorname' => $this->vorname,
								'Name1' => $this->nachname, // Vorname wird nicht angezeigt. KOMISCH
								'Name2' => $this->firma,
								'Street' => $this->str,
								'HouseNo' => $this->strnr,
								//'FloorNo' => '1',
								//'MailboxNo' => '1111',
								'ZIP' => $this->plz,
								'City' => $this->stadt,
								//'Country' => 'CH',
								//'Phone' => '0313381111', // für ZAW3213
								//'Mobile' => '0793381111',
								'EMail' => $this->email,
								'LabelAddress' => array(
								'LabelLine' => array($this->firma,
													 $this->getLabelName(),
													 $this->addinfo,
													 $this->str." ".$this->strnr								 
														)
								)
							),
							/*'AdditionalINFOS' => array(
							// Cash-On-Delivery amount in CHF for service 'BLN':
								

							  'AdditionalData' => array(
							  	
								)
							),*/
							'Attributes' => array(
								'PRZL' => array(
									// At least one code is required (schema validation)

									// Basic service code(s) (optional, default="ECO"):
									//'PRISI',
									// Additional service codes (optional)
									
									// if $oOrder->oxorder__oxpaymenttype->value == NACHNAME -> VOLLEN BETRAG AUS OXID..
									//'N', //Nachnahme !!
									
									// Delivery instruction codes (optional)
									//'ZAW3211', Sendung direkt auf Etage zustellen
									//'ZAW3213' Telefon avisierung
									
								),

								
								
								//'FreeText' => 'Freitext',
								// 'DeliveryDate' => '2010-06-19',
								// 'ParcelNo' => 2,
								// 'ParcelTotal' => 5,
								// 'DeliveryPlace' => 'Vor der Haustüre',
								'ProClima' => false
							),
							/*'Notification' => array(
								'Type' => 'EMAIL',
								'Service' => '32',
								'Freetext1' => "test1",
								'Freetext2' => "test2",
								'Language' => 'de',
								'Communication' => array(
												'Email' => $this->email
												)
	
							)*/
						)
					//,
					// Add addtional items here for multiple requests in one web service call ...
					// array( // 2.Item ...
					//		... // same structure as above
					//	),
					)
				)
			)
		)
	)
);



if($oOrder->oxorder__oxpaymenttype->value == "oxidcashondel"){
	
		$this->_pushPRZL("BLN" );
		$this->_pushPRZL("PRI" );
	
		$this->labelrequest['Envelope']['Data']['Provider']['Sending']['Item'][0]['AdditionalINFOS'] = array(	'AdditionalData' => array() );	
				
		$this->_pushAdditionalData("NN_BETRAG",$oOrder->oxorder__oxtotalordersum->value );
		/*$this->_pushAdditionalData("NN_IBAN","CH7509000000852216061" );
		$this->_pushAdditionalData("NN_END_NAME_VORNAME","Urbanpeople AG" );
		
		$this->_pushAdditionalData("NN_END_STRASSE","Friedaustrasse 17" );
		$this->_pushAdditionalData("NN_END_PLZ","8003" );
		$this->_pushAdditionalData("NN_END_ORT","Zürich" );
		$this->_pushAdditionalData("NN_CUS_EMAIL","florian@urbanpeople.com" );
		
		$this->_pushAdditionalData("NN_CUS_MOBILE","0763281844" );
		$this->_pushAdditionalData("NN_CUS_PHONE","0442979595" );*/
		
	
		
}elseif($oOrder->oxorder__oxdeltype->value == "ac544129fdba088d46979325a33613f1"){ //B-Post
		
				if(oxRegistry::getConfig()->getRequestParameter("prisi")){
			  		$this->_pushPRZL("PRISI" ); //kein eco sign
				}else{
					$this->_pushPRZL("ECO" );
				}
}
elseif($oOrder->oxorder__oxdeltype->value == "e75daa13b80bc749586ad5fc46defa91"){ //A-Post
		
				if(oxRegistry::getConfig()->getRequestParameter("prisi")){
			  		$this->_pushPRZL("PRISI" );
				}else{
					$this->_pushPRZL("PRI" );
				}
}
else{ 
				//Kann man 2015 löschen...
				if(oxRegistry::getConfig()->getRequestParameter("prisi")){
			  		$this->_pushPRZL("PRISI" );
				}else{
					$this->_pushPRZL("PRI" );
				}
				
	

}

// 2. Web service call
$response = null;
try {
	$response = $SOAP_Client -> GenerateLabel($this->labelrequest);
	/*echo "<pre>";
	print_r($this->labelrequest);
	echo "</pre>";*/
}
catch (SoapFault $fault) {
	echo('Error in GenerateLabel: '. $fault -> __toString() .'<br />');
}

// 3. Process requests: save label images and check for errors
// (see documentation of structure in "Handbuch Webservice Barcode", section 4.3.2)
foreach (getElements($response->Envelope->Data->Provider->Sending->Item) as $item) {
	if ($item->Errors != null) {

      	// Error in Label Request Item:
      	// This barcode label was not generated due to errors.
      	// The received error messages are returned in the specified language of the request.
      	// This means, that the label was not generated,
      	// but other labels from other request items in same call
      	// might have been generated successfully anyway.
      	$errorMessages = "";
      	$delimiter="";
      	foreach (getElements($item->Errors->Error) as $error) {
      		$errorMessages .= $delimiter.$error->Message;
      		$delimiter=",";
      	}
		echo "<pre>";
		print_r($item->Errors);
      	echo "</pre>";
		echo "<pre>";
		print_r($this->labelrequest);
      	echo "</pre>";
	
		//echo '<p>ERROR for item with itemID='.$item->ItemID.": ".$errorMessages.'.<br/></p>';

	}
    else {
      	// Get successfully generated label as binary data:
      	$identCode = $item->IdentCode;
   		$labelBinaryData = $item->Label;
		
		/*
		$label = imagecreatefromstring($labelBinaryData);

		$width = imagesx($im);
		$height = imagesy($im);
		
		$logo_data = imagecreatefromstring($logo);

		// Hier den Text schreiben, der in die Grafik kommen soll
		//$text = "Bla bla bla bla";

		// Angebabe für Textgroesse und Position
		//imageString($im, 2, 3, 16, $text, ImageColorAllocate ($im, 229, 0, 123));
		
		$canvas = ImageCreate (1500, 800);
		ImageColorAllocate ($canvas, 255, 255, 255);
		
		imagecopy($canvas, $label, 0, 0, 0, 0,imagesx($label),imagesy($label)); 
		imagecopy($canvas, $logo_data, 90, 500, 0, 0, 242, 260); 
		
		
		*/

	   	// Save the binary image data to image file:
	  
	   	$filename = 	getShopBasePath().'modules/uppl/_archive/wsbc/Label_'.$oOrder->oxorder__oxid->value.$identCode.'.pdf';
		
		//imagegif($canvas,$filename);
			file_put_contents($filename, $labelBinaryData);
	   	//file_put_contents($filename, $labelBinaryData);

	   	// Printout some label information (and warnings, if any):
		//echo '<p>Label generated successfully for identCode='.$identCode.': <br/>';
		if ($item->Warnings != null) {
			$warningMessages = "";
	      	foreach (getElements($item->Warnings->Warning) as $warning) {
	      		$warningMessages .= $warning->Message.",";
	      	}
	      	echo 'with WARNINGS: '.$warningMessages.'.<br/>';
	    }
	
	
		$this->filename = $filename;
		$this->trackcode = $identCode;
		return true;
	}
}






}
}
