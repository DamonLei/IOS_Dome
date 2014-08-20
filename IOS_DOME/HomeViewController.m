

//
//  HomeViewController.m
//  IOS_DOME
//
//  Created by lg雷刚 on 14-7-31.
//  Copyright (c) 2014年 lg雷刚. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
{
    NSMutableArray *dataAry;
}
@end

@implementation HomeViewController

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
    self.title = @"首页";
    
    dataAry = [[NSMutableArray alloc]initWithObjects:
               @"线程",
               @"截图",
               @"饼图",
               @"定位",
               @"微信",nil];
    
    if (IS_IOS7) {
        thetableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0,BOUNDS_WIDTH,BOUNDS_HEIGHT-64) style:UITableViewStyleGrouped];
    }else{
        thetableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0,BOUNDS_WIDTH,BOUNDS_HEIGHT-64) style:UITableViewStyleGrouped];
    }
    [thetableview setDelegate:self];
    [thetableview setDataSource:self];
    [thetableview setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:thetableview];
    
}

#pragma mark - ---------> UITableviewDelegate <---------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataAry.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellstr = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellstr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstr];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.textColor = [UIColor blackColor];
    }
    cell.textLabel.text = [dataAry objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            ThreadViewController *threadVC = [[ThreadViewController alloc]init];
            [self.navigationController pushViewController:threadVC animated:YES];
        }
            break;
        case 1:
        {
            ScreenShotViewController *screenShotVC = [[ScreenShotViewController alloc]init];
            [self.navigationController pushViewController:screenShotVC animated:YES];
        }
            break;
        case 2:
        {
            PieChartViewController *pieChartVC = [[PieChartViewController alloc]init];
            [self.navigationController pushViewController:pieChartVC animated:YES];
        }
            break;
        case 3:
        {
            LocationViewController *locationVC = [[LocationViewController alloc]init];
            [self.navigationController pushViewController:locationVC animated:YES];
        }
            break;
        case 4:
        {
            WXShareViewController *wxshareVC = [[WXShareViewController alloc]init];
            [self.navigationController pushViewController:wxshareVC animated:YES];
        }
            break;
        default:
            break;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0,0,320,1);
    view.backgroundColor = [UIColor redColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section != 3) {
        return 10.0f;
    }
    return 0.01;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0,0,320,1);
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
