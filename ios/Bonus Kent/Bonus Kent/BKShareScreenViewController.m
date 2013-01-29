//
//  BKShareScreenViewController.m
//  Bonus Kent
//
//  Created by Ali Asghar on 11/30/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import "BKShareScreenViewController.h"
#import <Social/Social.h>
#import "ColorUtils.h"
#import "UIUtils.h"
#import "Constants.h"
#import "SMWebRequest.h"

#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

@interface BKShareScreenViewController ()

@end

@implementation BKShareScreenViewController

@synthesize fbProfilePic;
@synthesize fbUserNameLbl;
@synthesize snappedPic;
@synthesize snappedPicUrl;
@synthesize requestConnection;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"save Image URL%@",snappedPic);
    NSString* path = [DOCUMENTS_FOLDER stringByAppendingPathComponent:
                      @"snap.png" ];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    
    [snappedPicUrl setImage:image];
    [self applyUIChanges];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setFbProfilePic:nil];
    [self setFbUserNameLbl:nil];
    [self setSnappedPicUrl:nil];
    [super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (FBSession.activeSession.isOpen) {
        [self populateUserDetails];
//        [self getFriendsList];
    }
}

- (void)populateUserDetails
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 self.fbUserNameLbl.text = user.name;
                 self.fbProfilePic.profileID = user.id;
             }
         }];
    }
}



- (IBAction)fbShareButtonClicked:(id)sender {
    // We're going to assume you have a UIImage named image_ stored somewhere.
    
    FBRequestConnection *connection = [[FBRequestConnection alloc] init];
    
    // First request uploads the photo.
    FBRequest *request1 = [FBRequest
                           requestForUploadPhoto:snappedPicUrl.image];
    
    [connection addRequest:request1
         completionHandler:
     ^(FBRequestConnection *connection, id result, NSError *error) {
         if (!error) {
         }
     }
            batchEntryName:@"photopost"
     ];
     [connection start];
    [self updateActivity];
}

- (IBAction)shareAndWinBtnClicked:(id)sender {
    /*
	 turning the image into a NSData object
	 getting the image back out of the UIImageView
	 setting the quality to 90
     */
	NSData *imageData = UIImageJPEGRepresentation(snappedPicUrl.image, 90);
	// setting up the URL to post to
	NSString *urlString = [NSString stringWithFormat:@"%@uploadImage.php",SERVER_URL];
	
	// setting up the request object now
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
	
	/*
	 add some header info now
	 we always need a boundary when we post a file
	 also we need to set the content type
	 
	 You might want to generate a random boundary.. this is just the same
	 as my output from wireshark on a valid html post
     */
	NSString *boundary = @"---------------------------14737809831466499882746641449";
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
	[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
	
	/*
	 now lets create the body of the post
     */
	NSMutableData *body = [NSMutableData data];
	[body appendData:[[NSString stringWithFormat:@"rn--%@rn",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\"ipodfile.jpg\"rn" dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[@"Content-Type: application/octet-streamrnrn" dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[NSData dataWithData:imageData]];
	[body appendData:[[NSString stringWithFormat:@"rn--%@--rn",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	// setting the body of the post to the reqeust
	[request setHTTPBody:body];
	
	// now lets make the connection to the web
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	
	NSLog(@"%@",returnString);
    [self performSegueWithIdentifier:@"SToCongratsView" sender:self];
}

#pragma mark - UI Methods

-(void)applyUIChanges{
    [self.view setBackgroundColor:[ColorUtils colorFromHexString:@"#F8F7E7"]];
    
    UIButton *leftButton = [UIUtils getTopLeftBarItem:@"  Camera"];
    [leftButton addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem ;
}

-(void)goBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - webservice calls

-(void)updateActivity{
    NSString *post = @"congratsScreenEntry=";
    post = [post stringByAppendingFormat:@"{\"id\":null,\"user_id\":%@,\"campaign_id\":30,\"activity\":\"share on facebook\", \"score\":10}",@"1"];
    
    NSLog(@"post = %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSString *url = SERVER_URL;
    url = [url stringByAppendingString:@"jsonCongratsScreenEntry.php"];
    
    NSLog(@"url = %@",url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc ]init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    SMWebRequest *loginRequest = [SMWebRequest requestWithURLRequest:request delegate:nil context:NULL];
    [loginRequest addTarget:self action:@selector(requestComplete:) forRequestEvents:SMWebRequestEventComplete];
    [loginRequest start];
    
}

-(void)requestComplete:(NSData *)data{
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"data :::: %@",response);
}


@end
