//
//  BounceButton.m
//  D-PET
//
//  Created by lk on 16/4/17.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "BounceButton.h"
#import "POP.h"
@implementation BounceButton
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    POPSpringAnimation *scale = [self pop_animationForKey:@"scale"];
    if (scale)
    {
        scale.toValue=[NSValue valueWithCGPoint:CGPointMake(0.8, 0.8)];
    }
    else
    {
        scale=[POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scale.toValue=[NSValue valueWithCGPoint:CGPointMake(0.87, 0.8)];
        scale.springBounciness=20;
        scale.springSpeed=18.0f;
        [self pop_addAnimation:scale forKey:@"scale"];
    }
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    POPSpringAnimation *scale = [self pop_animationForKey:@"scale"];
    if (scale)
    {
        scale.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    }
    else
    {
        scale=[POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scale.toValue=[NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
        
    }
    [super touchesEnded:touches withEvent:event];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
