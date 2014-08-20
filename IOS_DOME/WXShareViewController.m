//
//  WXShareViewController.m
//  IOS_DOME
//
//  Created by lg雷刚 on 14-8-4.
//  Copyright (c) 2014年 lg雷刚. All rights reserved.
//

#import "WXShareViewController.h"

#define imgURL @"http://img0.bdstatic.com/img/image/shouye/lymedff037.jpg"

@interface WXShareViewController ()
{
    UIImageView *sendImage;
    UITextField *sendtitle;
    UITextField *sendText;
    UITextField *sendLink;
}

@end

@implementation WXShareViewController

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
    self.title = @"微信";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    sendImage = [[UIImageView alloc]init];
    sendImage.frame = CGRectMake(10,30,60,60);
    sendImage.layer.borderWidth = 0.5f;
    sendImage.layer.borderColor = [UIColor blueColor].CGColor;
//    sendImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]]];
    [self.view addSubview:sendImage];
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue setMaxConcurrentOperationCount:1];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self
                                                                           selector:@selector(downloadImage:)
                                                                             object:imgURL];
    [queue addOperation:operation];
    
    
    sendtitle = [[UITextField alloc]init];
    sendtitle.frame = CGRectMake(80,10,210,30);
    sendtitle.backgroundColor = [UIColor clearColor];
    sendtitle.placeholder = @"请输入分享标题";
    sendtitle.font = [UIFont systemFontOfSize:14];
    sendtitle.borderStyle = UITextBorderStyleLine;
    sendtitle.text = @"1234567890";
    [self.view addSubview:sendtitle];
    
    sendText = [[UITextField alloc]init];
    sendText.frame = CGRectMake(80,45,210,30);
    sendText.backgroundColor = [UIColor clearColor];
    sendText.placeholder = @"请输入分享内容";
    sendText.font = [UIFont systemFontOfSize:14];
    sendText.borderStyle = UITextBorderStyleLine;
    sendText.text = @"1234567890";
    [self.view addSubview:sendText];
    
    sendLink = [[UITextField alloc]init];
    sendLink.frame = CGRectMake(80,80,210,30);
    sendLink.backgroundColor = [UIColor clearColor];
    sendLink.placeholder = @"请输入分享链接";
    sendLink.font = [UIFont systemFontOfSize:14];
    sendLink.text = imgURL;
    sendLink.borderStyle = UITextBorderStyleLine;
    sendLink.layer.borderColor = [UIColor blueColor].CGColor;
    [self.view addSubview:sendLink];
    
    {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKey)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [self.view addGestureRecognizer:tapGesture];
    }
    
    UIButton *send_friend = [UIButton buttonWithType:UIButtonTypeCustom];
    [send_friend setFrame:CGRectMake(10,120,140,40)];
    [send_friend setBackgroundColor:[UIColor grayColor]];
    [send_friend setTitle:@"微信好友" forState:UIControlStateNormal];
    [send_friend addTarget:self action:@selector(sendFriend) forControlEvents:UIControlEventTouchUpInside];
    send_friend.layer.cornerRadius = 5;
    [self.view addSubview:send_friend];
    
    UIButton *send_friends = [UIButton buttonWithType:UIButtonTypeCustom];
    [send_friends setFrame:CGRectMake(160,120,140,40)];
    [send_friends setBackgroundColor:[UIColor grayColor]];
    [send_friends setTitle:@"微信朋友圈" forState:UIControlStateNormal];
    [send_friends addTarget:self action:@selector(sendFriends) forControlEvents:UIControlEventTouchUpInside];
    send_friends.layer.cornerRadius = 5;
    [self.view addSubview:send_friends];
    
}

- (void)sendFriend{
    
}

- (void)sendFriends{
    
}

- (void)closeKey{
    [sendtitle resignFirstResponder];
    [sendText resignFirstResponder];
    [sendLink resignFirstResponder];
}

-(void)downloadImage:(NSString *)url{
    NSLog(@"url:%@", url);
    NSURL *nsUrl = [NSURL URLWithString:url];
    NSData *data = [[NSData alloc]initWithContentsOfURL:nsUrl];
    UIImage * image = [[UIImage alloc]initWithData:data];
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
}
-(void)updateUI:(UIImage*) image{
    sendImage.image = image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
