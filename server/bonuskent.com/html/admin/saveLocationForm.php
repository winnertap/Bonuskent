<?php
include('db.php');
session_start();
$session_id='1'; //$session id


$longitude = $_POST['longitude'];
$latitude = $_POST['latitude'];
$location_global_impact = $_POST['location_global_impact'];
$location_AR_global_impact = $_POST['location_AR_global_impact'];
$gmap_url = $_POST['gmap_url'];
$zoomlevel = $_POST['zoomlevel'];

mysql_query("UPDATE compaign SET location_global_impact='$location_global_impact',location_AR_global_impact='$location_AR_global_impact',gmap_url='$gmap_url', longitude='$longitude' ,latitude='$latitude', zoomlevel='$zoomlevel' WHERE id=".$_SESSION['compaignId']." ");

header( 'Location: compaign_marker.php' ) ;

?>