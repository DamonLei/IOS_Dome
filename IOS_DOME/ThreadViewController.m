//
//  ThreadViewController.m
//  IOS_DOME
//
//  Created by lg雷刚 on 14-7-31.
//  Copyright (c) 2014年 lg雷刚. All rights reserved.
//

#import "ThreadViewController.h"
//#define kURL @"http://images.cnitblog.com/i/607542/201405/041553036424817.png"
#define kURL @"http://dl2.itools.hk/dl/iTools_2.1.2.dmg"


@interface ThreadViewController (){
    NSOperationQueue *queue;
}

@end

@implementation ThreadViewController

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
    self.title = @"线程";
    
    queue = [[NSOperationQueue alloc]init];
    [queue setMaxConcurrentOperationCount:1];
    
    for (int i = 0; i < 5; i++) {
        NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self
                                                                               selector:@selector(downloadImage:)
                                                                                 object:kURL];
        [queue addOperation:operation];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nowOperation) userInfo:nil repeats:YES];
}

-(void)downloadImage:(NSString *)url{
    NSLog(@"url:%@", url);
    NSURL *nsUrl = [NSURL URLWithString:url];
    NSData *data = [[NSData alloc]initWithContentsOfURL:nsUrl];
    UIImage * image = [[UIImage alloc]initWithData:data];
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
}
-(void)updateUI:(UIImage*) image{
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (void)nowOperation{
    NSLog(@"当前有%li个进程",queue.operationCount);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
