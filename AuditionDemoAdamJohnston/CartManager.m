//
//  CartManager.m
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 08/11/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import "CartManager.h"

@implementation CartManager

@synthesize product;
@synthesize cartId;

+(id)sharedManager
{
    static CartManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc]init];
    });
    return sharedMyManager;
}

-(id)init
{
    if (self = [super init])
    {
        product = [[NSMutableDictionary alloc] init];
        combinedCostOfCart = [[NSNumber alloc] init];
        cartId = [[NSString alloc] init];
    }
    
    return self;
}

@end
