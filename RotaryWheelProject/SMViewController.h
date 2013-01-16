//
//  SMViewController.h
//  RotaryWheelProject
//
//  Created by Chen Zhang on 12-2-23.
//  Copyright (c) 2012年 utas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMRotaryProtocol.h"

@interface SMViewController : UIViewController<SMRotaryProtocol>
@property (nonatomic, strong)UILabel *sectorLabel;

@end
