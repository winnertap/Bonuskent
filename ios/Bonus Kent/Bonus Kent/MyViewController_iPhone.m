//
//  MyViewController_iPhone.m
//  Bonus Kent
//
//  Created by Ali Asghar on 11/29/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import "MyViewController_iPhone.h"
#import "UIImage+CS_Extensions.h"
#import "UIImage+Resize.h"
#import <ImageIO/ImageIO.h>
#import "BKShareScreenViewController.h"
#import "ColorUtils.h"
#import "UIUtils.h"
#import "LocationUtil.h"

#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

@implementation MyViewController_iPhone

@synthesize PreviewLayer;
@synthesize videoPreviewView;
@synthesize imageView;
@synthesize stillImageOutput;
@synthesize stillImage;
@synthesize radarView;
@synthesize radarOverlay;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



//********** VIEW DID LOAD **********
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [self.navigationItem setHidesBackButton:NO];
    
    [self initLocation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(saveImageToDocumentsDirectory:)
                                                 name:kImageCapturedSuccessfully
                                               object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(saveImageToPhotoAlbum)
//                                                 name:kImageCapturedSuccessfully
//                                               object:nil];

    CGSize size = CGSizeMake(50, 50);
    transformedImage = [imageView.image resizedImage:size interpolationQuality:kCGInterpolationDefault];
    imageView.image = transformedImage;
//	[imageView setFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, size.width, size.height)];
	//---------------------------------
	//----- SETUP CAPTURE SESSION -----
	//---------------------------------
	NSLog(@"Setting up capture session");
	CaptureSession = [[AVCaptureSession alloc] init];
	
	//----- ADD INPUTS -----
	NSLog(@"Adding video input");
	
	//ADD VIDEO INPUT
	AVCaptureDevice *VideoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	if (VideoDevice)
	{
		NSError *error;
		VideoInputDevice = [AVCaptureDeviceInput deviceInputWithDevice:VideoDevice error:&error];
		if (!error)
		{
			if ([CaptureSession canAddInput:VideoInputDevice])
				[CaptureSession addInput:VideoInputDevice];
			else
				NSLog(@"Couldn't add video input");
		}
		else
		{
			NSLog(@"Couldn't create video input");
		}
	}
	else
	{
		NSLog(@"Couldn't create video capture device");
	}
	
	//ADD AUDIO INPUT
	NSLog(@"Adding audio input");
	AVCaptureDevice *audioCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
	NSError *error = nil;
	AVCaptureDeviceInput *audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioCaptureDevice error:&error];
	if (audioInput)
	{
		[CaptureSession addInput:audioInput];
	}
	
	
	//----- ADD OUTPUTS -----
	
	//ADD VIDEO PREVIEW LAYER
	NSLog(@"Adding video preview layer");
	[self setPreviewLayer:[[AVCaptureVideoPreviewLayer alloc] initWithSession:CaptureSession]];
	
	PreviewLayer.orientation = AVCaptureVideoOrientationPortrait;		//<<SET ORIENTATION.  You can deliberatly set this wrong to flip the image and may actually need to set it wrong to get the right image
	
	[[self PreviewLayer] setVideoGravity:AVLayerVideoGravityResizeAspectFill];
	
	
	//ADD MOVIE FILE OUTPUT
	NSLog(@"Adding movie file output");
	MovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
	
	Float64 TotalSeconds = 60;			//Total seconds
	int32_t preferredTimeScale = 30;	//Frames per second
	CMTime maxDuration = CMTimeMakeWithSeconds(TotalSeconds, preferredTimeScale);	//<<SET MAX DURATION
	MovieFileOutput.maxRecordedDuration = maxDuration;
	
	MovieFileOutput.minFreeDiskSpaceLimit = 1024 * 1024;						//<<SET MIN FREE SPACE IN BYTES FOR RECORDING TO CONTINUE ON A VOLUME
	
	if ([CaptureSession canAddOutput:MovieFileOutput])
		[CaptureSession addOutput:MovieFileOutput];
    
    [self addStillImageOutput];
    
	//SET THE CONNECTION PROPERTIES (output properties)
	[self CameraSetOutputProperties];			//(We call a method as it also has to be done after changing camera)
    
    
	
	//----- SET THE IMAGE QUALITY / RESOLUTION -----
	//Options:
	//	AVCaptureSessionPresetHigh - Highest recording quality (varies per device)
	//	AVCaptureSessionPresetMedium - Suitable for WiFi sharing (actual values may change)
	//	AVCaptureSessionPresetLow - Suitable for 3G sharing (actual values may change)
	//	AVCaptureSessionPreset640x480 - 640x480 VGA (check its supported before setting it)
	//	AVCaptureSessionPreset1280x720 - 1280x720 720p HD (check its supported before setting it)
	//	AVCaptureSessionPresetPhoto - Full photo resolution (not supported for video output)
	NSLog(@"Setting image quality");
	[CaptureSession setSessionPreset:AVCaptureSessionPresetMedium];
	if ([CaptureSession canSetSessionPreset:AVCaptureSessionPreset640x480])		//Check size based configs are supported before setting them
		[CaptureSession setSessionPreset:AVCaptureSessionPreset640x480];
    
    
	
	//----- DISPLAY THE PREVIEW LAYER -----
	//Display it full screen under out view controller existing controls
	NSLog(@"Display the preview layer");
	CGRect layerRect = [[[self view] layer] bounds];
	[PreviewLayer setBounds:layerRect];
	[PreviewLayer setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                          CGRectGetMidY(layerRect))];
	//[[[self view] layer] addSublayer:[[self CaptureManager] previewLayer]];
	//We use this instead so it goes on a layer behind our UI controls (avoids us having to manually bring each control to the front):
	UIView *CameraView = [[UIView alloc] init];
	[[self videoPreviewView] addSubview:CameraView];
	[self.videoPreviewView sendSubviewToBack:CameraView];
	
	[[CameraView layer] addSublayer:PreviewLayer];
	
	
	//----- START THE CAPTURE SESSION RUNNING -----
	[CaptureSession startRunning];
    
    /********************Start Of Image Manipulation code by Ali*****************************/
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)];
    [pinchRecognizer setDelegate:self];
    [self.view addGestureRecognizer:pinchRecognizer];
    
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    [rotationRecognizer setDelegate:self];
    [self.view addGestureRecognizer:rotationRecognizer];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    [videoPreviewView addGestureRecognizer:panRecognizer];
    
    UITapGestureRecognizer *tapProfileImageRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [tapProfileImageRecognizer setNumberOfTapsRequired:1];
    [tapProfileImageRecognizer setDelegate:self];
    [videoPreviewView addGestureRecognizer:tapProfileImageRecognizer];
    
    if (!_marque) {
        _marque = [CAShapeLayer layer];
        _marque.fillColor = [[UIColor clearColor] CGColor];
        _marque.strokeColor = [[UIColor grayColor] CGColor];
        _marque.lineWidth = 1.0f;
        _marque.lineJoin = kCALineJoinRound;
        _marque.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:10],[NSNumber numberWithInt:5], nil];
        _marque.bounds = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, 0, 0);
        _marque.position = CGPointMake(imageView.frame.origin.x + videoPreviewView.frame.origin.x, imageView.frame.origin.y + videoPreviewView.frame.origin.y);
    }
    [[self.view layer] addSublayer:_marque];
	/********************End Of Image Manipulation code by Ali*****************************/
//    [self initLocation];
    
    [self applyUIChanges];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIDeviceOrientationLandscapeLeft);
}


//********** VIEW WILL APPEAR **********
//View about to be added to the window (called each time it appears)
//Occurs after other view's viewWillDisappear
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	WeAreRecording = NO;
}




//********** CAMERA SET OUTPUT PROPERTIES **********
- (void) CameraSetOutputProperties
{
	//SET THE CONNECTION PROPERTIES (output properties)
	AVCaptureConnection *CaptureConnection = [MovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
	
	//Set landscape (if required)
	if ([CaptureConnection isVideoOrientationSupported])
	{
		AVCaptureVideoOrientation orientation = AVCaptureVideoOrientationLandscapeRight;		//<<<<<SET VIDEO ORIENTATION IF LANDSCAPE
		[CaptureConnection setVideoOrientation:orientation];
	}
	
	//Set frame rate (if requried)
	CMTimeShow(CaptureConnection.videoMinFrameDuration);
	CMTimeShow(CaptureConnection.videoMaxFrameDuration);
	
	if (CaptureConnection.supportsVideoMinFrameDuration)
		CaptureConnection.videoMinFrameDuration = CMTimeMake(1, CAPTURE_FRAMES_PER_SECOND);
	if (CaptureConnection.supportsVideoMaxFrameDuration)
		CaptureConnection.videoMaxFrameDuration = CMTimeMake(1, CAPTURE_FRAMES_PER_SECOND);
	
	CMTimeShow(CaptureConnection.videoMinFrameDuration);
	CMTimeShow(CaptureConnection.videoMaxFrameDuration);
}

//********** GET CAMERA IN SPECIFIED POSITION IF IT EXISTS **********
- (AVCaptureDevice *) CameraWithPosition:(AVCaptureDevicePosition) Position
{
	NSArray *Devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
	for (AVCaptureDevice *Device in Devices)
	{
		if ([Device position] == Position)
		{
			return Device;
		}
	}
	return nil;
}



//********** CAMERA TOGGLE **********
- (IBAction)CameraToggleButtonPressed:(id)sender
{
	if ([[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count] > 1)		//Only do if device has multiple cameras
	{
		NSLog(@"Toggle camera");
		NSError *error;
		//AVCaptureDeviceInput *videoInput = [self videoInput];
		AVCaptureDeviceInput *NewVideoInput;
		AVCaptureDevicePosition position = [[VideoInputDevice device] position];
		if (position == AVCaptureDevicePositionBack)
		{
			NewVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self CameraWithPosition:AVCaptureDevicePositionFront] error:&error];
		}
		else if (position == AVCaptureDevicePositionFront)
		{
			NewVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self CameraWithPosition:AVCaptureDevicePositionBack] error:&error];
		}
        
		if (NewVideoInput != nil)
		{
			[CaptureSession beginConfiguration];		//We can now change the inputs and output configuration.  Use commitConfiguration to end
			[CaptureSession removeInput:VideoInputDevice];
			if ([CaptureSession canAddInput:NewVideoInput])
			{
				[CaptureSession addInput:NewVideoInput];
				VideoInputDevice = NewVideoInput;
			}
			else
			{
				[CaptureSession addInput:VideoInputDevice];
			}
			
			//Set the connection properties again
			[self CameraSetOutputProperties];
			
			
			[CaptureSession commitConfiguration];
//			[NewVideoInput release];
		}
	}
}




//********** START STOP RECORDING BUTTON **********
- (IBAction)StartStopButtonPressed:(id)sender
{
	
	if (!WeAreRecording)
	{
		//----- START RECORDING -----
		NSLog(@"START RECORDING");
		WeAreRecording = YES;
		
		//Create temporary URL to record to
		NSString *outputPath = [[NSString alloc] initWithFormat:@"%@%@", NSTemporaryDirectory(), @"output.mov"];
		NSURL *outputURL = [[NSURL alloc] initFileURLWithPath:outputPath];
		NSFileManager *fileManager = [NSFileManager defaultManager];
		if ([fileManager fileExistsAtPath:outputPath])
		{
			NSError *error;
			if ([fileManager removeItemAtPath:outputPath error:&error] == NO)
			{
				//Error - handle if requried
			}
		}
//		[outputPath release];
		//Start recording
		[MovieFileOutput startRecordingToOutputFileURL:outputURL recordingDelegate:self];
//		[outputURL release];
	}
	else
	{
		//----- STOP RECORDING -----
		NSLog(@"STOP RECORDING");
		WeAreRecording = NO;
        
		[MovieFileOutput stopRecording];
	}
}


//********** DID FINISH RECORDING TO OUTPUT FILE AT URL **********
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput
didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL
	  fromConnections:(NSArray *)connections
				error:(NSError *)error
{
    
	NSLog(@"didFinishRecordingToOutputFileAtURL - enter");
	
    BOOL RecordedSuccessfully = YES;
    if ([error code] != noErr)
	{
        // A problem occurred: Find out if the recording was successful.
        id value = [[error userInfo] objectForKey:AVErrorRecordingSuccessfullyFinishedKey];
        if (value)
		{
            RecordedSuccessfully = [value boolValue];
        }
    }
	if (RecordedSuccessfully)
	{
		//----- RECORDED SUCESSFULLY -----
        NSLog(@"didFinishRecordingToOutputFileAtURL - success");
		ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
		if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:outputFileURL])
		{
			[library writeVideoAtPathToSavedPhotosAlbum:outputFileURL
										completionBlock:^(NSURL *assetURL, NSError *error)
             {
                 if (error)
                 {
                     
                 }
             }];
		}
        
//		[library release];
		
	}
}


//********** VIEW DID UNLOAD **********
- (void)viewDidUnload
{
    [self setVideoPreviewView:nil];
    [self setImageView:nil];
    [self setRadarView:nil];
    [self setRadarOverlay:nil];
	[super viewDidUnload];
	
//	[CaptureSession release];
	CaptureSession = nil;
//	[MovieFileOutput release];
	MovieFileOutput = nil;
//	[VideoInputDevice release];
	VideoInputDevice = nil;
}

//********** DEALLOC **********
- (void)dealloc
{
//	[CaptureSession release];
//	[MovieFileOutput release];
//	[VideoInputDevice release];
    
//	[super dealloc];
}

#pragma mark - Image Gestures

-(void)scale:(id)sender {
    NSLog(@"width = %f ::::: height = %f",imageView.frame.size.width,imageView.frame.size.height);
    
    NSLog(@"Scale");
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _lastScale = 1.0;
    }
    
    CGFloat scale = 1.0 - (_lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    
    CGAffineTransform currentTransform = imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
    [imageView setTransform:newTransform];
    
    _lastScale = [(UIPinchGestureRecognizer*)sender scale];
    
    [self showOverlayWithFrame:imageView.frame];
}

-(void)rotate:(id)sender {
    NSLog(@"Rotate");
    if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        _lastRotation = 0.0;
        return;
    }
    
    CGFloat rotation = 0.0 - (_lastRotation - [(UIRotationGestureRecognizer*)sender rotation]);
    
    CGAffineTransform currentTransform = imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    
    [imageView setTransform:newTransform];
    
    _lastRotation = [(UIRotationGestureRecognizer*)sender rotation];
    
    imageView.image = [imageView.image imageRotatedByRadians:rotation];
    
    //    imageView.image = [imageView.image resizedImage:imageView.frame.size interpolationQuality:kCGInterpolationDefault];
    [self showOverlayWithFrame:imageView.frame];
}

-(void)move:(id)sender {
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:videoPreviewView];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _firstX = [imageView center].x;
        _firstY = [imageView center].y;
    }
    
    translatedPoint = CGPointMake(_firstX+translatedPoint.x, _firstY+translatedPoint.y);
    
    [imageView setCenter:translatedPoint];
}

-(void)tapped:(id)sender {
    _marque.hidden = YES;
}

-(void)showOverlayWithFrame:(CGRect)frame {
    
    if (![_marque actionForKey:@"linePhase"]) {
        CABasicAnimation *dashAnimation;
        dashAnimation = [CABasicAnimation animationWithKeyPath:@"lineDashPhase"];
        [dashAnimation setFromValue:[NSNumber numberWithFloat:0.0f]];
        [dashAnimation setToValue:[NSNumber numberWithFloat:15.0f]];
        [dashAnimation setDuration:0.5f];
        [dashAnimation setRepeatCount:HUGE_VALF];
        [_marque addAnimation:dashAnimation forKey:@"linePhase"];
    }
    
    _marque.bounds = CGRectMake(frame.origin.x, frame.origin.y, 0, 0);
    _marque.position = CGPointMake(frame.origin.x + videoPreviewView.frame.origin.x, frame.origin.y + videoPreviewView.frame.origin.y);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, frame);
    [_marque setPath:path];
    CGPathRelease(path);
    
    _marque.hidden = NO;
}

#pragma mark - Still Image Capturing Code

- (void)addStillImageOutput
{
    [self setStillImageOutput:[[AVCaptureStillImageOutput alloc] init]];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    [[self stillImageOutput] setOutputSettings:outputSettings];
    
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in [[self stillImageOutput] connections]) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
    [CaptureSession addOutput:[self stillImageOutput]];
}

- (void)captureStillImage
{
	AVCaptureConnection *videoConnection = nil;
	for (AVCaptureConnection *connection in [[self stillImageOutput] connections]) {
		for (AVCaptureInputPort *port in [connection inputPorts]) {
			if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
				videoConnection = connection;
				break;
			}
		}
		if (videoConnection) {
            break;
        }
	}
    
	NSLog(@"about to request a capture from: %@", [self stillImageOutput]);
	[[self stillImageOutput] captureStillImageAsynchronouslyFromConnection:videoConnection
                                                         completionHandler:^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
                                                             CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
                                                             if (exifAttachments) {
                                                                 NSLog(@"attachements: %@", exifAttachments);
                                                             } else {
                                                                 NSLog(@"no attachments");
                                                             }
                                                             NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
                                                             UIImage *image = [[UIImage alloc] initWithData:imageData];
                                                             NSLog(@"hmmm ::::: %i",[imageData length]);
                                                             
                                                             [self setStillImage:image];
//                                                             [image release];
                                                             [[NSNotificationCenter defaultCenter] postNotificationName:kImageCapturedSuccessfully object:nil];
                                                         }];
}

- (void)captureStillImageWithOverlay:(UIImage*)overlay
{
	AVCaptureConnection *videoConnection = nil;
	for (AVCaptureConnection *connection in [[self stillImageOutput] connections]) {
		for (AVCaptureInputPort *port in [connection inputPorts]) {
			if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
				videoConnection = connection;
				break;
			}
		}
		if (videoConnection) {
            break;
        }
	}
    
	NSLog(@"about to request a capture from: %@", [self stillImageOutput]);
	[[self stillImageOutput] captureStillImageAsynchronouslyFromConnection:videoConnection
                                                         completionHandler:^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
                                                             CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
                                                             if (exifAttachments) {
                                                                 NSLog(@"attachements: %@", exifAttachments);
                                                             } else {
                                                                 NSLog(@"no attachments");
                                                             }
                                                             NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
                                                             UIImage *image = [[UIImage alloc] initWithData:imageData];
                                                             
//                                                             CGSize imageSize = [image size];
//                                                             CGSize overlaySize = [overlay size];
//                                                             
//                                                             UIGraphicsBeginImageContext(imageSize);
//                                                             
//                                                             [image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
//                                                             
//                                                             CGFloat xScaleFactor = imageSize.width / 320;
//                                                             CGFloat yScaleFactor = imageSize.height / 480;
//                                                             
////                                                             [overlay drawInRect:CGRectMake(30 * xScaleFactor, 100 * yScaleFactor, overlaySize.width * xScaleFactor, overlaySize.height * yScaleFactor)]; // rect used in AROverlayViewController was (30,100,260,200)
//                                                         [overlay drawInRect:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, overlaySize.width * xScaleFactor, overlaySize.height * yScaleFactor )];
//                                                             UIImage *combinedImage = UIGraphicsGetImageFromCurrentImageContext();
                                                             
//                                                             UIImage *combinedImage = [self addOverlayToBaseImage:image overlay:overlay];
                                                             UIGraphicsEndImageContext();

//                                                             UIImage *combinedImage = [self addOverlayToBaseImage:image];
                                                               UIImage *combinedImage = [self addOverlayToBaseImage:image overlay:overlay];
                                                             
                                                             NSLog(@"width :::: %f",image.size.width);
                                                             NSLog(@"height :::: %f",image.size.height);
                                                             
                                                             [self setStillImage:combinedImage];
                                                             
//                                                             UIGraphicsEndImageContext();
                                                             
//                                                             [image release];
                                                             
                                                             NSData *imageData2 = UIImagePNGRepresentation(combinedImage);
                                                             NSLog(@"Data ::::: %i",[imageData2 length]);
                                                             UIImageWriteToSavedPhotosAlbum(combinedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
                                                             
                                                             NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                                   UIImagePNGRepresentation(combinedImage), @"imageData", nil];

                                                             [[NSNotificationCenter defaultCenter] postNotificationName:kImageCapturedSuccessfully object:dict];
                                                             
//                                                             [[NSNotificationCenter defaultCenter] postNotificationName:kImageCapturedSuccessfully object:nil];
                                                         }];
}

#pragma mark - Save Image to Library

- (void)saveImageToPhotoAlbum
{
    NSData *imageData = UIImagePNGRepresentation(stillImage);
    NSLog(@"Data ::::: %i",[imageData length]);
    UIImageWriteToSavedPhotosAlbum([self stillImage], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}


- (UIImage*)dumpOverlayViewToImage //将cameraOverlayView转为图片
{
	CGSize imageSize = self.imageView.bounds.size;
    
    
	UIGraphicsBeginImageContext(imageSize);
	[self.imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	return viewImage;
}
- (UIImage*)addOverlayToBaseImage:(UIImage*)baseImage
{
	UIImage *overlayImage = [self dumpOverlayViewToImage];
	CGPoint topCorner = CGPointMake(0, 0);
	CGSize targetSize = CGSizeMake(320, 480);
	CGRect scaledRect = CGRectZero;
	
	CGFloat scaledX = 480 * baseImage.size.width / baseImage.size.height;
	CGFloat offsetX = (scaledX - 320) / -2;
    
	scaledRect.origin = CGPointMake(offsetX, 0.0);
	scaledRect.size.width  = scaledX;
	scaledRect.size.height = 480;
	
	UIGraphicsBeginImageContext(targetSize);
	[baseImage drawInRect:scaledRect];
	[overlayImage drawAtPoint:topCorner];
	UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return result;
}

- (UIImage*)addOverlayToBaseImage:(UIImage*)baseImage overlay:(UIImage*)overlayImage{
    
//    UIImage *overlayImage = [UIImage imageNamed:@"img.png"];
    CGPoint topCorner = CGPointMake(imageView.frame.origin.x, imageView.frame.origin.y);
    CGSize targetSize = CGSizeMake(480, 640);
    CGRect scaledRect = CGRectZero;
    
    CGFloat scaledX = 640 * baseImage.size.width / baseImage.size.height;
    CGFloat offsetX = (scaledX - 480) / -2;
    
    scaledRect.origin = CGPointMake(offsetX, 0.0);
    scaledRect.size.width  = scaledX;
    scaledRect.size.height = 640;
    
    UIGraphicsBeginImageContext(targetSize);
    [baseImage drawInRect:scaledRect];
    [overlayImage drawAtPoint:topCorner];
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();    
    
    return result;  
}

-(void)saveImageToDocumentsDirectory:(NSNotification *) notification{
    
    NSString *savedImagePath = [DOCUMENTS_FOLDER stringByAppendingPathComponent:@"snap.png" ];
    [snapData writeToFile:savedImagePath atomically:NO];
    
    snapUrl = [[NSURL alloc] initFileURLWithPath:savedImagePath];
    
    [self performSegueWithIdentifier:@"SToShareScreen" sender:self];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Image couldn't be saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
//        [alert release];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Image saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [self performSegueWithIdentifier:@"SToShareScreen" sender:self];
//        [[self scanningLabel] setHidden:YES];
    }
}


- (IBAction)snap:(id)sender {
    [self captureStillImageWithOverlay:imageView.image];
//    [self saveImageToPhotoAlbum];
//    stillImage = [self addOverlayToBaseImage:[UIImage imageNamed:@"Illustration+of+a+gray+shirt.png"] overlay:transformedImage];
//    imageView.image = stillImage;
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
//                          UIImagePNGRepresentation(stillImage), @"imageData", nil];
    snapData = UIImagePNGRepresentation(stillImage);
//
    [[NSNotificationCenter defaultCenter] postNotificationName:kImageCapturedSuccessfully object:nil];
//    [self saveImageToPhotoAlbum];
    
}

- (IBAction)takeOverlay:(id)sender {
    CustomCameraViewController *viewController = [[CustomCameraViewController alloc] initWithNibName:nil bundle:nil];
    [self presentModalViewController:viewController animated:YES];
    viewController.delegate = self;
}

- (void)customCameraDidCancelled
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)customCameraDidFinished:(UIImage *)image
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Photo Taken!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"SToShareScreen"]){
        BKShareScreenViewController *vc = [segue destinationViewController];
        vc.snappedPic = snapUrl;
    }
}

-(void)initLocation{
    [self startStandardUpdates];
}

- (void)startStandardUpdates {
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    locationManager.distanceFilter = kCLDistanceFilterNone;
//    [locationManager startUpdatingLocation];
    [locationManager startUpdatingHeading];
}

-(void)processLocation:(CLLocation*)loc{
//    CLLocationDistance distance = [LocationUtil distanceBetweenCoordinate:loc.coordinate andCoordinate:toLocation];
}

#pragma mark - Delegate Methods (CLLocationManagerDelegate)

#pragma mark For IOS_6
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)location{
    [self processLocation:[location lastObject]];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    [self processLocation:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    NSLog(@"%f",newHeading.trueHeading);
    float oldRad =  -manager.heading.trueHeading * M_PI / 180.0f;
	float newRad =  -newHeading.trueHeading * M_PI / 180.0f;
	CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    theAnimation.fromValue = [NSNumber numberWithFloat:oldRad];
    theAnimation.toValue=[NSNumber numberWithFloat:newRad];
    theAnimation.duration = 0.5f;
    [radarView.layer addAnimation:theAnimation forKey:@"animateMyRotation"];
    radarView.transform = CGAffineTransformMakeRotation(newRad);
}

-(void)putRadarBlipAt:(int)degrees{
//    UIImage *blipImage =z [UIImage imageNamed:@"RadarDot@2x.png"];
}


#pragma mark - UI Methods

-(void)applyUIChanges{
    [self.view setBackgroundColor:[ColorUtils colorFromHexString:@"#F8F7E7"]];
    
    UIButton *leftButton = [UIUtils getHomeBackBarItem];
    [leftButton addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem ;
}

-(void)goBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}


@end