//
//  ViewController.m
//  CircleFilleAnimation
//
//  Created by Adithya H Bhat on 01/08/13.
//

#import "ViewController.h"
#import "View.h"

@interface ViewController ()

@property (nonatomic, strong) View *testAnimationView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.testAnimationView = [[[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil] lastObject];
    self.testAnimationView.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds)/2);
    [self.view addSubview:self.testAnimationView];
}

- (IBAction)stopAnimation:(id)sender
{
    [self.testAnimationView stop];
}

@end
