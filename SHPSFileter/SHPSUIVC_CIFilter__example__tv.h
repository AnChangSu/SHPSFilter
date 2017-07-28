//
//  SHPSUIVC_CIFilter__example__tv.h
//  SHPSFileter
//
//  Created by anchang on 13-6-4.
//  Copyright (c) 2013年 shem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import "SHPSUIView_image.h"

@interface SHPSUIVC_CIFilter__example__tv : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSString *filterName;
    NSString *categoryName;
    
    //数据相关
    CIFilter *fliter;
    NSArray *key;
    NSArray *value;
    
    //view相关
    SHPSUIView_image *bgImageView;
    
    SHPSUIView_image *inputImageView;
    
    NSMutableArray *sliderArray;
    NSMutableArray *imageArray;
    CIImage *beginImage;
    CIContext *context;
    
    int keyNumber;
    NSMutableArray *cellArray;
    NSMutableArray *cellTypeArray;
    
    NSTimer *sliderActionTimer;
    
    UITableViewController *attributeController;
    UIPopoverController *popController;
}

@property(nonatomic,strong) NSString *filterName;
@property(nonatomic,strong) NSString *categoryName;

@end
