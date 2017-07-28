//
//  SHPSUIView_CIImage__cell.h
//  SHPSFileter
//
//  Created by anchang on 13-6-5.
//  Copyright (c) 2013年 shem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHPSModel_Info_image.h"
#import "SHPSUIView_image.h"

@interface SHPSUIView_CIImage__cell : UITableViewCell{
    SHPSModel_Info_image *info;
    BOOL isUsed;
    SHPSUIView_image *imageView;
    
    __weak id actionTarget;
}

@property(nonatomic,strong) SHPSModel_Info_image *info;
@property(nonatomic,readonly) BOOL isUsed;
@property(nonatomic,strong) SHPSUIView_image *imageView;
@property(nonatomic,weak) id actionTarget;

@end
