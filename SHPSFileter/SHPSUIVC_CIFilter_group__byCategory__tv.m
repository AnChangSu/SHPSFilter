//
//  SHPSViewController.m
//  SHPSFileter
//
//  Created by anchang on 13-6-3.
//  Copyright (c) 2013年 shem. All rights reserved.
//

#import "SHPSUIVC_CIFilter_group__byCategory__tv.h"
#import "SHPSUIVC_CIFIlter__tv.h"
#import <CoreImage/CoreImage.h>


NSString *categoryNameArray[] = {
    @"CICategoryBlur",
    @"CICategoryColorAdjustment",
    @"CICategoryColorEffect",
    @"CICategoryCompositeOperation",
    @"CICategoryDistortionEffect",
    @"CICategoryGenerator",
    @"CICategoryGeometryAdjustment",
    @"CICategoryGradient",
    @"CICategoryHalftoneEffect",
    @"CICategoryReduction",
    @"CICategorySharpen",
    @"CICategoryStylize",
    @"CICategoryTileEffect",
    @"CICategoryTransition"
};


@interface SHPSUIVC_CIFilter_group__byCategory__tv ()

@end

@implementation SHPSUIVC_CIFilter_group__byCategory__tv

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.navigationItem.title = @"Category";
    
    CICategoryArray = [NSArray arrayWithObjects:
                                kCICategoryDistortionEffect,
                                kCICategoryGeometryAdjustment,
                                kCICategoryCompositeOperation,
                                kCICategoryHalftoneEffect,
                                kCICategoryColorAdjustment,
                                kCICategoryColorEffect,
                                kCICategoryTransition,
                                kCICategoryTileEffect,
                                kCICategoryGenerator,
                                kCICategoryReduction,
                                kCICategoryGradient,
                                kCICategoryStylize,
                                kCICategorySharpen,
                                kCICategoryBlur,nil];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [CICategoryArray count];
    //return sizeof(categoryNameArray)/sizeof(categoryNameArray[0]);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *categoryName = CICategoryArray[section];
    NSArray *array = [CIFilter filterNamesInCategory:categoryName];
    return [array count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return CICategoryArray[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    //config the cell
    NSString *categoryName = CICategoryArray[indexPath.section];
    NSArray *array = [CIFilter filterNamesInCategory:categoryName];
    
    cell.textLabel.text = array[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SHPSUIVC_CIFIlter__tv *controller = [[SHPSUIVC_CIFIlter__tv alloc] init];
    controller.categoryName = CICategoryArray[indexPath.section];
     NSArray *array = [CIFilter filterNamesInCategory:controller.categoryName];
    controller.filterName = array[indexPath.row];
    controller.object = [CIFilter filterWithName:controller.filterName];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
