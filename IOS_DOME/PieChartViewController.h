//
//  PieCtartViewController.h
//  CTTheme_Golf
//
//  Created by lg雷刚 on 14-5-30.
//  Copyright (c) 2014年 jwl姜卧龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"

@interface PieChartViewController : UIRootViewController<XYPieChartDelegate,XYPieChartDataSource>{
    XYPieChart *pieChart;
}

@end
