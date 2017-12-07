//
//  APIManager.h
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 12/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject


+ (APIManager *) sharedInstance;

-(NSMutableArray*)getBaseApi;

-(NSDictionary*)getFamilyApi;

-(NSDictionary*)getApiResult:(NSString*)urlString;

-(NSDictionary*)getAllCharacters;

-(NSString*)getBaseApiString;

-(NSString*)addToCart:(NSString*)productId;
//-(void)getCart;

-(NSString*)deleteFromCart:(NSString*)productId;


-(NSString*)getyodaSpeakTranslation:(NSString*)urlString;


@end
