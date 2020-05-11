//
//  MyProtocolRCT.h
//  fanju
//
//  Created by 陈俊 on 16/9/10.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import "MyProtocol.h"
#import "NSURLProtocol+WKWebViewSupport.h"

extern id myrct;

@interface MyProtocolRCT : RCTEventEmitter <RCTBridgeModule>

- (void)trigger: (NSString *)url;
- (void)triggerRequest: (NSURLRequest *)request;

+ (NSArray *) getUrlList;

@end
