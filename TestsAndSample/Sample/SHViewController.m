//
//  SHViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import <POP/POP.h>


@interface SHLargeBar : UINavigationBar
@end

@implementation SHLargeBar
-(void)awakeFromNib; {
  self.frame = CGRectMake(0, 0, 320, 100);
}
@end


#import "SHViewController.h"
#import "SHSecondViewController.h"
#import <SHTransitionBlocks.h>
#import  <SHNavigationControllerBlocks.h>

@interface SHViewController ()

@end

@implementation SHViewController

-(IBAction)unwinder:(UIStoryboardSegue *)sender; {
  
}
-(void)viewDidLoad; {
  [super viewDidLoad];

  [self.navigationController SH_setAnimationDuration:0.5 withPreparedTransitionBlock:^(UIView *containerView, UIViewController *fromVC, UIViewController *toVC, NSTimeInterval duration, id<SHViewControllerAnimatedTransitioning> transitionObject, SHTransitionAnimationCompletionBlock transitionDidComplete) {
    
//    if (transitionObject.isReversed == NO) {
//      toVC.view.layer.affineTransform = CGAffineTransformMakeTranslation(CGRectGetWidth(toVC.view.frame), 0);
//    }
//    else {
//      toVC.view.layer.affineTransform = CGAffineTransformMakeTranslation(-CGRectGetWidth(toVC.view.frame), 0);
//    }

    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    anim.fromValue = @(0.0);
    anim.toValue = @(100.0);
    anim.duration = duration*0.9;
    if(transitionObject.isReversed) {
      [fromVC.view.layer pop_addAnimation:anim forKey:@"slide"];
    }
    else {
      [toVC.view.layer pop_addAnimation:anim forKey:@"slide"];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            toVC.view.layer.affineTransform = CGAffineTransformIdentity;
            fromVC.view.layer.affineTransform = CGAffineTransformIdentity;
            transitionDidComplete();

    });
    

  }];
  
  [self.navigationController SH_setInteractiveTransitionWithGestureBlock:^UIGestureRecognizer *(UIScreenEdgePanGestureRecognizer *edgeRecognizer) {
    edgeRecognizer.edges = UIRectEdgeLeft;
    return edgeRecognizer;
  } onGestureCallbackBlock:^void(UIViewController * controller, UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
    UIScreenEdgePanGestureRecognizer * recognizer = (UIScreenEdgePanGestureRecognizer*)sender;
    CGFloat progress = [recognizer translationInView:sender.view].x / (recognizer.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (state == UIGestureRecognizerStateBegan) {
      // Create a interactive transition and pop the view controller
      controller.SH_interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
      [(UINavigationController *)controller popViewControllerAnimated:YES];
    }
    else if (state == UIGestureRecognizerStateChanged) {
      // Update the interactive transition's progress
      [controller.SH_interactiveTransition updateInteractiveTransition:progress];
    }
    else if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled) {
      // Finish or cancel the interactive transition
      if (progress > 0.5) {
        [controller.SH_interactiveTransition finishInteractiveTransition];
      }
      else {
        [controller.SH_interactiveTransition cancelInteractiveTransition];
      }
      
      controller.SH_interactiveTransition = nil;
    }
  
  }];
  
  [self.navigationController SH_setAnimatedControllerBlock:^id<UIViewControllerAnimatedTransitioning>(UINavigationController *navigationController, UINavigationControllerOperation operation, UIViewController *fromVC, UIViewController *toVC) {
    navigationController.SH_animatedTransition.reversed = operation == UINavigationControllerOperationPop;
    return navigationController.SH_animatedTransition;
  }];
  
  [self.navigationController SH_setInteractiveControllerBlock:^id<UIViewControllerInteractiveTransitioning>(UINavigationController *navigationController, id<UIViewControllerAnimatedTransitioning> animationController) {
    return navigationController.SH_interactiveTransition;
  }];
}


-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  
  double delayInSeconds = 2.0;
dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
  
  //[self.navigationController performSegueWithIdentifier:@"modal" sender:nil];
});

}


  
  
  

@end
