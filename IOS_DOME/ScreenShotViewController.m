//
//  ScreenShotViewController.m
//  IOS_DOME
//
//  Created by lg雷刚 on 14-7-29.
//  Copyright (c) 2014年 lg雷刚. All rights reserved.
//

#import "ScreenShotViewController.h"

@interface ScreenShotViewController ()
{
    UIImageView *imageview;
    UIPickerView *polePicker;
    
    float width;
    float height;
}
@end
#define colorRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@implementation ScreenShotViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"截图";
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake((320-200)/3,10,100,50);
    but.backgroundColor = [UIColor orangeColor];
    but.titleLabel.textColor = [UIColor whiteColor];
    but.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [but setTitle:@"截屏" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(getImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    but.layer.masksToBounds = YES;
    but.layer.cornerRadius = 25;
    
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    but2.frame = CGRectMake(320-100-(320-200)/3,10,100,50);
    but2.backgroundColor = [UIColor orangeColor];
    but2.titleLabel.textColor = [UIColor whiteColor];
    but2.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [but2 setTitle:@"恢复" forState:UIControlStateNormal];
    [but2 addTarget:self action:@selector(clearImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but2];
    but2.layer.masksToBounds = YES;
    but2.layer.cornerRadius = 25;
    
    imageview  = [[UIImageView alloc]init];
    imageview.backgroundColor = [UIColor whiteColor];
    imageview.frame = CGRectMake(60,80,200,250);
    imageview.layer.borderColor = [UIColor orangeColor].CGColor;
    imageview.layer.shadowColor = [UIColor grayColor].CGColor;
    imageview.layer.borderWidth = 0.5f;
    imageview.layer.masksToBounds = YES;
    imageview.layer.cornerRadius = 5;
    [self.view addSubview:imageview];
    
    [self getPic];
    
}
- (void)getImage{
    [imageview setImage:[self getNormalImage:self.view]];
}
- (void)clearImage{
    imageview.image = nil;
    [self getPic];
}
- (void)getPic{
    if (polePicker != nil) {
        [polePicker removeFromSuperview];
    }
    polePicker = [[UIPickerView alloc] init];
    polePicker.backgroundColor = colorRGBA(50,250,200,1.0);
    polePicker.frame = CGRectMake(0, height - 162 - 64, 320, 160);
    polePicker.backgroundColor = [UIColor whiteColor];
    polePicker.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth; //这里设置了就可以自定义高度了，一般默认是无法修改其216像素的高度
    polePicker.dataSource = self;
    polePicker.delegate = self;
    polePicker.tag = 1;
    polePicker.showsSelectionIndicator = YES;    //这个最好写
    [self.view addSubview:polePicker];
    polePicker.layer.borderWidth = 0.5f;
    polePicker.layer.borderColor = [UIColor orangeColor].CGColor;
}
//获取当前屏幕内容
- (UIImage *)getNormalImage:(UIView *)view{
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - --------------> UIPickerViewDataSoure <--------------
//Picker有几列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
//Picker每列有几行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 10;
}
#pragma mark UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 100;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}
- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *labpar = [[UILabel alloc]init];
    labpar.text = [NSString stringWithFormat:@"%li",(long)row];
    labpar.backgroundColor = [UIColor clearColor];
    labpar.font = [UIFont boldSystemFontOfSize:30];
    labpar.textAlignment = NSTextAlignmentCenter;
    return labpar;
}
////选中某一行
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    if (component == 0) {
//        oneHolePar.text = [NSString stringWithFormat:@"%i",row];
//    }else if (component == 1){
//        oneHolePutt.text = [NSString stringWithFormat:@"%i",row];
//    }
//    [pickerView reloadComponent:2];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
