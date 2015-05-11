//
//  FlickrServicesController.h
//  FlirckSample
//
//  Created by Wojtek Charysz on 11.05.15.
//  Copyright (c) 2015 Wojciech Charysz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestToken) (NSString *token, NSString *tokenSecret);

@interface FlickrServicesController : NSObject {
    NSString *apiKey;
    NSString *sharedSecretKey;
    NSString *callBackURL;
}

+ (instancetype)instance;

- (BOOL)initializeWithAPIKey:(NSString *)apiKey andSharedSecret:(NSString *)sharedSecret;
- (void)requestTokenWithCompletion:(RequestToken)completion;

@end