//
//  FlickrAuthViewController.m
//  FlirckSample
//
//  Created by Wojtek Charysz on 12.05.15.
//  Copyright (c) 2015 Wojciech Charysz. All rights reserved.
//

#import "FlickrAuthViewController.h"
#import "FlickrServicesController.h"

@interface FlickrAuthViewController ()

@end

@implementation FlickrAuthViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!_webView)
        {
            _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
            _webView.delegate = self;
            [self.view addSubview:_webView];
        } else {
            _webView.frame = self.view.frame;
        }
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSRange range = [webView.request.URL.absoluteString rangeOfString:@"oauth_verifier"];
    if (range.location != NSNotFound) {
        //[self.navigationController popViewControllerAnimated:YES];
        
        //oautch_verifier has 16 characters
        NSString *oauth_verifier = [webView.request.URL.absoluteString substringFromIndex:webView.request.URL.absoluteString.length - 16];
        NSLog(@"oauth_verifier: %@",oauth_verifier);
        
        [self dismissViewControllerAnimated:YES completion:^{
            [[FlickrServicesController instance] getAccessTokenForRequestToken:oauth_verifier];
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
