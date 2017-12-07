//
//  TextScroller.h
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 12/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextScroller : UITextView


- (id)initTextScroller:(UITextView*)textView andWithText:(NSString*)textToScroll;
-(void)setTextToScroll:(NSString*)text;

@end
