//
//  SHPSModel_info_color.h
//  SHPSFileter
//
//  Created by anchang on 13-6-5.
//  Copyright (c) 2013年 shem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>

@interface SHPSModel_info_color : NSObject{
    CIColor *attributeDefault;
    NSString *attributeType;
    NSString *keyString;
}

@property(nonatomic,strong) CIColor *attributeDefault;
@property(nonatomic,strong) NSString *attributeType;
@property(nonatomic,strong) NSString *keyString;

@end
