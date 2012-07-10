//
//  BrochureCell.h
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LORichTextLabel.h"
#import "EventCommentView.h"

@interface BrochureCellComment : NSObject
@property (nonatomic, retain) UIImage *thumb;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *comment;
@end

@interface BrochureCellInfo : NSObject
@property (nonatomic, assign) BOOL popular;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *favSubject;
@property (nonatomic, readonly) NSMutableArray *comments;
@end

@interface BrochureCell : UITableViewCell {
@private
    UIView *bgView;
    UIButton *favButton;
    UILabel *titleLabel;
    UILabel *priceLabel;
    UIView *divView;
    UIImageView *ribbonImage;
    UIView *favView;
    LORichTextLabel *favLabel;
    NSMutableArray *commentViews;
    int commentsCount;
}
@property (nonatomic, readonly) UIButton *favButton;
+(CGFloat)heightForInfo:(BrochureCellInfo *)info;
-(void)setInfo:(BrochureCellInfo *)info;
@end
