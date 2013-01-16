//
//  SMRotaryWheel.h
//  RotaryWheelProject
//
//  Created by Chen Zhang on 12-2-23.
//  Copyright (c) 2012年 utas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMRotaryProtocol.h"
#import "SMSector.h"

@interface SMRotaryWheel : UIControl
@property (weak)id<SMRotaryProtocol> delegate;
@property (nonatomic,strong)UIView *container;
@property int numberOfSections;
@property CGAffineTransform startTransform;
@property (nonatomic, strong) NSMutableArray *sectors;
@property int currentSector;
@property int currentWheel;

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber currentWheel:(int)currentWheel;
-(void)rotate;
@end
