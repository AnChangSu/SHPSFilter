//
//  SHPSModel_Info_number.h
//  SHPSFileter
//
//  Created by anchang on 13-6-4.
//  Copyright (c) 2013年 shem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHPSModel_Info_number : NSObject{
    float attributeDefault;
    float attributeIdentity;
    float attributeSliderMax;
    float attributeSliderMin;
    NSString *attributeType;
    NSString *keyString;
}

@property(nonatomic) float attributeDefault;
@property(nonatomic) float attributeIdentity;
@property(nonatomic) float attributeSliderMax;
@property(nonatomic) float attributeSliderMin;
@property(nonatomic,strong) NSString *attributeType;
@property(nonatomic,strong) NSString *keyString;

@end
