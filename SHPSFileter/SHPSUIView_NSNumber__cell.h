//
//  SHPSUIView_NSNumber__cell.h
//  SHPSFileter
//
//  Created by anchang on 13-6-5.
//  Copyright (c) 2013年 shem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHPSModel_Info_number.h"
#import "SHPSUIView_slider.h"

@interface SHPSUIView_NSNumber__cell : UITableViewCell{
    SHPSModel_Info_number *info;
    BOOL isUsed;
    SHPSUIView_slider *slider;
    
    __weak id actionTarget;
}

@property(nonatomic,strong) SHPSModel_Info_number *info;
@property(nonatomic,readonly) BOOL isUsed;
@property(nonatomic,strong) SHPSUIView_slider *slider;
@property(nonatomic,weak) id actionTarget;

@end
