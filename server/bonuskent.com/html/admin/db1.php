<?php
$mysql_hostname = "internal-db.s144678.gridserver.com";
$mysql_user = "db144678_jhon";
$mysql_password = "awakeN0130@MT";
$mysql_database = "db144678_bonuskentdb";
$prefix = "";
$bd = mysql_connect($mysql_hostname, $mysql_user, $mysql_password) or die("Opps some thing went wrong");
mysql_select_db($mysql_database, $bd) or die("Opps some thing went wrong");

?>