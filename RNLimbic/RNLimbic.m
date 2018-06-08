//
//  LimbicRN.m
//  LimbicRN
//
//  Created by Bas de Vries on 5/21/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RNLimbic.h"
#import <Limbic/Limbic-Swift.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTLog.h>

@implementation RNLimbic

// Export LimbicRN module
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(
                  getStressForCurrentUser:(NSDate *)startDate
                  endDate:(NSDate *)endDate
                  data:(NSDictionary *)data
                  api_key:(NSString *)api_key
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject
                  ) {
    Limbic.apiKey = api_key;
    Limbic *limbic = [[Limbic alloc] init];
    [limbic
     getStressForCurrentUserWithStartDate:startDate
     endDate:endDate
     data:data
     completionHandler:^(NSDictionary<NSDate *,NSDictionary<NSString *,NSNumber *> *> * _Nullable results, NSError * _Nullable error) {
         NSLog(@"error: %@", error);
         if (results != nil) {
             NSArray *keys = [results allKeys];
             NSMutableArray *entries = [NSMutableArray arrayWithCapacity:[keys count]];
             
             [keys enumerateObjectsUsingBlock:^(NSDate *key, NSUInteger idx, BOOL *stop) {
                 NSNumber *nsnumber_time = [NSNumber numberWithDouble:key.timeIntervalSince1970];
                 NSDictionary *entry = @{
                                         @"key": nsnumber_time,
                                         @"value": results[key],
                                         };
                 [entries addObject:entry];
             }];
             
             resolve(entries);
             
         } else {
             RCTLog(@"error");
             NSLog(@"%@",error);
             reject([NSString stringWithFormat:@"%li", error.code], @"A Limbic error occured", error);
         }
     }
     ];
}

//RCT_EXPORT_METHOD(getLastDayStressForCurrentUser: resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
//  Limbic *limbic = [[Limbic alloc] init];
//  [limbic getLastDayStressForCurrentUserWithCompletionHandler:^(NSDictionary<NSNumber *,NSDictionary<NSString *,NSNumber *> *> * _Nullable results, NSError * _Nullable error) {
//    if (results != nil) {
//      resolve(results);
//    } else {
//      reject(@"Limbic error", @"", error);
//    }
//  }];
//}
//
//RCT_EXPORT_METHOD(getLastWeekStressForCurrentUser: resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
//  Limbic *limbic = [[Limbic alloc] init];
//  [limbic getLastWeekStressForCurrentUserWithCompletionHandler:^(NSDictionary<NSNumber *,NSDictionary<NSString *,NSNumber *> *> * _Nullable results, NSError * _Nullable error) {
//    if (results != nil) {
//      resolve(results);
//    } else {
//      reject(@"Limbic error", @"", error);
//    }
//  }];
//}
//
//RCT_EXPORT_METHOD(getLastMonthStressForCurrentUser: resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
//  Limbic *limbic = [[Limbic alloc] init];
//  [limbic getLastMonthStressForCurrentUserWithCompletionHandler:^(NSDictionary<NSNumber *,NSDictionary<NSString *,NSNumber *> *> * _Nullable results, NSError * _Nullable error) {
//    if (results != nil) {
//      resolve(results);
//    } else {
//      reject(@"Limbic error", @"", error);
//    }
//  }];
//}
//
//RCT_EXPORT_METHOD(getLastYearStressForCurrentUser: resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
//  Limbic *limbic = [[Limbic alloc] init];
//  [limbic getLastYearStressForCurrentUserWithCompletionHandler:^(NSDictionary<NSNumber *,NSDictionary<NSString *,NSNumber *> *> * _Nullable results, NSError * _Nullable error) {
//    if (results != nil) {
//      resolve(results);
//    } else {
//      reject(@"Limbic error", @"", error);
//    }
//  }];
//}

@end
