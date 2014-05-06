//
//  CAAnimation+Additions.h
//  PieChartView
//
//  Created by Rajendra HN on 11/06/13.
//

#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (Additions)

//one these properties are set, you can not set delegate of these animations. previously set delegats wil be overwritten and if you set delegate after setting completion block it will invalidate the completion block
@property (nonatomic, strong) void (^completion)(BOOL finished);
@property (nonatomic, strong) void (^start)(void);

@end

@interface CABasicAnimation (Additions)

+ (CABasicAnimation *)animationForKey:(NSString *)key
                             duration:(CGFloat)duration
                            fromValue:(id)fromValue
                              toValue:(id)toValue
                      completionBlock:(void (^)(BOOL finished))completionBlock;

@end

@interface CAKeyframeAnimation (Additions)

+ (CAKeyframeAnimation *)animationForKey:(NSString *)key
                                duration:(CGFloat)duration
                                    path:(UIBezierPath *)path
                         completionBlack:(void (^)(BOOL finished))completionBlock;

@end

@interface CAAnimationGroup (Additions)

+ (CAAnimationGroup *)animationWithduration:(CGFloat)duration
                           animations:(NSArray *)animations
                      completionBlack:(void (^)(BOOL finished))completionBlock;

@end
