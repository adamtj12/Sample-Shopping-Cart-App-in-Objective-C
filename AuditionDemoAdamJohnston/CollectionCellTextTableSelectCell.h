//
//  ButtonCollectionViewCell.h
//  HomeDelivery
//
//  Created by Adam Johnston on 17/05/2016.
//  Copyright © 2016 Cobra Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCellTextTableSelectCell : UICollectionViewCell<UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *resultTableView;
@property (weak, nonatomic) IBOutlet UILabel *titleHeader;

@property (retain) NSArray
*selectedPersonURL;


@property (strong, nonatomic) NSArray *resultsData;

-(void)loadTableData:(NSMutableArray*)arr;
-(NSArray*)getSelectedPerson;

@end
