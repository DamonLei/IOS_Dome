
//
//  PieCtartViewController.m
//  CTTheme_Golf
//
//  Created by lg雷刚 on 14-5-30.
//  Copyright (c) 2014年 jwl姜卧龙. All rights reserved.
//

#import "PieChartViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PieChartViewController (){
    UILabel *labpie;
    NSMutableArray *pieAry;
    NSTimer *autoTimer;
}

@end

@implementation PieChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"饼图";
    self.view.backgroundColor = [UIColor whiteColor];
    
    pieAry = [NSMutableArray array];
    
    pieChart = [[XYPieChart alloc]initWithFrame:CGRectMake(0,20,320,320)];
    [pieChart setDelegate:self];
    [pieChart setDataSource:self];
    [pieChart setStartPieAngle:M_PI_2];
    [pieChart setAnimationSpeed:1.0];               //动画时长
    [pieChart setShowPercentage:YES];               //显示百分比
    [pieChart setPieBackgroundColor:[UIColor whiteColor]];     //背景色
    [pieChart setPieCenter:CGPointMake(160, 160)];          //中心点
    [pieChart setUserInteractionEnabled:YES];               //是否交互（拆分扇形）
    [pieChart setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:20]];       //字体
    [pieChart setLabelRadius:110];                          //半径
    [pieChart setLabelShadowColor:[UIColor redColor]];         //百分比文字影子颜色
    [self.view addSubview:pieChart];
    
    
    labpie = [[UILabel alloc]init];
    labpie.frame = CGRectMake(100,120,120,120);
    labpie.backgroundColor = [UIColor whiteColor];
    labpie.text = @"%";
    labpie.textAlignment = NSTextAlignmentCenter;
    labpie.font = [UIFont boldSystemFontOfSize:72];
    labpie.layer.cornerRadius = 60;
    [self.view addSubview:labpie];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(10,350,93,40);
    but.backgroundColor = [UIColor orangeColor];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but setTitle:@"刷新" forState:UIControlStateNormal];
    but.tag = 1;
    [but addTarget:self action:@selector(piereadload:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    UIButton *but__ = [UIButton buttonWithType:UIButtonTypeCustom];
    but__.frame = CGRectMake(113,350,93,40);
    but__.backgroundColor = [UIColor orangeColor];
    [but__ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but__ setTitle:@"+" forState:UIControlStateNormal];
    but__.tag = 2;
    [but__ addTarget:self action:@selector(piereadload:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but__];
    
    UIButton *but_ = [UIButton buttonWithType:UIButtonTypeCustom];
    but_.frame = CGRectMake(216,350,93,40);
    but_.backgroundColor = [UIColor orangeColor];
    [but_ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but_ setTitle:@"-" forState:UIControlStateNormal];
    but_.tag = 3;
    [but_ addTarget:self action:@selector(piereadload:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but_];
    
    UIButton *butAuto = [UIButton buttonWithType:UIButtonTypeCustom];
    butAuto.frame = CGRectMake(10,400,300,40);
    butAuto.backgroundColor = [UIColor orangeColor];
    [butAuto setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [butAuto setTitle:@"自动转动" forState:UIControlStateNormal];
    butAuto.tag = 4;
    [butAuto addTarget:self action:@selector(piereadload:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butAuto];
    
    autoTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(autoPie) userInfo:nil repeats:YES];
    [autoTimer setFireDate:[NSDate distantFuture]];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [pieAry addObject:[NSString stringWithFormat:@"%i",arc4random()%100]];
    [pieAry addObject:[NSString stringWithFormat:@"%i",arc4random()%100]];
    [pieAry addObject:[NSString stringWithFormat:@"%i",arc4random()%100]];
    [pieChart reloadData];
}

#pragma mark - ---------> XYPieChartDelegate <----------
#pragma mark DataSource
- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart{
    return pieAry.count;
}
- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index{
    
    return [[pieAry objectAtIndex:index] intValue];
}
- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index{
    return [UIColor colorWithRed:arc4random()%200/255.0 green:arc4random()%200/255.0 blue:arc4random()%200/255.0 alpha:1.0];
}
- (NSString *)pieChart:(XYPieChart *)pieChart textForSliceAtIndex:(NSUInteger)index{
    return @"140";
}

#pragma mark Delegate
- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index{
    NSLog(@"willSelectSliceAtIndex:%li",index);
}
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index{
    NSLog(@"didSelectSliceAtIndex:%li",index);
}
- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index{
    NSLog(@"willDeselectSliceAtIndex:%li",index);
}
- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index{
    NSLog(@"didDeselectSliceAtIndex:%li",index);
}

#pragma mark - ---------> 事件 <----------
- (void)piereadload:(UIButton*)but{
    if (but.tag == 1) {
        [pieAry removeAllObjects];
        [pieAry addObject:[NSString stringWithFormat:@"%i",arc4random()%100]];
        [pieAry addObject:[NSString stringWithFormat:@"%i",arc4random()%100]];
        [pieAry addObject:[NSString stringWithFormat:@"%i",arc4random()%100]];
    }else if (but.tag == 2){
        [pieAry insertObject:[NSString stringWithFormat:@"%i",arc4random()%100] atIndex:0];
    }else if (but.tag == 3){
        if (pieAry.count>0) {
            [pieAry removeLastObject];
        }
    }else if (but.tag == 4){
        if ([but.titleLabel.text isEqualToString:@"自动转动"]) {
            [autoTimer setFireDate:[NSDate date]];
            [but setTitle:@"暂停转动" forState:UIControlStateNormal];
        }else{
            [autoTimer setFireDate:[NSDate distantFuture]];
            [but setTitle:@"自动转动" forState:UIControlStateNormal];
        }
    }
    
    [pieChart reloadData];
}

- (void)autoPie{
    if (pieAry.count > 0) {
        [pieAry insertObject:[pieAry lastObject] atIndex:0];
        [pieAry removeLastObject];
    }
    [pieChart reloadData];
}
#pragma mark - ---------> 内存警告 <----------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
