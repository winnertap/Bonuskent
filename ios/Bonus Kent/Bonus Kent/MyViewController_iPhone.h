//
//  MyViewController_iPhone.h
//  Bonus Kent
//
//  Created by Ali Asghar on 11/29/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>

#import <AssetsLibrary/AssetsLibrary.h>		//<<Can delete if not storing videos to the photo library.  Delete the assetslibrary framework too requires this)


#import "CustomCameraViewController.h"

#define CAPTURE_FRAMES_PER_SECOND		20
#define kImageCapturedSuccessfully @"imageCapturedSuccessfully"

@interface MyViewController_iPhone : UIViewController
<AVCaptureFileOutputRecordingDelegate,UIGestureRecognizerDelegate,CLLocationManagerDelegate,CustomCameraDelegate>
{
	BOOL WeAreRecording;
	
	AVCaptureSession *CaptureSession;
	AVCaptureMovieFileOutput *MovieFileOutput;
	AVCaptureDeviceInput *VideoInputDevice;
    
    CGFloat _lastScale;
    CGFloat _lastRotation;
    CGFloat _firstX;
    CGFloat _firstY;
    UIImage *transformedImage;
    CAShapeLayer *_marque;
    
    NSURL* snapUrl;
    NSData *snapData;
    
    CLLocationManager *locationManager;
}

@property (retain) AVCaptureVideoPreviewLayer *PreviewLayer;

- (void) CameraSetOutputProperties;
- (AVCaptureDevice *) CameraWithPosition:(AVCaptureDevicePosition) Position;
- (IBAction)StartStopButtonPressed:(id)sender;
- (IBAction)CameraToggleButtonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *videoPreviewView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (retain) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, retain) UIImage *stillImage;

@property (strong, nonatomic) IBOutlet UIImageView *radarView;
@property (strong, nonatomic) IBOutlet UIView *radarOverlay;

- (void)addStillImageOutput;
- (void)captureStillImage;

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
- (IBAction)snap:(id)sender;
- (IBAction)takeOverlay:(id)sender;

@end