//
//  SHPSUIVC_CIFIlter__tv.h
//  SHPSFileter
//
//  Created by anchang on 13-6-3.
//  Copyright (c) 2013年 shem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHPSUIVC_CIFIlter__tv : UITableViewController{
    NSString *filterName;
    NSString *categoryName;
}

@property(nonatomic,strong) NSString *filterName;
@property(nonatomic,strong) NSString *categoryName;

@property (nonatomic, strong) id object;


@end
