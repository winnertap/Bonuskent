//
//  CustomCameraViewController.h
//  CameraOverlayView
//
//  Created by B.H.Liu appublisher on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APFullScreenCameraPicker.h"
#import "PhotoPreview.h"

@protocol CustomCameraDelegate <NSObject>

- (void)customCameraDidFinished:(UIImage*)image;
- (void)customCameraDidCancelled;

@end

@interface CustomCameraViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,APFullScreenCameraPickerDelegate,PhotoPreviewDelegate, UIGestureRecognizerDelegate>
{
    APFullScreenCameraPicker *_camera;
    PhotoPreview *_preView;
    UIView *_overlayView;
    BOOL  _cameraMode;
    CGPoint _startTouchPosition;
}

@property (nonatomic, strong) APFullScreenCameraPicker *camera;
@property (nonatomic,strong) PhotoPreview *preView;
@property (nonatomic, strong) UIView *overlayView;
@property (assign) BOOL cameraMode;
@property (nonatomic) CGPoint startTouchPosition;
@property (nonatomic,unsafe_unretained) id<CustomCameraDelegate>delegate;

- (void)initCamera;
//- (void)toggleAugmentedReality;
- (void)startCamera;
- (void)onSingleTap:(UITouch*)touch;
- (void)onDoubleTap:(UITouch*)touch;
- (void)onSwipeUp;
- (void)onSwipeDown;
- (void)onSwipeLeft;
- (void)onSwipeRight;


@end
