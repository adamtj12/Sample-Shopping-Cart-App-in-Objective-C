//
//  AdamAuditionButton.h
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 12/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdamAuditionButton : UIButton

@property (nonatomic, assign) UIColor *color;

- (id)initWithButtonColor:(UIColor*)color;

@property (nonatomic, assign) NSInteger buttonId;
@property (nonatomic, assign) NSString* buttonIdentifier;

@end
