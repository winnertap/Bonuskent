<?php 

	include("db.php");
	
	if(isset($_REQUEST['fIdsList'])){
		$jsonString = $_REQUEST['fIdsList'];
		
		//$jsonString = '{"fIdsList":"test11,test112,1r1fw1"}';
		
		$jsonString = stripslashes($jsonString);
		$json_array = json_decode($jsonString, true);
				
		//print_r($json_array);		
				
		$fIdsListArray = $json_array['fIdsList'];		
		$myArray = explode(',', $fIdsListArray);
		
		$userIds = array();
		$fIdsListArray2 = array();
		
		$counter = 0;
		
		for ($i=0; $i<sizeof($myArray); $i++) {
			$result = mysql_query("SELECT id FROM user WHERE f_id = '".$myArray[$i]."'") or die(mysql_error());
			//echo "  " . $i . " <br> ";
			while($row = mysql_fetch_assoc($result)){
				
				$userIds[$counter] = $row['id'];
				$fIdsListArray2[$counter] = $myArray[$i];
				//echo $fIdsListArray2[$counter];
				$counter++;
			}
		}
		
		$counter = 0;
		//print_r($userIds);
		
		for ($j=0; $j<sizeof($userIds); $j++) {
			
			//echo $userIds[$j];
			$result1 = mysql_query("SELECT SUM(score) AS score FROM `user_campaign_score` WHERE user_id = '".$userIds[$counter]."'") or die(mysql_error());
			
			//echo "  " . $j . " <br> ";
			while($row = mysql_fetch_assoc($result1)){
				
				$scoreArray[$counter] = $row['score'];
			}
			$counter++;
		}
		
		$counter = 0;
		$json = array();
		$data = array();
		
		for ($k=0; $k<sizeof($fIdsListArray2); $k++) {
			//echo "  " . $k . " <br> ";
			$json['f_id'] = $fIdsListArray2[$k];
			$json['score'] = $scoreArray[$k];
			$data[] = $json;
		}
		
		$resJson = json_encode( $data );
		echo $resJson;
		
	}else{
		echo "fIdsList not found";
	}
	
?>