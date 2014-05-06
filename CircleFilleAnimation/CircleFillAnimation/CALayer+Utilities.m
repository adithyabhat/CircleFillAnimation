//
//  CALayer+Utilities.m
//  WildSafari
//
//  Created by Rajendra HN on 05/06/13.
//

#import "CALayer+Utilities.h"

@implementation CALayer (Utilities)

+ (void)performWithoutAnimation:( void ( ^ )( void ) )block
{
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    block();
    [CATransaction commit];
}

@end
