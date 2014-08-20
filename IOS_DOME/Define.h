//
//  Define.h
//  IOS_DOME
//
//  Created by lg雷刚 on 14-7-31.
//  Copyright (c) 2014年 lg雷刚. All rights reserved.
//

#define IS_IOS7         ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_IPHONE5      ([[UIScreen mainScreen] bounds].size.height == 568.0f)
#define BOUNDS_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define BOUNDS_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
