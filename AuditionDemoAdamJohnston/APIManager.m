//
//  APIManager.m
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 12/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager

+(id)sharedInstance {
    static APIManager *sharedApiManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedApiManager = [[self alloc] init];
    });
    return sharedApiManager;
}

- (id)init {
    if (self = [super init]) {
        //someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
    }
    return self;
}

//Get the entire list of all star wars cotntent
-(NSMutableArray*)getBaseApi
{
    NSError *error;
    NSString *url_string = [NSString stringWithFormat: @"https://private-anon-711b86614d-ddshop.apiary-mock.com/products"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return json;
}

-(NSString*)getBaseApiString
{
    NSString *url_string = [NSString stringWithFormat: @"https://private-anon-711b86614d-ddshop.apiary-mock.com/products/"];
    return url_string;
}



-(NSString*)addToCart:(NSString*)productId
{
    CartManager *sharedManager = [CartManager sharedManager];

    NSURL *URL = [NSURL URLWithString:@"https://private-anon-711b86614d-ddshop.apiary-mock.com/cart"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
  //  NSString *myParameters = [[NSString alloc] initWithFormat:@"%@", productId];
    
    [request setHTTPBody:[[NSString stringWithFormat:@"{\n  \"productId\": %@\n}", productId] dataUsingEncoding:NSUTF8StringEncoding]];
    
   // [request setHTTPBody:[myParameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString* body;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error)
    {
                                      
                                      if (error) {
                                          // Handle error...
                                          return;
                                      }
                                      
                                      if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                          NSLog(@"Response HTTP Status code: %ld\n", (long)[(NSHTTPURLResponse *)response statusCode]);
                                          NSLog(@"Response HTTP Headers:\n%@\n", [(NSHTTPURLResponse *)response allHeaderFields]);
                                      }
        
        
                                    NSDictionary *body = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];

                                    sharedManager.cartId = [[body objectForKey:@"cartId"]stringValue];

                                      //NSString* body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                      NSLog(@"Response Body:\n%@\n", body);
                                  }];
    [task resume];
    
    
    return body;
}

-(NSString*)deleteFromCart:(NSString*)productId
{
    CartManager *sharedManager = [CartManager sharedManager];

    NSString *strURL=[NSString stringWithFormat:@"https://private-anon-711b86614d-ddshop.apiary-mock.com/cart/%@", sharedManager.cartId];
    
    NSURL *URL = [NSURL URLWithString:strURL];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"DELETE"];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      if (error) {
                                          // Handle error...
                                          return;
                                      }
                                      
                                      if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                          NSLog(@"Response HTTP Status code: %ld\n", (long)[(NSHTTPURLResponse *)response statusCode]);
                                          NSLog(@"Response HTTP Headers:\n%@\n", [(NSHTTPURLResponse *)response allHeaderFields]);
                                      }
                                      
                                      NSString* body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                      NSLog(@"Response Body:\n%@\n", body);
                                  }];
    [task resume];
    
    return @"";
}

//Searches the API based on the current link being sent from the vioew Controller.
-(NSDictionary*)getApiResult:(NSString*)urlString
{
    NSError *error;
    //pass the url of what was clicked.
    NSString *url_string = [NSString stringWithFormat:urlString];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    // p
    return json;
}

@end
