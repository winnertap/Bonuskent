<?php

session_start();

if(!isset($_SESSION['userName'])){
	header('Location:index.php');	
}

if(isset($_SESSION['compaignId'])){
  unset($_SESSION['compaignId']);
 unset($_SESSION['rewardId']); 
  unset($_SESSION['scoresId']); 
}

include('db.php');
  
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
<!--<div id="loading">
  <img src="img/ajax-loader.gif">
</div>-->
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

    <li>
    <a class="widgets" href="create_compaign.php">
    <img src="img/menu_icons/calendar.png">Create Campaign</a>
    </li>
    
    <li>
    <a class="widgets"data-parent="#sidebar_menu" href="manage_users.php">
    <img src="img/menu_icons/maps.png">Manage Users</a>
    </li>

    <li class="accordion-group active">
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
  
    <div class="container_top">
      <div class="row-fluid ">
        <div class="top_bar_stats to_hide_tablet">
          <div class="stats">
            <span class="title">Sales:</span> +19,77% <span class="bar_1"></span>
          </div>
          <div class="stats">
            <span class="title">Visits:</span> +23,34% <span class="bar_2"></span>
          </div>
          <div class="stats">
            <span class="title">New Users:</span> +2,84% <span class="bar_3"></span>
          </div>
        </div>
        
   <div class="top_right">
     <ul class="nav search">
      <li>
        <form class="form-search">
            <div class="input-append">
              <input type="text" class=" search-query" placeholder="Search..">
            </div>
        </form>
      </li>
    </ul>
    <ul class="nav nav_menu">
    
      <li class="dropdown">
      <a class="dropdown-toggle administrator" id="dLabel" role="button" data-toggle="dropdown" data-target="#" href="/page.html">
      <span class="icon"><img src="img/menu_top/profile-avatar.png"></span><span class="title">Administrator</span></a>
      <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
        <li><a href="#"><i class=" icon-user"></i> My Profile</a></li>
        <li><a href="#"><i class=" icon-cog"></i>Settings</a></li>
        <li><a href="#"><i class=" icon-unlock"></i>Log Out</a></li>
        <li><a href="#"><i class=" icon-flag"></i>Help</a></li>
      </ul>
      </li>
      <li class="dropdown">
      <a id="dLabel" role="button" data-toggle="dropdown" data-target="#" href="/page.html">
      <span class="icon"><img src="img/menu_top/profile-messages.png"></span><span class="notifications">3</span>
      </a>
      <ul class="dropdown-menu messages" aria-labelledby="dLabel">
        <div class="container">
          <div class="heading">
            <span class="title"><i class="icon-comments"></i>Messages</span><span class="link"><a href="#">Send a new message</a></span>
          </div>
          <ul>
            <li>
            <a href="#">
            <div class="avatar">
              <img src="img/message_avatar1.png"/>
            </div>
            <div class="container">
              <span class="name">John Smith</span>
              <span class="message"><i class="icon-share-alt"></i>The first thing I remember.. <br/></span>
              <span class="date">Aug 8</span>
            </div>
            </a>
            </li>
            <li>
            <a href="#">
            <div class="avatar">
              <img src="img/message_avatar2.png"/>
            </div>
            <div class="container">
              <span class="name">Celeste Holm</span>
              <span class="message"><i class="icon-share-alt"></i>What have you learned from.. <br/></span>
              <span class="date">Aug 6</span>
            </div>
            </a>
            </li>
            <li>
            <a href="#">
            <div class="avatar">
              <img src="img/message_avatar3.png"/>
            </div>
            <div class="container">
              <span class="name">Mark Jobs</span>
              <span class="message"><i class="icon-share-alt"></i>Start it and stick with it.. <br/></span>
              <span class="date">Jul 27</span>
            </div>
            </a>
            </li>
          </ul>
          <div class="footer">
            <a class="see_all">See All Messages <i class="icon-chevron-right"></i></a>
          </div>
        </div>
      </ul>
      </li>
    </ul>
  </div> <!-- End top-right -->

        <div class="span4">
         
        </div>
      </div>
    </div>
    <!-- End container_top -->  
  
    <div id="container2">
      
      <div class="row-fluid">
        <div class="box gradient">
          <div class="title">
            <h3>
            <i class=" icon-bar-chart"></i><span>Campaign table</span>
            </h3>
          </div>
          <!-- End .title -->
          <div class="content top">
            <table id="datatable_example" class="table table-striped full table-bordered">
            <thead>

            <tr>
           
              <th class="to_hide_phone ue">
                Comapign Id
              </th>              
              <th class="to_hide_phone">
                Compaign Name
              </th>

              <th class="">
                Start Date
              </th>
              <th class="to_hide_phone ue">
                End Date
              </th>
              <th class="to_hide_phone ue">
                Status
              </th>
             
              <th class="ms no_sort ">
                Actions
              </th>
            </tr>

            </thead>
            <tbody>

<?php
	$result = mysql_query("SELECT * FROM compaign");
	
	while($row = mysql_fetch_array($result)){
		  
		  echo "

            <tr>
			 <td class='to_hide_phone'>
                " . $row['id'] . "
              </td>
              <td class='to_hide_phone'>
				" . $row['name'] . "
              </td>
              <td>
                " . $row['start_date'] . "
              </td>
              <td class='to_hide_phone'>
                " . $row['end_date'] . "
              </td>
              <td id='compaignStatus_".$row['id']."'>
                " . $row['status'] . "
              </td>
              
              <td class='ms'>
                <div class='btn-group1'>
                  <a class='btn btn-small' rel='tooltip' data-placement='left' data-original-title=' edit ' onClick='editCompaign(\"create_compaign.php?compaignid=" . $row['id'] . "\") ;' ><i class='gicon-edit'></i></a>
                  <a class='btn btn-small' rel='tooltip' data-placement='left' data-original-title=' publish ' onClick='publishCompaign(\"compaignStatus_".$row['id']." \",".$row['id'].")'><i class='gicon-globe'></i></a>
                  <a class='btn btn-small' rel='tooltip' data-placement='top' data-original-title='unpublish' onClick='unPublishCompaign(\"compaignStatus_".$row['id']." \",".$row['id'].")'><i class='gicon-eye-open'></i></a>
                  <a class='btn btn-inverse btn-small' rel='tooltip' data-placement='bottom' data-original-title='Remove' data-toggle='modal' href='#myModal' onClick='return setDeleteCompaign(".$row['id'].") ;' >
				  	<i class='gicon-remove icon-white'></i>
				</a>
                </div>
              </td>
            </tr>";
	  }
?>
    
            </tbody>
            </table>
        
              <!-- End row-fluid -->
            </div>

          <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<form id='deleteCompaignForm' name="deleteCompaignForm" method='post' action='ajaxdeletecompaign.php'>
            	<input type="hidden" name="compaignIdToDelete" id="compaignIdToDelete" value="">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                  <h3 id="myModalLabel">Confirmation Message</h3>
                </div>
                <div class="modal-body">
                    <br /><br />
                    <p>Are you sure you want to delete this campaign?</p>
                    <br /><br />
                </div>
                <div class="modal-footer">
                  <button class="btn" data-dismiss="modal">Close</button>
                  <button class="btn btn-primary" id="deleteCompaignButton">Delete</button>
                </div>
			</form>
          </div>

		<p id="deleteMessagePreview"></p>

            <!-- End .content -->
          </div>
          <!-- End box -->
        </div>
        <!-- End .row-fluid -->
      </div></div>
      <!-- End #container -->
    </div>
    <div id="footer">
      <p>
        &copy; BonusKent Admin Template 2012
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
<script src="scripts/common.js"></script>

<script type="text/javascript" charset="utf-8">
    // Datatables
    $(document).ready(function() {
       $("input[type=checkbox], input:radio, input:file").uniform();
      var dontSort = [];
                $('#datatable_example thead th').each( function () {
                    if ( $(this).hasClass( 'no_sort' )) {
                        dontSort.push( { "bSortable": false } );
                    } else {
                        dontSort.push( null );
                    }
      } );
      $('#datatable_example').dataTable( {
        // "sDom": "<'row-fluid table_top_bar'<'span12'>'<'to_hide_phone'>'f'<'>r>t<'row-fluid'>",
         "sDom": "<'row-fluid table_top_bar'<'span12'<'to_hide_phone' f>>>t<'row-fluid control-group full top' <'span4 to_hide_tablet'l><'span8 pagination'p>>",
         "aaSorting": [[ 1, "asc" ]],
        "bPaginate": true,

        "sPaginationType": "full_numbers",
        "bJQueryUI": false,
        "aoColumns": dontSort,

      } );
      $.extend( $.fn.dataTableExt.oStdClasses, {
        "s`": "dataTables_wrapper form-inline"
      } );
    } );
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
       
      // Chosen select plugin
        $(".chzn-select, .dataTables_length select").chosen({
                   disable_search_threshold: 10

        });
       
     });
    </script>
<script type="text/javascript">
    $(function () {
       $('a[rel=tooltip]').tooltip();
     if (Modernizr.canvas) {
      $(".bar").peity("bar", {
        colour: "#fff",
        width: 50,
        height: 17
      }).fadeIn();
      $(".line").peity("line").fadeIn();
    };
  });
</script>



<script type="text/javascript" src="scripts/jquery.form.js"></script>
<script type="text/javascript" src="scripts/common.js"></script>
</body>
</html>