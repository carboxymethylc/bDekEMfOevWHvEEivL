//
//  SMSector.m
//  RotaryWheelProject
//
//  Created by Chen Zhang on 12-2-24.
//  Copyright (c) 2012年 utas. All rights reserved.
//

#import "SMSector.h"

@implementation SMSector
@synthesize minValue, maxValue, midValue, sector;

- (NSString *) description {
    return [NSString stringWithFormat:@"%i | %f, %f, %f", self.sector, self.minValue, self.midValue, self.maxValue];
}
@end
