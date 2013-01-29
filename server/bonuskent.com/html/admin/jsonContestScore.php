<?php 

	include("db.php");
	
	if(isset($_REQUEST['userId']) && isset($_REQUEST['campaignId'])){
		$userId = $_REQUEST['userId'];
		$campaignId = $_REQUEST['campaignId'];

		$result = mysql_query("SELECT campaign_id, SUM( score ) AS score
		FROM user_campaign_score
		WHERE user_id = $userId AND campaign_id = $campaignId
		GROUP BY campaign_id");
		
		$rows = array();
		$rewardArray = array();

		while($row = mysql_fetch_assoc($result)){
			//print_r($row);
			$rows[] = $row;	
			
			$result2 = mysql_query("SELECT * FROM reward WHERE campaign_id = '".$row['campaign_id']."' GROUP BY campaign_id");
		
			$rows = array();
			while($row = mysql_fetch_assoc($result2)){
				//print_r($row);
				$rewardArray[] = $row;	
				
			}		
		}
	
		$result22 = array_merge($rows, $rewardArray);

		//print_r($result22);
		print json_encode($result22);
		
		
	}else if(isset($_REQUEST['userId'])){
		$userId = $_REQUEST['userId'];
		
		$result = mysql_query("SELECT campaign_id, name, SUM( score ) AS scores,marker_image_path,marker_ar_image_path
  FROM user_campaign_score
inner join compaign on campaign_id = compaign.id
  WHERE user_id = $userId
  GROUP BY campaign_id");
		
		$rows = array();
		$rewardArray = array();

		while($row = mysql_fetch_assoc($result)){
			//print_r($row);
			$rows[] = $row;	
			
/*			$result2 = mysql_query("SELECT * FROM reward WHERE campaign_id = '".$row['campaign_id']."' GROUP BY campaign_id");
		
			$rows = array();
			while($row = mysql_fetch_assoc($result2)){
				//print_r($row);
				$rewardArray[] = $row;	
				
			}	*/	
		}
	
		//$result22 = array_merge($rows, $rewardArray);

		print json_encode($rows);
		//print json_encode($result22);
		
	}else{
		echo "user id not found";
	}
	
	//$userId = 4;
	
/*		$result1 = mysql_query("SELECT SUM( score ) AS score, user_id
FROM user_campaign_score
GROUP BY user_id
ORDER BY score DESC");
		
		$count = 0;
		while($row = mysql_fetch_assoc($result1)){
			//print_r($row);
			$count++;
			
			echo " <br> " . $row['user_id'];
			if($userId == $row['user_id']){
				echo "counter = " . $count;	
			}
		}*/
	
	
	

?>