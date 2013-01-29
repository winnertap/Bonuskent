//
//  PhotoPreview.m
//  CameraOverlayView
//
//  Created by B.H.Liu appublisher on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PhotoPreview.h"
#import <QuartzCore/QuartzCore.h>

#define THUMBNAIL_WIDTH 50
#define THUMBNAIL_HEIGHT 75
#define THUMBNAIL_FRAME_WIDTH 50
#define THUMBNAIL_FRAME_HEIGHT 75
#define THUMBNAIL_FRAME_OFFSET_X 0
#define THUMBNAIL_FRAME_OFFSET_Y 0

@implementation PhotoPreview
@synthesize image=_image;
@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _thumbnailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _thumbnailButton.frame = CGRectMake(self.frame.size.width - THUMBNAIL_FRAME_WIDTH - 10, self.frame.size.height - THUMBNAIL_FRAME_HEIGHT - 10, THUMBNAIL_FRAME_WIDTH, THUMBNAIL_FRAME_HEIGHT);
        [_thumbnailButton addTarget:self action:@selector(thumbnailTapped:) forControlEvents:UIControlEventTouchUpInside];
        _thumbnailButton.hidden = YES;
        [self addSubview:_thumbnailButton];
        
        _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageButton.frame = CGRectMake(0, 0, 320, 480);
        [_imageButton addTarget:self action:@selector(imageTapped:) forControlEvents:UIControlEventTouchUpInside];
        _imageButton.hidden = NO;
        _imageButton.alpha = 0.0f;
        [self addSubview:_imageButton];
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
}

- (void)thumbnailTapped:(id)sender 
{	
	[self hideThumbnail];
    
	// fade in full screen image
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.66f];
    _imageButton.alpha = 1.0f;	
    [UIView commitAnimations];	
    
	[self bringSubviewToFront:_imageButton];
    
    if ([self.delegate respondsToSelector:@selector(thumbnailTapped)]) 
    {
		[self.delegate thumbnailTapped];
	}
}

- (void)imageTapped:(id)sender 
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: nil																													delegate: self 
                                                    cancelButtonTitle: @"Cancel" 
                                               destructiveButtonTitle: NULL 
                                                    otherButtonTitles: @"Use", @"Retake", NULL];
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;																							
	[actionSheet showInView:self];
}


- (void)hidePreviewImage 
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.66f];
    _imageButton.alpha = 0.0f;	
    [UIView commitAnimations];	
}

- (UIImage*)generateThumbnail:(UIImage*)source
{
	CGRect scaledRect = CGRectZero;
	scaledRect.size.width  = THUMBNAIL_WIDTH;
	scaledRect.size.height = THUMBNAIL_HEIGHT;
	scaledRect.origin = CGPointMake(THUMBNAIL_FRAME_OFFSET_X, THUMBNAIL_FRAME_OFFSET_Y);
	CGSize targetSize = CGSizeMake(THUMBNAIL_FRAME_WIDTH, THUMBNAIL_FRAME_HEIGHT);	
	
	UIGraphicsBeginImageContext(targetSize);
	[source drawInRect:scaledRect];
	
	// draw a simple thumbnail border
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 0.07f); 
    CGContextStrokeRectWithWidth(context, scaledRect, 5.0f);	
	
	UIImage* thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();	
	return thumbnailImage;
}

- (void)showThumbnail:(UIImage *)newImage 
{
	[_thumbnailButton setImage:newImage forState:UIControlStateNormal];
	_thumbnailButton.alpha = 0.0f;
	_thumbnailButton.hidden = NO;	
    
    CGAffineTransform preTransform = CGAffineTransformMakeScale(0.1f, 0.1f);
    _thumbnailButton.transform = preTransform;
    
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationDuration:0.3f];
    _thumbnailButton.alpha = 1.0f;
	
	CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    _thumbnailButton.transform = transform;
	
    [UIView commitAnimations];	
}

- (void)generateAndShowThumbnail:(UIImage*)newImage
{
	if (newImage != nil && newImage != self.image)
    {
		self.image = newImage;
		[_imageButton setImage:newImage forState:UIControlStateNormal];
	}
    
	UIImage *thumb = [self generateThumbnail:self.image];
	[self showThumbnail:thumb];
}

- (void)hideThumbnail 
{
	if (_thumbnailButton.hidden || _thumbnailButton.alpha == 0.0f) return;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationDuration:0.3f];
    _thumbnailButton.alpha = 0.0f;
	
	CGAffineTransform transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    _thumbnailButton.transform = transform;
    
    [UIView commitAnimations];	
}

- (void)hideThumbnailAfterDelay:(CGFloat)delay 
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	[self performSelector:@selector(hideThumbnail) withObject:self afterDelay:delay];
}

#pragma mark-
#pragma mark- UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
	switch (buttonIndex) {
		case 0:
			NSLog(@"use photo");
            if ([self.delegate respondsToSelector:@selector(imageForUse:)]) 
            {
				[self.delegate imageForUse:self.image];
			}
			break;
		case 1:
			[self hidePreviewImage];
			if ([self.delegate respondsToSelector:@selector(previewClosed)]) 
            {
				[self.delegate performSelector:@selector(previewClosed) withObject:self];
			}
			break;
		default:
			break;
	}
}


@end
