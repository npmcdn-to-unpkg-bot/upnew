<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <title>[{ $title }]</title>
  <meta http-equiv="Content-Type" content="text/html; charset=[{$charset}]">
  [{if isset($meta_refresh_sec,$meta_refresh_url) }]
  <meta http-equiv=Refresh content="[{$meta_refresh_sec}];URL=[{$meta_refresh_url|replace:"&amp;":"&"}]">
  [{/if}]
  <link rel="shortcut icon" href="[{ $oViewConf->getBaseDir() }]favicon.ico">

<style type="text/css">
.container-fluid.box {
position: relative;
border: 1px solid #7a7a7a;
border-top: none;
margin-top: 0;
margin-bottom: -1px;
padding: 10px;
overflow: auto;
height: 80%;
}
body.upcustom{
	padding: 0;
margin: 0 20px;
background: #fff;
height: 100%;
}
</style>
 
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	</head>
<body class="upcustom">

<div class="container-fluid box">
[{include file="inc_error.tpl" Errorlist=$Errors.default}]