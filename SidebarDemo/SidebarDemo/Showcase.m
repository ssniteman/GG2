//
//  Showcase.m
//  SidebarDemo
//
//  Created by Shane Sniteman on 10/16/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "Showcase.h"


#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface Showcase ()<UIWebViewDelegate>

@end

@implementation Showcase{
    UIActivityIndicatorView * loading;
}


-(void)webViewDidStartLoad:(UIWebView *)webView{
    [loading startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [loading stopAnimating];
}



-(void)setLink:(NSString *)link{
    _link = link;
    
    self.webView.delegate = self;

    loading=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    loading.center = CGPointMake(SCREEN_WIDTH/2-15, SCREEN_HEIGHT/2-15);
    
    
    [loading startAnimating];
    
    
    
    

loading.color = [UIColor colorWithRed:0.753f green:0.251f blue:0.204f alpha:1.0f];
[self.view addSubview:loading];


}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //RIGHT MENU BUTTON
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveButton)];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
    saveButton.tintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    
    //Left MENU BUTTON
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButton)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    cancelButton.tintColor = [UIColor colorWithRed:0.859f green:0.282f blue:0.255f alpha:1.0f];
    
    
    // Do any additional setup after loading the view.
    self.webView.delegate = self;

    NSURL *url = [NSURL URLWithString:self.link];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

@end