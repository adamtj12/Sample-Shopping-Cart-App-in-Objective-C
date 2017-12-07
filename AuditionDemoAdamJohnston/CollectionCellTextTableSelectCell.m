//
//  ButtonCollectionViewCell.m
//  HomeDelivery
//
//  Created by Adam Johnston on 17/05/2016.
//  Copyright © 2016 Cobra Technology. All rights reserved.
//

#import "CollectionCellTextTableSelectCell.h"
#import "MBProgressHUD.h"
@implementation CollectionCellTextTableSelectCell
{
    APIManager *manager;
    int selectedSegment;
    NSString *stringText;
}

@synthesize selectedPersonURL;
-(void)loadTableData:(NSMutableArray*)arr
{
    
    //update the working Data with new request
    manager = [[APIManager alloc]init];

    if([arr isKindOfClass:[NSArray class]])
    {
        self.resultsData = arr;
    }
    else
    {
        if([arr isKindOfClass:[NSString class]])
        {
            stringText = arr;
        }
    }
//    self.resultsData = arr;
}

-(NSDictionary*)getSelectedPerson
{
    //get selected item in the table
    selectedPersonURL =  [manager getApiResult:[_resultsData objectAtIndex:selectedSegment]];
    return selectedPersonURL;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_resultsData count];    //count number of row from counting array hear cataGorry is An Array
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.detailTextLabel.font=[UIFont fontWithName:@"Starjedi" size:19.0];
    cell.textLabel.font =[UIFont fontWithName:@"Starjedi" size:19.0];
    cell.detailTextLabel.textColor=[UIColor whiteColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@""];
    }
    
    //loading in the correct data from API MANAGERX
    
    // check if the data is coming through as an array or string and set up Collection Cell to adapt to either one.
    if([[_resultsData objectAtIndex:indexPath.row] isKindOfClass:[NSArray class]])
    {
        //Passing through the URL that is contained in the Data.
        cell.textLabel.text = [[manager getApiResult:[_resultsData objectAtIndex:indexPath.row]]valueForKey:@"name"];
    }
    else
    {
        //Film Array does not have name so loading in title as replacement title for cell.
        if([[manager getApiResult:[_resultsData objectAtIndex:indexPath.row]]valueForKey:@"name"])
        {
            cell.textLabel.text = [[manager getApiResult:[_resultsData objectAtIndex:indexPath.row]]valueForKey:@"name"];
        }
        
        else if([[manager getApiResult:[_resultsData objectAtIndex:indexPath.row]]valueForKey:@"title"])
        {
            cell.textLabel.text = [[manager getApiResult:[_resultsData objectAtIndex:indexPath.row]]valueForKey:@"title"];

        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    //Load Information View here
    selectedSegment = indexPath.row;
    
    [MBProgressHUD showHUDAddedTo:self.superview.superview.superview animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.superview.superview.superview animated:YES];
            
            
                MoreInformationViewController *moreInfo = [self.superview.superview nextResponder];
                
                
                moreInfo.infoArray = [self getSelectedPerson];
                
                [moreInfo initDetails];
        });
    });

    
}

@end
