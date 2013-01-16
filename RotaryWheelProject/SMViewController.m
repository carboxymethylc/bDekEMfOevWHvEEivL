//
//  SMViewController.m
//  RotaryWheelProject
//
//  Created by Chen Zhang on 12-2-23.
//  Copyright (c) 2012年 utas. All rights reserved.
//

#import "SMViewController.h"
#import "SMRotaryWheel.h"

@implementation SMViewController
@synthesize sectorLabel;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    // 1 - Call super method
    [super viewDidLoad];
    // 2 - Create sector label
	sectorLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 350, 120, 30)];
	sectorLabel.textAlignment = UITextAlignmentCenter;
	[self.view addSubview:sectorLabel];
    // 3 - Set up rotary wheel
    SMRotaryWheel *wheel = [[SMRotaryWheel alloc] initWithFrame:CGRectMake(0, 0, 370, 370)
                                                    andDelegate:self 
                                                   withSections:8];
        wheel.currentWheel=1;
    wheel.center = CGPointMake(160, 240);
    // 4 - Add wheel to view
    [self.view addSubview:wheel];
    
    
    
    SMRotaryWheel *wheel_2 = [[SMRotaryWheel alloc] initWithFrame:CGRectMake(0, 0, 200,200)
                                                    andDelegate:self
                                                   withSections:8];
    wheel_2.currentWheel=2;
    wheel_2.center = CGPointMake(160, 240);
    // 4 - Add wheel to view
    [self.view addSubview:wheel_2];
    
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) wheelDidChangeValue:(NSString *)newValue {
    self.sectorLabel.text = newValue;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
