//
//  ButtonCollectionViewCell.h
//  HomeDelivery
//
//  Created by Adam Johnston on 17/05/2016.
//  Copyright © 2016 Cobra Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCellTextInformationSingleLineCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleHeader;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;

@property (weak, nonatomic) IBOutlet UIButton *openButton;

@end
