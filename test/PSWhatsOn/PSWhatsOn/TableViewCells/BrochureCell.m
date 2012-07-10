//
//  BrochureCell.m
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import "BrochureCell.h"
#import "UIColor+HexString.h"
#import "QuartzCore/QuartzCore.h"
#import "MainViewController.h"

@implementation BrochureCellComment
@synthesize thumb, name, comment;

- (void)dealloc {
    [thumb release];
    [name release];
    [comment release];
    [super dealloc];
}

@end

@implementation BrochureCellInfo
@synthesize popular, title, price, favSubject, comments;

- (id)init {
    if ((self = [super init])) {
        comments = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [title release];
    [price release];
    [favSubject release];
    [comments release];
    [super dealloc];
}

@end

@implementation BrochureCell
@synthesize favButton = favButton;

static const CGFloat FAV_SIZE = 16;

+ (CGFloat)width {
    return 300;
}

+ (CGFloat)heightForInfo:(BrochureCellInfo *)info {
    CGFloat ret = 0;
    CGSize priceSize;
    
    if (info.price.length) {
        priceSize = [info.price sizeWithFont:[BrochureCell titleFont]];                                    
    }
    
    CGSize szMax = CGSizeMake([BrochureCell width] - FAV_SIZE - 20 - priceSize.width, CGFLOAT_MAX);
    CGSize sz = [info.title sizeWithFont:[BrochureCell titleFont] constrainedToSize:szMax];
    ret += MAX(FAV_SIZE, sz.height);
    
    ret += 10; //div view height
    
    BOOL end = TRUE;
    if (info.favSubject.length) {        
        end = FALSE;
        ret += 10 + 20; //fav view
    }
    
    if (info.comments.count) {        
        if (end) {
            ret += 10; //space between div and this, since fav subject is empty
        }
        end = FALSE;
        for (BrochureCellComment *comment in info.comments) {
            ret += [EventCommentView heightForName:comment.name comment:comment.comment];
        }
    }
    
    if (end) {
        ret += 20; //top bottom margin
    } else {
        ret += 10; //top margin without bottom
    }
    
    ret += 10; //space
    return ret;
}

+ (UIFont *)titleFont {
    static UIFont *titleFont = nil;
    if (titleFont == nil) {
        titleFont = [UIFont boldSystemFontOfSize:17];
    }
    return titleFont;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect r;
        
        self.backgroundColor = [UIColor clearColor];
        
        bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor colorWithHexString:@"#ededed"];
        [self addSubview:bgView];
        [bgView release];
                
        favButton = [[UIButton alloc] init];       
        favButton.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage imageNamed:@"icon_star.png"];
        [favButton setImage:image forState:UIControlStateNormal];
        favButton.frame = CGRectMake(10, 13, image.size.width, image.size.height);
        [bgView addSubview:favButton];
        [favButton release];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.frame = CGRectMake(10 + FAV_SIZE + 5, 10, 0, 0);
        titleLabel.textColor = [UIColor colorWithHexString:@"#4384b1"];
        titleLabel.font = [BrochureCell titleFont];
        titleLabel.numberOfLines = 0;
        [bgView addSubview:titleLabel];
        [titleLabel release];
        
        priceLabel = [[UILabel alloc] init];
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.textColor = [UIColor redColor];
        priceLabel.font = [BrochureCell titleFont];
        priceLabel.numberOfLines = 1;
        [bgView addSubview:priceLabel];
        [priceLabel release];
        
        divView = [[UIView alloc] init];
        divView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        divView.frame = CGRectMake(10, 0, [BrochureCell width] - 20, 1);
        [bgView addSubview:divView];
        [divView release];
        
        ribbonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ribbon_popular.png"]];
        r = ribbonImage.frame;
        r.origin.x = [BrochureCell width] + 10 - r.size.width + 2;
        r.origin.y = 8;
        ribbonImage.frame = r;
        [self addSubview:ribbonImage];
        [ribbonImage release];
        
        CGFloat w = [BrochureCell width];
        CGFloat h = 20;
        
        favView = [[UIView alloc] init];
        favView.backgroundColor = [UIColor whiteColor];
        favView.frame = CGRectMake(0, 0, w , h);   
        [bgView addSubview:favView];
        [favView release];
        
        UIBezierPath *triPath;
        CAShapeLayer *shapeLayer;
        
        triPath = [UIBezierPath bezierPath];
        [triPath moveToPoint:CGPointMake(0, 0)];
        [triPath addLineToPoint:CGPointMake(17 - 7, 0)];        
        [triPath addLineToPoint:CGPointMake(17, -7)];
        [triPath addLineToPoint:CGPointMake(17 + 7, 0)];
        [triPath addLineToPoint:CGPointMake(w, 0)];
        
        shapeLayer = [CAShapeLayer layer];
        [shapeLayer setFrame:favView.bounds];
        [shapeLayer setPath:triPath.CGPath];
        [shapeLayer setFillColor:[UIColor clearColor].CGColor];
        [shapeLayer setLineWidth:1];
        [shapeLayer setStrokeColor:[UIColor lightGrayColor].CGColor];
        [favView.layer addSublayer:shapeLayer];
        
        triPath = [UIBezierPath bezierPath];
        [triPath moveToPoint:CGPointMake(0, 0)];
        [triPath addLineToPoint:CGPointMake(17 - 7, 0)];        
        [triPath addLineToPoint:CGPointMake(17, -7)];
        [triPath addLineToPoint:CGPointMake(17 + 7, 0)];
        [triPath addLineToPoint:CGPointMake(w, 0)];
        [triPath addLineToPoint:CGPointMake(w, h)];
        [triPath addLineToPoint:CGPointMake(0, h)];                                
        [triPath addLineToPoint:CGPointMake(0, 0)];
                
        shapeLayer = [CAShapeLayer layer];
        [shapeLayer setFrame:favView.bounds];
        [shapeLayer setPath:triPath.CGPath];
        [shapeLayer setFillColor:[UIColor whiteColor].CGColor];
        [favView.layer addSublayer:shapeLayer];
        
        favLabel = [[LORichTextLabel alloc] initWithWidth:0];
        favLabel.frame = CGRectMake(5, 4, favView.frame.size.width - 10, 10);
        [favLabel setFont:[UIFont systemFontOfSize:10]];
        [favLabel setTextColor:[UIColor grayColor]];        
        
        LORichTextLabelStyle *style = [LORichTextLabelStyle styleWithFont:[UIFont boldSystemFontOfSize:10] color:[UIColor colorWithHexString:@"#82c4dc"]];        
        style.removePrefix = TRUE;
        [favLabel addStyle:style forPrefix:@"#"];
        
        [favView addSubview:favLabel];
        [favLabel release];
        
        commentViews = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)dealloc {
    [commentViews release];
    [super dealloc];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat top = 10;
    CGRect r;
    CGSize sz;    
    CGSize priceSize;

    if (priceLabel.text.length) {
        priceSize = [priceLabel.text sizeWithFont:[BrochureCell titleFont]];                                    
    }
    
    CGSize sizeMax = CGSizeMake([BrochureCell width] - FAV_SIZE - 20 - priceSize.width - 5, CGFLOAT_MAX);
    sz = [titleLabel.text sizeWithFont:[BrochureCell titleFont] constrainedToSize:sizeMax];
    r = titleLabel.frame;
    r.size.width = sz.width;
    r.size.height = sz.height;
    titleLabel.frame = r;
    
    r = priceLabel.frame;
    r.origin.x = titleLabel.frame.origin.x + titleLabel.frame.size.width + 10;
    r.origin.y = titleLabel.frame.origin.y + (titleLabel.frame.size.height - priceSize.height) * 0.5;
    r.size = priceSize;
    priceLabel.frame = r;
    
    top += MAX(FAV_SIZE, titleLabel.frame.size.height);
    
    r = divView.frame;
    r.origin.y = top + 9;
    divView.frame = r;    
    top += 10;
    
    if (!favView.hidden) {
        r = favView.frame;
        r.origin.y = top + 10;
        favView.frame = r;
        top += 10 + r.size.height;
    } else {
        top += 10;
    }
    
    for (int i = 0; i < commentsCount; ++i) {
        EventCommentView *ecv = [commentViews objectAtIndex:i];
        r = ecv.frame;
        r.origin.y = top;
        ecv.frame = r;
        top = r.origin.y + r.size.height;
    }
            
    bgView.frame = CGRectMake(10, 10, self.frame.size.width - 20, self.frame.size.height - 10);
}

- (void)setInfo:(BrochureCellInfo *)info {
    titleLabel.text = info.title;
    priceLabel.text = info.price;
    ribbonImage.hidden = !info.popular;    
    if (info.favSubject.length) {
        favView.hidden = FALSE;
        NSString *s = [NSString stringWithFormat:@"#%@ favorite this.", info.favSubject];
        [favLabel setText:s];
    } else {
        favView.hidden = TRUE;
    }
    
    commentsCount = info.comments.count;
    if (commentsCount) {
        int idx = 0;
        for (BrochureCellComment *comment in info.comments) {
            EventCommentView *ecv = nil;
            if (idx < commentViews.count) {
                ecv = [commentViews objectAtIndex:idx];                
            } else {
                ecv = [[EventCommentView alloc] initWithFrame:CGRectMake(0, 0, [BrochureCell width], 0)];
                ecv.backgroundColor = [UIColor whiteColor];
                [commentViews addObject:ecv];
                [bgView addSubview:ecv];
                [ecv release];
            }
            ecv.hidden = FALSE;
            [ecv setThumbImage:comment.thumb];
            [ecv setName:comment.name comment:comment.comment];
            [ecv updateSize];
            [ecv setDivHidden:idx == 0 && favView.hidden];
            ++idx;
        }
    }
    
    for (int i = commentsCount; i < commentViews.count; ++i) {
        EventCommentView *ecv = [commentViews objectAtIndex:i];
        ecv.hidden = TRUE;
    }
         
}

@end
