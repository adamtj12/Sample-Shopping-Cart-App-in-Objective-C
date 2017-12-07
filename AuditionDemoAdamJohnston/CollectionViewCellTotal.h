//
//  ButtonCollectionViewCell.h
//  HomeDelivery
//
//  Created by Adam Johnston on 17/05/2016.
//  Copyright © 2016 Cobra Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCellTotal : UICollectionViewCell

@property (strong, nonatomic) IBOutlet AdamAuditionButton *button;

@property (strong, nonatomic) IBOutlet AdamAuditionButton *buttonDelete;

@property (strong, nonatomic) IBOutlet UITextField *priceField;

@end
