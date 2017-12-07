//
//  ViewController.h
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 12/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartViewController : AdamBaseViewController<UICollectionViewDelegate, UICollectionViewDataSource, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating >


@property (weak, nonatomic) IBOutlet UICollectionView *menuCollection;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *gpsButton;

@property (nonatomic, strong) UISearchController *searchController;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) NSMutableArray* allTableData;
@property (strong, nonatomic) NSMutableArray* filteredTableData;


@end

