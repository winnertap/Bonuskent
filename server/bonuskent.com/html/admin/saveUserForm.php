<?php
include('db.php');
session_start();

$userId = $_POST['userId'];

$username = $_POST['username'];
$password = $_POST['password'];
$firstname = $_POST['firstname'];
$lastname = $_POST['lastname'];
$email = $_POST['email'];
$role = $_POST['role'];
$date_created = $_POST['date_created'];
$date_updated = $_POST['date_updated'];
$gender = $_POST['gender'];
$date_of_birth = $_POST['date_of_birth'];
$education = $_POST['education'];
$city = $_POST['city'];
$network = $_POST['network'];
$status = $_POST['status'];
$poi = $_POST['poi'];
$f_id = $_POST['f_id'];

$currentDate = date("Y/m/d");

mysql_query("UPDATE user SET username='$username',password='$password', firstname='$firstname', lastname='$lastname', email='$email', 
role='$role', date_created='$date_created', date_updated='$currentDate', gender='$gender', date_of_birth='$date_of_birth', education='$education', 
city='$city', network='$network', status='$status', poi='$poi', f_id='$f_id'  WHERE id='$userId' ") or die(mysql_error());

header( 'Location: manage_users.php' );


?>