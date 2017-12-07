    //
//  MoreInformationViewController.m
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 13/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import "MoreInformationViewController.h"
#import "CollectionCellTextTableSelectCell.h"

@interface MoreInformationViewController ()

@end

@implementation MoreInformationViewController
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
    NSMutableDictionary *notEmptyDictionary;
    NSArray * sortedKeys;
    NSArray * objects;
}

@synthesize selectedMenuItem;
@synthesize InformationKeys;

-(void)initDetails
{
    manager = [[APIManager alloc]init];
    // removing empty values from the data to display
    notEmptyDictionary = [[NSMutableDictionary alloc]init];
    for(int i = 0 ;i<InformationKeys.count;i++)
    {
        if([[[InformationKeys allValues]objectAtIndex:i] isKindOfClass:[NSString class]])
        {
            //set string value with key
            [notEmptyDictionary setValue:[[InformationKeys allValues]objectAtIndex:i] forKey:[[InformationKeys allKeys]objectAtIndex:i]];
        }
        
        if([[[InformationKeys allValues]objectAtIndex:i] isKindOfClass:[NSNumber class]])
        {
            //set string value with key
            [notEmptyDictionary setValue:[[InformationKeys allValues]objectAtIndex:i] forKey:[[InformationKeys allKeys]objectAtIndex:i]];
        }

        else
        {
            //set array value with key . will be loaded into table
            if([[[InformationKeys allValues]objectAtIndex:i] isKindOfClass:[NSArray class]])
            {
                if([[[InformationKeys allValues]objectAtIndex:i]count] > 0)
                {
                    [notEmptyDictionary setValue:[[InformationKeys allValues]objectAtIndex:i] forKey:[[InformationKeys allKeys]objectAtIndex:i]];
                }
            }
        }
    }
    
    //Sorting the values Alphabetically
  sortedKeys = [[notEmptyDictionary allKeys] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
  objects = [notEmptyDictionary objectsForKeys: sortedKeys notFoundMarker: [NSNull null]];

    [self.menuCollection reloadData];
    
}

- (void)viewDidLoad
{
    if(_infoArray)
        
    [super viewDidLoad];
    
    //setting up collection cell NIB's
    cellNibMenuOption = [UINib nibWithNibName:@"CollectionCellButton" bundle:nil];
    cellNibInformation = [UINib nibWithNibName:@"CollectionCellTextInformation" bundle:nil];
    cellNibInformationSingle = [UINib nibWithNibName:@"CollectionCellTextInformationSingleLine" bundle:nil];
    cellNibTable = [UINib nibWithNibName:@"CollectionCellTextTableSelect" bundle:nil];
    
    flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [self.menuCollection setCollectionViewLayout:flowLayout];

    [self initDetails];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.menuCollection.frame.size.width,1);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //make string collection cells smaller
    if([[objects objectAtIndex:indexPath.section] isKindOfClass:[NSString class]])
    {
        return CGSizeMake(370, 90);
    }
    
    if([[objects objectAtIndex:indexPath.section] isKindOfClass:[NSNumber class]])
    {
        return CGSizeMake(370, 90);
    }

    else
    {
        return CGSizeMake(370, 240);
    }
    
    return CGSizeMake(0,0);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [objects count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        if([[objects objectAtIndex:indexPath.section] isKindOfClass:[NSString class]])
        {
            [self.menuCollection registerNib:cellNibInformation forCellWithReuseIdentifier:@"cvCellInformation"];
            
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvCellInformation" forIndexPath:indexPath];
            
            //Find tag with Unique ID.
            UILabel* textLabel = (UILabel *)[cell viewWithTag:100];
            UITextView* textView = (UITextView *)[cell viewWithTag:101];

            [textView setText:[objects objectAtIndex:indexPath.section]];
            
            //remove dashes and present to user correctly
            NSString* correctedHeader = [[sortedKeys objectAtIndex:indexPath.section] stringByReplacingOccurrencesOfString:@"_" withString:@" "];
            NSLog(@"%@", correctedHeader);

            [textLabel setText:correctedHeader];
        }
        if([[objects objectAtIndex:indexPath.section] isKindOfClass:[NSNumber class]])
        {
            NSString *numValue = [[objects objectAtIndex:indexPath.section] stringValue];
            
            [self.menuCollection registerNib:cellNibInformation forCellWithReuseIdentifier:@"cvCellInformation"];
            
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvCellInformation" forIndexPath:indexPath];
            
            //Find tag with Unique ID.
            UILabel* textLabel = (UILabel *)[cell viewWithTag:100];
            UITextView* textView = (UITextView *)[cell viewWithTag:101];
            
            [textView setText:numValue];
            
            //remove dashes and present to user correctly
            NSString* correctedHeader = [[sortedKeys objectAtIndex:indexPath.section] stringByReplacingOccurrencesOfString:@"_" withString:@" "];
            NSLog(@"%@", correctedHeader);
            
            [textLabel setText:correctedHeader];
        }
    
        else if([[objects objectAtIndex:indexPath.section] isKindOfClass:[NSArray class]])
        {
            [self.menuCollection registerNib:cellNibTable forCellWithReuseIdentifier:@"cellNibTable"];
            cellTable = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellNibTable" forIndexPath:indexPath];
            
            [cellTable loadTableData:[objects objectAtIndex:indexPath.section]];
            
            cellTable.resultTableView.dataSource = cellTable;
            cellTable.resultTableView.delegate   = cellTable;
            
            cellTable.resultTableView.allowsSelection = 0;
            
            //remove dashes and present to user correctly

            NSString* correctedHeader = [[sortedKeys objectAtIndex:indexPath.section] stringByReplacingOccurrencesOfString:@"_" withString:@" "];
            NSLog(@"%@", correctedHeader);

            [cellTable.titleHeader setText:correctedHeader];
            
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
    //Pass the text to the crawler text.
    //pass information to the next controller
    if ([segue.identifier isEqualToString:@"informationViewSegue"])
    {
        MoreInformationViewController *moreInfo = [segue destinationViewController];
        moreInfo.infoArray = [cellTable selectedPersonURL];
    }
}
- (IBAction)openingCrawlPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"OpeningCrawlSegue" sender:nil];
}
- (IBAction)backPressed:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addToCartPressed:(id)sender
{
    CartManager *sharedManager = [CartManager sharedManager];
    
    long stockValue = [[notEmptyDictionary objectForKey:@"stock"]integerValue];
    
    int numberOfExistingSameProducts = 0;
    
    if(stockValue > 0)
    {
        for(int i = 0; i<sharedManager.product.count;i++)
        {
            if([[[sharedManager.product objectForKey:[NSString stringWithFormat:@"%@%d", @"products", i]] valueForKey:@"productId"] isEqualToValue:[notEmptyDictionary valueForKey:@"productId"]])
            {
                numberOfExistingSameProducts = [[[sharedManager.product objectForKey:[NSString stringWithFormat:@"%@%d", @"products", i]] valueForKey:@"quantity"]longValue];
                
                numberOfExistingSameProducts++;
                
                [[sharedManager.product objectForKey:[NSString stringWithFormat:@"%@%d", @"products", i]]  setValue:[NSNumber numberWithInt:numberOfExistingSameProducts] forKey:@"quantity"];
                
                [manager addToCart:[notEmptyDictionary objectForKey:@"productId"]];
            }
        }
        
        if(numberOfExistingSameProducts == 0)
        {
            int currentAmountOfValues = sharedManager.product.count;
            
            [sharedManager.product setObject:notEmptyDictionary forKey:[NSString stringWithFormat:@"%@%d", @"products", sharedManager.product.count]];
            numberOfExistingSameProducts++;
            
            [[sharedManager.product objectForKey:[NSString stringWithFormat:@"%@%d", @"products", currentAmountOfValues]] setObject:[NSNumber numberWithInteger:numberOfExistingSameProducts]
                                     forKey:@"quantity"];
            
            [manager addToCart:[notEmptyDictionary objectForKey:@"productId"]];

//            [[sharedManager.product objectForKey:[NSString stringWithFormat:@"%@%d", @"products", currentAmountOfValues]]  setInteger:numberOfExistingSameProducts forKey:@"quantity"];

        }
    }
    else
    {
        [TSMessage showNotificationWithTitle:@"Out of Stock!"
                                    subtitle:@"Sorry but this item is out of stock."
                                        type:TSMessageNotificationTypeError];

        // message to say item is out of stock.
    }
}

- (IBAction)addToWishlistPressed:(id)sender
{
    WishListManager *sharedManager = [WishListManager sharedManager];

    int numberOfExistingSameProducts = 0;

    for(int i = 0; i<sharedManager.product.count;i++)
    {
        if([[[sharedManager.product objectForKey:[NSString stringWithFormat:@"%@%d", @"products", i]] valueForKey:@"productId"] isEqualToValue:[notEmptyDictionary valueForKey:@"productId"]])
        {
            numberOfExistingSameProducts ++;
        }
    }
        
        if(numberOfExistingSameProducts == 0)
        {
            [sharedManager.product setObject:notEmptyDictionary forKey:[NSString stringWithFormat:@"%@%lu", @"products", (unsigned long)sharedManager.product.count]];
        }
        else
        {
            [TSMessage showNotificationWithTitle:@"Item is already in Wishlist!"
                                        subtitle:@"Select another item to add to wishlist, or add it to cart"
                                            type:TSMessageNotificationTypeError];
        }
            
}



@end
