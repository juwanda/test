//
//  CommenCell.m
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import "CommentCell.h"
#import "UIColor+HexString.h"

@implementation CommentCellInfo
@synthesize thumbImage, name, comment, time;

- (void)dealloc {
    [thumbImage release];
    [name release];
    [comment release];
    [time release];
    [super dealloc];
}

@end

@implementation CommentCell

static LORichTextLabel *measureLabel = nil;

+ (CGFloat)width {
    return 320;
}

+ (CGFloat)heightForInfo:(CommentCellInfo *)info {
    
    if (measureLabel == nil) {
        measureLabel = [[LORichTextLabel alloc] initWithWidth:0];
        [measureLabel setFont:[UIFont systemFontOfSize:15]];
        [measureLabel setTextColor:[UIColor grayColor]];        
        
        LORichTextLabelStyle *style = [LORichTextLabelStyle styleWithFont:[UIFont boldSystemFontOfSize:15] color:[UIColor colorWithHexString:@"#2a4b6b"]];        
        style.removePrefix = TRUE;
        [measureLabel addStyle:style forPrefix:@"#"];
        
        CGRect r;
        r = measureLabel.frame;
        r.origin.x = 55;
        r.origin.y = 10;
        r.size.width = [self width] - 60;
        measureLabel.frame = r;
    }    
    
    NSString *text = [NSString stringWithFormat:@"#%@ %@", info.name, info.comment];
    [measureLabel setText:text];
    [measureLabel layoutSubviews];
    return MAX(60, measureLabel.frame.size.height + 20 + 20);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        thumbImage = [[UIImageView alloc] init];
        thumbImage.frame = CGRectMake(10, 10, 40, 40);
        [self addSubview:thumbImage];
        [thumbImage release];
        
        textLabel = [[LORichTextLabel alloc] initWithWidth:0];
        textLabel.frame = CGRectMake(55, 10, [CommentCell width] - 60, 0);
        [textLabel setFont:[UIFont systemFontOfSize:15]];
        [textLabel setTextColor:[UIColor grayColor]];        
        
        LORichTextLabelStyle *style = [LORichTextLabelStyle styleWithFont:[UIFont boldSystemFontOfSize:15] color:[UIColor colorWithHexString:@"#2a4b6b"]];        
        style.removePrefix = TRUE;
        [textLabel addStyle:style forPrefix:@"#"];
                        
        [self addSubview:textLabel];
        [textLabel release];
        
        timeLabel = [[UILabel alloc] init];
        timeLabel.frame = CGRectMake(55, 0, [CommentCell width] - 60, 20);
        timeLabel.font = [UIFont boldSystemFontOfSize:10];
        timeLabel.backgroundColor = [UIColor clearColor];        
        timeLabel.textColor = [UIColor colorWithHexString:@"#d0d0d0"];
        [self addSubview:timeLabel];        
        [timeLabel release];
                
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect r = timeLabel.frame;
    r.origin.y = textLabel.frame.origin.y +  textLabel.frame.size.height;
    timeLabel.frame = r;
}

- (void)setInfo:(CommentCellInfo *)info {
    thumbImage.image = info.thumbImage;
    NSString *text = [NSString stringWithFormat:@"#%@ %@", info.name, info.comment];
    [textLabel setText:text];
    timeLabel.text = info.time;
    
    
}

@end
