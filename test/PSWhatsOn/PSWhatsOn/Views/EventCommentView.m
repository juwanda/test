//
//  EventCommentView.m
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import "EventCommentView.h"
#import "UIColor+HexString.h"
#import <QuartzCore/QuartzCore.h>

@implementation EventCommentView

static LORichTextLabel *measureLabel = nil;

static NSString *BG_COLOR = @"#ededed";
static NSString *COMMENT_COLOR = @"#4384b1";
static const CGFloat SCREEN_WIDTH = 300;
static const CGFloat MAX_HEIGHT = 999999;
static const CGFloat FONT_SIZE = 10;
static const CGFloat MARGIN = 10;
static const CGFloat SPACE = 5;
static const CGFloat THUMB_SIZE = 20;

+(CGFloat)heightForName:(NSString *)name comment:(NSString *)comment {
    //NSString *str = [NSString stringWithFormat:@"%@ %@", name, comment];
    CGFloat defaultHeight = THUMB_SIZE;
    
    /*
    UIFont *font = [UIFont systemFontOfSize:FONT_SIZE];
    CGSize szMax = CGSizeMake(SCREEN_WIDTH - (THUMB_SIZE + MARGIN * 2 + SPACE), MAX_HEIGHT);
    CGSize sz = [str sizeWithFont:font constrainedToSize:szMax];
    CGFloat height = sz.height;
    */
    
    //NSLog(@"hfn: %f", MAX(defaultHeight, height) + MARGIN * 2);
    
    if (measureLabel == nil) {
        measureLabel = [[LORichTextLabel alloc] initWithWidth:0];
        [measureLabel setFont:[UIFont systemFontOfSize:10]];
        [measureLabel setTextColor:[UIColor grayColor]];        
        
        LORichTextLabelStyle *style = [LORichTextLabelStyle styleWithFont:[UIFont boldSystemFontOfSize:10] color:[UIColor colorWithHexString:@"#82c4dc"]];        
        style.removePrefix = TRUE;
        [measureLabel addStyle:style forPrefix:@"#"];
        
        CGRect r;
        r = measureLabel.frame;
        r.size.width = SCREEN_WIDTH - (THUMB_SIZE + MARGIN * 2 + SPACE);
        measureLabel.frame = r;
    }    
    
    NSArray *arr = [name componentsSeparatedByString:@" "];
    NSMutableString *n = [NSMutableString string];
    for (NSString *s in arr) {
        if (n.length) {
            [n appendString:@" "];
        }
        [n appendFormat:@"#%@", s];
    }
    
    NSString *text = [NSString stringWithFormat:@"%@ %@", n, comment];
    [measureLabel setText:text];
    [measureLabel layoutSubviews];
    
    //NSLog(@"h: %f", measureLabel.frame.size.height);
    
    return MAX(defaultHeight, measureLabel.frame.size.height) + MARGIN * 2;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:BG_COLOR]; //[UIColor whiteColor];
        
        lineView = [[UIView alloc] initWithFrame:CGRectMake(MARGIN, 0, SCREEN_WIDTH - MARGIN * 2, 1)];
        lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        [self addSubview:lineView];
        [lineView release];        
        
        /*
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(MARGIN, 0)];
        [path addLineToPoint:CGPointMake(SCREEN_WIDTH - MARGIN, 0)];        
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [shapeLayer setFrame:self.bounds];
        [shapeLayer setPath:path.CGPath];
        [shapeLayer setFillColor:[UIColor clearColor].CGColor];
        [shapeLayer setLineWidth:1];
        [shapeLayer setStrokeColor:[UIColor lightGrayColor].CGColor];
        [self.layer addSublayer:shapeLayer];
        */
        
        thumbImage = [[UIImageView alloc] init];        
        thumbImage.frame = CGRectMake(MARGIN, MARGIN, THUMB_SIZE, THUMB_SIZE);
        [self addSubview:thumbImage];
        [thumbImage release];
        
        /*
        commentLabel = [[UILabel alloc] init];
        commentLabel.backgroundColor = [UIColor clearColor];        
        commentLabel.textColor = [UIColor colorWithHexString:COMMENT_COLOR];
        commentLabel.font = [UIFont systemFontOfSize:FONT_SIZE];        
        commentLabel.numberOfLines = 0;
        commentLabel.frame = CGRectMake(MARGIN + THUMB_SIZE + SPACE, MARGIN - 2, SCREEN_WIDTH - (THUMB_SIZE + MARGIN * 2 + SPACE), 0);
        [self addSubview:commentLabel];
        [commentLabel release];
        */
         
        commentLabel = [[LORichTextLabel alloc] initWithWidth:0];
        commentLabel.frame = CGRectMake(MARGIN + THUMB_SIZE + SPACE, MARGIN - 2, SCREEN_WIDTH - (THUMB_SIZE + MARGIN * 2 + SPACE), 0);
        [commentLabel setFont:[UIFont systemFontOfSize:10]];
        [commentLabel setTextColor:[UIColor grayColor]];        
        
        LORichTextLabelStyle *style = [LORichTextLabelStyle styleWithFont:[UIFont boldSystemFontOfSize:10] color:[UIColor colorWithHexString:@"#82c4dc"]];        
        style.removePrefix = TRUE;
        [commentLabel addStyle:style forPrefix:@"#"];
        
        [self addSubview:commentLabel];
        [commentLabel release];


    }
    return self;
}

- (void)setThumbImage:(UIImage *)image {
    thumbImage.image = image;
}

- (void)setName:(NSString *)name comment:(NSString *)comment {
    /*
    NSString *str = [NSString stringWithFormat:@"%@ %@", name, comment];
    commentLabel.text = str;
    CGSize sz = [str sizeWithFont:commentLabel.font constrainedToSize:CGSizeMake(commentLabel.frame.size.width, MAX_HEIGHT)];
    CGRect r;
    r = commentLabel.frame;
    r.size.height = sz.height;
    commentLabel.frame = r;   
    */
    NSArray *arr = [name componentsSeparatedByString:@" "];
    NSMutableString *n = [NSMutableString string];
    for (NSString *s in arr) {
        if (n.length) {
            [n appendString:@" "];
        }
        [n appendFormat:@"#%@", s];
    }
    
    NSString *str = [NSString stringWithFormat:@"%@ %@", n, comment];
    [commentLabel setText:str];
    [commentLabel layoutSubviews];
}

- (void)updateSize {
    CGRect r;
    CGFloat defaultHeight = THUMB_SIZE;
    r = self.frame;
    r.size.height = MAX(defaultHeight, commentLabel.frame.size.height) + MARGIN * 2;
    self.frame = r;        
}

- (void)setDivHidden:(BOOL)hidden {
    lineView.hidden = hidden;
}

@end
