//
//  SelectItemViewController.h
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 12/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdamBaseViewController.h"
@interface SelectItemViewController :AdamBaseViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSString *selectedMenuItem;

@property (strong, nonatomic) NSArray *InformationKeys;

@property (weak, nonatomic) IBOutlet UICollectionView *menuCollection;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;

@end

