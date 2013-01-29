//
//  CHViewController.h
//  CHAVF
//
//  Created by Cole Joplin on 3/2/12.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "HughesPreviewView.h"
#import "HughesVideoProcessor.h"

@interface CHViewController : UIViewController <HughesVideoProcessorDelegate> {
    HughesVideoProcessor *videoProcessor;
    HughesPreviewView *oglView;
    UIBackgroundTaskIdentifier backgroundRecordingID;    
    dispatch_queue_t progressQueue;
}
@property (strong, nonatomic) IBOutlet UIButton *recordButton;
@property (strong, nonatomic) IBOutlet UIView *previewView;

- (IBAction)toggleRecording:(id)sender;

@end
