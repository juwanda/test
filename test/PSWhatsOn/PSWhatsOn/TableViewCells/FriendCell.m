//
//  FriendCell.m
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCellInfo
@synthesize img, title;

- (void)dealloc {
    [img release];
    [title release];
    [super dealloc];
}

@end

@implementation FriendCell

static const CGFloat TITLE_FONT_SIZE = 17;

+ (CGFloat)height {
    return 45;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add_cell_bg.png"]];
        self.backgroundView = iv;
        [iv release];
        
        thumbImage = [[UIImageView alloc] init];
        thumbImage.frame = CGRectMake(10, 10, 25, 25);
        [self addSubview:thumbImage];
        [thumbImage release];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];        
        titleLabel.frame = CGRectMake(45, 0, 235, 45);
        [self addSubview:titleLabel];
        [titleLabel release];
    }
    return self;
}

- (void)setInfo:(FriendCellInfo *)info {
    thumbImage.image = info.img;
    titleLabel.text = info.title;
}

@end
