<?php
include('db.php');
session_start();
$session_id='1'; //$session id

$reward_name = $_POST['reward_name'];
$reward_text = $_POST['reward_text'];

mysql_query("UPDATE reward SET reward_name='$reward_name', reward_text='$reward_text' WHERE id=".$_SESSION['rewardId']." ");

header( 'Location: manage_compaign.php' ) ;

?>