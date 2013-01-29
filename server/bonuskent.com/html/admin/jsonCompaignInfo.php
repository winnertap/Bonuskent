<?php 

	include("db.php");
	
	$result = mysql_query("SELECT * FROM compaign where status='published' OR status='active'");

$rows = array();

while($row = mysql_fetch_assoc($result)){
	
	
	$rows[] = $row;
}
print json_encode($rows);

?>