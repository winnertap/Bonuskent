<?php 

	include("db.php");
	
	
	if(isset($_REQUEST['userId']) && isset($_REQUEST['compaignId']) && isset($_REQUEST['activityId'])){
		$userId = $_REQUEST['userId'];
		$compaignId = $_REQUEST['compaignId'];
		$activity = $_REQUEST['activityId'];
	}else{
		echo "No parameter given.";
	}
	

	if(isset($userId)){
		
		$result = mysql_query("SELECT * FROM user_activity where user_id='".$userrId."'");
	
		$rows = array();
		
		while($row = mysql_fetch_assoc($result)){

			$rows[] = $row;
		}
		print json_encode($rows);
	}
?>