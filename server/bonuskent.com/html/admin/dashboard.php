<?php
session_start();

if(!isset($_SESSION['userName'])){
	header('Location:index.php');	
}

include('db.php');

if(isset($_SESSION['compaignId']))
  unset($_SESSION['compaignId']);
  
?>

<!DOCTYPE html>
<html class="no-js" lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="Page-Enter" content="blendTrans(Duration=0.2)">
<meta http-equiv="Page-Exit" content="blendTrans(Duration=0.2)">
<title>.: BonusKent - Admin :.</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="css/images/favicon.ico">
<!-- Le styles -->
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

<!--    <div style="margin:0 0 20px 10px; width:100px;">
    	<img src="img/logo.png" alt="" />
    </div>
-->
<div id="sidebar" class="collapse">
   <div class="logo">
    <a href="index.html"></a>
  </div>
  <ul id="sidebar_menu" class="navbar nav nav-list sidebar_box">
    <li class="accordion-group active">
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

    <li class="widgets">
    <a class="widgets"data-parent="#sidebar_menu" href="manage_compaign.php">
    <img src="img/menu_icons/maps.png">Manage Campaign</a>
    </li>

    <li>
    <a class="widgets"data-parent="#sidebar_menu" href="logout.php">
    <img src="img/menu_icons/maps.png">Logout</a>
    </li>

    
  </ul>  <!-- End sidebar_box -->
  <div class="sidebar_box statistics visible-desktop">
    <div class="container">
      <div class="title">
        <i class="gicon-globe"></i> Estimated earnings
      </div>
      <div class="row-fluid fluid">
        <div class="span6 pagination-centered">
          <div class="row-fluid fluid">
            <i class="icon-caret-up green medium span3"></i>
            <span class="percent span3">7%</span>
            <span class="bar1 span6">3,4,10,5,3,6,3</span>
          </div>
          <div class="row-fluid fluid">
            <h2><strong>$11.37</strong></h2>
          </div>
          <div class="row-fluid fluid">
             Today so far
          </div>
        </div>
        <div class="span6 pagination-centered">
          <div class="row-fluid fluid">
            <i class="icon-caret-down red medium span3"></i>
            <span class="percent span3">2%</span>
            <span class="bar2 span6">1, 4, 6, 7,4, 2,4</span>
          </div>
          <div class="row-fluid fluid">
            <h2><strong>$22.84</strong></h2>
          </div>
          <div class="row-fluid fluid">
             Yesterday <i class="icon-question-sign muted inline" rel="tooltip" data-placement="right" data-original-title="Your total earnings accrued yesterday. This amount is an estimate that is subject to change when your earnings are verified for accuracy at the end of every month."></i>
          </div>
        </div>
      </div>
      <!-- End .title -->
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
            <span class="title">Campaigns:</span> +19,77% <span class="bar_1"></span>
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
        <ul class="row-fluid fluid general_statistics hidden-phone">
              <li class="box gradient span3">
              <a href="manage_compaign.php">
              <div class="icon">
                <img src="img/general/coffee2.png">
                <img class="hover" src="img/general/coffee.png">
              </div>
              <div class="heading">
                 +1.204 
              </div>
              <div class="desc">
                <!-- Development -->
                 Campaigns
              </div>
              </a>
              </li>
          <li class="box gradient span3">
          <a href="manage_users.php">
          <div class="icon">
            <img src="img/general/sun2.png">
            <img class="hover" src="img/general/sun.png">
          </div>
          <div class="heading">
            1.832
          </div>
          <div class="desc">
            Users
          </div>
          </a>
          </li>
          <li class="box gradient span3">
          <a>
          <div class="icon">
            <img src="img/general/flipchart2.png">
            <img class="hover" src="img/general/flipchart.png">
          </div>
          <div class="heading">
            2.927
          </div>
          <div class="desc">
            Emails sent
          </div>
          </a>
          </li>
          <li class="box gradient span3">
          <a>
          <div class="icon">
            <img src="img/general/clock2.png">
            <img class="hover" src="img/general/clock.png">
          </div>
          <div class="heading">
            14.029
          </div>
          <div class="desc">
            Notifications
          </div>
          </a>
          </li>
        </ul>
      </div>
      <div class="row-fluid">
        <div class="box gradient">
          <div class="title">
            <div class="row-fluid">
              <div class="span6">
                <h4>
                <i class=" icon-bar-chart"></i><span>Sources overview</span>
                </h4>
              </div>
              <!-- End .span6 -->
              <div class="span6 to_hide right_offset">
                <div class="btn-toolbar">
                  <div class="options_arrow pull-right">
                    <div class="dropdown pull-right">
                      <a class="dropdown-toggle " id="dLabel" role="button" data-toggle="dropdown" data-target="#" href="/page.html">
                      <i class=" icon-caret-down"></i>
                      </a>
                      <ul class="dropdown-menu " role="menu" aria-labelledby="dLabel">
                        <li><a href="#">Today</a></li>
                        <li><a href="#">Yesterday</a></li>
                        <li><a href="#">Last 7 Days</a></li>
                        <li><a href="#">Last 30 Days</a></li>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
              <!-- End .span6 -->
            </div>
            <!-- End .row-fluid -->
          </div>
          <!-- End .title -->
          <div class="content">
            <div id="placeholder" style="width:100%;height:350px;">
            </div>
          </div>
        </div>
        <!-- End .box -->
      </div>
      <!-- End .row-fluid -->
      <div class="row-fluid">
        <div class="span8">
          <div class="box gradient">
            <div class="title">
              <h4>
              <i class="icon-globe"></i><span>Countries</span>
              </h4>
            </div>
            <!-- End .title -->
            <div class="content">
              <table id="datatable_example" class="responsive table table-striped" style="width:100%;height:300px;margin-bottom:0; ">
              <thead>
              <tr>
                <th class="jv no_sort">
                  No
                </th>
                <th class="ue">
                  Country
                </th>
                <th class="ms no_sort ">
                  Visits
                </th>
                <th class="Yy to_hide_phone">
                  % Visits
                </th>
              </tr>
              </thead>
              <tbody>
              <tr>
                <td>
                  1
                </td>
                <td>
                  Italy
                </td>
                <td class="ms">
                  161.083
                </td>
                <td class="to_hide_phone">
                  45,73% <span class="line">5,3,9,6,5,9,7,3,5,2</span>
                </td>
              </tr>
              <tr>
                <td>
                  2
                </td>
                <td>
                  France
                </td>
                <td class="ms">
                  93.966
                </td>
                <td class="to_hide_phone">
                  26,67% <span class="line">5,3,2,-1,-3,-2,2,3,5,2</span>
                </td>
              </tr>
              <tr>
                <td>
                  3
                </td>
                <td>
                  United Kingdom
                </td>
                <td class="ms">
                  69.640
                </td>
                <td class="to_hide_phone">
                  19,77% <span class="line">0,-3,-6,-4,-5,-4,-7,-3,-5,-2</span>
                </td>
              </tr>
              <tr>
                <td>
                  4
                </td>
                <td>
                  Germany
                </td>
                <td class="ms">
                  24.421
                </td>
                <td class="to_hide_phone">
                  6,93% &nbsp;&nbsp;<span class="line">5,3,9,6,5,9,7,3,5,2</span>
                </td>
              </tr>
              <tr>
                <td>
                  5
                </td>
                <td>
                  Canada
                </td>
                <td class="ms">
                  1.693
                </td>
                <td class="to_hide_phone">
                  0,48% &nbsp;&nbsp;<span class="line">5,3,2,-1,-3,-2,2,3,5,2</span>
                </td>
              </tr>
              <tr>
                <td>
                  6
                </td>
                <td>
                  US
                </td>
                <td class="ms">
                  642
                </td>
                <td class="to_hide_phone">
                  0,18% &nbsp;&nbsp;<span class="line">5,3,9,6,5,9,7,3,5,2</span>
                </td>
              </tr>
              </tbody>
              </table>
            </div>
            <!-- End .content -->
          </div>
          <!-- End .box -->
        </div>
        <!-- End .span8 -->
        <div class="span4">
          <div class="box gradient">
            <div class="title row-fluid fluid">
              <h4 class="span6">
              <i class="icon-eye-open"></i>
              <span>Social Stats <span class="label label-success"><span class="icomoon-icon-arrow-up white"></span>+23,5%</span></span>
              </h4>
              <div class="btn-toolbar span6">
                <div class="options_arrow pull-right right_offset">
                  <div class="dropdown pull-right">
                    <a class="dropdown-toggle " id="dLabel" role="button" data-toggle="dropdown" data-target="#" href="/page.html">
                    <i class=" icon-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu " role="menu" aria-labelledby="dLabel">
                      <li><a href="#">Today</a></li>
                      <li><a href="#">Yesterday</a></li>
                      <li><a href="#">Last 7 Days</a></li>
                      <li><a href="#">Last 30 Days</a></li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
            <!-- End .title -->
            <div class="content row-fluid">
              <div id="donut" class="graph" style="width:100%;height:300px;">
              </div>
            </div>
            <!-- End .content -->
          </div>
          <!-- End .box -->
        </div>
        <!-- End .span4 -->
      </div>
      <!-- End .row-fluid -->
      <div class="row-fluid">
        <div class="span6">
          <div class="box gradient">
            <div class="title">
              <h4>
              <i class="icon-eye-open"></i>
              <span>Schedule </span>
              </h4>
            </div>
            <!-- End .title -->
            <div class="content full top">
              <div id='calendar'>
              </div>
            </div>
            <!-- End .content -->
          </div>
          <!-- End .box -->
        </div>
        <!-- End .span6 -->
        <div class="span6 box gradient">
          <div class="row-fluid">
            <div class="title">
              <h4>
              <i class="icon-eye-open"></i>
              <span>Latest comments </span>
              </h4>
            </div>
            <!-- End .title -->
            <div class="content">
              <ul class="messages_layout">
                <li class="from_user left">
                <a href="#" class="avatar"><img src="img/message_avatar1.png"/></a>
                <div class="message_wrap">
                  <span class="arrow"></span>
                  <div class="info">
                    <a class="name">John Smith</a>
                    <span class="time">1 hour ago</span>
                    <div class="options_arrow">
                      <div class="dropdown pull-right">
                        <a class="dropdown-toggle " id="dLabel" role="button" data-toggle="dropdown" data-target="#" href="/page.html">
                        <i class=" icon-caret-down"></i>
                        </a>
                        <ul class="dropdown-menu " role="menu" aria-labelledby="dLabel">
                          <li><a href="#"><i class=" icon-share-alt icon-large"></i>Reply</a></li>
                          <li><a href="#"><i class=" icon-trash icon-large"></i>Delete</a></li>
                          <li><a href="#"><i class=" icon-share icon-large"></i>Share</a></li>
                        </ul>
                      </div>
                    </div>
                  </div>
                  <div class="text">
                     As an interesting side note, as a head without a body, I envy the dead. There's one way and only one way to determine if an animal is intelligent. Dissect its brain! Man, I'm sore all over. I feel like I just went ten rounds with mighty Thor.
                  </div>
                </div>
                </li>
                <li class="by_myself right">
                <a href="#" class="avatar"><img src="img/message_avatar4.png"/></a>
                <div class="message_wrap">
                  <span class="arrow"></span>
                  <div class="info">
                    <a class="name">Bender (myself) </a>
                    <span class="time">4 hours ago</span>
                    <div class="options_arrow">
                      <div class="dropdown pull-right">
                        <a class="dropdown-toggle " id="dLabel" role="button" data-toggle="dropdown" data-target="#" href="/page.html">
                        <i class=" icon-caret-down"></i>
                        </a>
                        <ul class="dropdown-menu " role="menu" aria-labelledby="dLabel">
                          <li><a href="#"><i class=" icon-share-alt icon-large"></i>Reply</a></li>
                          <li><a href="#"><i class=" icon-trash icon-large"></i>Delete</a></li>
                          <li><a href="#"><i class=" icon-share icon-large"></i>Share</a></li>
                        </ul>
                      </div>
                    </div>
                  </div>
                  <div class="text">
                     All I want is to be a monkey of moderate intelligence who wears a suit… that's why I'm transferring to business school! I had more, but you go ahead. Man, I'm sore all over. I feel like I just went ten rounds with mighty Thor. File not found.
                  </div>
                </div>
                </li>
                <li class="from_user left">
                <a href="#" class="avatar"><img src="img/message_avatar2.png"/></a>
                <div class="message_wrap">
                  <span class="arrow"></span>
                  <div class="info">
                    <a class="name">Celeste Holm </a>
                    <span class="time">1 Day ago</span>
                    <div class="options_arrow">
                      <div class="dropdown pull-right">
                        <a class="dropdown-toggle " id="dLabel" role="button" data-toggle="dropdown" data-target="#" href="/page.html">
                        <i class=" icon-caret-down"></i>
                        </a>
                        <ul class="dropdown-menu " role="menu" aria-labelledby="dLabel">
                          <li><a href="#"><i class=" icon-share-alt icon-large"></i>Reply</a></li>
                          <li><a href="#"><i class=" icon-trash icon-large"></i>Delete</a></li>
                          <li><a href="#"><i class=" icon-share icon-large"></i>Share</a></li>
                        </ul>
                      </div>
                    </div>
                  </div>
                  <div class="text">
                     And I'd do it again! And perhaps a third time! But that would be it. Are you crazy? I can't swallow that. And I'm his friend Jesus. No, I'm Santa Claus! And from now on you're all named Bender Jr.
                  </div>
                </div>
                </li>
                <li class="from_user left">
                <a href="#" class="avatar"><img src="img/message_avatar3.png"/></a>
                <div class="message_wrap">
                  <span class="arrow"></span>
                  <div class="info">
                    <a class="name">Mark Jobs </a>
                    <span class="time">2 Days ago</span>
                    <div class="options_arrow">
                      <div class="dropdown pull-right">
                        <a class="dropdown-toggle " id="dLabel" role="button" data-toggle="dropdown" data-target="#" href="/page.html">
                        <i class=" icon-caret-down"></i>
                        </a>
                        <ul class="dropdown-menu " role="menu" aria-labelledby="dLabel">
                          <li><a href="#"><i class=" icon-share-alt icon-large"></i>Reply</a></li>
                          <li><a href="#"><i class=" icon-trash icon-large"></i>Delete</a></li>
                          <li><a href="#"><i class=" icon-share icon-large"></i>Share</a></li>
                        </ul>
                      </div>
                    </div>
                  </div>
                  <div class="text">
                     That's the ONLY thing about being a slave. Now, now. Perfectly symmetrical violence never solved anything. Uh, is the puppy mechanical in any way? As an interesting side note, as a head without a body, I envy the dead.
                  </div>
                </div>
                </li>
              </ul>
            </div>
            <!-- End .content -->
          </div>
          <!-- End .box -->
        </div>
        <!-- End .span6 -->
      </div>
    </div>
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
<script language="javascript" type="text/javascript" src="js/plugins/flot/jquery.flot.js"></script>
<script language="javascript" type="text/javascript" src="js/plugins/flot/jquery.flot.stack.js"></script>
<script language="javascript" type="text/javascript" src="js/plugins/flot/jquery.flot.pie.js"></script>
<script language="javascript" type="text/javascript" src="js/plugins/flot/jquery.flot.resize.js"></script>
<script language="javascript" type="text/javascript" src="js/plugins/jquery.peity.min.js"></script>
<script type="text/javascript" language="javascript" src="js/plugins/datatables/js/jquery.dataTables.js"></script>
<script src="js/plugins/justGage.1.0.1/resources/js/raphael.2.1.0.min.js"></script>
<script src="js/plugins/justGage.1.0.1/resources/js/justgage.1.0.1.min.js"></script>
<script language="javascript" type="text/javascript" src="js/plugins/full-calendar/fullcalendar.min.js"></script>


<script src="js/scripts.js"></script>
<script language="javascript" type="text/javascript" src="js/jnavigate.jquery.min.js"></script>
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
      $(document).ready(function() {
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        var calendar = $('#calendar').fullCalendar({
          header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
          },
          selectable: true,
          selectHelper: true,
          select: function(start, end, allDay) {
            var title = prompt('Event Title:');
            if (title) {
              calendar.fullCalendar('renderEvent',
                {
                  title: title,
                  start: start,
                  end: end,
                  allDay: allDay
                },
                true // make the event "stick"
              );
            }
            calendar.fullCalendar('unselect');
          },
          editable: true,
          events: [
            {
              title: 'All Day Event',
              start: new Date(y, m, 1)
            },
            {
              title: 'Long Event',
              start: new Date(y, m, d+5),
              end: new Date(y, m, d+7)
            },
            {
              id: 999,
              title: 'Repeating Event',
              start: new Date(y, m, d-3, 16, 0),
              allDay: false
            },
            {
              id: 999,
              title: 'Repeating Event',
              start: new Date(y, m, d+4, 16, 0),
              allDay: false
            },
            {
              title: 'Meeting',
              start: new Date(y, m, d, 10, 30),
              allDay: false
            },
            {
              title: 'Lunch',
              start: new Date(y, m, d, 12, 0),
              end: new Date(y, m, d, 14, 0),
              allDay: false
            },
            {
              title: 'Birthday Party',
              start: new Date(y, m, d+1, 19, 0),
              end: new Date(y, m, d+1, 22, 30),
              allDay: false
            },
            {
              title: 'Click for PixelGrade',
              start: new Date(y, m, 28),
              end: new Date(y, m, 29),
              url: 'http://pixelgrade.com/'
            }
          ]
        });
      });
    </script>
<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {
      var dontSort = [];
                $('#datatable_example thead th').each( function () {
                    if ( $(this).hasClass( 'no_sort' )) {
                        dontSort.push( { "bSortable": false } );
                    } else {
                        dontSort.push( null );
                    }
      } );
      $('#datatable_example').dataTable( {
        "sDom": "<'row table_top_bar'<'row-fluid'>'<'to_hide_phone'>'f'<'>r>t<'row'>",
         "sDom": "<'row table_top_bar'<'row-fluid'<'to_hide_phone' f>>><'row'>",
        "aaSorting": [[ 4, "asc" ]],
        "bPaginate": false,
        "bJQueryUI": false,
        "aoColumns": dontSort
      } );
      $.extend( $.fn.dataTableExt.oStdClasses, {
        "s`": "dataTables_wrapper form-inline"
      } );
    } );
</script>

<script type="text/javascript">
    $(function () {
    
    var sin = [], cos = [], tes = [];
    for (var i = 0; i < 14; i += 1) {
      sin.push([i, Math.sin(i)*Math.random()*0.9]);
      cos.push([i, Math.cos(i)*Math.random()*1.4]);
      tes.push([i, Math.cos(i)*Math.random()*0.4]);
    }
    var plot = $.plot($("#placeholder"),
     [  { data: sin, label: "Google+", color:"#ef4723", shadowSize:0 }, { data: cos, label: "Envato", color:"#a1d14d", shadowSize:0},  { data: tes, label: "Facebook", color:"#4a8cf7", shadowSize:0 } ], {
       series: {
         lines: { show: true, fill:true },
         points: { show: true, fill:true },
       },
       grid: { hoverable: true, clickable: true, autoHighlight: false, borderWidth:0,  backgroundColor: { colors: ["#fff", "#fbfbfb"] } },
       yaxis: { min: -1.5, max: 1.5 },
     });
    function showTooltip(x, y, contents) {
      $('<div id="tooltip">' + contents + '</div>').css( {
        position: 'absolute',
        display: 'none',
        top: y + 5,
        left: x + 5,
        border: '1px solid #ccc',
        padding: '2px 6px',
        'background-color': '#fff',
        opacity: 0.80
      }).appendTo("body").fadeIn(200);
    }
    var previousPoint = null;
    $("#placeholder").bind("plothover", function (event, pos, item) {
      $("#x").text(pos.x.toFixed(2));
      $("#y").text(pos.y.toFixed(2));
      if (item) {
        if (previousPoint != item.dataIndex) {
          previousPoint = item.dataIndex;
          $("#tooltip").remove();
          var x = item.datapoint[0].toFixed(2),
          y = item.datapoint[1].toFixed(2);
          showTooltip(item.pageX, item.pageY,
            item.series.label + " of " + x + " = " + y);
        }
      }
    });
  });
$(function () {
  var data = [];
  var series = Math.floor(Math.random()*5)+1;
  data[0] = { label: "Google+", data:42, color: "#cb4b4b" };
  data[1] = { label: "Envato", data:27, color: "#4da74d"};
  data[2] = { label: "Pinterest", data:9, color: "#edc240"};
  data[3] = { label: "Facebook", data:22, color: "#5e96ea"};
  // DONUT
   $.plot($("#donut"), data,
    {
            series: {
            pie: { 
              show: true,
              innerRadius: 0.42,
              highlight: {
                opacity: 0.3
              },
              radius: 1,
              stroke: {
                color: '#fff',
                width: 4
              },
              startAngle: 0,
              combine: {
                          color: '#353535',
                          threshold: 0.05
              },
              label: {
                          show: true,
                          radius: 1,
                          formatter: function(label, series){
                              return '<div class="chart-label">'+label+'&nbsp;'+Math.round(series.percent)+'%</div>';
                          }
                      }
              },
              grow: { active: false}
              },
              legend:{show:true},
              grid: {
                      hoverable: true,
                      clickable: true
              },
    });
});
</script>
</body>
</html>