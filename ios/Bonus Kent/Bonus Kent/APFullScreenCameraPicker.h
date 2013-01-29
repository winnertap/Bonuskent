//
//  APFullScreenCameraPicker.h
//  CameraOverlayView
//
//  Created by B.H.Liu appublisher on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <QuartzCore/QuartzCore.h>

@class APFullScreenCameraPicker;

@protocol APFullScreenCameraPickerDelegate <NSObject>
- (void)cameraWillTakePicture;
- (void)cameraDidTakePicture:(UIImage*)photoTaken;

@end

@interface APFullScreenCameraPicker : UIImagePickerController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,unsafe_unretained) id<APFullScreenCameraPickerDelegate>APDelegate;

+ (BOOL)isAvailable;
- (void)displayModalWithController:(UIViewController*)controller animated:(BOOL)animated;
- (void)takePicture;
- (void)writeImageToDocuments:(UIImage*)image;


@end
