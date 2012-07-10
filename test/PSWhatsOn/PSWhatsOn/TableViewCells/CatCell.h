//
//  CatCell.h
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CATCELL_BG_DEFAULT  0
#define CATCELL_BG_SEEALL   1

#define CATCELL_COUNT_NONE -1

@interface CatCellInfo : NSObject
@property (nonatomic, retain) UIImage *img;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) int bgType;
@end

@interface CatCell : UITableViewCell {
@private
    UIImageView *bgImage;
    UIImageView *thumbImage;
    UILabel *titleLabel;
    UILabel *countLabel;
}
+(CGFloat)height;
-(void)setInfo:(CatCellInfo *)info;
@end
