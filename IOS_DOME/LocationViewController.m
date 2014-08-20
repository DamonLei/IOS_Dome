//
//  LocationViewController.m
//  IOS_DOME
//
//  Created by lg雷刚 on 14-8-1.
//  Copyright (c) 2014年 lg雷刚. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController (){
    CLLocationManager *locationManager;
    UILabel *locationStr;
}

@end

@implementation LocationViewController

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
    self.title = @"定位";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake((320-100)/2,BOUNDS_HEIGHT-130-64,100,100);
    but.backgroundColor = [UIColor orangeColor];
    but.titleLabel.textColor = [UIColor whiteColor];
    but.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [but setTitle:@"定位" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(startLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    but.layer.masksToBounds = YES;
    but.layer.cornerRadius = 50;
    
    locationStr = [[UILabel alloc]init];
    locationStr.frame = CGRectMake(10,50,300,300);
    locationStr.backgroundColor = [UIColor clearColor];
    locationStr.font = [UIFont systemFontOfSize:16];
    locationStr.textAlignment = NSTextAlignmentCenter;
    locationStr.textColor = [UIColor blackColor];
    locationStr.text = @"暂无定位";
    locationStr.numberOfLines = 0;
    [self.view addSubview:locationStr];
}

- (void)startLocation{
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];//创建位置管理器
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 1000.0f;
        //启动位置更新
        [locationManager startUpdatingLocation];
    }else {
        locationStr.text = @"没有开启定位！请在设置>隐私>定位>开始定位服务";
    }
    
    [locationManager startUpdatingLocation];
    
}
//  定位成功
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    //当前坐标
    locationStr.text = [NSString stringWithFormat:@"当前坐标:%0.6f,%0.6f\n",newLocation.coordinate.latitude,newLocation.coordinate.longitude];
    
    
    //    当前的水平距离
//    NSString *currentHorizontalAccuracy =
//    [[NSString alloc]
//     initWithFormat:@"%g",
//     newLocation.horizontalAccuracy];
//    horizontalAccuracy.text = currentHorizontalAccuracy;
    locationStr.text = [NSString stringWithFormat:@"%@当前的水平距离:%g\n",locationStr.text,newLocation.horizontalAccuracy];
    
    
//    NSString *currentAltitude = [[NSString alloc]
//                                 initWithFormat:@"%g",
//                                 newLocation.altitude];
    
    locationStr.text = [NSString stringWithFormat:@"%@当前的高度:%g\n",locationStr.text,newLocation.horizontalAccuracy];
    
//    NSString *currentVerticalAccuracy =
//    [[NSString alloc]
//     initWithFormat:@"%g",
//     newLocation.verticalAccuracy];
//    verticalAccuracy.text = currentVerticalAccuracy;
    
    locationStr.text = [NSString stringWithFormat:@"%@当前的垂直线:%g\n",locationStr.text,newLocation.verticalAccuracy];
    
    if (oldLocation == nil)
        oldLocation = newLocation;
    
    CLLocationDistance distanceBetween = [newLocation
                                          distanceFromLocation:oldLocation];
    
    NSString *tripString = [[NSString alloc]
                            initWithFormat:@"%f",
                            distanceBetween];
//    distance.text = tripString;
    locationStr.text = [NSString stringWithFormat:@"%@当前移动距离:%@\n",locationStr.text,tripString];
    
    //定位城市通过CLGeocoder
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            
            NSString *test = [placemark locality];
            NSLog(@"%@", test);
//            self.myCity.text = [NSString stringWithFormat:@"%@",placemark];
            locationStr.text = [NSString stringWithFormat:@"%@当前城市:%@\n",locationStr.text,placemark];
        }
    }];
}
//  定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    CLLocationCoordinate2D coor = currentLocation.coordinate;
    locationStr.text = [NSString stringWithFormat:@"定位坐标:%0.6f,%0.6f",coor.latitude,coor.longitude];
    NSLog(@"%@",[NSString stringWithFormat:@"定位坐标:%0.6f,%0.6f",coor.latitude,coor.longitude]);
    
    //得到newLocation
    CLLocation *loc = [locations objectAtIndex:0];
    //判断是不是属于国内范围
    if (![WGS84TOGCJ02 isLocationOutOfChina:[loc coordinate]]) {
        //转换后的coord
        CLLocationCoordinate2D coord = [WGS84TOGCJ02 transformFromWGSToGCJ:[loc coordinate]];
        NSLog(@"%@",[NSString stringWithFormat:@"纠正定位坐标:%0.6f,%0.6f",coord.latitude,coord.longitude]);
    }
    
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //Geocoding Block
    [geocoder reverseGeocodeLocation: manager.location completionHandler:^(NSArray *placemarks, NSError *error) {
        //Get nearby address
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        //String to hold address
        NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
        
        locationStr.text = [NSString stringWithFormat:@"%@当前位置:%@",locationStr.text,locatedAt];
        
        //Print the location to console
        NSLog(@"I am currently at %@",locatedAt);
        NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
        NSLog(@"placemark.country %@",placemark.country);
        NSLog(@"placemark.postalCode %@",placemark.postalCode);
        NSLog(@"placemark.administrativeArea %@",placemark.administrativeArea);
        NSLog(@"placemark.locality %@",placemark.locality);
        NSLog(@"placemark.subLocality %@",placemark.subLocality);
        NSLog(@"placemark.subThoroughfare %@",placemark.subThoroughfare);
    }];
    
    [locationManager stopUpdatingLocation];
}

//  定位失败
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    locationStr.text = @"定位失败";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
