<?php

include('db.php');

if(isset($_REQUEST['jsonGiven'])){
	$jsonString = $_REQUEST['jsonGiven'];
}else{
	echo "No JSON given.";
}

//$jsonString = '{"id":null,"unlock_image_score":42,"share_facebook_score":322,"each_vote_score":32,"user_id":2}';



/* use json_decode to create an array from json */
$json_array = json_decode($jsonString, true);

mysql_query("INSERT INTO user_activity (id, unlock_image_score, share_facebook_score, each_vote_score, user_id)
 VALUES('".$json_array['id']."', '".$json_array['unlock_image_score']."', '".$json_array['share_facebook_score']."', '".$json_array['each_vote_score']."', '".$json_array['user_id']."') ") or die(mysql_error());  

$echoId = mysql_insert_id();

echo $echoId;

?>