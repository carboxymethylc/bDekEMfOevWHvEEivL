//
//  SMRotaryWheel.m
//  RotaryWheelProject
//
//  Created by Chen Zhang on 12-2-23.
//  Copyright (c) 2012年 utas. All rights reserved.
//

#import "SMRotaryWheel.h"
#import <QuartzCore/QuartzCore.h>

@interface SMRotaryWheel()
-(void)drawWheel;
-(float) calculateDistanceFromCenter:(CGPoint)point;
- (void) buildSectorsEven;
- (void) buildSectorsOdd;
- (UIImageView *) getSectorByValue:(int)value;
@end
static float deltaAngle;

static float minAlphavalue = 0.6;
static float maxAlphavalue = 1.0;


@implementation SMRotaryWheel
@synthesize delegate,container,numberOfSections;
@synthesize startTransform;
@synthesize sectors;
@synthesize currentSector;
@synthesize currentWheel;
- (NSString *) getSectorName:(int)position
{
    
    NSLog(@"\n currentWheel = %d",currentWheel);
    
    NSString *res = @"";
    switch (position)
    {
        case 0:
            res = @"Circles";
            break;
            
        case 1:
            res = @"Flower";
            break;
            
        case 2:
            res = @"Monster";
            break;
            
        case 3:
            res = @"Person";
            break;
            
        case 4:
            res = @"Smile";
            break;
            
        case 5:
            res = @"Sun";
            break;
            
        case 6:
            res = @"Swirl";
            break;
            
        case 7:
            res = @"3 circles";
            break;
            
        case 8:
            res = @"Triangle";
            break;
            
        default:
            break;
    }
    return res;
}

//- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber
- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber currentWheel:(int)currentWheel
{
    // 1 - Call super init
    if ((self = [super initWithFrame:frame]))
    {
        // 2 - Set properties
        self.numberOfSections = sectionsNumber;
        self.currentWheel = currentWheel;
        self.delegate = del;
        // 3 - Draw wheel
        [self drawWheel];
        self.currentSector = 0;
//        [NSTimer scheduledTimerWithTimeInterval:2.0
//                                         target:self
//                                       selector:@selector(rotate)
//                                       userInfo:nil
//                                        repeats:YES];
	}
    return self;
}

- (void) drawWheel
{
    NSLog(@"\n currentWheel in drawWheel = %d",currentWheel);
    
    container = [[UIView alloc] initWithFrame:self.frame];
    CGFloat angleSize = 2*M_PI/numberOfSections;
    
    for (int i = 0; i<numberOfSections; i++)
    {
        
        // 4 - Create image view
        UIImageView *im = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"segment.png"]];
        im.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
        
        if(currentWheel==1)
        {
            im.frame = CGRectMake(im.frame.origin.x, im.frame.origin.y,160,60);
        }
        else
        {
            //im.frame = CGRectMake(im.frame.origin.x, im.frame.origin.y,60,30);
        }
        
        
        im.layer.position = CGPointMake(container.bounds.size.width/2.0-container.frame.origin.x,
                                        container.bounds.size.height/2.0-container.frame.origin.y); 
        
        
        im.transform = CGAffineTransformMakeRotation(angleSize*i);
        //im.alpha = minAlphavalue;
        im.alpha = maxAlphavalue;
        im.tag = i;
        if (i == 0)
        {
            im.alpha = maxAlphavalue;
        }
		// 5 - Set sector image        
        UIImageView *sectorImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 15, 40, 40)];
        sectorImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon%i.png", i]];
        [im addSubview:sectorImage];
        // 6 - Add image view to container
        [container addSubview:im];
    }
    container.userInteractionEnabled = NO;
    [self addSubview:container];
    
    sectors = [NSMutableArray arrayWithCapacity:numberOfSections];
    UIImageView *mask = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 58, 58)];
    mask.image =[UIImage imageNamed:@"centerButton.png"] ;
    mask.center = self.center;
    mask.center = CGPointMake(mask.center.x, mask.center.y+3);
    [self addSubview:mask];
    // 7.1 - Add background image
	UIImageView *bg = [[UIImageView alloc] initWithFrame:self.frame];
	bg.image = [UIImage imageNamed:@"bg.png"];
    if(currentWheel ==2)
    {
        bg.image = [UIImage imageNamed:@""];
    }
    
	[self addSubview:bg];
    
    if (numberOfSections % 2 == 0) {
        [self buildSectorsEven];
    } else {
        [self buildSectorsOdd];
    }
      // 9 - Call protocol method
    [self.delegate wheelDidChangeValue:[self getSectorName:currentSector]];
}
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    // 1 - Get touch position
    CGPoint touchPoint = [touch locationInView:self];
    
    // 1.1 - Get the distance from the center
    float dist = [self calculateDistanceFromCenter:touchPoint];
    // 1.2 - Filter out touches too close to the center
    
    /*CHIRAG:TEMPORARY IN COMMENT.
    if (dist < 40 || dist > 100)
    {
        // forcing a tap to be on the ferrule
        NSLog(@"ignoring tap (%f,%f)", touchPoint.x, touchPoint.y);
        return NO;
    }
    */
    
    
    // 2 - Calculate distance from center
    float dx = touchPoint.x - container.center.x;
    float dy = touchPoint.y - container.center.y;
    // 3 - Calculate arctangent value
    deltaAngle = atan2(dy,dx); 
    // 4 - Save current transform
    startTransform = container.transform;
    
    // 5 - Set current sector's alpha value to the minimum value
	UIImageView *im = [self getSectorByValue:currentSector];
	//im.alpha = minAlphavalue;
    im.alpha = maxAlphavalue;
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    CGFloat radians = atan2f(container.transform.b, container.transform.a);
    NSLog(@"rad is %f", radians);
    
    CGPoint pt = [touch locationInView:self];
    float dx = pt.x  - container.center.x;
    float dy = pt.y  - container.center.y;
    float ang = atan2(dy,dx);
    float angleDifference = deltaAngle - ang;
    container.transform = CGAffineTransformRotate(startTransform, -angleDifference);
    return YES;
}

-(float) calculateDistanceFromCenter:(CGPoint)point {
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    float dx = point.x - center.x;
    float dy = point.y - center.y;
    return sqrt(dx*dx + dy*dy);
}

- (void) rotate
{
    CGAffineTransform t = CGAffineTransformRotate(container.transform, -0.78);
    container.transform = t;
}

- (void) buildSectorsOdd {
	// 1 - Define sector length
    CGFloat fanWidth = M_PI*2/numberOfSections;
	// 2 - Set initial midpoint
    CGFloat mid = 0;
	// 3 - Iterate through all sectors
    for (int i = 0; i < numberOfSections; i++) {
        SMSector *sector = [[SMSector alloc] init];
		// 4 - Set sector values
        sector.midValue = mid;
        sector.minValue = mid - (fanWidth/2);
        sector.maxValue = mid + (fanWidth/2);
        sector.sector = i;
        mid -= fanWidth;
        if (sector.minValue < - M_PI) {
            mid = -mid;
            mid -= fanWidth; 
        }
		// 5 - Add sector to array
        [sectors addObject:sector];
		NSLog(@"cl is %@", sector);
    }
}

- (void) buildSectorsEven {
    // 1 - Define sector length
    CGFloat fanWidth = M_PI*2/numberOfSections;
    // 2 - Set initial midpoint
    CGFloat mid = 0;
    // 3 - Iterate through all sectors
    for (int i = 0; i < numberOfSections; i++) {
        SMSector *sector = [[SMSector alloc] init];
        // 4 - Set sector values
        sector.midValue = mid;
        sector.minValue = mid - (fanWidth/2);
        sector.maxValue = mid + (fanWidth/2);
        sector.sector = i;
        if (sector.maxValue-fanWidth < - M_PI) {
            mid = M_PI;
            sector.midValue = mid;
            sector.minValue = fabsf(sector.maxValue);
            
        }
        mid -= fanWidth;
        NSLog(@"cl is %@", sector);
        // 5 - Add sector to array
        [sectors addObject:sector];
    }
}

-(void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    // 1 - Get current container rotation in radians
    CGFloat radians = atan2f(container.transform.b, container.transform.a);
    // 2 - Initialize new value
    CGFloat newVal = 0.0;
    // 3 - Iterate through all the sectors
    for (SMSector *s in sectors) {
        // 4 - Check for anomaly (occurs with even number of sectors)
        if (s.minValue > 0 && s.maxValue < 0) {
            if (s.maxValue > radians || s.minValue < radians) {
                // 5 - Find the quadrant (positive or negative)
                if (radians > 0) {
                    newVal = radians - M_PI;
                } else {
                    newVal = M_PI + radians;                    
                }
                currentSector = s.sector;
            }
        }
        // 6 - All non-anomalous cases
        else if (radians > s.minValue && radians < s.maxValue) {
            newVal = radians - s.midValue;
            currentSector = s.sector;
        }    }
    // 7 - Set up animation for final rotation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    CGAffineTransform t = CGAffineTransformRotate(container.transform, -newVal);
    container.transform = t;
    [UIView commitAnimations];
    [self.delegate wheelDidChangeValue:[self getSectorName:currentSector]];
    
    UIImageView *im = [self getSectorByValue:currentSector];
	im.alpha = maxAlphavalue;
}

- (UIImageView *) getSectorByValue:(int)value {
    UIImageView *res;
    NSArray *views = [container subviews];
    for (UIImageView *im in views) {
        if (im.tag == value)
            res = im;
    }
    return res;
}



@end
