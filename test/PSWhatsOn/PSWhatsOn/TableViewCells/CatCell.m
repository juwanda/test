//
//  CatCell.m
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import "CatCell.h"

@implementation CatCellInfo
@synthesize img, title, count, bgType;

- (void)dealloc {
    [img release];
    [title release];
    [super dealloc];
}

@end

@implementation CatCell

static const CGFloat TITLE_FONT_SIZE = 17;
static const CGFloat COUNT_FONT_SIZE = 12;

+ (CGFloat)height {
    return 45;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        bgImage = [[UIImageView alloc] init];
        bgImage.frame = CGRectMake(0, 0, 280, 45);
        self.backgroundView = bgImage;
        [bgImage release];
        
        thumbImage = [[UIImageView alloc] init];
        thumbImage.frame = CGRectMake(15, 15, 12, 15);
        [self addSubview:thumbImage];
        [thumbImage release];
                
        titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];        
        titleLabel.frame = CGRectMake(45, 0, 180, 45);
        [self addSubview:titleLabel];
        [titleLabel release];
        
        countLabel = [[UILabel alloc] init];
        countLabel.backgroundColor = [UIColor clearColor];
        countLabel.textColor = [UIColor whiteColor];
        countLabel.font = [UIFont boldSystemFontOfSize:COUNT_FONT_SIZE];        
        countLabel.frame = CGRectMake(225, 0, 50, 45);
        countLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:countLabel];
        [countLabel release];
    }
    return self;
}

- (void)setInfo:(CatCellInfo *)info {
    
    thumbImage.image = info.img;
    titleLabel.text = info.title;
    countLabel.text = info.count > 0 ? [NSString stringWithFormat:@"%d", info.count] : nil; 
    
    NSString *fn;
    if (info.bgType == CATCELL_BG_SEEALL)  {
        fn = @"cat_cell_seeall.png";        
    } else if (info.bgType == CATCELL_BG_DEFAULT) {
        fn = @"cat_cell_bg.png";
    }  
    bgImage.image = [UIImage imageNamed:fn];
}

@end
