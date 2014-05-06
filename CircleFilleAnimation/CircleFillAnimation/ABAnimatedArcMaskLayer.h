//
//  AnimatedArcShapeLayer.h
//  CircleFilleAnimation
//
//  Created by Adithya H Bhat on 02/08/13.
//

#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSInteger, AnimationStartPoint)
{
    AnimationStartPointRight = 0,
    AnimationStartPointTop = -1,
    AnimationStartPointLeft = -2,
    AnimationStartPointBottom = -3
};

typedef NS_ENUM(NSInteger, AnimationType)
{
    AnimationTypeFill,
    AnimationTypeUnfill
};

@interface ABAnimatedArcMaskLayer : CAShapeLayer

//Custom initializer class method returns an instance of AnimatedArcMaskLayer class, with the layer stroke color and fill color set appropriately
+ (id)layerWithFrame:(CGRect)frame;

- (void)animateWithAnimationType:(AnimationType)animationType
             animationStartPoint:(AnimationStartPoint)animationStartpoint
                        duration:(CGFloat)duration
                  arcStartRadius:(CGFloat)startRadius
                    arcEndRadius:(CGFloat)endRadius
                       clockwise:(BOOL)isClockwise;

//Stops the animtion
- (void)stopAnimation;

@end
