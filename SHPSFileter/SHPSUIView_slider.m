//
//  SHPSUIView_slider.m
//  SHPSFileter
//
//  Created by anchang on 13-6-7.
//  Copyright (c) 2013年 shem. All rights reserved.
//

#import "SHPSUIView_slider.h"

@implementation SHPSUIView_slider

@synthesize isAdd;
@synthesize isAutoPlay;

-(void)actionButton:(UIButton*)button{
    isAutoPlay = !isAutoPlay;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 30, 30);
        [self addSubview:button];
        
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
