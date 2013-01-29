//
//  LeadershipBoardViewController.m
//  Bonus Kent
//
//  Created by Ali Asghar on 12/11/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import "LeadershipBoardViewController.h"
#import "BKLeaderBoardCell.h"
#import "User.h"
#import "UIUtils.h"
#import "ColorUtils.h"
#import "Constants.h"
#import "SMWebRequest.h"
#import "SBJson.h"

@interface LeadershipBoardViewController ()

@end

@implementation LeadershipBoardViewController

@synthesize friendPickerController = _friendPickerController;
@synthesize selectedFriends = _selectedFriends;
@synthesize tableView;
@synthesize userDisplayNameLbl;
@synthesize userProfileImage;
@synthesize pointLbl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidUnload{
    [self setPointLbl:nil];
    [self setUserDisplayNameLbl:nil];
    [self setUserProfileImage:nil];
    [self setTableView:nil];
    self.friendPickerController = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [self applyUIChanges];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self populateUserDetails];
    [self getUserTotalScore];
    [self getFriendsList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    _friendPickerController.delegate = nil;
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
    static NSString *CellIdentifier = @"fbFriendCell";
    
    BKLeaderBoardCell *cell = (BKLeaderBoardCell*)[tableViewLocal dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BKLeaderBoardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    User *user = [items objectAtIndex:indexPath.row];
    cell.name.text = user.name;
//    cell.profileImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=normal",user.profileId]]]];
    
    if(user.profilePictureData != nil){
        cell.profileImage.image = [UIImage imageWithData:user.profilePictureData];
    }else{
        cell.profileImage.image = nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"50_transparent.png"]];
    view.opaque = YES;
    cell.backgroundView = view;
    
    cell.rank.text = [NSString stringWithFormat:@"%d",(indexPath.row+1)];
    
    cell.points.text = user.score;
    
    return cell;
}

-(void)tableView:(UITableView *)tableview didSelectRowAtIndexPath :(NSIndexPath *)indexPath {
//    selectedCampaign = [items objectAtIndex:indexPath.row];
//    NSLog(@"clicked campaign is :::: %@",selectedCampaign.name);
//    [self performSegueWithIdentifier:@"SToCampaignDetails" sender:self];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(BKLeaderBoardCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //    cell.value.font = [UIFont fontWithName:@"Georgia-Bold" size:18.0];
}

#pragma mark - Facebook Function

-(void)getFriendsList{
    facebookIds = @"";
    facebookContacts = [[NSMutableDictionary alloc]init];
    FBRequest* friendsRequest = [FBRequest requestForMyFriends];
    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                  NSDictionary* result,
                                                  NSError *error) {
        NSArray* friends = [result objectForKey:@"data"];
        NSLog(@"Found: %i friends", friends.count);
        for (NSDictionary<FBGraphUser>* friend in friends) {
            User *user = [[User alloc]init];
            user.name = friend.name;
            user.profileId = friend.id;
            [facebookContacts setObject:user forKey:[NSString stringWithFormat:@"%@",friend.id]];
            if([facebookIds length] > 0){
                facebookIds = [facebookIds stringByAppendingFormat:@",%@",friend.id];
            }else{
                facebookIds = [facebookIds stringByAppendingFormat:@"%@",friend.id];
            }
            
//            NSLog(@"I have a friend named %@ with id %@ and email %@", friend.name, friend.id,[friend objectForKey:@"email"]);
        }
        [self getFriendsStats];
    }];
}

- (void)populateUserDetails
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 self.userDisplayNameLbl.text = user.name;
                 self.userProfileImage.profileID = user.id;
             }
         }];
    }
}


#pragma mark - UI Methods

-(void)applyUIChanges{
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    [self.navigationItem setHidesBackButton:NO];

    [self.view setBackgroundColor:[ColorUtils colorFromHexString:@"#F8F7E7"]];
    
    UIButton *leftButton = [UIUtils getTopLeftBarItem:@"   Back"];
    [leftButton addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.tabBarController.navigationItem.leftBarButtonItem = leftButtonItem ;
}

-(void)goBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - webservice calls

-(void)getFriendsStats{
    NSString *post = @"fIdsList=";
    post = [post stringByAppendingFormat:@"{\"fIdsList\":\"%@\"}",@"100000463662117"];
    
    NSLog(@"post = %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];

    NSString *url = SERVER_URL;
    url = [url stringByAppendingString:@"jsonLeaderBoard.php"];
    
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
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                        initWithTarget:self
                                        selector:@selector(loadImage)
                                        object:nil];
    [queue addOperation:operation];
    
    items = [[NSMutableArray alloc]init];
    if([response length] > 0){
        [items removeAllObjects];
        // Create SBJSON object to parse JSON
        SBJsonParser *parser = [[SBJsonParser alloc] init];
    
        // parse the JSON string into an object - assuming json_string is a NSString of JSON data
        NSArray *friends = [parser objectWithString:response error:nil];
    
        for (NSDictionary *friend in friends) {
            // You can retrieve individual values using objectForKey on the status NSDictionary
            // This will print the tweet and username to the console
            User *wrapper = [facebookContacts objectForKey:[friend objectForKey:@"f_id"]];
            id score = [friend objectForKey:@"score"];
            if(score != [NSNull null] ){
                wrapper.score = score;
            }else{
                wrapper.score = @"0 pts";
            }
            [items addObject:wrapper];
        }
    }

    [tableView reloadData];
    [facebookContacts removeAllObjects];
//    if([response length] > 0){
//        [items removeAllObjects];
//        // Create SBJSON object to parse JSON
//        SBJsonParser *parser = [[SBJsonParser alloc] init];
//        
//        // parse the JSON string into an object - assuming json_string is a NSString of JSON data
//        NSArray *campaigns = [parser objectWithString:response error:nil];
//        
//        for (NSDictionary *campaign in campaigns) {
//            // You can retrieve individual values using objectForKey on the status NSDictionary
//            // This will print the tweet and username to the console
//            Campaign *wrapper = [[Campaign alloc]init];
//            wrapper.name = [campaign objectForKey:@"name"];
//            wrapper.desc = [campaign objectForKey:@"description"];
//            wrapper.img = [campaign objectForKey:@"image_path"];
//            wrapper.latitude = [campaign objectForKey:@"latitude"];
//            wrapper.longitude = [campaign objectForKey:@"longitude"];
//            [items addObject:wrapper];
//        }
//    }
//    [tableView reloadData];
}

-(void)getUserTotalScore{
    NSUserDefaults *dataStore = [NSUserDefaults standardUserDefaults];
    
    NSString *post = @"userId=";
    post = [post stringByAppendingString:[dataStore valueForKey:@"userId"]];
    
    NSLog(@"post = %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSString *url = SERVER_URL;
    url = [url stringByAppendingString:@"jsonDataUserProfile.php"];
    
    NSLog(@"url = %@",url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc ]init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    SMWebRequest *loginRequest = [SMWebRequest requestWithURLRequest:request delegate:nil context:NULL];
    [loginRequest addTarget:self action:@selector(userTotalScoreRequestComplete:) forRequestEvents:SMWebRequestEventComplete];
    [loginRequest start];
    
}

-(void)userTotalScoreRequestComplete:(NSData *)data{
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"data 2 :::: %@",response);
    pointLbl.text = [NSString stringWithFormat:@"%@ pts",response];
}


- (void)loadImage {
    for(int i = 0;i < [items count];i++){
        User *user = (User *)[items objectAtIndex:i];
        NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=normal",user.profileId]]];
        user.profilePictureData = imageData;
        [self performSelectorOnMainThread:@selector(updateView) withObject:nil waitUntilDone:YES];
    }
}

- (void)updateView {
    [tableView reloadData];
}





@end
