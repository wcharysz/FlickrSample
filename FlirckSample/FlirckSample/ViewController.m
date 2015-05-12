//
//  ViewController.m
//  FlirckSample
//
//  Created by Wojtek Charysz on 11.05.15.
//  Copyright (c) 2015 Wojciech Charysz. All rights reserved.
//

#import "ViewController.h"
#import "FlickrServicesController.h"
#import "FlickrAuthViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[FlickrServicesController instance] requestTokenWithCompletion:^(NSURLRequest *authorizationRequest) {
        
        if (authorizationRequest)
        {
            FlickrAuthViewController *authViewController = [[FlickrAuthViewController alloc] init];
            authViewController.view.frame = self.view.frame;
            
            authViewController.webView.delegate = [FlickrServicesController instance];
            
            [self presentViewController:authViewController animated:YES completion:^{
                [authViewController.webView loadRequest:authorizationRequest];
            }];
        }
        
    }];
    
    /*
    [[FlickrServicesController instance] requestTokenWithCompletion:^(NSString *token, NSString *tokenSecret) {
        
        
        
        NSLog(@"token: %@",token);
        NSLog(@"tokenSecret: %@",tokenSecret);
        
        if (token && tokenSecret)
        {
            NSURLRequest *authRequest = [[FlickrServicesController instance] getRequestAuthorizeToken:token andSecret:tokenSecret];
            
            if (authRequest)
            {
                FlickrAuthViewController *authViewController = [[FlickrAuthViewController alloc] init];
                authViewController.view.frame = self.view.frame;
                
                authViewController.webView.delegate = [FlickrServicesController instance];
                
                [self presentViewController:authViewController animated:YES completion:^{
                    [authViewController.webView loadRequest:authRequest];
                }];
            }
        }
         
    }];
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
