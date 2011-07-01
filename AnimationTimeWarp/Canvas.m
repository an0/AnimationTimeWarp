//
//  Canvas.m
//  AnimationTimeWarp
//
//  Created by Ling Wang on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Canvas.h"
#import <QuartzCore/QuartzCore.h>

@implementation Canvas

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
		// Add layer.
		CATextLayer *A = [CATextLayer layer];
		A.string = @"A";
		A.fontSize = 48;
		A.foregroundColor = [UIColor blackColor].CGColor;
		A.bounds = CGRectMake(0, 0, 48, 48);
		A.position = self.center;
		[self.layer addSublayer:A];
		
		// Move animation.
		CAKeyframeAnimation *move = [CAKeyframeAnimation animationWithKeyPath:@"position"];
		move.values = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMinX(self.bounds), CGRectGetMaxY(self.bounds))], [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMinY(self.bounds))], [NSValue valueWithCGPoint:CGPointMake(CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds))], nil];
		move.calculationMode = kCAAnimationCubic;
		move.duration = 10;
		move.speed = 2;
//		move.timeOffset = 1;
		
		// Opacity animation.
		CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
		opacity.toValue = [NSNumber numberWithFloat:0];
		opacity.duration = 2.5;
		opacity.beginTime = 2.5; // Fade from the half way.
		
		// Animatin group.
		CAAnimationGroup *group = [CAAnimationGroup animation];
		group.animations = [NSArray arrayWithObjects:move, opacity, nil];
		group.duration = 8;
		group.repeatCount = HUGE_VALF;
		
		// Time warp.
		CFTimeInterval currentTime = CACurrentMediaTime();
		CFTimeInterval currentTimeInSuperLayer = [self.layer convertTime:currentTime fromLayer:nil];
		A.beginTime = currentTimeInSuperLayer + 5; // Delay the appearance of A.
		CFTimeInterval currentTimeInLayer = [A convertTime:currentTimeInSuperLayer fromLayer:self.layer];
		CFTimeInterval addTime = currentTimeInLayer;
		group.beginTime = addTime + 3; // Delay the animatin group.
		
		// FIXME: beginTime does not work if the layer itself is shifted with beginTime.
		// group.beginTime = 0;
		
		[A addAnimation:group forKey:nil];
		
		// Timer. For nice visual effect. Optional.
		CATextLayer *timer = [CATextLayer layer];
		timer.fontSize = 48;
		timer.foregroundColor = [UIColor redColor].CGColor;
		timer.bounds = CGRectMake(0, 0, 48, 48);
		timer.position = self.center;
		[self.layer addSublayer:timer];
		CAKeyframeAnimation *count = [CAKeyframeAnimation animationWithKeyPath:@"string"];
		count.values = [NSArray arrayWithObjects:@"5", @"4", @"3", @"2", @"1", nil];
		CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
		fade.toValue = [NSNumber numberWithFloat:0.2];
		group = [CAAnimationGroup animation];
		group.animations = [NSArray arrayWithObjects:count, fade, nil];
		group.duration = 5;
		[timer addAnimation:group forKey:nil];
    }
    return self;
}

@end
