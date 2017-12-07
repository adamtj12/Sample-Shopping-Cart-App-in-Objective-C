//
//  AdamBaseViewController.m
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 19/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import "AdamBaseViewController.h"

@interface AdamBaseViewController ()

@end

@implementation AdamBaseViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //SETTING THE BACKGROUND IMAGE FOR ALL CONTROLLERS.
    self.imageview.image = [UIImage imageNamed:@"3849640532_b2e073b358_z.jpg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
