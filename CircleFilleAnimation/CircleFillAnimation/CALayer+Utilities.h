//
//  CALayer+Utilities.h
//  WildSafari
//
//  Created by Rajendra HN on 05/06/13.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Utilities)

+ (void)performWithoutAnimation:( void ( ^ )( void ) )block;

@end
