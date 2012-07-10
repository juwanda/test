//
//  FriendCell.h
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCellInfo : NSObject
@property (nonatomic, retain) UIImage *img;
@property (nonatomic, retain) NSString *title;
@end

@interface FriendCell : UITableViewCell {
@private
    UIImageView *thumbImage;
    UILabel *titleLabel;
}
+(CGFloat)height;
-(void)setInfo:(FriendCellInfo *)info;
@end
