//
//  TextScroller.m
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 12/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import "TextScroller.h"

@implementation TextScroller


-(id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        
        [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [self setBackgroundColor:[UIColor redColor]];
        
        [self setFont:[UIFont boldSystemFontOfSize:36.0]];
        [self setTextColor:[UIColor redColor]];
        
        [self setTextAlignment:NSTextAlignmentCenter];
        
        // Start with a blank transform
        CATransform3D blankTransform = CATransform3DIdentity;
        
        // Skew the text
        blankTransform.m34 = -1.0 / 300;
        
        // Rotate the text
        blankTransform = CATransform3DRotate(blankTransform, 45.0f * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
        
        // Set the transform
        [self.layer setTransform:blankTransform];
        
        // Now we need to skew the box so the bottom is wider than the top.
        
        return self;

    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillRect(context, self.bounds);
    
    self.layer.cornerRadius = 8;
    self.layer.borderWidth = 0;
    self.clipsToBounds = YES;
}


- (id)initTextScroller:(UITextView*)textView andWithText:(NSString*)textToScroll
{
    return self;
    
}
-(void)setTextToScroll:(NSString*)text
{
    self.text = text;
}

@end
