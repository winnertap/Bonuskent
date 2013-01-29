<?php 

	include("db.php");
	
	if(isset($_REQUEST['userId'])){
		$userId = $_REQUEST['userId'];

		$result1 = mysql_query("SELECT campaign_id, SUM(score) AS score from user_campaign_score where user_id = '".$userId."' group by campaign_id");
		
		$rows = array();
		
		while($row = mysql_fetch_assoc($result1)){
			$rows[] = $row;
		}
		print json_encode($rows);
		
		
	}else{
		echo "user id not found";
	}
	
?>