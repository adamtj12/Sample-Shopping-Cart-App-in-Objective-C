//
//  MoreInformationViewController.h
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 13/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdamBaseViewController.h"


@interface MoreInformationViewController : AdamBaseViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSString *selectedMenuItem;

@property (strong, nonatomic) NSDictionary *InformationKeys;

@property (weak, nonatomic) IBOutlet UICollectionView *menuCollection;

@property (strong, nonatomic) NSMutableDictionary *filmInformation;

@property (strong, nonatomic) NSMutableDictionary *orderedDictionary;

@property (strong, nonatomic) NSDictionary *infoArray;

-(void)initDetails;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;

@end
