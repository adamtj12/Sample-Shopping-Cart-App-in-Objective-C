//
//  AdamDemoLocationMapViewController.m
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 19/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import "AdamDemoLocationMapViewController.h"

@interface AdamDemoLocationMapViewController ()

@end

@implementation AdamDemoLocationMapViewController
{
    MKUserLocation *lcationCurrently;
    CLLocationManager *locationManager;
}

@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView.delegate = self;
    [mapView setShowsUserLocation:YES];
    
    //SET UP LOCATION DELEGTE METHODS
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        //NEED FROM IOS 8 ON WARDS.
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];

}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //SETTING CAMERA AREA OF MAP VIEW.
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    //SET TO UPDATE LABELS WHEN LOCATION MOVES.
    lcationCurrently = userLocation;
    [self updateCoordinateMessage];
}

-(void)updateCoordinateMessage
{
    
    // SET LABELS TO CURRENT LAT AND LON
    self.longField.text = [[NSString alloc] initWithFormat:@"Current Longitude: %f", lcationCurrently.coordinate.longitude];
    
    self.latField.text = [[NSString alloc] initWithFormat:@"Current Latitude: %f", lcationCurrently.coordinate.latitude];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
