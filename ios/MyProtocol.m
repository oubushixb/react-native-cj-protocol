//
//  MyProtocol.m
//  fanju
//
//  Created by 陈俊 on 16/8/26.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "MyProtocol.h"
#import "MyProtocolRCT.h"

static MyProtocolRCT *rctProtocol = nil;
static double LAST_REQUEST_TIME = 0;
static NSString *LAST_REQUEST = nil;

@implementation MyProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
  
  NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:[request URL] resolvingAgainstBaseURL: NO];
  urlComponents.query = nil;
  urlComponents.fragment = nil;
  NSString *urlStr = [[request URL] absoluteString];
  
  /*[myrct triggerRequest:@{
   @"header": [request allHTTPHeaderFields],
   @"url": urlStr
   }];*/
  /*NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:
   @"header", [request allHTTPHeaderFields],
   @"url", urlStr,
   nil];*/
  //[myrct triggerRequest:[request allHTTPHeaderFields]];
  
  double now = [[NSDate date] timeIntervalSince1970];
  
  /*if(now - LAST_REQUEST_TIME < 300 && [LAST_REQUEST isEqualToString:urlStr]) {
   return NO;
   }*/
  
  NSArray* urlList = [MyProtocolRCT getUrlList];
  
#if DEUBG
  if([urlStr rangeOfString:@"m3u8"].location != NSNotFound) {
    NSLog(@"检测到特殊request: %@", [[request URL] absoluteString]);
  }
  
  if([urlStr rangeOfString:@".mp4"].location != NSNotFound) {
    NSLog(@"检测到特殊request: %@", [[request URL] absoluteString]);
  }
#endif
  
  for (int i=0; i<[urlList count]; i++) {
    NSString *whiteStr = [urlList objectAtIndex:i];
    
    if([urlStr rangeOfString:whiteStr].location != NSNotFound) {
      NSLog(@"检测到特殊request: %@", [[request URL] absoluteString]);
      [myrct trigger:urlStr];
      [myrct triggerRequest:request];
      //[rctProtocol trigger:[[request URL] absoluteString]];
      LAST_REQUEST = [[request URL] absoluteString];
      LAST_REQUEST_TIME = now;
    }
  }
  
  return NO;
}

/*+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
 return request;
 NSMutableURLRequest *mRequest = [request mutableCopy];
 NSString *fieldValue = @"https://www.bilibili.com";
 [mRequest setValue:fieldValue forHTTPHeaderField:@"Referer"];
 return mRequest;
 }*/

@end
