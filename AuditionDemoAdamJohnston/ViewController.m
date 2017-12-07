//
//  ViewController.m
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 12/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *films;

@end

@implementation ViewController
{
    
    UICollectionViewFlowLayout *flowLayout;
    UINib *cellNibDefault, *cellNibInformation, *cellNibAmount, *cellNibMenuOption;
    
    UICollectionViewCell *cell;
    APIManager *manager;
    NSMutableArray *menuOptions;
    NSString *SeguePerformedName;
    NSArray *searchResults;
    NSInteger *currentIndex;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    manager = [[APIManager alloc]init];
    
    menuOptions = [manager getBaseApi];
    
    //SET UP COLLECTION VIEW
    cellNibMenuOption = [UINib nibWithNibName:@"CollectionCellButton" bundle:nil];
    
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
    
    CGFloat height = 50;
    
    return CGSizeMake(300, height);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [menuOptions count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.menuCollection registerNib:cellNibMenuOption forCellWithReuseIdentifier:@"cvCellButton"];
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvCellButton" forIndexPath:indexPath];
    
    //CUSTOM BUTTON WITH TAG TO IDENTIFY WHAT BUTTON TRIGGERED ACTION.
    AdamAuditionButton* button = (AdamAuditionButton *)[cell viewWithTag:109];
    
    //ADDING TARGET TO BUTTON
    [button addTarget:self action:@selector(menuItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //SORT MENU ALPHABETICALLY
//    NSArray *keys = [[menuOptions valueForKey:@"name"] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    
    NSArray *Values = [[menuOptions valueForKey:@"name"] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    
    [button setTitle:[[[menuOptions valueForKey:@"name"] objectAtIndex:indexPath.section] capitalizedString] forState:UIControlStateNormal];
    
    currentIndex = indexPath.section;
    
    [button setButtonId:indexPath.section];
    
    return cell;
}

-(void)menuItemPressed:(AdamAuditionButton*)selectedButton
{
    SeguePerformedName = selectedButton.titleLabel.text;
    
    currentIndex = selectedButton.buttonId;
    
    [self performSegueWithIdentifier:@"1" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(AdamAuditionButton*)sender
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
