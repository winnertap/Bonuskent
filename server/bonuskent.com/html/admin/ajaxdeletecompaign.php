<?php
	include('db.php');

	if(isset($_POST) and $_SERVER['REQUEST_METHOD'] == "POST")
		{
			$compaignIdToDelete = $_POST['compaignIdToDelete'];
			mysql_query("DELETE FROM compaign WHERE id = ".$compaignIdToDelete." ");
			//echo "Compaign deleted successfully.";
		}else{
			//echo "An error occured while deleting campaign.";	
		}
	
	header('Location: manage_compaign.php');
	//mysql_close($con);								
?>