//
//  MyProtocolRCT.m
//  fanju
//
//  Created by 陈俊 on 16/9/10.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "MyProtocolRCT.h"

id myrct = nil;
static NSArray *urlList;

@implementation MyProtocolRCT

RCT_EXPORT_MODULE();

- (id)init {
  if (self = [super init]) {
    
  }
  
  myrct = self;
  return self;
}

- (NSArray<NSString *> *)supportedEvents {
  return @[@"VIDEO_FIND", @"REQUEST_FIND"];
}

- (void)trigger: (NSString *)url {
  //[self.bridge.eventDispatcher sendAppEventWithName:@"VIDEO_FIND" body:@{@"url": url}];
  [self sendEventWithName:@"VIDEO_FIND" body:@{@"url": url}];
}

- (void)triggerRequest: (NSURLRequest *)request {
  NSMutableDictionary *body = [[request allHTTPHeaderFields] mutableCopy];
  if(!body) {
    body = [NSMutableDictionary dictionary];
  }
  [body setValue:[[request URL] absoluteString] forKey:@"url"];
  [self sendEventWithName:@"REQUEST_FIND" body:body];
}

RCT_EXPORT_METHOD(setUrlList:(NSArray *) list) {
  urlList = list;
}

RCT_EXPORT_METHOD(supportRequest) {
  
}

RCT_EXPORT_METHOD(registeProtocol) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSURLProtocol wk_registerScheme:@"http"];
        [NSURLProtocol wk_registerScheme:@"https"];
        [NSURLProtocol registerClass:[MyProtocol class]];
    });
}

+ (NSArray *) getUrlList {
  return urlList;
}

@end
