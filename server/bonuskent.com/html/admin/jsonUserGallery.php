<?php 

	include("db.php");
	
	if(isset($_REQUEST['userId'])){
		$userId = $_REQUEST['userId'];
		
		$result1 = mysql_query("SELECT imagepath FROM gallery WHERE user_id = '".$userId."'");
		
		$rows = array();
		
		while($row = mysql_fetch_assoc($result1)){
			$rows[] = $row;
		}
		
		print json_encode($rows);
		
	}else{
		echo "user id not found";
	}
	
?>