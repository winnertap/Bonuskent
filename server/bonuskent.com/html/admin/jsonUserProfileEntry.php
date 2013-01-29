<?php

include('db.php');

if(isset($_REQUEST['userProfileJson'])){
	$jsonString = $_REQUEST['userProfileJson'];

/*$jsonString = '{"id":null,"username":"Jack","firstname":"Jackson","lastname":"Tom","email":"tom@gmail.com","password":"1234psw","role":"enduser"
				,"date_created":"","date_updated":"","gender":"male","date_of_birth":"","education":"Masters","city":"Italy","network":"Facebook"
				,"status":"active","f_id":"test1145as"}';*/

$jsonString = stripslashes($jsonString);

/* use json_decode to create an array from json */
$json_array = json_decode($jsonString, true);

$facebook_id = $json_array['f_id'];
$userF_id = "";
$currentDate = date("Y/m/d");

$result = mysql_query("SELECT * FROM user where f_id = '$facebook_id' ") or die(mysql_error());

while($row = mysql_fetch_assoc($result)){
	
	$userF_id = $row['f_id'];
	$user_id = $row['id'];
}

	if($userF_id == $facebook_id){
		echo $user_id;	
	}else{
		mysql_query("INSERT INTO user (username, firstname, lastname, email, password, role, date_created, date_updated, gender, date_of_birth , education
		, city, network, status, f_id)
		 VALUES('".$json_array['username']."', '".$json_array['firstname']."', '".$json_array['lastname']."'
			, '".$json_array['email']."', '".$json_array['password']."', '".$json_array['role']."', '".$currentDate."'
			, '".$json_array['date_updated']."', '".$json_array['gender']."', '".$json_array['date_of_birth']."', '".$json_array['education']."'
			, '".$json_array['city']."', '".$json_array['network']."', '".$json_array['status']."', '".$json_array['f_id']."'
			) ") or die(mysql_error());  
	
		$userId = mysql_insert_id();	
		echo $userId;
	}
}else{
	echo "No JSON given.";
}


?>