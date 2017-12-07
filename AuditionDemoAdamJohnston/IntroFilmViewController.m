//
//  IntroFilmViewController.m
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 12/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import "IntroFilmViewController.h"

@interface IntroFilmViewController ()

@end

@implementation IntroFilmViewController
{
    SWCrawl *crawl;
}
@synthesize openingSceneText;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.scrollingText setTextToScroll:openingSceneText];
    
    
    crawl = [SWCrawl new];
    
    //Funny casing to use the characters in SW Jedi font that we need.
    [crawl setLogoText:_movieTitleText];
    
    [crawl setEpisodeNumberFont:[UIFont fontWithName:@"Starjedi" size:22.0]];
    [crawl setEpisodeNumberText:_movieEpisodeNumberText];
    
    //Lowercase string because SW Title font has a couple funny characters in it. Check out the font.
    [crawl setEpisodeTitleText:_movieTitleText.lowercaseString];
    [crawl setBodyText:openingSceneText];
    
    [self.crawlView updateTextViaCrawl:crawl];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)donePressed:(id)sender
{
   [self dismissViewControllerAnimated:YES completion:nil];
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
