//
//  APFullScreenCameraPicker.m
//  CameraOverlayView
//
//  Created by B.H.Liu appublisher on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "APFullScreenCameraPicker.h"

#define CAMERA_TRANSFORM_X 1
#define CAMERA_TRANSFORM_Y 1.22412

@implementation APFullScreenCameraPicker
@synthesize APDelegate=_APDelegate;

- (id)init 
{
    if (self = [super init]) 
    {
        self.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.showsCameraControls = NO;
        self.navigationBarHidden = YES;
        self.toolbarHidden = YES;
        self.wantsFullScreenLayout = YES;
		self.cameraViewTransform = CGAffineTransformScale(self.cameraViewTransform, CAMERA_TRANSFORM_X, CAMERA_TRANSFORM_Y);  
  		self.delegate = self;
				
    }
    return self;
}

- (void)dealloc
{
    self.APDelegate = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)canBecomeFirstResponder
{ 
    return YES; 
}

+ (BOOL)isAvailable 
{
    return [self isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (void)displayModalWithController:(UIViewController*)controller animated:(BOOL)animated 
{
    [controller presentModalViewController:self animated:YES];
}

- (void)takePicture 
{
    if ([self.APDelegate respondsToSelector:@selector(cameraWillTakePicture)]) 
    {
		[self.APDelegate performSelector:@selector(cameraWillTakePicture) withObject:self];
	}
    [super takePicture];
}

- (UIImage*)dumpOverlayViewToImage //将cameraOverlayView转为图片
{
	CGSize imageSize = self.cameraOverlayView.bounds.size;
	UIGraphicsBeginImageContext(imageSize);
	[self.cameraOverlayView.layer renderInContext:UIGraphicsGetCurrentContext()];
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info 
{
	UIImage *baseImage = [info objectForKey:UIImagePickerControllerOriginalImage];
	if (baseImage == nil) return;
    
	// save composite
	UIImage *compositeImage = [self addOverlayToBaseImage:baseImage];
        
	UIImageWriteToSavedPhotosAlbum(compositeImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    if ([self.APDelegate respondsToSelector:@selector(cameraDidTakePicture:)]) 
    {
		[self.APDelegate cameraDidTakePicture:compositeImage];
	}
    
}

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError *)error contextInfo:(NSDictionary*)info 
{
    
}

- (void)writeImageToDocuments:(UIImage*)image 
{
	NSData *png = UIImagePNGRepresentation(image);
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSError *error = nil;
    [png writeToFile:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"image_%f.png",[[NSDate date] timeIntervalSince1970]]] options:NSAtomicWrite error:&error];
}

//********** MOTION BEGAN **********
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
	if (motion == UIEventSubtypeMotionShake)
	{
		NSLog(@"shake");
	}
    self.cameraDevice = !self.cameraDevice;
}

@end
