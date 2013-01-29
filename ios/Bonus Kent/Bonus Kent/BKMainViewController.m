//
//  BKMainViewController.m
//  Bonus Kent
//
//  Created by Ali Asghar on 11/24/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import "BKMainViewController.h"
#import "ColorUtils.h"

@interface BKMainViewController ()

@end

@implementation BKMainViewController

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
}

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [self.navigationItem setHidesBackButton:YES];
    
    [self.view setBackgroundColor:[ColorUtils colorFromHexString:@"#F8F7E7"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)campaignBtnClicked:(id)sender {
    [self performSegueWithIdentifier:@"SToCampaignList" sender:self];
}

- (IBAction)contestsBtnClicked:(id)sender {
    [self performSegueWithIdentifier:@"SToContestsScreen" sender:self];
}

- (IBAction)snap:(id)sender {
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

@end
