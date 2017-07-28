//
//  SHPSUIView_image.m
//  SHPSFileter
//
//  Created by anchang on 13-6-4.
//  Copyright (c) 2013年 shem. All rights reserved.
//

#import "SHPSUIView_image.h"

@implementation SHPSUIView_image

@synthesize controller;
@synthesize isNeedResetBeginImage;
@synthesize isInputImage;

-(void)actionAblum:(id)sender{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    
    if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] ) {
        popController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        popController.popoverContentSize = CGSizeMake(1024, 768);
        [popController presentPopoverFromRect:CGRectMake(0,0,10,10) inView:controller.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"访问相册失败！" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)actionCamera:(id)sender{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    
    if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
        popController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        popController.popoverContentSize = CGSizeMake(1024, 768);
        [popController presentPopoverFromRect:CGRectMake(0,0,10,10) inView:controller.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"读取摄像头失败！" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
        self.userInteractionEnabled = YES;
        singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionAblum:)];
        singleTap.numberOfTapsRequired = 1;
        singleTap.delegate = self;
        [self addGestureRecognizer:singleTap];
        
        doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionCamera:)];
        doubleTap.numberOfTapsRequired = 2;
        doubleTap.delegate = self;
        [self addGestureRecognizer:doubleTap];
        
         [singleTap requireGestureRecognizerToFail:doubleTap];
    }
    
    return self;
}

-(id)initWithImage:(UIImage *)image{
    
    self = [super initWithImage:image];
    if (self) {
        
        self.userInteractionEnabled = YES;
        singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionAblum:)];
        singleTap.numberOfTapsRequired = 1;
        singleTap.delegate = self;
        [self addGestureRecognizer:singleTap];
        
        doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionCamera:)];
        doubleTap.numberOfTapsRequired = 2;
        singleTap.delegate = self;
        [self addGestureRecognizer:doubleTap];
        
        [singleTap requireGestureRecognizerToFail:doubleTap];
    }
    
    return self;
}

#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
	
}

#pragma mark-imagePicker delegate


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
    UIImage *image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.image = image;
    if ( isNeedResetBeginImage && [controller respondsToSelector:@selector(resetBeginImage)] ) {
        [controller performSelector:@selector(resetBeginImage)];
    }
    
    if ( isInputImage && [controller respondsToSelector:@selector(resetBGImage:)] ) {
        [controller performSelector:@selector(resetBGImage:) withObject:image];
    }
    
    [popController dismissPopoverAnimated:YES];

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [popController dismissPopoverAnimated:YES];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
