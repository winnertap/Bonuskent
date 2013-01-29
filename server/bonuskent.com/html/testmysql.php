<?php 
$link = mysql_connect('internal-db.s144678.gridserver.com','db144678_jhon','awakeN0130@MT'); 
if (!$link) { 
	die('Could not connect to MySQL: ' . mysql_error()); 
} 
echo 'Connection OK'; mysql_close($link); 
?> 