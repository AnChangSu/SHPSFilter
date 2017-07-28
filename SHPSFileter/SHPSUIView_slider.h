//
//  SHPSUIView_slider.h
//  SHPSFileter
//
//  Created by anchang on 13-6-7.
//  Copyright (c) 2013年 shem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHPSUIView_slider : UISlider{
    //自动播放的时候，是加还是减
    BOOL isAdd;
    BOOL isAutoPlay;
}
@property(nonatomic) BOOL isAdd;
@property(nonatomic) BOOL isAutoPlay;

@end
