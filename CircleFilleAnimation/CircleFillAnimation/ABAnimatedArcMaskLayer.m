//
//  AnimatedArcShapeLayer.m
//  CircleFilleAnimation
//
//  Created by Adithya H Bhat on 02/08/13.
//

#import "ABAnimatedArcMaskLayer.h"
#import "CALayer+Utilities.h"
#import "CAAnimation+Additions.h"

//static inline double radians (double degrees) {return degrees * M_PI/180;}
#define DEG2RAD(x) (0.0174532925 * (x))

@implementation ABAnimatedArcMaskLayer
{
    CGFloat timeElapsed;
    NSString *animationKey;
}

#pragma mark - Private

- (void)updateTime
{
    timeElapsed += 0.01;
}

- (void)setNilValueForKey:(NSString *)theKey
{
    
    if ([theKey isEqualToString:animationKey])
    {
        [self setValue:[NSNumber numberWithFloat:0.0] forKey:animationKey];
    }
    else
    {
        [super setNilValueForKey:theKey];
    }
}

#pragma mark - Public functions

+ (id)layerWithFrame:(CGRect)frame
{
    ABAnimatedArcMaskLayer *animatedArcMaskLayer = [ABAnimatedArcMaskLayer layer];
    animatedArcMaskLayer.frame = frame;
    
    //Only the layer region that is opaque will be drawn. In this case only the path should be drawn, hence its given some color.  
    animatedArcMaskLayer.strokeColor = [UIColor blackColor].CGColor;
    animatedArcMaskLayer.fillColor = [UIColor clearColor].CGColor;

    return animatedArcMaskLayer;
}

- (void)animateWithAnimationType:(AnimationType)animationType
             animationStartPoint:(AnimationStartPoint)animationStartpoint
                        duration:(CGFloat)duration
                  arcStartRadius:(CGFloat)startRadius
                    arcEndRadius:(CGFloat)endRadius
                       clockwise:(BOOL)isClockwise
{
    CGFloat circleRadius = startRadius + ((endRadius - startRadius)/2);
    CGFloat centerX;
    CGFloat centerY = centerX = MIN(CGRectGetHeight(self.bounds)/2, CGRectGetWidth(self.bounds)/2);
    CGPoint circleCenter = CGPointMake(centerX, centerY);
    CGFloat pathLineWidth = endRadius - startRadius;
    
    //Create the path
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:circleCenter
                                                        radius:circleRadius
                                                    startAngle:DEG2RAD(0)
                                                      endAngle:DEG2RAD(360)
                                                     clockwise:isClockwise];
    self.path = path.CGPath;
    self.lineWidth = pathLineWidth;
    self.transform = CATransform3DMakeRotation((DEG2RAD(90) * animationStartpoint), 0, 0, 1);
    
    timeElapsed = 0.0f;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                      target:self
                                                    selector:@selector(updateTime)
                                                    userInfo:nil
                                                     repeats:YES];
    
    animationKey = (animationType == AnimationTypeFill)? @"strokeEnd" : @"strokeStart";
    CABasicAnimation *animation = [CABasicAnimation animationForKey:animationKey
                                                           duration:duration
                                                          fromValue:[NSNumber numberWithFloat:0]
                                                            toValue:[NSNumber numberWithFloat:1]
                                                    completionBlock:^(BOOL finished) {
                                                        [CALayer performWithoutAnimation:^{
                                                            [timer invalidate];
                                                            CGFloat finalStrokeValue;
                                                            if(finished == YES)
                                                            {
                                                                finalStrokeValue = 1;
                                                            }
                                                            else
                                                            {
                                                                finalStrokeValue = timeElapsed/duration;
                                                            }
                                                            [self setValue:[NSNumber numberWithFloat:finalStrokeValue] forKey:animationKey];
                                                        }];
                                                    }];
    
    [self addAnimation:animation forKey:@"stroke"];
}

- (void)stopAnimation
{
    [self removeAllAnimations];
}


@end
