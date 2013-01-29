//
//  CongratulationsViewController.m
//  Bonus Kent
//
//  Created by Ali Asghar on 12/12/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import "CongratulationsViewController.h"
#import "UIUtils.h"
#import "ColorUtils.h"

@interface CongratulationsViewController ()

@end

@implementation CongratulationsViewController

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
    [self applyUIChanges];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Methods

-(void)applyUIChanges{
    [self.view setBackgroundColor:[ColorUtils colorFromHexString:@"#F8F7E7"]];
    
    UIButton *leftButton = [UIUtils getTopLeftBarItem:@"   Back"];
    [leftButton addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem ;
}

-(void)goBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
