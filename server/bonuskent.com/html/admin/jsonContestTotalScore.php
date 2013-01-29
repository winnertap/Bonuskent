<?php 

	include("db.php");
	
	if(isset($_REQUEST['userId']) && isset($_REQUEST['campaignId'])){
		$userId = $_REQUEST['userId'];
		$campaignId = $_REQUEST['campaignId'];
		$rows = array();
		$userArray = array();

		$result1 = mysql_query("SELECT SUM( score ) AS scores, user_id, campaign_id, user.username
		  FROM user_campaign_score
			inner join user on user.id =  user_id
		  GROUP BY user_id
		  HAVING campaign_id = $campaignId
		  ORDER BY scores DESC
		  LIMIT 0 , 5");
		
		while($row = mysql_fetch_assoc($result1)){
				$rows[] = $row;	
			}
		
		print json_encode($rows);

	}else
	if(isset($_REQUEST['userId'])){
		$userId = $_REQUEST['userId'];
		$rows = array();
		$userArray = array();

		$result1 = mysql_query("
			SELECT SUM( score ) AS scores, user_id, user.username
		  FROM user_campaign_score
			inner join user on user.id =  user_id
		  GROUP BY user_id
		  ORDER BY scores DESC
		  LIMIT 0 , 5");
		
		while($row = mysql_fetch_assoc($result1)){
				$rows[] = $row;	
			}
		
		print json_encode($rows);

	}else{
		echo "user id not found";
	}

?>