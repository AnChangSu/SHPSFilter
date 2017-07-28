//
//  SHPSUIView_NSNumber__cell.m
//  SHPSFileter
//
//  Created by anchang on 13-6-5.
//  Copyright (c) 2013年 shem. All rights reserved.
//

#import "SHPSUIView_NSNumber__cell.h"

@implementation SHPSUIView_NSNumber__cell

@synthesize info;
@synthesize isUsed;
@synthesize slider;
@synthesize actionTarget;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)actionAutoChange:(id)sender{
    
}

-(void)actionSwitch:(UISwitch*)sender{
    isUsed = sender.on;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"beginFilter" object:nil];
}

-(void)createView{
    UISwitch *view = [[UISwitch alloc] initWithFrame:CGRectMake(235, 7, 50, 30)];
    [view addTarget:self action:@selector(actionSwitch:) forControlEvents:UIControlEventValueChanged];
    [view setOn:YES];
    isUsed = YES;
    [self addSubview:view];
}

-(void)setInfo:(SHPSModel_Info_number *)kInfo{
    info = kInfo;
    
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
    
    [self createView];
}

@end
