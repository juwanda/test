//
//  CatBarCell.h
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatBarCellInfo : NSObject    
@property (nonatomic, retain) NSString *title;
@end

@interface CatBarCell : UITableViewCell {
@private
    UIImageView *imageView;
    UILabel *titleLabel;
}
+(CGFloat)height;
-(void)setInfo:(CatBarCellInfo *)info;
@end
