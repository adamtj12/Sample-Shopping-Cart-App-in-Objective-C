//
//  FilmInfoViewController.m
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 12/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import "FilmInfoViewController.h"
#import "CollectionCellTextTableSelectCell.h"
@interface FilmInfoViewController ()

@end

@implementation FilmInfoViewController
{
    APIManager *manager;
    NSMutableDictionary *filmOptions;
    
    UICollectionViewFlowLayout *flowLayout;
    UINib *cellNibDefault, *cellNibInformation, *cellNibInformationSingle, *cellNibMenuOption, *cellNibTable;
    UICollectionViewCell *cell;
    NSString *SeguePerformedName;
    NSInteger *selectedIndex;
    CollectionCellTextTableSelectCell *cellTable;
    NSMutableArray *dataArrayLeft;
    NSMutableArray *dataArrayRight;
}

@synthesize selectedMenuItem;
@synthesize InformationKeys;

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.scrollview.contentSize=CGSizeMake(375,1700.0);
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    manager = [[APIManager alloc]init];
    
    
    // defining ifferent Cell options for different types of data
    cellNibMenuOption = [UINib nibWithNibName:@"CollectionCellButton" bundle:nil];
    cellNibInformation = [UINib nibWithNibName:@"CollectionCellTextInformation" bundle:nil];
    cellNibInformationSingle = [UINib nibWithNibName:@"CollectionCellTextInformationSingleLine" bundle:nil];
    
    cellNibTable = [UINib nibWithNibName:@"CollectionCellTextTableSelect" bundle:nil];

    [_backButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIFont fontWithName:@"Starjedi" size:20.0], NSFontAttributeName,
                                         [UIColor colorWithRed:255.0f green:217.0f blue:123.0f alpha:1], NSForegroundColorAttributeName,
                                         nil]
                               forState:UIControlStateNormal];

    self.navigationItem.backBarButtonItem = _backButton;

    flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [self.menuCollection setCollectionViewLayout:flowLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.menuCollection.frame.size.width,1);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger widthOfTable = self.menuCollection.frame.size.width;
    
    CGFloat height = 230;

    //sewtting height based on the cell containting a table or a label.
    if(indexPath.section == 2)
    {
        return CGSizeMake(370, 65);
    }
    
    if(indexPath.section >= 3)
    {
        return CGSizeMake(370, 300);
    }

    else
    {
            return CGSizeMake(370, 80);
    }
    

    return CGSizeMake(0, 0);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 7;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        if(indexPath.section == 0)
        {
            [self.menuCollection registerNib:cellNibInformation forCellWithReuseIdentifier:@"cvCellInformation"];
            
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvCellInformation" forIndexPath:indexPath];
            
            //find the label buy using the tag and set the value
            UILabel* textLabel = (UILabel *)[cell viewWithTag:100];
            UITextView* textView = (UITextView *)[cell viewWithTag:101];
            

            [textView setText:[_filmInformation objectForKey:@"title"]];
            [textLabel setText:@"Title"];
            return cell;
        }
        
        if(indexPath.section == 1)
        {
            [self.menuCollection registerNib:cellNibInformation forCellWithReuseIdentifier:@"cvCellInformation"];
            
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvCellInformation" forIndexPath:indexPath];
            UILabel* textLabel = (UILabel *)[cell viewWithTag:100];
            UITextView* textView = (UITextView *)[cell viewWithTag:101];

            [textView setText:[_filmInformation objectForKey:@"director"]];
            [textLabel setText:@"director"];
            
            return cell;
        }
    

        if(indexPath.section == 2)
        {
            [self.menuCollection registerNib:cellNibInformationSingle forCellWithReuseIdentifier:@"cellNibInformationSingle"];
            
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellNibInformationSingle" forIndexPath:indexPath];
            
            UIButton* buttonOpen = (UIButton *)[cell viewWithTag:102];
            [cellTable loadTableData:[_filmInformation objectForKey:@"characters"]];

            if(indexPath.row == 0)
            {
                [buttonOpen addTarget:self action:@selector(openingCrawlPressed:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            return cell;
        }
    
    if(indexPath.section == 3)
    {
        [self.menuCollection registerNib:cellNibTable forCellWithReuseIdentifier:@"cellNibTable"];
        
        cellTable = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellNibTable" forIndexPath:indexPath];

        UITableView* table = (UITableView *)[cellTable viewWithTag:104];

        [cellTable loadTableData:[_filmInformation objectForKey:@"vehicles"]];

        table.dataSource = cellTable;
        table.delegate = cellTable;
        
        UILabel* textLabel = (UILabel *)[cell viewWithTag:100];
        [cellTable.titleHeader setText:@"Vehicles"];
        
       // [table reloadData];
        return cellTable;

    }
    [self.menuCollection registerNib:cellNibTable forCellWithReuseIdentifier:@"cellNibTable"];

    
    if(indexPath.section == 4)
    {
        
        cellTable = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellNibTable" forIndexPath:indexPath];
        
        UITableView* table = (UITableView *)[cellTable viewWithTag:104];
        
        [cellTable loadTableData:[_filmInformation objectForKey:@"characters"]];
        
        table.dataSource = cellTable;
        table.delegate = cellTable;
        
        UILabel* textLabel = (UILabel *)[cell viewWithTag:100];
        [cellTable.titleHeader setText:@"Characters"];
        
    //[table reloadData];
        return cellTable;
        
    }

    if(indexPath.section == 5)
    {
        
        cellTable = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellNibTable" forIndexPath:indexPath];
        
        UITableView* table = (UITableView *)[cellTable viewWithTag:104];
        
        [cellTable loadTableData:[_filmInformation objectForKey:@"planets"]];

        table.dataSource = cellTable;
        table.delegate = cellTable;
        
        UILabel* textLabel = (UILabel *)[cell viewWithTag:100];
        [cellTable.titleHeader setText:@"Planets"];
        
        //[table reloadData];
        return cellTable;
        
    }

    if(indexPath.section == 6)
    {
        
        cellTable = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellNibTable" forIndexPath:indexPath];
        
        UITableView* table = (UITableView *)[cellTable viewWithTag:104];
        
        [cellTable loadTableData:[_filmInformation objectForKey:@"species"]];
        
        table.dataSource = cellTable;
        table.delegate = cellTable;
        
        UILabel* textLabel = (UILabel *)[cell viewWithTag:100];
        [cellTable.titleHeader setText:@"Species"];
        
       // [table reloadData];
        return cellTable;
        
    }
    
    return cell;

}


-(void)menuItemPressed:(AdamAuditionButton*)selectedButton
{
    SeguePerformedName = selectedButton.titleLabel.text;
    [self performSegueWithIdentifier:@"FilmInfoSegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(AdamAuditionButton*)sender
{
//    NSArray* Keys   = [[filmOptions allKeys] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
//    
//    NSArray* Values = [filmOptions objectsForKeys: [[filmOptions allKeys] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)] notFoundMarker: [NSNull null]];
    
    if ([segue.identifier isEqualToString:@"1"])
    {
        //        FilmInfoViewController *filmInfo = [segue destinationViewController];
        //        filmInfo.filmInformation = filmOptions;
    }
    
    if ([segue.identifier isEqualToString:@"OpeningCrawlSegue"])
    {
        IntroFilmViewController *filmInfo = [segue destinationViewController];

        filmInfo.openingSceneText = [_filmInformation valueForKey:@"opening_crawl"];

        filmInfo.movieTitleText = [_filmInformation valueForKey:@"title"];

        filmInfo.movieEpisodeNumberText = [[_filmInformation valueForKey:@"episode_id"]stringValue];
    }
    
    if ([segue.identifier isEqualToString:@"informationViewSegue"])
    {
        MoreInformationViewController *moreInfo = [segue destinationViewController];
        moreInfo.infoArray = _selectedTableItem;
        
    }
}
- (IBAction)openingCrawlPressed:(id)sender
{
    [self performSegueWithIdentifier:@"OpeningCrawlSegue" sender:nil];
}

/*@property (strong, nonatomic) NSArray *infoArray;
 
 
 @property (strong, nonatomic) NSString *selectedMenuItem;

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
