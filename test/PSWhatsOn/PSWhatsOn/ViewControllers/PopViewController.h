//
//  PopViewController.h
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopViewDelegate
-(void)onPopViewFavCommentTouch;
@end

@interface PopViewController : UIViewController
@property (nonatomic, retain) IBOutlet UIView *favPopView;
@property (nonatomic, retain) IBOutlet UIView *friendPopView;
@property (nonatomic, assign) id<PopViewDelegate> delegate;
-(void)showFavPopFromRect:(CGRect)rect;
-(void)showFriendPopFromRect:(CGRect)rect;
@end
