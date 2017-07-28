//
//  SHPSUIView_CIColor__cell.h
//  SHPSFileter
//
//  Created by anchang on 13-6-5.
//  Copyright (c) 2013年 shem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHPSModel_info_color.h"
#import "SHPSUIView_slider.h"

@interface SHPSUIView_CIColor__cell : UITableViewCell{
    SHPSModel_info_color *info;
    BOOL isUsed;
    SHPSUIView_slider *sliderRed;
    SHPSUIView_slider *sliderGreen;
    SHPSUIView_slider *sliderBlue;
    SHPSUIView_slider *sliderAlhpa;
    
    __weak id actionTarget;
}

@property(nonatomic,strong) SHPSModel_info_color *info;
@property(nonatomic,readonly) BOOL isUsed;

@property(nonatomic,strong) SHPSUIView_slider *sliderRed;
@property(nonatomic,strong) SHPSUIView_slider *sliderGreen;
@property(nonatomic,strong) SHPSUIView_slider *sliderBlue;
@property(nonatomic,strong) SHPSUIView_slider *sliderAlpha;

@property(nonatomic,weak) id actionTarget;

@end
