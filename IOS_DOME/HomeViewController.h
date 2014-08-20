//
//  HomeViewController.h
//  IOS_DOME
//
//  Created by lg雷刚 on 14-7-31.
//  Copyright (c) 2014年 lg雷刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThreadViewController.h"
#import "ScreenShotViewController.h"
#import "PieChartViewController.h"
#import "LocationViewController.h"
#import "WXShareViewController.h"

@interface HomeViewController : UIRootViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *thetableview;
}

@end
