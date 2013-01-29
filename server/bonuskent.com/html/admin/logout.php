<?php
session_start();

if(isset($_SESSION['userName']))
  unset($_SESSION['userName']);
  
header('Location:index.php');	
?>
