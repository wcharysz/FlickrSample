//
//  FlickrServicesController.h
//  FlirckSample
//
//  Created by Wojtek Charysz on 11.05.15.
//  Copyright (c) 2015 Wojciech Charysz. All rights reserved.
//

@import Foundation;
@import UIKit;

typedef void (^RequestToken) (NSURLRequest *authorizationRequest);

@interface FlickrServicesController : NSObject <UIWebViewDelegate> {
    NSString *apiKey;
    NSString *sharedSecretKey;
}

@property(nonatomic, strong) NSString *callBackURLString;

+ (instancetype)instance;

- (BOOL)initializeWithAPIKey:(NSString *)apiKey andSharedSecret:(NSString *)sharedSecret;
- (void)requestTokenWithCompletion:(RequestToken)completion;
- (NSURLRequest *)getRequestAuthorizeToken:(NSString *)token andSecret:(NSString *)tokenSecret;

@end