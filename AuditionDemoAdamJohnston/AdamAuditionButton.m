//
//  AdamAuditionButton.m
//  AuditionDemoAdamJohnston
//
//  Created by Adam Johnston on 12/09/2017.
//  Copyright © 2017 AdamJ. All rights reserved.
//

#import "AdamAuditionButton.h"

@implementation AdamAuditionButton

@synthesize buttonId = _buttonId;
@synthesize buttonIdentifier = _buttonIdentifier;

- (id)initWithButtonColor:(UIColor*)color
{
    //SET COLOR OF BUTTON
    _color = color;
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor * color = [UIColor lightGrayColor];
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, self.bounds);
    
    self.layer.cornerRadius = 8;
    self.layer.borderWidth = 0;
    self.clipsToBounds = YES;
}


-(void)setButtonId:(NSInteger)buttonId{
    
    //KEEP TRACK IOF WHAT BUTTON HAS BEEN PRESSED
    _buttonId = buttonId;
}

-(void)setButtonIdentifier:(NSString *)buttonIdentifier{
    //KEEP TRACK IOF WHAT BUTTON HAS BEEN PRESSED

    _buttonIdentifier = buttonIdentifier;
}

@end
