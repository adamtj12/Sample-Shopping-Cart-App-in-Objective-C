 //
//  SelectItemViewController.m
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 12/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import "SelectItemViewController.h"

@interface SelectItemViewController ()

@end

@implementation SelectItemViewController
{
    APIManager *manager;
    NSMutableArray *menuOptions;

    UICollectionViewFlowLayout *flowLayout;
    UINib *cellNibDefault, *cellNibInformation, *cellNibAmount, *cellNibMenuOption;
    UICollectionViewCell *cell;
    NSString *SeguePerformedName;
    NSInteger *selectedIndex;
    
}

@synthesize selectedMenuItem;
@synthesize InformationKeys;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    manager = [[APIManager alloc]init];
    
    //set the menu up based on the selected segment and pass string to API to search for results
    //menuOptions = [[manager getApiResult:[NSString stringWithFormat:@"%@%@", [manager getBaseApiString], selectedMenuItem]]valueForKey:@"results"];
    
    NSLog(@" available areas of Star Wars Knowledge%@", menuOptions);
    
    
//    [_backButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                         [UIFont fontWithName:@"Starjedi" size:20.0], NSFontAttributeName,
//                                         [UIColor colorWithRed:255.0f green:217.0f blue:123.0f alpha:1], NSForegroundColorAttributeName,
//                                         nil]
//                               forState:UIControlStateNormal];

    cellNibMenuOption = [UINib nibWithNibName:@"CollectionCellButton" bundle:nil];
    
    flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [self.menuCollection setCollectionViewLayout:flowLayout];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    
    CGFloat height = 75;
    
    if(indexPath.row == 0)
        return CGSizeMake(widthOfTable*0.56, height);
    if(indexPath.row == 1)
        return CGSizeMake(widthOfTable*0.6, height);
    
    return CGSizeMake(0, 0);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [InformationKeys count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.menuCollection registerNib:cellNibMenuOption forCellWithReuseIdentifier:@"cvCellButton"];
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvCellButton" forIndexPath:indexPath];
    
    AdamAuditionButton* button = (AdamAuditionButton *)[cell viewWithTag:109];
    
    [button addTarget:self action:@selector(menuItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    
//    NSArray *keys = [[menuOptions valueForKey:@"title"]objectAtIndex:indexPath.row];
    
    
    //Sort the tiles again and display .
//    if([selectedMenuItem isEqualToString:@"films"])
//    {
//
//        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"episode_id" ascending:YES];
//        NSArray *sortedTitles = [menuOptions sortedArrayUsingDescriptors:@[sd]];
//        [button setTitle:[[sortedTitles valueForKey:@"title"]objectAtIndex:indexPath.section] forState:UIControlStateNormal];
//    }
//    else
//    {
//        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
//        NSArray *sortedTitles = [menuOptions sortedArrayUsingDescriptors:@[sd]];
//        [button setTitle:[[sortedTitles valueForKey:@"name"]objectAtIndex:indexPath.section] forState:UIControlStateNormal];
//    }
    
    //button = [button initWithButtonColor:[UIColor colorWithRed:255.0 green:217.0 blue:123.0  alpha:1]];
    button = [button initWithButtonColor:[UIColor redColor]];

    button.tag = indexPath.section;
    
    button.titleLabel.font = [UIFont fontWithName:@"Starjedi" size:22.0];
    
    [button setButtonId:indexPath.section];
    
    return cell;
}

-(void)menuItemPressed:(AdamAuditionButton*)selectedButton
{
    SeguePerformedName = selectedButton.titleLabel.text;
    selectedIndex = selectedButton.tag;
    
    //if film is selecrted go to film section if not go to the information section.
    if([selectedMenuItem isEqualToString:@"films"])
    {
        [self performSegueWithIdentifier:@"FilmInfo" sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"informationViewSegue" sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(AdamAuditionButton*)sender
{
    
    
    // pass information relevant to next view controller.
    if ([segue.identifier isEqualToString:@"FilmInfo"])
    {
        FilmInfoViewController *filmInfo = [segue destinationViewController];
        filmInfo.filmInformation = [menuOptions objectAtIndex:selectedIndex];
    }
    
    if ([segue.identifier isEqualToString:@"informationViewSegue"])
    {
        MoreInformationViewController *moreInfo = [segue destinationViewController];
        moreInfo.infoArray = [menuOptions objectAtIndex:selectedIndex];
    }
}

/* 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
