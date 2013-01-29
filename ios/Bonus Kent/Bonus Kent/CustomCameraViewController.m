//
//  CustomCameraViewController.m
//  CameraOverlayView
//
//  Created by B.H.Liu appublisher on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomCameraViewController.h"

@interface CustomCameraViewController()
- (void)addOverlay:(UIImage*)overlayImage;
@end


#define OVERLAY_ALPHA 0.90f

// horizontal onSwipe
#define HORIZ_SWIPE_DRAG_MIN 180
#define VERT_SWIPE_DRAG_MAX 100

// vertical onSwipe
#define HORIZ_SWIPE_DRAG_MAX 100
#define VERT_SWIPE_DRAG_MIN 250

@implementation CustomCameraViewController
@synthesize camera=_camera;
@synthesize preView=_preView;
@synthesize overlayView=_overlayView;
@synthesize startTouchPosition=_startTouchPosition;
@synthesize cameraMode=_cameraMode;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.cameraMode = YES;
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    //[UIApplication sharedApplication].statusBarHidden = YES;
    
    self.overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.overlayView.opaque = NO;
    self.overlayView.alpha = OVERLAY_ALPHA;
        
    self.view = self.overlayView;
}

- (void) viewDidAppear:(BOOL)animated 
{ 
    if (self.cameraMode == NO)
    {
        [self.delegate customCameraDidCancelled];
        return;
    }
    
    [self initCamera];
    [self startCamera];
    
        
    NSURL *url = [NSURL URLWithString:@"http://nowasys.com/augemntedreality/images/tshirt.png"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];

    
    [self performSelector:@selector(addOverlay:) withObject:img afterDelay:1.5];
    
    [self becomeFirstResponder];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.preView = nil;
    self.overlayView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark-
#pragma mark- methods
- (void) initCamera 
{  
    if ([APFullScreenCameraPicker isAvailable]) 
    {  
        
        NSLog(@"Initializing camera.");
        self.camera = [[APFullScreenCameraPicker alloc] init];
        [self.camera.view setBackgroundColor:[UIColor clearColor]];
        [self.camera setCameraOverlayView:self.overlayView];
        self.camera.APDelegate = self;
        
        self.preView = [[PhotoPreview alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.preView.delegate = self;
        [self.view addSubview:self.preView];

    } 
    else 
    {
        NSLog(@"Camera not available.");
    }
}

- (void)startCamera
{
    [self presentModalViewController:self.camera animated:YES];
}

- (void) addGenstures
{
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)];
    [pinchRecognizer setDelegate:self];
    [overlay addGestureRecognizer:pinchRecognizer];
    
//    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
//    [rotationRecognizer setDelegate:self];
//    [overlay addGestureRecognizer:rotationRecognizer];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    [overlay addGestureRecognizer:panRecognizer];
    
    UITapGestureRecognizer *tapProfileImageRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [tapProfileImageRecognizer setNumberOfTapsRequired:1];
    [tapProfileImageRecognizer setDelegate:self];
    [overlay addGestureRecognizer:tapProfileImageRecognizer];

}
UIImageView *overlay;
- (void)addOverlay:(UIImage*)overlayImage
{
    overlay = [[UIImageView alloc] initWithImage:overlayImage];
    [self.view addSubview:overlay];
     [self addGenstures];
}

#pragma mark-
#pragma mark- APFullScreenCameraPicker Delegate
- (void)cameraWillTakePicture
{
    [self.preView hideThumbnail];
}

- (void)cameraDidTakePicture:(UIImage *)photoTaken
{
    [self.preView generateAndShowThumbnail:photoTaken];
    [self.preView hideThumbnailAfterDelay:5.0f];
}

#pragma mark-
#pragma mark- PhotoPreview Delegate
- (void)thumbnailTapped
{
    self.view.alpha = 1.0f;
    [self.view bringSubviewToFront:self.preView];
}

- (void)previewClosed
{
    self.view.alpha = OVERLAY_ALPHA;
}

- (void)imageForUse:(UIImage *)image
{
    [self dismissModalViewControllerAnimated:YES];
    self.cameraMode = NO;
    if ([self.delegate respondsToSelector:@selector(customCameraDidFinished:)])
    {
        [self.delegate customCameraDidFinished:image];
    }
}

#pragma mark- 
#pragma mark- Touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self.view];
	self.startTouchPosition = point;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
	UITouch *touch = [touches anyObject];
    
    if ([touch tapCount] == 1) {
		[self onSingleTap:touch];
	} else if ([touch tapCount] == 2) {
		[self onDoubleTap:touch];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.view];
    
	// If the onSwipe tracks correctly.
	if (fabsf(self.startTouchPosition.x - currentTouchPosition.x) >= HORIZ_SWIPE_DRAG_MIN &&
        fabsf(self.startTouchPosition.y - currentTouchPosition.y) <= VERT_SWIPE_DRAG_MAX)
	{
		[NSObject cancelPreviousPerformRequestsWithTarget:self];
		if (self.startTouchPosition.x < currentTouchPosition.x) 
        {
			[self onSwipeRight];
		} 
        else 
        {
			[self onSwipeLeft];
		}
		self.startTouchPosition = currentTouchPosition;
        
	} 
    else if (fabsf(self.startTouchPosition.y - currentTouchPosition.y) >= VERT_SWIPE_DRAG_MIN &&
               fabsf(self.startTouchPosition.x - currentTouchPosition.x) <= HORIZ_SWIPE_DRAG_MAX)
    {
		[NSObject cancelPreviousPerformRequestsWithTarget:self];
		if (self.startTouchPosition.y < currentTouchPosition.y) 
        {
			[self onSwipeDown];
		} 
        else 
        {
			[self onSwipeUp];
		}
		self.startTouchPosition = currentTouchPosition;  
        
    } 
    else 
    {
		// Process a non-swipe event.
	}
}

-(void)onSingleTap:(UITouch*)touch 
{
	NSLog(@"onSingleTap");
	[self.camera takePicture];
}

-(void)onDoubleTap:(UITouch*)touch 
{
	NSLog(@"onDoubleTap");
}

- (void)onSwipeUp 
{
	NSLog(@"onSwipeUp");
}

- (void)onSwipeDown 
{
	NSLog(@"onSwipeDown");
    [self dismissModalViewControllerAnimated:YES];
    self.cameraMode = NO;
}


- (void)onSwipeLeft 
{
	NSLog(@"onSwipeLeft");
}

- (void)onSwipeRight 
{
	NSLog(@"onSwipeRight");
}


#pragma mark - Image Gestures
CGFloat _lastScale;
CGFloat _lastRotation;
CGFloat _firstX;
CGFloat _firstY;

-(void)scale:(id)sender {
    NSLog(@"width = %f ::::: height = %f",overlay.frame.size.width, overlay.frame.size.height);
    
    NSLog(@"Scale");
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _lastScale = 1.0;
    }
    
    CGFloat scale = 1.0 - (_lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    
    CGAffineTransform currentTransform = overlay.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
    [overlay setTransform:newTransform];
    
    _lastScale = [(UIPinchGestureRecognizer*)sender scale];
    
//    [self showOverlayWithFrame:overlay.frame];
}

-(void)rotate:(id)sender {
    NSLog(@"Rotate");
    if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        _lastRotation = 0.0;
        return;
    }
    
    CGFloat rotation = 0.0 - (_lastRotation - [(UIRotationGestureRecognizer*)sender rotation]);
    
    CGAffineTransform currentTransform = overlay.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    
    [overlay setTransform:newTransform];
    
    _lastRotation = [(UIRotationGestureRecognizer*)sender rotation];
    
//    overlay.image = [overlay.image imageRotatedByRadians:rotation];
    
    //    imageView.image = [imageView.image resizedImage:imageView.frame.size interpolationQuality:kCGInterpolationDefault];
    [self showOverlayWithFrame:overlay.frame];
}

-(void)move:(id)sender {
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:overlay];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _firstX = [overlay center].x;
        _firstY = [overlay center].y;
    }
    
    translatedPoint = CGPointMake(_firstX+translatedPoint.x, _firstY+translatedPoint.y);
    
    [overlay setCenter:translatedPoint];
}


-(void)showOverlayWithFrame:(CGRect)frame {
    
//    if (![_marque actionForKey:@"linePhase"])
//    {
//        CABasicAnimation *dashAnimation;
//        dashAnimation = [CABasicAnimation animationWithKeyPath:@"lineDashPhase"];
//        [dashAnimation setFromValue:[NSNumber numberWithFloat:0.0f]];
//        [dashAnimation setToValue:[NSNumber numberWithFloat:15.0f]];
//        [dashAnimation setDuration:0.5f];
//        [dashAnimation setRepeatCount:HUGE_VALF];
//        [_marque addAnimation:dashAnimation forKey:@"linePhase"];
//    }
    
//    _marque.bounds = CGRectMake(frame.origin.x, frame.origin.y, 0, 0);
//    _marque.position = CGPointMake(frame.origin.x + videoPreviewView.frame.origin.x, frame.origin.y + videoPreviewView.frame.origin.y);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, frame);
//    [_marque setPath:path];
    CGPathRelease(path);
    
//    _marque.hidden = NO;
}

#pragma mark - Still Image Capturing Code



@end
