//
//  SHPSUIView_image.h
//  SHPSFileter
//
//  Created by anchang on 13-6-4.
//  Copyright (c) 2013年 shem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHPSModel_Info_image.h"

@interface SHPSUIView_image : UIImageView<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>{

    UITapGestureRecognizer *singleTap;
    UITapGestureRecognizer *doubleTap;
    __weak UIViewController *controller;
    
    UIPopoverController *popController;
    UIImagePickerController *imagePicker;
    
    BOOL isNeedResetBeginImage;
    BOOL isInputImage;
}

@property(nonatomic,weak) UIViewController *controller;
@property(nonatomic) BOOL isNeedResetBeginImage;
@property(nonatomic) BOOL isInputImage;


@end
