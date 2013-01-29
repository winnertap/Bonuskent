<?php
include('db.php');
session_start();
$session_id='1'; //$session id


$compaignName = $_POST['compaign_name'];
$startDate = $_POST['start_date'];
$endDate = $_POST['end_date'];
$compaignDescription = $_POST['compaignDescription'];
$compaignImageName = "";

if(isset($_SESSION['compaignImageName'])){
	$compaignImageName = $_SESSION['compaignImageName'];
	unset($_SESSION['compaignImageName']);	
}


	if(isset($_SESSION['compaignId'])){
		$compaignId = $_SESSION['compaignId'];
		mysql_query("UPDATE compaign SET name='$compaignName', image_path='$compaignImageName', start_date='$startDate' ,end_date='$endDate' ,description='$compaignDescription' WHERE id=".$_SESSION['compaignId']." ");
		//echo $_SESSION['compaignId'];
	}
	else{
		//echo "comapign not set.";
		$currentDate = date("Y/m/d");
		
		mysql_query("INSERT INTO compaign (userid,name, image_path,start_date,end_date,description, status, date_created) VALUES (" . $_SESSION['userId'] . ",'$compaignName', '$compaignImageName','$startDate','$endDate','$compaignDescription', 'unpublished', '$currentDate')") or die ("Error in query: $query. ".mysql_error());
		
		$compaignId = mysql_insert_id();
	
		$_SESSION['compaignId'] = $compaignId;
	}



header( 'Location: compaign_location.php' ) ;

?>