//
//  SMRotaryProtocol.h
//  RotaryWheelProject
//
//  Created by Chen Zhang on 12-2-23.
//  Copyright (c) 2012年 utas. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMRotaryProtocol <NSObject>

- (void) wheelDidChangeValue:(NSString *)newValue;

@end
