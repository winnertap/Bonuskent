<?php 

	include("db.php");
	
	if(isset($_REQUEST['userId'])){
		$userId = $_REQUEST['userId'];
		
		$result1 = mysql_query("SELECT SUM(score) AS score FROM `user_campaign_score` WHERE user_id = '".$userId."'");
		
		$score = 0;
		
		while($row = mysql_fetch_assoc($result1)){
			$score = $row['score'];
		}
		
		if($score == ""){
			echo "0";
		}
		
		echo $score;
		
	}else{
		echo "user id not found";
	}
	
?>