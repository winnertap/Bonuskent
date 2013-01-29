//
//  BKViewController.m
//  Bonus Kent
//
//  Created by Ali Asghar on 11/23/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import "BKViewController.h"
#import "BKAppDelegate.h"
#import "ColorUtils.h"
#import "SMWebRequest.h"
#import "Constants.h"
#import <Social/Social.h>

@interface BKViewController ()

@end

@implementation BKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [self.navigationItem setHidesBackButton:YES];
    
        
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             
             if (!error) {
                 [self userRegistrationRequest:[NSString stringWithFormat:@"{\"username\":\"%@\",\"firstname\":\"%@\",\"lastname\":\"%@\",\"email\":\"%@\",\"password\":\"1234psw\",\"role\":\"enduser\",\"date_created\":\"\",\"date_updated\":\"\",\"gender\":\"\",\"date_of_birth\":\"%@\",\"education\":\"\",\"city\":\"%@\",\"network\":\"Facebook\",\"status\":\"active\",\"f_id\":\"%@\"}",user.username,user.first_name,user.last_name,[user objectForKey:@"email"],user.birthday,[user.location objectForKey:@"name"],user.id]];
             }
         }];
        
        [self performSegueWithIdentifier:@"SToMain" sender:self];
    }
    
    
	// Do any additional setup after loading the view, typically from a nib.
    [self applyUIChanges];
}

-(void)applyUIChanges{
    [self.view setBackgroundColor:[ColorUtils colorFromHexString:@"#F8F7E7"]];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header.png"] forBarMetrics:UIBarMetricsDefault];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fbLogin:(id)sender {
    BKAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
}

#pragma mark - webservice calls

-(void)userRegistrationRequest:(NSString*)profile{
    
    NSString *post = @"userProfileJson=";
    post = [post stringByAppendingString:profile];
    
    NSLog(@"post = %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSString *url = SERVER_URL;
    url = [url stringByAppendingString:@"jsonUserProfileEntry.php"];
    
    NSLog(@"url = %@",url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc ]init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSLog(@"request = %@",request.description);
    SMWebRequest *loginRequest = [SMWebRequest requestWithURLRequest:request delegate:nil context:NULL];
    [loginRequest addTarget:self action:@selector(requestComplete:) forRequestEvents:SMWebRequestEventComplete];
    [loginRequest start];
    
}

-(void)requestComplete:(NSData *)data{
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"data :::: %@",response);
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    if([response length] > 0 && [f numberFromString:response] != nil){
        NSUserDefaults *dataStore = [NSUserDefaults standardUserDefaults];
        [dataStore setValue:response forKey:@"userId"];
        [dataStore synchronize];
    }
}

@end
