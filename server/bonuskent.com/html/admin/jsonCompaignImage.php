<?php 

	include("db.php");
	
	if(isset($_REQUEST['userId'])){
		$userId = $_REQUEST['userId'];
		
		if(isset($campaignId)){
			$result = mysql_query("SELECT image_path FROM compaign where id='".$campaignId."'");
		
			$rows = array();
			
			while($row = mysql_fetch_assoc($result)){
				
				
				$rows[] = $row;
			}
			print json_encode($rows);
		}		
		
	}else{
		echo "No userId given.";	
	}


?>