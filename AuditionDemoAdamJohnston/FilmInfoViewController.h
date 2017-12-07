//
//  FilmInfoViewController.h
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 12/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdamBaseViewController.h"
@interface FilmInfoViewController : AdamBaseViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSString *selectedMenuItem;

@property (strong, nonatomic) NSDictionary *selectedTableItem;

@property (strong, nonatomic) NSArray *InformationKeys;

@property (weak, nonatomic) IBOutlet UICollectionView *menuCollection;

@property (strong, nonatomic) NSMutableDictionary *filmInformation;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;

@end
