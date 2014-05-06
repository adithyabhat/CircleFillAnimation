//
//  CAAnimation+Additions.m
//  PieChartView
//
//  Created by Rajendra HN on 11/06/13.
//

#import "CAAnimation+Additions.h"

@interface CAAnimationDelegate : NSObject

@property (nonatomic, copy) void (^completion)(BOOL);
@property (nonatomic, copy) void (^start)(void);

- (void)animationDidStart:(CAAnimation *)anim;
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;

@end

@implementation CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim
{
    if (self.start != nil) {
        self.start();
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.completion != nil) {
        self.completion(flag);
    }
}

@end

@implementation CAAnimation (Additions)

- (void)setCompletion:(void (^)(BOOL))completion
{
    if ([self.delegate isKindOfClass:[CAAnimationDelegate class]]) {
        ((CAAnimationDelegate *)self.delegate).completion = completion;
    }
    else {
        CAAnimationDelegate *delegate = [[CAAnimationDelegate alloc] init];
        delegate.completion = completion;
        self.delegate = delegate;
    }
}

- (void (^)(BOOL))completion
{
    if ([self.delegate isKindOfClass:[CAAnimationDelegate class]])
    {
        return ((CAAnimationDelegate *)self.delegate).completion;
    }
    else
    {
        return nil;
    }
}

- (void)setStart:(void (^)(void))start
{
    if ([self.delegate isKindOfClass:[CAAnimationDelegate class]]) {
        ((CAAnimationDelegate *)self.delegate).start = start;
    }
    else {
        CAAnimationDelegate *delegate = [[CAAnimationDelegate alloc] init];
        delegate.start = start;
        self.delegate = delegate;
    }
}

- (void (^)(void))start
{
    if ([self.delegate isKindOfClass:[CAAnimationDelegate class]])
    {
        return ((CAAnimationDelegate *)self.delegate).start;
    }
    else
    {
        return nil;
    }
}

@end

@implementation CABasicAnimation (Additions)

+ (CABasicAnimation *)animationForKey:(NSString *)key
                             duration:(CGFloat)duration
                            fromValue:(id)fromValue
                              toValue:(id)toValue
                      completionBlock:(void (^)(BOOL))completionBlock
{
    CABasicAnimation *animation = [self animationWithKeyPath:key];
    animation.toValue = toValue;
    animation.fromValue = fromValue;
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.completion = completionBlock;
    return animation;
}

@end

@implementation CAKeyframeAnimation (Additions)

+ (CAKeyframeAnimation *)animationForKey:(NSString *)key duration:(CGFloat)duration path:(UIBezierPath *)path completionBlack:(void (^)(BOOL))completionBlock
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:key];
    animation.duration = duration;
    animation.path = path.CGPath;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.completion = completionBlock;
    return animation;
}

@end

@implementation CAAnimationGroup (Additions)

+ (CAAnimationGroup *)animationWithduration:(CGFloat)duration animations:(NSArray *)animations completionBlack:(void (^)(BOOL))completionBlock
{
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.duration = duration;
    animation.animations = animations;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.completion = completionBlock;
    return animation;
}

@end
