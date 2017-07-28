//
//  SHPSUIVC_CIFilter__example__tv.m
//  SHPSFileter
//
//  Created by anchang on 13-6-4.
//  Copyright (c) 2013年 shem. All rights reserved.
//

#import "SHPSUIVC_CIFilter__example__tv.h"
#import "SHPSModel_Info_number.h"
#import "SHPSModel_Info_image.h"
#import "SHPSUIView_image.h"

#import "SHPSUIView_CIVector__cell.h"
#import "SHPSUIView_NSNumber__cell.h"
#import "SHPSUIView_CIImage__cell.h"
#import "SHPSUIView_CIColor__cell.h"
#import "SHPSUIView_NSValue__cell.h"


@interface SHPSUIVC_CIFilter__example__tv ()

-(void)actionSlider:(id)sender;

@end

@implementation SHPSUIVC_CIFilter__example__tv

@synthesize filterName;
@synthesize categoryName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

-(void)actionTimer{
    int count =0;
    for (int i=0; i<[sliderArray count]; i++) {
        SHPSUIView_slider *slider = [sliderArray objectAtIndex:i];
        if ( !slider.isAutoPlay ) {
            continue;
        }
        count++;
        float max = slider.maximumValue;
        float min = slider.minimumValue;
        double tick = (max-min)/40;
        if ( slider.isAdd ) {
            (slider.value + tick > max) ? (slider.isAdd = 0) : 1;
            slider.value += tick;
        }else{
            (slider.value - tick < min) ? (slider.isAdd = 1) : 1;
            slider.value -= tick;
        }
    }
    if ( count ) {
        [self actionSlider:nil];
    }
}

-(void)actionTapSlider:(id)sender{
    NSLog(@"_____________________tap");
}

-(void)actionSlider:(id)sender{
    //SHPSUIView_slider *slider = (SHPSUIView_slider*)sender;
    CIFilter *filter = [CIFilter filterWithName:self.filterName];
    
    [filter setDefaults];

    for (int i=0; i<[cellArray count]; i++) {
        UIView *view = [cellArray objectAtIndex:i];
        NSString *string = [cellTypeArray objectAtIndex:i];
        
        if ( [string isEqualToString:@"NSNumber"] ) {
            SHPSUIView_NSNumber__cell *cell = (SHPSUIView_NSNumber__cell*)view;
            if ( cell.isUsed ) {
                [filter setValue:[NSNumber numberWithFloat:cell.slider.value] forKey:cell.info.keyString];
                //NSLog(@"cell.slider.value = %f",cell.slider.value);
            }
        }else if( [string isEqualToString:@"CIImage"] ){
            SHPSUIView_CIImage__cell *cell = (SHPSUIView_CIImage__cell*)view;
            if ( cell.isUsed ) {
                
                if ( [cell.info.keyString isEqualToString:kCIInputImageKey]  ) {
                    [filter setValue:beginImage forKey:kCIInputImageKey];
                }else{
                    CIImage *image = [CIImage imageWithCGImage:[cell.imageView.image CGImage]];
                    [filter setValue:image forKey:cell.info.keyString];
                }
                
            }
        }else if( [string isEqualToString:@"CIColor"] ){
            SHPSUIView_CIColor__cell *cell = (SHPSUIView_CIColor__cell*)view;
            if ( cell.isUsed ) {
                [filter setValue:[CIColor colorWithRed:cell.sliderRed.value green:cell.sliderGreen.value blue:cell.sliderBlue.value alpha:cell.sliderAlpha.value] forKey:cell.info.keyString];
                
                //NSLog(@"%@",cell.info.keyString);
                //NSLog(@"%f___%f___%f___%f",cell.sliderRed.value,cell.sliderGreen.value,cell.sliderBlue.value,cell.sliderAlpha.value);
            }
        }else if( [string isEqualToString:@"CIVector"] ){
            SHPSUIView_CIVector__cell *cell = (SHPSUIView_CIVector__cell*)view;
            if ( cell.isUsed ) {
                [filter setValue:cell.info.attributeDefault forKey:cell.info.keyString];
            }
        }else if( [string isEqualToString:@"NSValue"] ){
            SHPSUIView_NSValue__cell *cell = (SHPSUIView_NSValue__cell*)view;
            if ( cell.isUsed ) {
                CGAffineTransform trans;
#warning 所有transform为默认值
                if ( [self.filterName isEqualToString:@"CIAffineTransform"] ) {
                    trans = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
                }else{
                    trans = CGAffineTransformMake(0.4, 0, 0, 0.4, 0, 0);
                }
                NSValue *transValue = [NSValue valueWithCGAffineTransform:trans];

                [filter setValue:transValue forKey:cell.info.keyString];
               
            }
        }
    }
    
    
    
    
    // 得到过滤后的图片
    CIImage *outputImage = [filter outputImage]; //imageByApplyingTransform:CGAffineTransformMakeRotation(-90*M_PI/180)];
    // 转换图片
#warning 注意，categoryGenerator,和categoryTileEffect两个大类和其他一些效果必须使用固定frame不能使用[outputImage extent]
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:CGRectMake(0, 0, 1024, 768)];//[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];  
    //UIImage *newImg = [UIImage imageWithCIImage:outputImage];
    // 显示图片
    [bgImageView setImage:newImg];
    bgImageView.backgroundColor = [UIColor clearColor];
    // 释放C对象
    CGImageRelease(cgimg);

}

-(void)actionSetting:(UIBarButtonItem*)sender{
    [popController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(void)createViewWithAttributes{
    
    for (NSString *obj in key) {
        if ( [obj isEqualToString:@"CIAttributeFilterDisplayName"]
            || [obj isEqualToString:@"CIAttributeFilterCategories"]
            || [obj isEqualToString:@"CIAttributeFilterName"]
            || [obj isEqualToString:@"CIAttributeFilterAvailable_iOS"]) {
            continue;
        }
        
        keyNumber++;
        
        NSDictionary *valueDic = [[fliter attributes] valueForKey:obj];
        
        if ( ![valueDic isKindOfClass:[NSDictionary class]] ) {
            return;
        }
        
//        NSLog(@"valueDic = %@  == %@",valueDic,[valueDic class]);
        
        NSString *string = [valueDic objectForKey:@"CIAttributeClass"];
        
        
        /*CIVector *vector =[CIVector vectorWithString:@"[0 0 1 0]"] ;
        CIColor *color = [CIColor colorWithString:@"(1 0.8 0.6 1)"];
        NSLog(@"______%@",key);
        NSLog(@"_____%@",valueDic);*/
#warning 整个例子里没有处理data相关数据，目前data相关的效果CIColorCube不能正常工作
        if ( [string isEqualToString:@"NSNumber"] ) {
            
            SHPSModel_Info_number *info = [[SHPSModel_Info_number alloc] init];
            info.attributeDefault = [[valueDic objectForKey:@"CIAttributeDefault"] floatValue];
            info.attributeIdentity = [[valueDic objectForKey:@"CIAttributeIdentity"] floatValue];
            info.attributeSliderMax = [[valueDic objectForKey:@"CIAttributeSliderMax"] floatValue];
            info.attributeSliderMin = [[valueDic objectForKey:@"CIAttributeSliderMin"] floatValue];
            info.attributeType = [valueDic objectForKey:@"CIAttributeType"];
            info.keyString = obj;
            
            SHPSUIView_NSNumber__cell *cell = [[SHPSUIView_NSNumber__cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NumberCell"];
            
            cell.info = info;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 7, 70, 30)];
            label.backgroundColor = [UIColor clearColor];
            label.adjustsFontSizeToFitWidth = YES;
            label.text = obj;
            [cell addSubview:label];
            
            SHPSUIView_slider *slider = [[SHPSUIView_slider alloc] initWithFrame:CGRectMake(80, 7, 150, 30)];
            slider.maximumValue = info.attributeSliderMax;
            slider.minimumValue = info.attributeSliderMin;
            slider.value = info.attributeDefault;
            [slider addTarget:self action:@selector(actionSlider:) forControlEvents:UIControlEventValueChanged];
            [slider addTarget:self action:@selector(actionTapSlider:) forControlEvents:UIControlEventTouchDownRepeat];
            [cell addSubview:slider];
            cell.slider = slider;
            
            [cellTypeArray addObject:string];
            
            [cellArray addObject:cell];
            [sliderArray addObject:slider];
            
        }else if( [string isEqualToString:@"CIImage"] ){
            
            /*if ( [obj isEqualToString:kCIInputImageKey] ) {
                //continue;
            }*/
            
            SHPSModel_Info_image *info = [[SHPSModel_Info_image alloc] init];
            info.keyString = obj;
            info.attributeType = [valueDic objectForKey:@"CIAttributeType"];
            
            SHPSUIView_CIImage__cell *cell = [[SHPSUIView_CIImage__cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ImageCell"];
            
            cell.info = info;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 50, 70, 30)];
            label.backgroundColor = [UIColor clearColor];
            label.adjustsFontSizeToFitWidth = YES;
            label.text = obj;
            [cell addSubview:label];
            
            SHPSUIView_image *imageView = [[SHPSUIView_image alloc] initWithFrame:CGRectMake(80, 10, 150, 100)];
           // image.imageInfo = info;
            imageView.controller = self;
            imageView.isNeedResetBeginImage = NO;
            imageView.image = [UIImage imageNamed:@"image2.PNG"];
            [cell addSubview:imageView];
            
            cell.imageView = imageView;
            
            if ( [obj isEqualToString:@"inputImage"] ) {
                imageView.isInputImage = YES;
                inputImageView = imageView;
            }
            
        
            [cellArray addObject:cell];
            [imageArray addObject:imageView];
            [cellTypeArray addObject:string];
            
        }else if( [string isEqualToString:@"CIColor"] ){
            
            SHPSModel_info_color *info = [[SHPSModel_info_color alloc] init];
            NSString *string2 = [valueDic objectForKey:@"CIAttributeDefault"];
            NSString *string1 = [NSString stringWithFormat:@"%@",string2];
            //NSString *temp = [NSString stringWithUTF8String:string];
           
            info.attributeDefault = [CIColor colorWithString:string1];
            // NSLog(@"___________color = %@",info.attributeDefault );
            info.attributeType = [valueDic objectForKey:@"CIAttributeType"];
            info.keyString = obj;
            
            SHPSUIView_CIColor__cell *cell = [[SHPSUIView_CIColor__cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ImageCell"];
            
            cell.info = info;
            
            UILabel *labelRed = [[UILabel alloc] initWithFrame:CGRectMake(5, 7, 70, 30)];
            labelRed.backgroundColor = [UIColor clearColor];
            labelRed.adjustsFontSizeToFitWidth = YES;
            labelRed.text = @"red";
            [cell addSubview:labelRed];
            
            SHPSUIView_slider *sliderRed = [[SHPSUIView_slider alloc] initWithFrame:CGRectMake(80, 7, 150, 30)];
            sliderRed.maximumValue = 1;
            sliderRed.minimumValue = 0;
            sliderRed.value = info.attributeDefault.red;
            [sliderRed addTarget:self action:@selector(actionSlider:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:sliderRed];
            cell.sliderRed = sliderRed;
            
            UILabel *labelGreen = [[UILabel alloc] initWithFrame:CGRectMake(5, 42, 70, 30)];
            labelGreen.backgroundColor = [UIColor clearColor];
            labelGreen.adjustsFontSizeToFitWidth = YES;
            labelGreen.text = @"green";
            [cell addSubview:labelGreen];
            
            SHPSUIView_slider *sliderGreen = [[SHPSUIView_slider alloc] initWithFrame:CGRectMake(80, 42, 150, 30)];
            sliderGreen.maximumValue = 1;
            sliderGreen.minimumValue = 0;
            sliderGreen.value = info.attributeDefault.red;
            [sliderGreen addTarget:self action:@selector(actionSlider:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:sliderGreen];
            cell.sliderGreen = sliderGreen;
            
            UILabel *labelBlue = [[UILabel alloc] initWithFrame:CGRectMake(5, 77, 70, 30)];
            labelBlue.backgroundColor = [UIColor clearColor];
            labelBlue.adjustsFontSizeToFitWidth = YES;
            labelBlue.text = @"blue";
            [cell addSubview:labelBlue];
            
            SHPSUIView_slider *sliderBlue = [[SHPSUIView_slider alloc] initWithFrame:CGRectMake(80, 77, 150, 30)];
            sliderBlue.maximumValue = 1;
            sliderBlue.minimumValue = 0;
            sliderBlue.value = info.attributeDefault.red;
            [sliderBlue addTarget:self action:@selector(actionSlider:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:sliderBlue];
            cell.sliderBlue = sliderBlue;
            
            UILabel *labelAlpha = [[UILabel alloc] initWithFrame:CGRectMake(5, 112, 70, 30)];
            labelAlpha.backgroundColor = [UIColor clearColor];
            labelAlpha.adjustsFontSizeToFitWidth = YES;
            labelAlpha.text = @"alpha";
            [cell addSubview:labelAlpha];
            
            SHPSUIView_slider *sliderAlpha = [[SHPSUIView_slider alloc] initWithFrame:CGRectMake(80, 112, 150, 30)];
            sliderAlpha.maximumValue = 1;
            sliderAlpha.minimumValue = 0;
            sliderAlpha.value = info.attributeDefault.red;
            [sliderAlpha addTarget:self action:@selector(actionSlider:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:sliderAlpha];
            cell.sliderAlpha = sliderAlpha;
            
            [cellArray addObject:cell];
            [cellTypeArray addObject:string];
            
            [sliderArray addObject:sliderRed];
            [sliderArray addObject:sliderGreen];
            [sliderArray addObject:sliderBlue];
            [sliderArray addObject:sliderAlpha];
        }else if( [string isEqualToString:@"CIVector"] ){
#warning vector在这个例子里都为初始数值，不能改变，测试后CIPerspectiveTile不能正常工作，需要修改相应vector
            SHPSModel_info_vector *info = [[SHPSModel_info_vector alloc] init];
            NSString *string2 = [valueDic objectForKey:@"CIAttributeDefault"];
            NSString *string1 = [NSString stringWithFormat:@"%@",string2];
            //NSString *temp = [NSString stringWithUTF8String:string];
            if ( [obj isEqualToString:@"inputCenter"] ) {
                info.attributeDefault = [CIVector vectorWithX:768/2 Y:1024/2];
            }else{
                info.attributeDefault = [CIVector vectorWithString:string1];
            }
            
            // NSLog(@"___________color = %@",info.attributeDefault );
            info.attributeType = [valueDic objectForKey:@"CIAttributeType"];
            info.keyString = obj;
            
            SHPSUIView_CIVector__cell *cell = [[SHPSUIView_CIVector__cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VectorCell"];
            cell.info = info;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 7, 180, 30)];
            label.backgroundColor = [UIColor clearColor];
            label.adjustsFontSizeToFitWidth = YES;
            label.text = [NSString stringWithFormat:@"%@:%@",obj,string1];
            [cell addSubview:label];
            
            [cellArray addObject:cell];
            [cellTypeArray addObject:string];
        }else if( [string isEqualToString:@"NSValue"] ){
            SHPSModel_info_value *info = [[SHPSModel_info_value alloc] init];
            info.attributeDefault = [valueDic objectForKey:@"CIAttributeDefault"];
            info.attributeType = [valueDic objectForKey:@"CIAttributeType"];
            info.keyString = obj;
            
            SHPSUIView_NSValue__cell *cell = [[SHPSUIView_NSValue__cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ValueCell"];
            cell.info = info;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 7, 180, 30)];
            label.backgroundColor = [UIColor clearColor];
            label.adjustsFontSizeToFitWidth = YES;
            label.text = [NSString stringWithFormat:@"%@:%@",obj,info.attributeType];
            [cell addSubview:label];
            
            [cellArray addObject:cell];
            [cellTypeArray addObject:string];
        }
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [popController dismissPopoverAnimated:YES];
    
    [sliderActionTimer invalidate];
    sliderActionTimer = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    if ( sliderActionTimer == nil ) {
        sliderActionTimer = [NSTimer scheduledTimerWithTimeInterval:0.08 target:self selector:@selector(actionTimer) userInfo:nil repeats:YES];
    }
}


-(void)resetBGImage:(UIImage *)image{
    bgImageView.image = image;
    beginImage = [CIImage imageWithCGImage:[bgImageView.image CGImage]];
    [self actionSlider:nil];
}


-(void)resetBeginImage{
     beginImage = [CIImage imageWithCGImage:[bgImageView.image CGImage]];
    inputImageView.image = bgImageView.image;
    
    [self actionSlider:nil];
}

-(id)init{
    
    self = [super init];
    if ( self ) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionSlider:) name:@"beginFilter" object:[UIDevice currentDevice]];
        
        sliderActionTimer = [NSTimer scheduledTimerWithTimeInterval:0.08 target:self selector:@selector(actionTimer) userInfo:nil repeats:YES];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    cellTypeArray = [[NSMutableArray alloc] init];
    cellArray = [[NSMutableArray alloc] init];
    attributeController = [[UITableViewController alloc] init];
    attributeController.tableView.delegate = self;
    attributeController.tableView.dataSource = self;
    popController = [[UIPopoverController alloc] initWithContentViewController:attributeController];
    popController.popoverContentSize = CGSizeMake(320, 480);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"setting" style:UIBarButtonItemStyleBordered target:self action:@selector(actionSetting:)];
    
    beginImage = [CIImage imageWithCGImage:[[UIImage imageNamed:@"image1.PNG"] CGImage]];
    // 创建基于GPU的CIContext对象
    context = [CIContext contextWithOptions: nil];
    
    sliderArray = [[NSMutableArray alloc] init];
    imageArray = [[NSMutableArray alloc] init];
    
    bgImageView = [[SHPSUIView_image alloc] initWithImage:[UIImage imageNamed:@"image1.PNG"]];
    bgImageView.controller = self;
    bgImageView.isNeedResetBeginImage = YES;
    [self.view addSubview:bgImageView];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ Demo",self.filterName];
    
    fliter = [CIFilter filterWithName:self.filterName];
    key = [[fliter attributes] allKeys];
    value = [[fliter attributes] allValues];
    
    //NSLog(@"_____________%@",[[fliter attributes] description]);
    
    id obj = [value objectAtIndex:0];
    if ( [obj isKindOfClass:[NSDictionary class]] ) {
        //NSLog(@"1111111111111111111");
    }
    NSLog(@"___________key = %@  value = %@",key,value);
    
    [self createViewWithAttributes];
    
    [self actionSlider:nil];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSString * ) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"setting";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"++++++++++%d",[cellTypeArray count]);
    return [cellTypeArray count];
    // Return the number of rows in the section.
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
    }
    
    // Configure the cell...
    
    
    /*CIFilter *filter = [CIFilter filterWithName:filterName];
     NSDictionary *dictionary = [filter attributes];
     NSArray *key = [dictionary allKeys];
     NSArray *value = [dictionary allValues];
     cell.textLabel.text = [NSString stringWithFormat:@"key:%@__value:%@",[key objectAtIndex:indexPath.row],[value objectAtIndex:indexPath.row]];
     cell.textLabel.numberOfLines = 0;*/
    
    // NSLog(@"key = %@,value = %@",[key objectAtIndex:indexPath.row],[value objectAtIndex:indexPath.row]);
    
    return [cellArray objectAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *string = [cellTypeArray objectAtIndex:indexPath.row];
    if ( [string isEqualToString:@"NSNumber"] ) {
        return 44;
    }else if( [string isEqualToString:@"CIImage"] ){
        return 120;
    }else if( [string isEqualToString:@"CIColor"] ){
        return 150;
    }else{
        return 44;
    }
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"beginFilter" object:nil];
    
}


@end
