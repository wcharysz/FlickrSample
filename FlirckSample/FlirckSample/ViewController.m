//
//  ViewController.m
//  FlirckSample
//
//  Created by Wojtek Charysz on 11.05.15.
//  Copyright (c) 2015 Wojciech Charysz. All rights reserved.
//

#import "ViewController.h"
#import "FlickrServicesController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[FlickrServicesController instance] requestTokenWithCompletion:^(NSString *token, NSString *tokenSecret) {
        
        NSLog(@"token: %@",token);
        NSLog(@"tokenSecret: %@",tokenSecret);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
