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

      <div id="loading" class="other_pages" style="position:inherit">
        <!-- Login page -->
        <div id="login">
          <div class="support-note"><!-- let's check browser support with modernizr -->
            <span class="no-csstransforms">CSS transforms are not supported in your browser</span>
            <span class="no-csstransforms3d">CSS 3D transforms are not supported in your browser</span>
            <span class="no-csstransitions">CSS transitions are not supported in your browser</span>
          </div>

         
     
        
     
        <div class="row-fluid">
          <div class="row-fluid">
            <!--<div id="arrow_register"></div>-->
            <div><a href="index.html"></a></div>
            <div class="pull-right spacer-medium not-member members right_offset">Not a member? <a href="#" id="bb-nav-next" class="members_button">Sign up <i class="icon-magic"></i></a></div>
            <div class="pull-right spacer-medium already-member members right_offset" style="display:none;">Already a member? <a href="#" class="members_button" id="bb-nav-prev">Log in <i class="icon-undo"></i></a></div>
          </div> 

      <div class="row-fluid bb-bookblock" id="bb-bookblock">
        <div class="bb-item row-fluid login">

         <div class="top-background">
          <div class="fill-background right"><div class="bg row-fluid"></div></div>
          <div id="login-corner-shadow"></div>
        </div>
        <div class="row-fluid container">
          <div class="content">
            <div class="message row-fluid">
              <h4>Enter your username and password.</h4>
              <!--<h3>Have fun!</h3>-->
            </div>
          <form name="loginForm" action="loginNext.php" method="post">
            <div class="control-group row-fluid">
              <label class="row-fluid " for="inputEmail">Username</label>
              <div class="controls row-fluid input-append">
                <input type="text" name="userName" id="userName" placeholder="Your Username"  class="row-fluid" value=""> 
                <span class="add-on"><i class="icon-user"></i></span>
              </div>
            </div>
              <div class="control-group row-fluid">
              <label class="row-fluid " for="inputPassword">Password <!--<div class="pull-right"><a class="muted"><small>Forgot your password ?</small></a></div>-->
              </label>
              <div class="controls row-fluid input-append">
                <input type="password" name="password" id="inputPassword" placeholder="Your Password"  class="row-fluid" value=""> 
                <span class="add-on"><i class="icon-lock"></i></span>
              </div>
            </div>
            <div class="control-group row-fluid"></div>
            <div class="control-group row-fluid fluid">
     <!--         <div class="controls span6">
                <label class="checkbox">
                  <input type="checkbox"> Remember me
                </label>
              </div>
     -->         
     		<div class="controls span5 offset1" style="margin-left:100px;">
		        <button data-original-title="Login" onClick="rewardFormSubmit()" data-placement="top" rel="tooltip" class="btn btn-success btn-large">Take me in</button>
              </div>
            </div>
          </form>
          </div><!-- End .container -->
          </div> <!-- End .row-fluid -->
        </div> <!-- .bb-item  -->

       <div class="bb-item row-fluid register">
         <div class="top-background row-fluid fluid">
          <div class="fill-background "><div class="bg row-fluid"></div></div>
          <div id="login-corner-shadow" class="left"></div>
        </div>
        <div class="row-fluid fluid container">
          <div class="content">
            <div class="message row-fluid ">
             <h4>Register and Have Fun!</h4>              
            </div>
            <form class="form-horizontal row-fluid">
               <div class="control-group row-fluid">
              <label class="row-fluid " for="inputEmail">Enter your Email</label>
              <div class="controls row-fluid input-append">
                <input type="text" id="inputEmail" placeholder="email.."  class="row-fluid" > <span class="add-on"><i class="icon-globe"></i></span>
              </div>
            </div>
            <div class="control-group row-fluid">
              <label class="row-fluid " for="inputEmail">Pick a username</label>
              <div class="controls row-fluid input-append">
                <input type="text" id="inputEmail" placeholder="username.."  class="row-fluid" autocomplete="off" > <span class="add-on"><i class="icon-user"></i></span>
              </div>
            </div>

              <div class="control-group row-fluid">
              <label class="row-fluid " for="inputPassword">And a password </label>
              <div class="controls row-fluid input-append">
                <input type="password" id="inputPassword" placeholder="password.."  class="row-fluid" autocomplete="off"> <span class="add-on"><i class="icon-lock"></i></span>
              </div>
            </div>

<!---->
            <div class="control-group row-fluid">
              <label class="row-fluid " for="inputEmail">Gender</label>
              <div class="controls row-fluid input-append">
                <select>
                	<option value="-1">Select</option>
                	<option value="m">Male</option>
                	<option value="f">Female</option>
                    
                </select> <span class="add-on"><i class="icon-home"></i></span>
              </div>
            </div>

            <div class="control-group row-fluid">
              <label class="row-fluid " for="inputEmail">Date Of Birth</label>
              <div class="controls row-fluid input-append">
                <input type="text" id="dateOfBirth" placeholder="Date Of Birth.."  class="row-fluid" autocomplete="off" > <span class="add-on"><i class="icon-calendar"></i></span>
              </div>
            </div>

            <div class="control-group row-fluid">
              <label class="row-fluid " for="inputEmail">Education</label>
              <div class="controls row-fluid input-append">
                <input type="text" id="education" placeholder="Education.."  class="row-fluid" autocomplete="off" > <span class="add-on"><i class="icon-tag"></i></span>
              </div>
            </div>

            <div class="control-group row-fluid">
              <label class="row-fluid " for="inputEmail">Location</label>
              <div class="controls row-fluid input-append">
                <input type="text" id="location" placeholder="Location.."  class="row-fluid" autocomplete="off" > <span class="add-on"><i class="icon-link"></i></span>
              </div>
            </div>

            <div class="control-group row-fluid">
              <label class="row-fluid " for="inputEmail">Network</label>
              <div class="controls row-fluid input-append">
                <input type="text" id="network" placeholder="Network.."  class="row-fluid" autocomplete="off" > <span class="add-on"><i class="icon-facebook"></i></span>
              </div>
            </div>

            <div class="control-group row-fluid">
              <label class="row-fluid " for="inputEmail">POI</label>
              <div class="controls row-fluid input-append">
                <input type="text" id="poi" placeholder="POI.."  class="row-fluid" autocomplete="off" > <span class="add-on"><i class="icon-dashboard"></i></span>
              </div>
            </div>




<!---->

            <div class="control-group row-fluid fluid">
             
              <div class="controls span5 offset7">
                <a href="index.html" class="btn btn-info row-fluid">Register <i class="gicon-chevron-right icon-white"></i></a>
              </div>
            </div>
          </form>

          </div><!-- End .container -->
          </div> <!-- End .row-fluid -->
        </div> <!-- .bb-item  -->

      
        </div> <!-- End #bb-bookblock -->

<!--          <div class="row-fluid spacer">
            <p class="row-fluid pagination-centered "><span class="muted">Or sign in using</span></p>
            <ul class="row-fluid fluid general_statistics alternative_login">
                <li class="box gradient span6 twitter">
                   <a href="index.html"n class="btn btn-twitter row-fluid"><i class="icon-twitter"></i>Login with Twitter</a>
                </li>
                <li class="box gradient span6 facebook">
                 <a href="index.html" class="btn btn-facebook row-fluid"><i class="icon-facebook"></i>Login with Facebook</a>
              </li>
            </ul>
          </div> --><!-- End .row-fluid -->

        </div> <!-- End .row-fluid -->

    </div> <!-- End #login -->
        <!-- <img src="img/ajax-loader.gif"> -->
    </div> <!-- End #loading -->


    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->

    
    <!-- Flip effect on login screen -->
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
    <script type="text/javascript" src="js/plugins/jquerypp.custom.js"></script>
    <script type="text/javascript" src="js/plugins/jquery.bookblock.js"></script>
    <script language="javascript" type="text/javascript" src="js/plugins/jquery.uniform.min.js"></script>


   <script type="text/javascript">
      $(function() {
        var Page = (function() {

          var config = {
              $bookBlock: $( '#bb-bookblock' ),
              $navNext  : $( '#bb-nav-next' ),
              $navPrev  : $( '#bb-nav-prev' ),
              $navJump  : $( '#bb-nav-jump' ),
              bb        : $( '#bb-bookblock' ).bookblock( {
                speed       : 800,
                shadowSides : 0.8,
                shadowFlip  : 0.7
              } )
            },
            init = function() {

              initEvents();
              
            },
            initEvents = function() {

              var $slides = config.$bookBlock.children(),
                  totalSlides = $slides.length;

              // add navigation events
              config.$navNext.on( 'click', function() {
              $("#arrow_register").fadeOut();
              $(".not-member").slideUp();
              $(".already-member").slideDown();
                config.bb.next();
                return false;

              } );

              config.$navPrev.on( 'click', function() {

                 $(".not-member").slideDown();
                $(".already-member").slideUp();
                config.bb.prev();
                return false;

              } );

              config.$navJump.on( 'click', function() {
                
                config.bb.jump( totalSlides );
                return false;

              } );
              
              // add swipe events
              $slides.on( {

                'swipeleft'   : function( event ) {
                
                  config.bb.next();
                  return false;

                },
                'swiperight'  : function( event ) {
                
                  config.bb.prev();
                  return false;
                  
                }

              } );

            };

            return { init : init };

        })();

        Page.init();

      });
    </script>

    <script type='text/javascript'>
 
    $(window).load(function() {
     $('#loading1').fadeOut();
    });
      $(document).ready(function() {
           $("input:checkbox, input:radio, input:file").uniform();


      $('[rel=tooltip]').tooltip();
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
