<?php
	include('db.php');

	if(isset($_POST) and $_SERVER['REQUEST_METHOD'] == "POST")
		{
			$compaignid = $_POST['compaignid'];
			mysql_query("UPDATE compaign SET status='unpublished' WHERE id = ".$compaignid." ");

			echo "unpublished";
		}
	
?>