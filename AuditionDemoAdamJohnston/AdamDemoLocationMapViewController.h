//
//  AdamDemoLocationMapViewController.h
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 19/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdamDemoLocationMapViewController : AdamBaseViewController <MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UILabel *longField;

@property (weak, nonatomic) IBOutlet UILabel *latField;

@end
