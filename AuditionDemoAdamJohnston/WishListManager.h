//
//  CartManager.h
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 08/11/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WishListManager : NSObject
{
    NSMutableDictionary *product;
    NSNumber *combinedCostOfCart;
    NSString *cartId;
}

@property (strong, atomic) NSMutableDictionary *product;
@property (strong, atomic) NSNumber *combinedCostOfCart;
@property (strong, atomic) NSString *cartId;

+(id)sharedManager;

@end
