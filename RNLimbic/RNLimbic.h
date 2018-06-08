//
//  LimbicRN.h
//  LimbicRN
//
//  Created by Bas de Vries on 5/21/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#ifndef RNLimbic_h
#define RNLimbic_h
#import <React/RCTBridgeModule.h>

@interface RNLimbic : NSObject <RCTBridgeModule>

@property(nonatomic, strong) NSString *apiKey;

@end

#endif /* LimbicRN_h */
