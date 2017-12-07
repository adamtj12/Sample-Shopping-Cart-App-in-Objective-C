//
//  ViewController.m
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 12/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import "WishViewController.h"

@interface WishViewController ()

@property (nonatomic, strong) NSArray *films;

@end

@implementation WishViewController
{
    
    UICollectionViewFlowLayout *flowLayout;
    UINib *cellNibMenuOption;
    
    UICollectionViewCell *cell;
    APIManager *manager;
    NSMutableArray *menuOptions;
    NSString *SeguePerformedName;
    NSArray *searchResults;
    NSInteger *currentIndex;
    WishListManager *sharedManager;
    NSString *quantity, *price, *totalPriceCombined;
    NSMutableArray *numbers;
    BOOL productAddedToCart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    manager = [[APIManager alloc]init];
    
    sharedManager = [WishListManager sharedManager];

    menuOptions = [manager getBaseApi];
    
    //SET UP COLLECTION VIEW
    cellNibMenuOption = [UINib nibWithNibName:@"CollectionCellWishItem" bundle:nil];

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
    return [sharedManager.product count];
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
        
            currentIndex = indexPath.section;
        
        //CUSTOM BUTTON WITH TAG TO IDENTIFY WHAT BUTTON TRIGGERED ACTION.
        AdamAuditionButton* buttonDelete = (AdamAuditionButton *)[cell viewWithTag:111];
        
        buttonDelete.buttonId = indexPath.section;
        
        [buttonDelete addTarget:self
                         action:@selector(deleteFromCart:)
               forControlEvents:UIControlEventTouchUpInside];
        
        AdamAuditionButton* buttonAddToCart = (AdamAuditionButton *)[cell viewWithTag:114];
        buttonAddToCart.buttonId = indexPath.section;
        
        [buttonAddToCart addTarget:self
                         action:@selector(addToCartPressed:)
               forControlEvents:UIControlEventTouchUpInside];

        currentIndex = indexPath.section;
        
        [button setButtonId:indexPath.section];

            [button setButtonId:indexPath.section];
        
        
            UITextField* priceField = (UITextField *)[cell viewWithTag:112];
        
            long priceTimesQuantity = ([[[sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", indexPath.section]] valueForKey:@"price"]longValue] * [[[sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", indexPath.section]] valueForKey:@"quantity"]longValue]);
        
            [priceField setText:[NSString stringWithFormat:@"£%ld", priceTimesQuantity]];
    }
    return cell;
}

-(void)deleteFromCart:(id)sender
{
    // if quantity is 1 then remove entire product from the shared instance of the cart
        AdamAuditionButton* buttonDelete = (AdamAuditionButton *)sender;

        NSString *productName = [[sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", buttonDelete.buttonId]] valueForKey:@"name"];
    
    
        if(productAddedToCart)
        {
            [TSMessage showNotificationWithTitle:@"Product moved into Cart"
                                        subtitle:[NSString stringWithFormat:@""]
                                            type:TSMessageNotificationTypeSuccess];
            productAddedToCart = 0;
        }
    
        else
        {
            [TSMessage showNotificationWithTitle:@"Product removed from Wish List"
                                    subtitle:[NSString stringWithFormat:@"You have removed all quantities of %@", productName]
                                        type:TSMessageNotificationTypeError];
        }
    
        [sharedManager.product removeObjectForKey:[NSString stringWithFormat:@"%@%ld", @"products", buttonDelete.buttonId]];

        [self.menuCollection reloadData];
        numbers = [[NSMutableArray alloc]init];
}


- (IBAction)addToCartPressed:(id)sender
{
    AdamAuditionButton* buttonDelete = (AdamAuditionButton *)sender;
    
    CartManager *sharedManager2 = [CartManager sharedManager];
    
    long stockValue = [[[sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", buttonDelete.buttonId]]objectForKey:@"stock"]integerValue];
    
    int numberOfExistingSameProducts = 0;
    
    if(stockValue > 0)
    {
        for(int i = 0; i<sharedManager2.product.count;i++)
        {
            if([[[sharedManager2.product objectForKey:[NSString stringWithFormat:@"%@%d", @"products", i]] valueForKey:@"productId"] isEqualToValue:[[sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", buttonDelete.buttonId]] valueForKey:@"productId"]])
            {
                numberOfExistingSameProducts = [[[sharedManager2.product objectForKey:[NSString stringWithFormat:@"%@%d", @"products", i]] valueForKey:@"quantity"]longValue];
                
                numberOfExistingSameProducts++;
                
                [[sharedManager2.product objectForKey:[NSString stringWithFormat:@"%@%d", @"products", i]]  setValue:[NSNumber numberWithInt:numberOfExistingSameProducts] forKey:@"quantity"];
                
                [manager addToCart:[[sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", buttonDelete.buttonId]] objectForKey:@"productId"]];
                
                productAddedToCart = 1;
                [self deleteFromCart:sender];

            }
        }
        
        if(numberOfExistingSameProducts == 0)
        {
            int currentAmountOfValues = sharedManager2.product.count;
            
            [sharedManager2.product setObject:[sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", buttonDelete.buttonId]] forKey:[NSString stringWithFormat:@"%@%d", @"products", sharedManager2.product.count]];
            numberOfExistingSameProducts++;
            
            [[sharedManager2.product objectForKey:[NSString stringWithFormat:@"%@%d", @"products", currentAmountOfValues]] setObject:[NSNumber numberWithInteger:numberOfExistingSameProducts]
                                                                                                                             forKey:@"quantity"];
            
            [manager addToCart:[[sharedManager.product valueForKey:[NSString stringWithFormat:@"%@%ld", @"products", buttonDelete.buttonId]] objectForKey:@"productId"]];
            
            productAddedToCart = 1;
            [self deleteFromCart:sender];
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
