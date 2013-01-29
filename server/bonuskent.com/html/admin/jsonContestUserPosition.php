<?php 

	include("db.php");
	
	if(isset($_REQUEST['userId']) && isset($_REQUEST['campaignId'])){
		$userId = $_REQUEST['userId'];
		$campaignId = $_REQUEST['campaignId'];

		$result1 = mysql_query("SELECT SUM( score ) AS score, user_id, campaign_id
		FROM user_campaign_score
		GROUP BY user_id
		HAVING campaign_id = $campaignId
		ORDER BY score DESC") or die(mysql_error());
		
		$count = 0;
		while($row = mysql_fetch_assoc($result1)){
			$count++;
			
			if($userId == $row['user_id']){
				echo "Total: You have ".$row['score']." points on " . $count . " position.";	
			}
		}

	}else if(isset($_REQUEST['userId'])){
		$userId = $_REQUEST['userId'];

		$result1 = mysql_query("SELECT SUM( score ) AS score, user_id
		FROM user_campaign_score
		GROUP BY user_id
		ORDER BY score DESC");
		
		$count = 0;
		while($row = mysql_fetch_assoc($result1)){
			$count++;
			
			if($userId == $row['user_id']){
				echo "Total: You have ".$row['score']." points on " . $count . " position.";	
			}
		}

	}else{
		echo "user id not found";
	}

?>