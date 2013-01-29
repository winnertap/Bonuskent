<?php
	include('db.php');

	if(isset($_POST) and $_SERVER['REQUEST_METHOD'] == "POST")
		{
			$userIdToDelete = $_POST['userIdToDelete'];
			mysql_query("DELETE FROM user WHERE id = ".$userIdToDelete." ");
			//echo "Compaign deleted successfully.";
		}else{
			//echo "An error occured while deleting campaign.";	
		}
	
	header('Location: manage_users.php');
	//mysql_close($con);								
?>