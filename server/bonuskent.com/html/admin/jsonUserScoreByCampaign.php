<?php 

	include("db.php");
	
	if(isset($_REQUEST['campaignId'])){
		$campaignId = $_REQUEST['campaignId'];

		$result1 = mysql_query("SELECT user_id, SUM( score ) AS score FROM user_campaign_score WHERE campaign_id = '" . $campaignId ."' GROUP BY score DESC limit 3");
		
		$rows = array();
		
		while($row = mysql_fetch_assoc($result1)){
			$rows[] = $row;
		}
		print json_encode($rows);
		
		
	}else{
		echo "user id not found";
	}
	
?>