//
//  SHPSModel_info_value.h
//  SHPSFileter
//
//  Created by anchang on 13-6-5.
//  Copyright (c) 2013年 shem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHPSModel_info_value : NSObject{
    NSValue *attributeDefault;
    NSString *attributeType;
    NSString *keyString;
}

@property(nonatomic,strong) NSValue *attributeDefault;
@property(nonatomic,strong) NSString *attributeType;
@property(nonatomic,strong) NSString *keyString;

@end
