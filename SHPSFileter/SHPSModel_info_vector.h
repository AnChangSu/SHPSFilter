//
//  SHPSMode_info_vector.h
//  SHPSFileter
//
//  Created by anchang on 13-6-5.
//  Copyright (c) 2013年 shem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>

@interface SHPSModel_info_vector : NSObject{
    CIVector *attributeDefault;
    NSString *keyString;
    NSString *attributeType;
}

@property(nonatomic,strong) CIVector *attributeDefault;
@property(nonatomic,strong) NSString *keyString;
@property(nonatomic,strong) NSString *attributeType;

@end
