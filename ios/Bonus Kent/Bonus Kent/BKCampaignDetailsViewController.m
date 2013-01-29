//
//  BKCampaignDetailsViewController.m
//  Bonus Kent
//
//  Created by Ali Asghar on 11/24/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import "BKCampaignDetailsViewController.h"
#import "ColorUtils.h"
#import "UIUtils.h"

@interface BKCampaignDetailsViewController ()

@end

@implementation BKCampaignDetailsViewController
@synthesize campaign;
@synthesize promoImage;
@synthesize descriptionText;

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
    promoImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bonuskent.com/admin/uploads/%@",campaign.img]]]];
    descriptionText.text = campaign.desc;
    
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
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_03.png"] forState:UIControlStateNormal];
    [leftButton setTitle:@"  Campaigns" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        leftButton.frame = CGRectMake(0.0f, 0.0f, 105.0f, 45.0f);
    }else{
        leftButton.frame = CGRectMake(0.0f, 0.0f, 90.0f, 35.0f);
        leftButton.titleLabel.font =[UIFont boldSystemFontOfSize:12.0];
    }
    [leftButton titleEdgeInsets];

    [leftButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem ;
}

#pragma mark - Action Method

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
