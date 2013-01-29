<?php
session_start();

if(!isset($_SESSION['userName'])){
	header('Location:index.php');	
}

include('db.php');

$compaignId = $_SESSION['compaignId'];
$userId = $_SESSION['userId'];

//echo $compaignId ." compaignId ";
//echo $userId ." userId ";	
		
if(isset($_SESSION['scoresId'])){
		$scoresId = $_SESSION['scoresId'];
		//echo "scoresId = " . $scoresId;
	}else{
		//echo "scores not set.";
		$currentDate = date("Y/m/d");
		mysql_query("INSERT INTO scores (user_id, campaign_id, date_created) VALUES ($userId, $compaignId,  '$currentDate')") or die ("Error in query: $query. ".mysql_error());
		
		$scoresId = mysql_insert_id();
		//echo "scoresIdw = " . $scoresId;
		$_SESSION['scoresId'] = $scoresId;
	}

?>

<!DOCTYPE html>
<html class="no-js" lang="en">
<head>
<meta charset="utf-8">
<title>.: BonusKent - Admin :.</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="css/images/favicon.ico">
<!-- Le styles -->
<link href="js/plugins/chosen/chosen/chosen.css" rel="stylesheet">
<link href="css/twitter/bootstrap.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<link href="css/twitter/responsive.css" rel="stylesheet">
<link href="css/jquery-ui-1.8.23.custom.css" rel="stylesheet">

<script src="js/plugins/modernizr.custom.32549.js"></script>
<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
      <![endif]-->
</head>
<body>
<div id="loading">
  <img src="img/ajax-loader.gif">
</div>
<div id="responsive_part">
    <div class="logo">
      <a href="index.html"></a>
    </div>
    <ul class="nav responsive">
      <li>
      <btn class="btn btn-la1rge btn-i1nfo responsive_menu icon_item" data-toggle="collapse" data-target="#sidebar">
       <i class="icon-reorder"></i>
      </btn>
      </li>
    </ul>
</div> <!-- Responsive part -->


<div id="sidebar" class="collapse">
   <div class="logo">
    <a href="index.html"></a>
  </div>
  <ul id="sidebar_menu" class="navbar nav nav-list sidebar_box">
    <li>
    <a class="dashboard" href="dashboard.php"><img src="img/menu_icons/dashboard.png">Dashboard</a>
    </li>

    <li class="accordion-group active">
    <a class="accordion-group active" href="create_compaign.php">
    <img src="img/menu_icons/calendar.png">Create Campaign</a>
    </li>
    
    <li>
    <a class="widgets"data-parent="#sidebar_menu" href="manage_users.php">
    <img src="img/menu_icons/maps.png">Manage Users</a>
    </li>

    <li>
    <a class="widgets"data-parent="#sidebar_menu" href="manage_compaign.php">
    <img src="img/menu_icons/maps.png">Manage Campaign</a>
    </li>

    <li>
    <a class="widgets"data-parent="#sidebar_menu" href="logout.php">
    <img src="img/menu_icons/maps.png">Logout</a>
    </li>

    
  </ul>
  <!-- End sidebar_box -->
  <div class="sidebar_box statistics visible-desktop">
    <div class="container">

      <div class="title row-fluid fluid">
        <i class="gicon-refresh"></i> Real time stats
      </div>
      <div class="row-fluid fluid">
        <div class="span6 pagination-centered">
          <div class="row-fluid">
            <div id="g1" class="gauge">
            </div>
          </div>
        </div>
        <div class="span6 pagination-centered">
          <div class="row-fluid fluid">
            <div id="g2" class="gauge">
            </div>
          </div>
        </div>
        <!-- End row-fluid -->
        <div class="row-fluid fluid">
          <div id="real-time-sidebar" style="width:100%;height:65px;">
          </div>
        </div>
        <div class="row-fluid fluid pagination-centered">
           Page views <i class="icon-question-sign muted inline" rel="tooltip" data-placement="right" data-original-title="As an interesting side note, as a head without a body, I envy the dead. There's one way and only one way to determine if an animal is intelligent."></i>
        </div>
      </div>
      <!-- End .title -->
    </div>
  </div>
  <!-- End sidebar_box -->
</div>
<div id="main">
  <div class="container">
    <div id="container2">
      
        <ul class="nav nav-tabs" id="tabExample1">
            <li class=""><a href="create_compaign.php">Description</a></li>
            <li class=""><a href="compaign_location.php">Location</a></li>
            <li class=""><a href="compaign_marker.php">Marker</a></li>
            <li class="active"><a href="compaign_congrats.php">Congrats</a></li>
            <li class=""><a href="compaign_rewards.php">Rewards</a></li>
         </ul>
		      
      <!---->
		<div class="page-content">
        
         <div class="box gradient">
          <div class="title">
            <h3>
            <i class="icon-book"></i><span>Campaign Congrats</span>
            </h3>
          </div>
          <div class="content">
                  
<?php

	$result = mysql_query("SELECT * FROM scores WHERE id = ". $scoresId ."");
	
	while($row = mysql_fetch_array($result)){
		  $congrats_text = $row['congrats_text'];
		  $unlock_image_score = $row['unlock_image_score'];
		  $share_facebook_score = $row['share_facebook_score'];
		  $each_vote_score = $row['vote_score'];



  echo"
  
       <form id='saveCongratsForm' name='saveCongratsForm' enctype='multipart/form-data' method='post' action='saveCongratsForm.php'>
      	
        <table width='600' cellspacing='5' cellpadding='5'>
          <tr>
		  		<td>Congrats Text</td>
      			<td><textarea rows='5' cols='35' name='condrats_text'>$congrats_text</textarea></td>
        
          <tr>
            <td>Unlocking image/badge</td>
            <td><input type='text' value='$unlock_image_score' name='unlocking_image_score' id='unlocking_image_score'> 
            	<span onClick='increment(\"unlocking_image_score\")' style='font-size:25px; cursor:pointer'> + </span>
                <span onClick='deccrement(\"unlocking_image_score\")' style='font-size:25px; cursor:pointer'> - </span></td>
          </tr>
          <tr>
            <td>Share on facebook</td>
            <td><input type='text' value='$share_facebook_score' name='share_on_facebook_score' id='share_on_facebook_score'>
            	<span onClick='increment(\"share_on_facebook_score\")' style='font-size:25px; cursor:pointer'> + </span>
                <span onClick='deccrement(\"share_on_facebook_score\")' style='font-size:25px; cursor:pointer'> - </span></td>
          </tr>
          <tr>
            <td>Each vote</td>
            <td><input type='text' value='$each_vote_score' name='each_vote_score' id='each_vote_score'>
            	<span onClick='increment(\"each_vote_score\")' style='font-size:25px; cursor:pointer'> + </span>
                <span onClick='deccrement(\"each_vote_score\")' style='font-size:25px; cursor:pointer'> - </span></td>
          </tr>
        </table>";
	}
?>      	
        <br class="clear">
        
        <button data-original-title="save" onclick="compaignLocationFormSubmit()" data-placement="top" rel="tooltip" class="btn btn-success btn-large">Save and Go to Next Step</button>

	</div> <!-- end of class='content' -->
       
	    </div></div>
        
		</div>
      <!---->
      
      </div></div>
      <!-- End #container -->
    </div>
    <div id="footer">
      <p>
        &copy; Bird Admin Template 2012
      </p>
      <span class="company_logo"><a href="http://www.pixelgrade.com"></a></span>
    </div>
  </div>
</div>
<!-- /container -->
<!-- Le javascript
    ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="js/jquery.js"></script>
<script language="javascript" type="text/javascript" src="js/plugins/jquery.sparkline.min.js"></script>
<script src="js/plugins/excanvas.compiled.js"></script>
<script src="js/bootstrap-transition.js"></script>
<script src="js/bootstrap-alert.js"></script>
<script src="js/bootstrap-modal.js"></script>
<script src="js/bootstrap-dropdown.js"></script>
<script src="js/bootstrap-scrollspy.js"></script>
<script src="js/bootstrap-tab.js"></script>
<script src="js/bootstrap-tooltip.js"></script>
<script src="js/bootstrap-popover.js"></script>
<script src="js/bootstrap-button.js"></script>
<script src="js/bootstrap-collapse.js"></script>
<script src="js/bootstrap-carousel.js"></script>
<script src="js/bootstrap-typeahead.js"></script>
<script src="js/fileinput.jquery.js"></script>
<script src="js/jquery-ui-1.8.23.custom.min.js"></script>
<script src="js/jquery.touchdown.js"></script>
<script language="javascript" type="text/javascript" src="js/plugins/full-calendar/fullcalendar.min.js"></script>
<script language="javascript" type="text/javascript" src="js/plugins/flot/jquery.flot.js"></script>
<script language="javascript" type="text/javascript" src="js/plugins/flot/jquery.flot.stack.js"></script>
<script language="javascript" type="text/javascript" src="js/plugins/flot/jquery.flot.pie.js"></script>
<script language="javascript" type="text/javascript" src="js/plugins/flot/jquery.flot.resize.js"></script>
<script language="javascript" type="text/javascript" src="js/plugins/jquery.uniform.min.js"></script>
<script language="javascript" type="text/javascript" src="js/plugins/jquery.peity.min.js"></script>
<script type="text/javascript" language="javascript" src="js/plugins/datatables/js/jquery.dataTables.js"></script>
<script language="javascript" type="text/javascript" src="js/plugins/chosen/chosen/chosen.jquery.min.js"></script>
<script src="js/plugins/justGage.1.0.1/resources/js/raphael.2.1.0.min.js"></script>
<script src="js/plugins/justGage.1.0.1/resources/js/justgage.1.0.1.min.js"></script>
<script src="js/plugins/responsive-tables.js"></script>
<script src="js/scripts.js"></script>

<script type="text/javascript" src="scripts/jquery.min.js"></script>
<script type="text/javascript" src="scripts/jquery.form.js"></script>
<script type="text/javascript" src="scripts/common.js"></script>

<script type="text/javascript" charset="utf-8">
    // Datatables
    $(document).ready(function() {
     
	});
    </script>
<script type='text/javascript'>
    $(window).load(function() {
     $('#loading').fadeOut();
    });
      $(document).ready(function() {
      $('body').css('display', 'none');
      $('body').fadeIn(500);
      $("#logo a, #sidebar_menu a:not(.accordion-toggle), a.ajx").click(function() {
      event.preventDefault();
      newLocation = this.href;
      $('body').fadeOut(500, newpage);
      });
      function newpage() {
      window.location = newLocation;
      }
              
     });
    </script>


</body>
</html>