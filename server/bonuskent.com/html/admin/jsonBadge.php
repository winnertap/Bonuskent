<?php

include('db.php');

if(isset($_REQUEST['userId'])){
	$userid = $_REQUEST['userId'];
	
	$rows = array();
	$result = mysql_query("SELECT * FROM badges where user_id = '$userid' ") or die(mysql_error());
	
	while($row = mysql_fetch_assoc($result)){
		$rows[] = $row;
	}
	
	print json_encode($rows);
}else{
	echo "No JSON given.";
}


?>