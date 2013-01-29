<?php

include('db.php');

if(isset($_REQUEST['congratsScreenEntry'])){
	$jsonString = $_REQUEST['congratsScreenEntry'];

//$jsonString = '{"id":null,"user_id":2,"campaign_id":30,"activity":"share_facebook_score", "image":"asdas.jpg"}';

$jsonString = stripslashes($jsonString);
//echo $jsonString;
/* use json_decode to create an array from json */
$json_array = json_decode($jsonString, true);

//print_r($json_array);

$campaign_id = $json_array['campaign_id'];
$activty = $json_array['activity'];
$activityScore = 0;

//echo " activty= " . $activty;

$result = mysql_query("SELECT * FROM scores where campaign_id = '$campaign_id' ") or die(mysql_error());

while($row = mysql_fetch_assoc($result)){
	
	$activityScore  = $row[$activty];
	
	//echo $activityScore . "   ";
}


if (strpos($activty,'unlock') !== false) {
	//echo "unlock";
	mysql_query("INSERT INTO badges (name, campaign_id, user_id, image_path)
 VALUES('Unlock image badge','".$json_array['campaign_id']."', '".$json_array['user_id']."', '".$json_array['image']."') ") or die(mysql_error());  
}

mysql_query("INSERT INTO activity (id, name, user_id)
 VALUES('".$json_array['id']."', '".$activty."', '".$json_array['user_id']."') ") or die(mysql_error());  

$activityId = mysql_insert_id();


mysql_query("INSERT INTO user_campaign_score (id, user_id, campaign_id, activity_id, score)
 VALUES('".$json_array['id']."', '".$json_array['user_id']."', '".$json_array['campaign_id']."', '".$activityId."', '".$activityScore."') ") or die(mysql_error());  

	echo "Saved successfully";




}else{
	echo "No JSON given.";
}


?>