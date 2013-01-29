//
//  BKCampaignListViewController.m
//  Bonus Kent
//
//  Created by Ali Asghar on 11/24/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import "BKCampaignListViewController.h"
#import "BKCampaignTableCell.h"
#import "BKCampaignDetailsViewController.h"
#import "BKCampaignMapViewController.h"
#import "ColorUtils.h"
#import "LocationUtil.h"
#import "UIUtils.h"
#import "SMWebRequest.h"
#import "Constants.h"
#import "SBJson.h"
#import "BKContestsViewController.h"

@interface BKCampaignListViewController ()

@end

@implementation BKCampaignListViewController

@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
      [self applyUIChanges];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [self.navigationItem setHidesBackButton:NO];
    
    items = [[NSMutableArray alloc]init];
    
    [self getCampaigns];
    [self initLocation];
  
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
    static NSString *CellIdentifier = @"campaignTableCell";
    
    BKCampaignTableCell *cell = (BKCampaignTableCell*)[tableViewLocal dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BKCampaignTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Campaign *campaign = [items objectAtIndex:indexPath.row];
    cell.title.text = campaign.name;
    cell.campaignImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bonuskent.com/admin/uploads/%@",campaign.img]]]];//campaign.img;
    cell.distance.text = campaign.distance;
    
    if ([campaign.withinRange isEqualToString:@"Y"]) {
        [cell.locationMarkerImage setImage:[UIImage imageNamed:@"ttttt_09.png"]];
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"50_transparent.png"]];
    view.opaque = YES;
    cell.backgroundView = view;

    return cell;
}

-(void)tableView:(UITableView *)tableview didSelectRowAtIndexPath :(NSIndexPath *)indexPath {
    selectedCampaign = [items objectAtIndex:indexPath.row];
    if([selectedCampaign.withinRange isEqualToString:@"N"]){
        [self performSegueWithIdentifier:@"SToMap" sender:self];
    }else{
        [self performSegueWithIdentifier:@"SToCampaignDetails" sender:self];
    }
 
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(BKCampaignTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    cell.value.font = [UIFont fontWithName:@"Georgia-Bold" size:18.0];
}

#pragma mark - Segue Methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"SToCampaignDetails"]){
        BKCampaignDetailsViewController *vc = [segue destinationViewController];
        vc.campaign = selectedCampaign;
    }
    if([[segue identifier] isEqualToString:@"SToMap"]){
        BKCampaignMapViewController *vc = [segue destinationViewController];
        vc.campaigns = items;
    }
    if([[segue identifier] isEqualToString:@"SToContests"]){
        BKContestsViewController *vc = [segue destinationViewController];
        vc.campaigns = allCampaigns;
    }
}

#pragma mark - UI Methods

-(void)applyUIChanges{
    [self.view setBackgroundColor:[ColorUtils colorFromHexString:@"#F8F7E7"]];

    
    UIButton *leftButton = [UIUtils getHomeBackBarItem];
    [leftButton addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    UIButton *rightButton = [UIUtils getTopRightBarItem:@"Map"];
    [rightButton addTarget:self action:@selector(goToMapAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem ;
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

-(void)goBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)goToMapAction{
    [self performSegueWithIdentifier:@"SToMap" sender:self];
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
    allCampaigns = [[NSMutableArray alloc]init];
    if([response length] > 0){
//        [allCampaigns removeAllObjects];
        // Create SBJSON object to parse JSON
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        
        // parse the JSON string into an object - assuming json_string is a NSString of JSON data
        NSArray *campaigns = [parser objectWithString:response error:nil];
        int index = 0;
        for (NSDictionary *campaign in campaigns) {
            // You can retrieve individual values using objectForKey on the status NSDictionary
            // This will print the tweet and username to the console
            Campaign *wrapper = [[Campaign alloc]init];
            wrapper.name = [campaign objectForKey:@"name"];
            wrapper.desc = [campaign objectForKey:@"description"];
            wrapper.img = [campaign objectForKey:@"image_path"];
            if(index >0){
                wrapper.latitude = @"37.787539";
                wrapper.longitude = @"-122.405591";
            }else{
                wrapper.latitude = [campaign objectForKey:@"latitude"];
                wrapper.longitude = [campaign objectForKey:@"longitude"];
            }
            
            if([[campaign objectForKey:@"location_AR_global_impact"] isEqualToString:@"0"]){
                    wrapper.locationARGlobalImpact = DEFAULT_GLOBAL_IMPACT_AR_LOCATION;
            }else{
                    wrapper.locationARGlobalImpact = [campaign objectForKey:@"location_AR_global_impact"];
            }
            if([[campaign objectForKey:@"location_global_impact"] isEqualToString:@"0"]){
                wrapper.locationGlobalImpact = DEFAULT_GLOBAL_IMPACT_LOCATION;
            }else{
                wrapper.locationGlobalImpact = [campaign objectForKey:@"location_global_impact"];
            }
            
//            wrapper.locationGlobalImpact = [campaign objectForKey:@"location_global_impact"];
            [allCampaigns addObject:wrapper];
            index++;
            
        }        
    }
//    [tableView reloadData];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark - Location Methods

-(void)initLocation{
    [self startStandardUpdates];
}

- (void)startStandardUpdates {
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
}

-(void)processLocation:(CLLocation*)loc{
    if([allCampaigns count] > 0){
        
        NSMutableArray *newArray = [[NSMutableArray alloc]init];
        for(int index = 0; index < [allCampaigns count];index++){
            Campaign *campaign = [allCampaigns objectAtIndex:index];
            CLLocationDistance distance = [LocationUtil distanceBetweenCoordinate:loc.coordinate andCoordinate:CLLocationCoordinate2DMake([campaign.latitude floatValue], [campaign.longitude floatValue])];
            
            if(distance < ([campaign.locationGlobalImpact floatValue]*1000)){
                campaign.distance = [NSString stringWithFormat:@"%f",distance];
                if(distance < [campaign.locationARGlobalImpact floatValue]){
                    campaign.withinRange = @"Y";
                }else{
                    campaign.withinRange = @"N";
                }
                [items addObject:campaign];
                [newArray addObject:campaign];
            }
            //        NSLog(@"distance %f",distance);
        }
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *sortedArray;
        sortedArray = [newArray sortedArrayUsingDescriptors:sortDescriptors];
        
//        for (Campaign *campaign in newArray){
//            NSLog(@"name ::::: %@",campaign.name);
//        }
//        
//        for (Campaign *campaign in sortedArray){
//            NSLog(@"name ::::: %@",campaign.name);
//        }
        items = [sortedArray mutableCopy];
        [tableView reloadData];
    }
}

#pragma mark - Delegate Methods (CLLocationManagerDelegate)

#pragma mark For IOS_6
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)location{
    [self processLocation:[location lastObject]];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    [self processLocation:newLocation];
}

@end
