//
//  ViewController.m
//  AdamJohnstonYoda
//
//  Created by Adam Johnston on 03/05/2017.
//  Copyright © 2017 1Self. All rights reserved.
//

#import "YodaViewController.h"
#import <UNIRest.h>


@interface YodaViewController ()


@end

@implementation YodaViewController
{
    NSString *myString;
    UIActivityIndicatorView *indicator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
}

- (IBAction)TranslatePressed:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        /* Your UI code */
        
        [[APIManager sharedInstance]getyodaSpeakTranslation:[self.enterTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

        
            /* Do UI work here */
            self.translatedTextField.text = [[APIManager sharedInstance]getyodaSpeakTranslation:[self.enterTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
            [indicator stopAnimating];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


                   @end
