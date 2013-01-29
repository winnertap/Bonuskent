//
//  BKCampaignMapViewController.m
//  Bonus Kent
//
//  Created by Ali Asghar on 11/30/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import "BKCampaignMapViewController.h"
#import "MapLocation.h"
#import "ColorUtils.h"
#import "UIUtils.h"
#import "Campaign.h"

@interface BKCampaignMapViewController ()

@end

@implementation BKCampaignMapViewController
@synthesize mapView;
@synthesize campaigns;

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
	    [self plotCrimePositions];
    [self applyUIChanges];
}

-(NSArray*)getData{
    NSMutableArray *returnArray = [[NSMutableArray alloc]init];
    for (Campaign *campaign in campaigns){
        MapLocation *gramercyPark = [[MapLocation alloc]initWithName:campaign.name address:campaign.desc coordinate:CLLocationCoordinate2DMake([campaign.latitude floatValue],[campaign.longitude floatValue])];
        [returnArray addObject:gramercyPark];
    }
    return returnArray;
}

// Add new method above refreshTapped
- (void)plotCrimePositions {
    
    for (id<MKAnnotation> annotation in mapView.annotations) {
        [mapView removeAnnotation:annotation];
    }
    
    NSArray *data = [self getData];
    
    for (MapLocation * annotation in data) {
        [mapView addAnnotation:annotation];
        [mapView addOverlay:[MKCircle circleWithCenterCoordinate:annotation.coordinate radius:500]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMapView:nil];
    [super viewDidUnload];
}

#pragma mark - MapKit Delegate Methods

- (MKAnnotationView *)mapView:(MKMapView *)mapViewLocal viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MapLocation class]]) {
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"cxcx_03.png"];//here we use a nice image instead of the default pins
//            [annotationView addOverlay:[MKCircle circ circleWithCenterCoordinate: radius:someRadius]];
            
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

//implement the viewForOverlay delegate method...
-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay
{
    MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
    circleView.strokeColor = [UIColor redColor];
    circleView.lineWidth = 2;
    circleView.fillColor = [UIColor blueColor];
    return circleView;
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

-(void)goToMapAction{
    [self performSegueWithIdentifier:@"SToMap" sender:self];
}


@end
