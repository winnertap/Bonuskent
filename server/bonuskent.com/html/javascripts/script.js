var animationSpeed = 400;

$(function() {
    if( !iosAgent() ) {
        // Only enable hover functions and parallax on non iOs
        stellarInit();
        hoverInit();
    }
	smoothScroll();
	equalizeHeight();
    carouselInit();
    tooltipInit();
    contactInit();
    lightboxInit();
});


// Function for checking iOS agent
function iosAgent() {
    var deviceAgent = navigator.userAgent.toLowerCase();
    var newClass = '';
    var isIOS = false;
    if( deviceAgent.match(/iphone/i) ) {
        newClass = 'agent-iphone';
        isIOS = true;
    }
    else if( deviceAgent.match(/ipod/i) ) {
        newClass = 'agent-ipod';
        isIOS = true;
    }
    else if( deviceAgent.match(/ipad/i) ) {
        newClass = 'agent-ipad';
        isIOS = true;
    }

    $('body').addClass( newClass );

    return isIOS;
}



// Function for carousel init
function carouselInit() {
    $('#intro').carousel({
        interval: 5000
    });

    if( !$('body').hasClass( 'iphone' ) ) {
        $('#thumbs').carousel({
            interval: 5000
        });
    } else {
        $('#thumbs').removeClass('carousel slide');
    }
}

// Function for smooth scrolling between the sections
function smoothScroll() {
	$('.navbar').on('click','a', function(e) {
        e.preventDefault();
        target = this.hash;
        $.scrollTo( target, 3 * animationSpeed, {
            axis: 'y'
        } );
   });
}

// Make the sections have the height of the window
function equalizeHeight() {
    var section = $('html').not('.ie8').find('.section'); // getting the sections in all but ie8
	section.css({'min-height': (($(window).height()))+'px'});
    $(window).resize(function(){
        section.css({'min-height': (($(window).height()))+'px'});
    });
}

// initialize stellar
function stellarInit() {
    $(window).stellar({
        horizontalScrolling: false
    });
}

// initialize tooltips
function tooltipInit() {
    $('.well-author a, #style-switcher a').tooltip({
        placement: 'top'
    });
}

// Validate contact form
function contactInit() {
    $('#submitEmail').click( function() {
        var $email = $('#email');
        if( validateEmail( $email.val() ) ) {
            message( "<strong>Thanks for your interest!</strong> we will be in touch soon....", "success", 5000 );
        }
        else {
            message( "<strong>Invalid Email</strong> please type in a correct email address", "error", 5000 );
        }
    });

    $('#email').keypress( function() {
        if( validateEmail( $(this).val() ) ) {
            $(this).removeClass( 'invalid-email' );
        }
        else {
            $(this).addClass( 'invalid-email' );
        }
    });
}

function validateEmail(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function message( content, type, duration ) {
    var messageHTML = '<div class="alert alert-' + type + '">'
                    + content
                    + '</div>';

    var message = $(messageHTML).hide();

    $('#messages').append(message);

    message.fadeIn();

    // Increase compatibility with unnamed functions
    setTimeout(function() {
        message.fadeOut();
    }, duration);  // will work with every browser
}

function hoverInit() {
    $('[data-image]').on('mouseenter', function(){
        $(this).find('i').animate({
            top: '50%'
            }, 300
        );
    });
    $('[data-image]').on('mouseleave', function(){
        $(this).find('i').animate({
            top: '120%'
            }, 300, function() {
                $(this).css('top', '-100px');
            }
        );
    });
}

function lightboxInit() {
    $('[data-image]').on('click', function() {
        var src = $(this).data('image');
        console.log(src);
        $('#lightbox').find('img').attr('src', src);
    });
}
;
