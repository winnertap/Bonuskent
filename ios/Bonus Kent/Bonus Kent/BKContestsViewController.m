//
//  BKContestsViewController.m
//  Bonus Kent
//
//  Created by Ali Asghar on 12/13/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import "BKContestsViewController.h"
#import "BKContestsTableCell.h"
#import "Campaign.h"
#import "SMWebRequest.h"
#import "SBJson.h"
#import "Constants.h"
#import "ColorUtils.h"
#import "UIUtils.h"

@interface BKContestsViewController ()

@end

@implementation BKContestsViewController

@synthesize campaigns;
@synthesize tableView;
@synthesize profileImage;

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
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [self.navigationItem setHidesBackButton:NO];
    
    [self populateUserDetails];
    [self applyUIChanges];
    if([campaigns count] <= 0){
        [self getCampaigns];
    }else{
        items = [campaigns mutableCopy];
        [tableView reloadData];
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 	return [items count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableViewLocal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"contestTableCell";
    
    BKContestsTableCell *cell = (BKContestsTableCell*)[tableViewLocal dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BKContestsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Campaign *campaign = [items objectAtIndex:indexPath.row];
    cell.campaignName.text = campaign.name;
    cell.campaignImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bonuskent.com/admin/uploads/%@",campaign.img]]]];
    cell.points.text = [NSString stringWithFormat:@"%i pts",((indexPath.row+1) * 10)];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"50_transparent.png"]];
    view.opaque = YES;
    cell.backgroundView = view;
    
    return cell;
}

-(void)tableView:(UITableView *)tableview didSelectRowAtIndexPath :(NSIndexPath *)indexPath {
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(BKContestsTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - webservice calls

-(void)getCampaigns{
    
    NSString *url = SERVER_URL;
    url = [url stringByAppendingString:@"jsonCompaignInfo.php"];
    
    NSLog(@"url = %@",url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc ]init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    SMWebRequest *loginRequest = [SMWebRequest requestWithURLRequest:request delegate:nil context:NULL];
    [loginRequest addTarget:self action:@selector(requestComplete:) forRequestEvents:SMWebRequestEventComplete];
    [loginRequest start];
    
}

-(void)requestComplete:(NSData *)data{
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"campaign list :::: %@",response);
    items = [[NSMutableArray alloc]init];
    if([response length] > 0){
        //        [allCampaigns removeAllObjects];
        // Create SBJSON object to parse JSON
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        
        // parse the JSON string into an object - assuming json_string is a NSString of JSON data
        NSArray *campaignArr = [parser objectWithString:response error:nil];
        for (NSDictionary *campaign in campaignArr) {
            // You can retrieve individual values using objectForKey on the status NSDictionary
            // This will print the tweet and username to the console
            Campaign *wrapper = [[Campaign alloc]init];
            wrapper.name = [campaign objectForKey:@"name"];
            wrapper.desc = [campaign objectForKey:@"description"];
            wrapper.img = [campaign objectForKey:@"image_path"];
            
            [items addObject:wrapper];
        }
        [tableView reloadData];
    }
}

#pragma mark - Facebook Functions

- (void)populateUserDetails
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 self.profileImage.profileID = user.id;
             }
         }];
    }
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
    
    
    [leftButton addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem ;
}

-(void)goBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [self setProfileImage:nil];
    [super viewDidUnload];
}
@end
