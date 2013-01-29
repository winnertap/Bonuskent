<?php
include('db.php');
session_start();
$session_id='1'; //$session id


$condrats_text = $_POST['condrats_text'];
$unlocking_image_score = $_POST['unlocking_image_score'];
$share_on_facebook_score = $_POST['share_on_facebook_score'];
$each_vote_score = $_POST['each_vote_score'];

mysql_query("UPDATE scores SET congrats_text='$condrats_text', unlock_image_score ='$unlocking_image_score' ,share_facebook_score ='$share_on_facebook_score' ,vote_score ='$each_vote_score' WHERE campaign_id=".$_SESSION['compaignId']." AND user_id=".$_SESSION['userId']." ");

header( 'Location: compaign_rewards.php' ) ;

?>