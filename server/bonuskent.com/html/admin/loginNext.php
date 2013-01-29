<?php 
session_start();

include('db.php');
		
		$userName=addslashes($_POST['userName']);
		$password=addslashes($_POST['password']);
				
		$result = mysql_query("SELECT * FROM user WHERE username='".$userName."'");
		
		while($row = mysql_fetch_array($result))
		  {
			if($userName == $row['username'] && $password == $row['password']){
				$_SESSION['userName']=$userName;
				$_SESSION['userId']=$row['id'];

				header('Location:dashboard.php');	
			}else{
				//header('Location:login.php');
				//echo "wrong User Name or Password.";
			}
		  }
		mysql_close($bd);
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html class="js hashchange history draganddrop rgba multiplebgs borderradius boxshadow opacity cssanimations cssgradients csstransitions fontface localstorage sessionstorage applicationcache mti-repaint mti-repaint mti-repaint" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" dir="ltr" lang="en">
<head>
	
	<title>.: Bonus Kent :.</title>

    <script language="JavaScript">
		function move() {
			window.location = 'index.php';
		}
	</script>
	
</head>
  <body onload="timer=setTimeout('move()',1000)">
             
    <div id="header" style="height:130px">
  <div class="wrapper">


    <div id="quick_login" class="">

    </div>
 
  </div>

<div style="clear:both"></div>

</div>

<p style="padding:20px; text-align:center">Wrong User Name or Password. Redirecting to <strong>login page</strong>.</p>

</body>
</html>