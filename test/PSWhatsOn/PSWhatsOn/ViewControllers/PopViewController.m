//
//  PopViewController.m
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import "PopViewController.h"

@implementation PopViewController
@synthesize favPopView, friendPopView, delegate;

- (void)dealloc {
    [favPopView release];
    [friendPopView release];
    [super dealloc];
}

- (void)showAnim {
    self.view.hidden = FALSE;
    self.view.alpha = 0.0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.view.alpha = 1.0;
    [UIView commitAnimations];
}

- (void)hideAnim {
    self.view.alpha = 1.0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(onHideAnimFinish)];
    [UIView setAnimationDuration:0.3];
    self.view.alpha = 0.0;
    [UIView commitAnimations];
}

- (void)onHideAnimFinish {
    self.view.hidden = TRUE;
}

-(void)showFavPopFromRect:(CGRect)rect {
    const CGPoint tip = CGPointMake(9, 140);
    
    CGPoint rc = CGPointMake(rect.origin.x + rect.size.width * 0.5, rect.origin.y + rect.size.height * 0.5);
    CGRect r;
    r = favPopView.frame;
    r.origin.x = rc.x - tip.x;
    r.origin.y = rc.y - tip.y;
    if (r.origin.y < 0) {
        r.origin.y = 0;
    } else if (r.origin.y + r.size.height > self.view.frame.size.height) {
        r.origin.y = self.view.frame.size.height - r.size.height;
    }
    favPopView.frame = r;
    
    favPopView.hidden = FALSE;
    friendPopView.hidden = TRUE;
    [self showAnim];    
}

- (void)showFriendPopFromRect:(CGRect)rect {
    const CGPoint tip = CGPointMake(54, 108);
    
    CGPoint rc = CGPointMake(rect.origin.x + rect.size.width * 0.5, rect.origin.y + rect.size.height * 0.5);
    CGRect r;
    r = friendPopView.frame;
    r.origin.x = rc.x - tip.x;
    r.origin.y = rc.y - tip.y;
    if (r.origin.y < 0) {
        r.origin.y = 0;
    } else if (r.origin.y + r.size.height > self.view.frame.size.height) {
        r.origin.y = self.view.frame.size.height - r.size.height;
    }
    
    if (r.origin.x < 0) {
        r.origin.x = 0;
    } else if (r.origin.x + r.size.width > self.view.frame.size.width) {
        r.origin.x = self.view.frame.size.width - r.size.width;         
    }
    
    friendPopView.frame = r;
    
    favPopView.hidden = TRUE;
    friendPopView.hidden = FALSE;
    [self showAnim];    
}

- (IBAction)onHideTouch:(id)sender {
    [self hideAnim];
}

- (IBAction)onCommentTouch:(id)sender {
    if (delegate) {
        [delegate onPopViewFavCommentTouch];
    }
    [self hideAnim];
}

@end
