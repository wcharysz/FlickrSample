//
//  FlickrServicesController.m
//  FlirckSample
//
//  Created by Wojtek Charysz on 11.05.15.
//  Copyright (c) 2015 Wojciech Charysz. All rights reserved.
//
// http://stackoverflow.com/questions/15930628/implementing-oauth-1-0-in-an-ios-app

#import "FlickrServicesController.h"
#import "TDOAuth.h"

@implementation FlickrServicesController

+ (instancetype)instance {
    static FlickrServicesController *controller = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[self alloc] init];
    });
    return controller;
}

- (instancetype)init {
    self = [super init];
    if (self)
    {
        _callBackURLString = @"www.example.com";
    }
    return self;
}

- (BOOL)initializeWithAPIKey:(NSString *)newApiKey andSharedSecret:(NSString *)sharedSecret {
    
    apiKey = newApiKey;
    sharedSecretKey = sharedSecret;

    return (apiKey && sharedSecretKey);
}

- (void)requestTokenWithCompletion:(RequestToken)completion {
    
    /*
     NSString *address = [NSString stringWithFormat:@"https://www.flickr.com/services/oauth/authorize?oauth_token=%@",requestToken.key];
     
     NSURL *authURL = [NSURL URLWithString:address];
     */
    
    
    //additional params
    NSDictionary *dict = @{@"oauth_callback": _callBackURLString};
    
    //init request
    NSURLRequest *request = [TDOAuth URLRequestForPath:@"/request_token" GETParameters:dict scheme:@"https" host:@"www.flickr.com/services/oauth" consumerKey:apiKey consumerSecret:sharedSecretKey accessToken:nil tokenSecret:nil];
    
    //call request
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        

        if (!connectionError && data)
        {
            NSString *stringResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"A stringResponse %@",stringResponse);
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            NSArray *split = [stringResponse componentsSeparatedByString:@"&"];
            for (NSString *str in split){
                NSArray *split2 = [str componentsSeparatedByString:@"="];
                
                if (split2.count > 1)
                {
                    [params setObject:split2[1] forKey:split2[0]];
                }
            }
            
            NSString *token = params[@"oauth_token"];
            tokenSecret = params[@"oauth_token_secret"];
            
            NSString *stringAuthForURL = [NSString stringWithFormat:@"https://www.flickr.com/services/oauth/authorize?oauth_token=%@&oauth_callback=%@",token,_callBackURLString];
            
            NSURL *url = [NSURL URLWithString:stringAuthForURL];
            NSURLRequest *authRequest = [[NSURLRequest alloc] initWithURL:url];
                    
            NSLog(@"authRequest url %@",authRequest.URL);
            
            completion(authRequest); 
            
        }
        else
        {
            completion(nil);
        }
    }];
}

- (void)getAccessTokenForRequestToken:(NSString *)requestToken {
    
    NSDictionary *dict = @{@"oauth_callback": _callBackURLString};
    
    //init request
    NSURLRequest *rq = [TDOAuth URLRequestForPath:@"/access_token" GETParameters:dict scheme:@"https" host:@"www.flickr.com/services/oauth" consumerKey:apiKey consumerSecret:sharedSecretKey accessToken:requestToken tokenSecret:tokenSecret];
    
    [NSURLConnection sendAsynchronousRequest:rq queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSString *stringResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"B stringResponse %@",stringResponse);
        
        if (!connectionError && data)
        {
            NSString *stringResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"C stringResponse %@",stringResponse);
        }
    }];
}


#pragma mark UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
   
    
    
}

@end
