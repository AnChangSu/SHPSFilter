//
//  SHPSUIView_CIVector__cell.h
//  SHPSFileter
//
//  Created by anchang on 13-6-5.
//  Copyright (c) 2013年 shem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHPSModel_info_vector.h"

@interface SHPSUIView_CIVector__cell : UITableViewCell{
    SHPSModel_info_vector *info;
    BOOL isUsed;
    
    __weak id actionTarget;
}

@property(nonatomic,strong) SHPSModel_info_vector *info;
@property(nonatomic,readonly) BOOL isUsed;

@property(nonatomic,weak) id actionTarget;

@end
