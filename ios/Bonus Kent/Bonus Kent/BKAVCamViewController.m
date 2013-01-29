//
//  BKAVCamViewController.m
//  Bonus Kent
//
//  Created by Ali Asghar on 11/28/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import "BKAVCamViewController.h"
#import <AVFoundation/AVFoundation.h>

@implementation BKAVCamViewController
@synthesize videoPreviewView;

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"captureManager.videoInput.device.focusMode"];
}

- (void)viewDidLoad
{
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
	session.sessionPreset = AVCaptureSessionPresetMedium;
    
	CALayer *viewLayer = self.videoPreviewView.layer;
	NSLog(@"viewLayer = %@", viewLayer);
    
	AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    
	captureVideoPreviewLayer.frame = self.videoPreviewView.bounds;
	[self.videoPreviewView.layer addSublayer:captureVideoPreviewLayer];
    
	AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
	NSError *error = nil;
	AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
	if (!input) {
		// Handle the error appropriately.
		NSLog(@"ERROR: trying to open camera: %@", error);
	}
    if (error != nil) {
        NSLog(@"ERROR : %@",error);
    }
	[session addInput:input];
    
	[session startRunning];
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end