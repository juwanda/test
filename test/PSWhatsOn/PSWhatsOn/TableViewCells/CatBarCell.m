//
//  CatBarCell.m
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import "CatBarCell.h"

@implementation CatBarCellInfo
@synthesize title;

- (void)dealloc {
    [title release];
    [super dealloc];
}

@end

@implementation CatBarCell

+ (CGFloat) width {
    return 280;
}

+ (CGFloat)height {
    return 21;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userInteractionEnabled = FALSE;
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cat_bar_empty.png"]];
        [self addSubview:imageView];
        [imageView release];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(10, 0, [CatBarCell width] - 20, [CatBarCell height]);
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:12];
        titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:titleLabel];
        [titleLabel release];
        
    }
    return self;
}

- (void)setInfo:(CatBarCellInfo *)info {
    titleLabel.text = info.title;
}

@end
