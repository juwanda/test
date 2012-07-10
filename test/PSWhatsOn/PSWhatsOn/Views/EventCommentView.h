//
//  EventCommentView.h
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LORichTextLabel.h"

@interface EventCommentView : UIView {
@private
    UIView *lineView;
    UIImageView *thumbImage;
    //UILabel *commentLabel;
    LORichTextLabel *commentLabel;
}
+(CGFloat)heightForName:(NSString *)name comment:(NSString *)comment;
-(void)setThumbImage:(UIImage *)image;
-(void)setName:(NSString *)name comment:(NSString *)comment;
-(void)updateSize;
-(void)setDivHidden:(BOOL)hidden;
@end
