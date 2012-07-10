//
//  CommenCell.h
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LORichTextLabel.h"

@interface CommentCellInfo : NSObject
@property (nonatomic, retain) UIImage *thumbImage;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *comment;
@property (nonatomic, retain) NSString *time;
@end

@interface CommentCell : UITableViewCell {
@private
    UIImageView *thumbImage;
    LORichTextLabel *textLabel;
    UILabel *timeLabel;
}
+(CGFloat)heightForInfo:(CommentCellInfo *)info;
-(void)setInfo:(CommentCellInfo *)info;
@end
