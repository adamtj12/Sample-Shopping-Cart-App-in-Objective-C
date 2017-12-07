//
//  ViewController.m
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 12/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import "CartViewController.h"

@interface CartViewController ()

@property (nonatomic, strong) NSArray *films;

@end

@implementation CartViewController
{
    
    UICollectionViewFlowLayout *flowLayout;
    UINib *cellNibMenuOption, *cellNibTotal;
    
    UICollectionViewCell *cell;
    APIManager *manager;
    NSMutableArray *menuOptions;
    NSString *SeguePerformedName;
    NSArray *searchResults;
    NSInteger *currentIndex;
    CartManager *sharedManager;
    NSString *quantity, *price, *totalPriceCombined;
    NSMutableArray *numbers;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    manager = [[APIManager alloc]init];
    
    sharedManager = [CartManager sharedManager];

    menuOptions = [manager getBaseApi];
    
    //SET UP COLLECTION VIEW
     cellNibMenuOption = [UINib nibWithNibName:@"CollectionCellCartItem" bundle:nil];
    
     cellNibTotal = [UINib nibWithNibName:@"CollectionCellCartTotal" bundle:nil];

    flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [self.menuCollection setCollectionViewLayout:flowLayout];
    
    
    numbers = [[NSMutableArray alloc]init];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.menuCollection.frame.size.width,1);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger widthOfTable = self.menuCollection.frame.size.width;
    
    CGFloat height = 88;
    
    return CGSizeMake(300, height);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [sharedManager.product count]+1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", indexPath.section]])
    {
            [self.menuCollection registerNib:cellNibMenuOption forCellWithReuseIdentifier:@"cvCellOption"];
        
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvCellOption" forIndexPath:indexPath];
        
            //CUSTOM BUTTON WITH TAG TO IDENTIFY WHAT BUTTON TRIGGERED ACTION.
            AdamAuditionButton* button = (AdamAuditionButton *)[cell viewWithTag:109];
        
            //ADDING TARGET TO BUTTON
            [button addTarget:self action:@selector(menuItemPressed:) forControlEvents:UIControlEventTouchUpInside];
        
            [button setTitle:[[[sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", indexPath.section]] objectForKey:@"name"] capitalizedString] forState:UIControlStateNormal];
        
            UITextField* quantityField = (UITextField *)[cell viewWithTag:110];
        
            quantity = [[[sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", indexPath.section]] valueForKey:@"quantity"] stringValue];
        
            [quantityField setText:quantity];
        
            //CUSTOM BUTTON WITH TAG TO IDENTIFY WHAT BUTTON TRIGGERED ACTION.
            AdamAuditionButton* buttonDelete = (AdamAuditionButton *)[cell viewWithTag:111];
        
            buttonDelete.buttonId = indexPath.section;
        
            [buttonDelete addTarget:self
                             action:@selector(deleteFromCart:)
               forControlEvents:UIControlEventTouchUpInside];
        
            currentIndex = indexPath.section;
        
            [button setButtonId:indexPath.section];
        
            UITextField* priceField = (UITextField *)[cell viewWithTag:112];
        
            long priceTimesQuantity = ([[[sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", indexPath.section]] valueForKey:@"price"]longValue] * [[[sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", indexPath.section]] valueForKey:@"quantity"]longValue]);
        
            [priceField setText:[NSString stringWithFormat:@"£%ld", priceTimesQuantity]];
        
            [numbers addObject:[NSNumber numberWithLong:priceTimesQuantity]];
    }
    else
    {
        [self.menuCollection registerNib:cellNibTotal forCellWithReuseIdentifier:@"cvCellTotal"];

        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvCellTotal" forIndexPath:indexPath];

        int count = [numbers count];
        NSInteger sum = 0;
        for (int i = 0; i < count; i++)
        {
            sum += [[numbers objectAtIndex:i] integerValue];
        }

        
        UITextField* totalField = (UITextField *)[cell viewWithTag:113];
        
        [totalField setText:[NSString stringWithFormat:@"£%ld", (long)sum]];
    }
    
    
    return cell;
}

-(void)deleteFromCart:(id)sender
{
    // if quantity is 1 then remove entire product from the shared instance of the cart
    AdamAuditionButton* buttonDelete = (AdamAuditionButton *)sender;

    long numberInCartOfProduct = [[[sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", buttonDelete.buttonId]] valueForKey:@"quantity"]longValue];
    
    if(numberInCartOfProduct == 1)
    {
        NSString *productName = [[sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", buttonDelete.buttonId]] valueForKey:@"name"];
        
        [TSMessage showNotificationWithTitle:@"Product removed from cart"
                                    subtitle:[NSString stringWithFormat:@"You have removed all quantities of %@", productName]
                                        type:TSMessageNotificationTypeError];
        
        
        [manager deleteFromCart:[[sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", buttonDelete.buttonId]] valueForKey:@"productId"]];

        [sharedManager.product removeObjectForKey:[NSString stringWithFormat:@"%@%ld", @"products", buttonDelete.buttonId]];
        

        [self.menuCollection reloadData];
        numbers = [[NSMutableArray alloc]init];

    }
    else
    {
        long Value = [[[sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", buttonDelete.buttonId]] valueForKey:@"quantity"]longValue];
        long lesserValue = Value-1;
        
        if(lesserValue > 0)
        {
            [manager deleteFromCart:[[sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", buttonDelete.buttonId]] valueForKey:@"productId"]];

            [[sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", buttonDelete.buttonId]] setObject:[NSNumber numberWithLong:lesserValue] forKey:@"quantity"];
        }
        else
        {
            //tell user the product is totally removed.
            
        }
        
        [self.menuCollection reloadData];
        numbers = [[NSMutableArray alloc]init];

    }
}


-(void)menuItemPressed:(AdamAuditionButton*)selectedButton
{
    SeguePerformedName = selectedButton.titleLabel.text;
    
    currentIndex = selectedButton.buttonId;
    [self performSegueWithIdentifier:@"1" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(AdamAuditionButton*)sender
{
    NSDictionary* Keys= [menuOptions objectAtIndex:currentIndex];
    
    if ([segue.identifier isEqualToString:@"1"])
    {
        MoreInformationViewController *selectItem = [segue destinationViewController];
        selectItem.InformationKeys = Keys;
        
        //PASS THROUGH WHAT OPTION WAS SELECTED AND RE USE SAME VIEW BASED ON SEGUE TYPE.
        
        selectItem.selectedMenuItem = [SeguePerformedName lowercaseString];
    }
}



@end
