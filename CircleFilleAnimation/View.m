//
//  View.m
//  CircleFilleAnimation
//
//  Created by Adithya H Bhat on 01/08/13.
//

#import "View.h"
#import "CALayer+Utilities.h"
#import "CAAnimation+Additions.h"
#import "ABAnimatedArcMaskLayer.h"

//static inline double radians (double degrees) {return degrees * M_PI/180;}
#define DEG2RAD(x) (0.0174532925 * (x))

@interface View ()

@property (weak, nonatomic) IBOutlet UIImageView *fillImageView;
@property (strong, nonatomic) CAShapeLayer *shapeLayer;

@end

@implementation View


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
}

- (void)testAnimation
{
    CGPoint viewCenter = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
    CGFloat circleRadius = MIN(CGRectGetHeight(self.bounds)/2, CGRectGetWidth(self.bounds)/2)-20;
    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:viewCenter];
    [path addArcWithCenter:viewCenter
                    radius:circleRadius
                startAngle:DEG2RAD(0)
                  endAngle:DEG2RAD(360)
                 clockwise:NO];
//    [path closePath];
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = self.bounds;
    self.shapeLayer.path = path.CGPath;
    self.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.lineWidth = 10.0f;
    self.shapeLayer.transform = CATransform3DMakeRotation(DEG2RAD(-90), 0, 0, 1);

//    shapeLayer.opacity = 1.0;
    
//    [self.layer addSublayer:self.shapeLayer];
    
    self.layer.mask = self.shapeLayer;
    
//    shapeLayer.strokeStart = 0;
//    shapeLayer.strokeEnd = 1;

//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
//    animation.fromValue = [NSNumber numberWithFloat:0.5];
//    animation.toValue = [NSNumber numberWithFloat:0.8];
//    animation.duration = 5;
//    animation.delegate = self;
//    self.shapeLayer.strokeStart = 0.5;
    NSNumber *strokeEndVal = [NSNumber numberWithFloat:1];
    CABasicAnimation *animation = [CABasicAnimation animationForKey:@"strokeStart"
                                                           duration:5
                                                          fromValue:[NSNumber numberWithFloat:0]
                                                            toValue:[NSNumber numberWithFloat:1]
                                                    completionBlock:^(BOOL finished) {
                                                        [CALayer performWithoutAnimation:^{
                                                            self.shapeLayer.strokeEnd = [strokeEndVal floatValue];
                                                        }];
                                                    }];
    
    [self.shapeLayer addAnimation:animation forKey:@"stroke"];
}

- (void)animationUsingMyModule
{
    ABAnimatedArcMaskLayer *maskLayer = [ABAnimatedArcMaskLayer layerWithFrame:self.bounds];
    self.fillImageView.layer.mask = maskLayer;
//    self.layer.mask = maskLayer;
//    [self.layer addSublayer:maskLayer];
    CGFloat circleRadius = MIN(CGRectGetHeight(self.bounds)/2, CGRectGetWidth(self.bounds)/2);
    [maskLayer animateWithAnimationType:AnimationTypeUnfill
                    animationStartPoint:AnimationStartPointTop
                               duration:5.0f
                         arcStartRadius:circleRadius - 40.0f
                           arcEndRadius:circleRadius - 17.0f
                              clockwise:YES];
}

- (void)awakeFromNib
{
//    [self testAnimation];
    [self animationUsingMyModule];
}

- (void)stop
{
    ABAnimatedArcMaskLayer *layer = (ABAnimatedArcMaskLayer *)self.fillImageView.layer.mask;
    [layer stopAnimation];
}

//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
//{
//    [CALayer performWithoutAnimation:^{
//        CGFloat toVal = [((CABasicAnimation *)anim).toValue floatValue];
//        self.shapeLayer.strokeStart = toVal;
//    }];
//}


@end
