//
//  EventCell.m
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import "EventCell.h"
#import "EventCommentView.h"
#import "UIColor+HexString.h"

@implementation MyLocation
@synthesize coordinate;
@end

@implementation EventCellComment
@synthesize thumbImage, name, comment;

- (void)dealloc {
    [thumbImage release];
    [name release];
    [comment release];
    [super dealloc];
}

@end

@implementation EventCellInfo
@synthesize expanded, popular, actionSubject, actionVerb, actionObject, image;
@synthesize lat, lon, videoPath, title, where, mrt, when, admission, tel, email;
@synthesize total, here, maybe, desc, favSubject, comments;

- (id)init {
    if (self = [super init]) {
        comments = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [actionSubject release];
    [actionVerb release];
    [actionObject release];
    [image release];
    [videoPath release];
    [title release];
    [where release];
    [mrt release];
    [when release];
    [admission release];
    [tel release];
    [email release];
    [total release];
    [here release];
    [maybe release];
    [desc release];
    [favSubject release];
    [comments release];
    [super dealloc];
}

@end

@implementation EventCell

static NSString *BG_COLOR = @"#ffffff"; //@"#ededed";
static NSString *TITLE_COLOR = @"#4384b1";
static NSString *INFO_BG_COLOR = @"#ededed";
static NSString *FAV_BG_COLOR = @"#ededed";
static const CGFloat METERS_PER_MILE = 1000; //1689.344;
static const CGFloat TITLE_FONT_SIZE = 17;
static const CGFloat SCREEN_WIDTH = 300;
static const CGFloat MAX_HEIGHT = 999999;
static const CGFloat MARGIN = 10;
static const CGFloat SPACE = 5;
static const CGFloat FAV_SPACE = 2;
static const CGFloat ACTION_HEIGHT = 35;
static const CGFloat ACTION_IMG_SIZE = 20;
static const CGFloat HEADER_IMG_HEIGHT = 150;
static const CGFloat INFO_WIDTH = 95;
static const CGFloat INFO_TITLE_LEFT = 140;
static const CGFloat INFO_TITLE_WIDTH = 55;
static const CGFloat INFO_TITLE_HEIGHT = 13;
static const CGFloat INFO_CONTENT_WIDTH = INFO_TITLE_LEFT - INFO_TITLE_WIDTH;
static const CGFloat INFO_FONT_SIZE = 10;
static const CGFloat MAP_HEIGHT = 80;
static const CGFloat INFO_BUTTONS_HEIGHT = 30;
static const CGFloat STAT_HEIGHT = 40;
static const CGFloat DESC_AUTHOR_HEIGHT = 20;
static const CGFloat DESC_TAB = 20;
static const CGFloat DESC_FONT_SIZE = 10;
static const CGFloat FAV_WIDTH = 16;
static const CGFloat TITLE_WIDTH = SCREEN_WIDTH - (MARGIN + FAV_WIDTH + SPACE * 2 + INFO_WIDTH);
static const CGFloat TIME_TOP = 12;
static const CGFloat DIST_TOP = 23;
static const CGFloat DIV_HEIGHT = 1;
static const CGFloat GOING_HEIGHT = 12;
static const CGFloat FAV_HEIGHT = 30;

@synthesize todoButton = todoButton;
@synthesize brochureButton = brochureButton;
@synthesize videoButton = videoButton;
@synthesize favButton = favButton;
@synthesize statButton1, statButton2, statButton3;
@synthesize mapButton;

+ (CGFloat)heightForInfo:(EventCellInfo *)info {
    CGSize sz;
    CGSize szMax;    
    CGFloat ret = 0;
    if (info.actionSubject.length && info.actionVerb.length && info.actionObject.length) {
        ret += ACTION_HEIGHT;
    }
    if (info.image) {
        ret += HEADER_IMG_HEIGHT;
    }    
    ret += MARGIN;
    szMax = CGSizeMake(TITLE_WIDTH + SPACE * 2, MAX_HEIGHT);
    sz = [info.title sizeWithFont:[UIFont boldSystemFontOfSize:TITLE_FONT_SIZE] constrainedToSize:szMax];
    ret += sz.height;
    ret += SPACE + DIV_HEIGHT;
    
    if (info.expanded) {
        CGFloat totalHeight = 0;
        
        szMax = CGSizeMake(INFO_CONTENT_WIDTH, MAX_HEIGHT);
        sz = [info.where sizeWithFont:[UIFont systemFontOfSize:INFO_FONT_SIZE] constrainedToSize:szMax];
        totalHeight += sz.height;
        
        szMax = CGSizeMake(INFO_CONTENT_WIDTH, MAX_HEIGHT);
        sz = [info.mrt sizeWithFont:[UIFont systemFontOfSize:INFO_FONT_SIZE] constrainedToSize:szMax];
        totalHeight += sz.height;
        
        szMax = CGSizeMake(INFO_CONTENT_WIDTH, MAX_HEIGHT);
        sz = [info.when sizeWithFont:[UIFont systemFontOfSize:INFO_FONT_SIZE] constrainedToSize:szMax];
        totalHeight += sz.height;
        
        szMax = CGSizeMake(INFO_CONTENT_WIDTH, MAX_HEIGHT);
        sz = [info.admission sizeWithFont:[UIFont systemFontOfSize:INFO_FONT_SIZE] constrainedToSize:szMax];
        totalHeight += sz.height;
        
        szMax = CGSizeMake(INFO_CONTENT_WIDTH, MAX_HEIGHT);
        sz = [info.tel sizeWithFont:[UIFont systemFontOfSize:INFO_FONT_SIZE] constrainedToSize:szMax];
        totalHeight += sz.height;
        
        szMax = CGSizeMake(INFO_CONTENT_WIDTH, MAX_HEIGHT);
        sz = [info.email sizeWithFont:[UIFont systemFontOfSize:INFO_FONT_SIZE] constrainedToSize:szMax];
        totalHeight += sz.height;
        
        ret += SPACE * 3 + INFO_BUTTONS_HEIGHT + totalHeight; //top, bottom, & space between info and stat
        
        ret += STAT_HEIGHT + SPACE;
        ret += DESC_AUTHOR_HEIGHT + SPACE;
        
        szMax = CGSizeMake(SCREEN_WIDTH - MARGIN * 2 - DESC_TAB - SPACE, MAX_HEIGHT);
        sz = [info.desc sizeWithFont:[UIFont systemFontOfSize:DESC_FONT_SIZE] constrainedToSize:szMax];
        ret += sz.height + SPACE;        
    }
    
    ret += SPACE + GOING_HEIGHT + SPACE;
    
    BOOL end = TRUE;
    if (info.favSubject.length) {
        end = FALSE;
        ret += FAV_SPACE + FAV_HEIGHT;
    } 
    
    if (info.comments.count) {
        end = FALSE;
        for (EventCellComment *comment in info.comments) {
            ret += [EventCommentView heightForName:comment.name comment:comment.comment];
        }
    }
    
    if (end) {
        //ret += MARGIN;    
    }
    return ret;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {                
        self.contentView.backgroundColor = [UIColor colorWithHexString:BG_COLOR];        
        //self.contentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        //self.contentView.layer.borderWidth = 1;
        //self.contentView.layer.cornerRadius = 10;
        
        maskLayer = [CAShapeLayer layer];
        self.layer.mask = maskLayer;                
        
        headerImage = [[UIImageView alloc] init];
        headerImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEADER_IMG_HEIGHT);
        headerImage.clipsToBounds = TRUE;
        [self addSubview:headerImage];
        [headerImage release];
        
        actionView = [[UIView alloc] init];
        actionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ACTION_HEIGHT);
        actionView.backgroundColor = [UIColor redColor];
        actionView.hidden = TRUE;        
        [self addSubview:actionView];
        [actionView release];
        
        /*
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:actionView.bounds 
                                                       byRoundingCorners:UIRectCornerTopLeft
                                                             cornerRadii:CGSizeMake(10.0f, 10.0f)];
        */
        UIBezierPath *triPath = [UIBezierPath bezierPath];
        [triPath moveToPoint:CGPointMake(0, 0)];
        [triPath addLineToPoint:CGPointMake(SCREEN_WIDTH, 0)];
        [triPath addLineToPoint:CGPointMake(SCREEN_WIDTH, ACTION_HEIGHT)];
        [triPath addLineToPoint:CGPointMake(13 + 7, ACTION_HEIGHT)];
        [triPath addLineToPoint:CGPointMake(13, ACTION_HEIGHT + 7)];
        [triPath addLineToPoint:CGPointMake(13 - 7, ACTION_HEIGHT)];
        [triPath addLineToPoint:CGPointMake(0, ACTION_HEIGHT)];
        [triPath addLineToPoint:CGPointMake(0, 0)];
        
        
        CAShapeLayer *customLayer = [CAShapeLayer layer];
        [customLayer setFrame:actionView.bounds];
        [customLayer setPath:triPath.CGPath];
        [customLayer setFillColor:[UIColor whiteColor].CGColor];
        [actionView.layer addSublayer:customLayer];
        
        triPath = [UIBezierPath bezierPath];
        [triPath moveToPoint:CGPointMake(0, ACTION_HEIGHT)];
        [triPath addLineToPoint:CGPointMake(13 - 7, ACTION_HEIGHT)];
        [triPath addLineToPoint:CGPointMake(13, ACTION_HEIGHT + 7)];
        [triPath addLineToPoint:CGPointMake(13 + 7, ACTION_HEIGHT)];
        [triPath addLineToPoint:CGPointMake(SCREEN_WIDTH, ACTION_HEIGHT)];        
        
        customLayer = [CAShapeLayer layer];
        [customLayer setFrame:actionView.bounds];
        [customLayer setPath:triPath.CGPath];
        [customLayer setLineWidth:1];
        [customLayer setStrokeColor:[UIColor lightGrayColor].CGColor];
        [customLayer setFillColor:[UIColor clearColor].CGColor];
        [actionView.layer addSublayer:customLayer];
        
        
        
        actionImage = [[UIImageView alloc] init];
        actionImage.frame = CGRectMake(5, 7, ACTION_IMG_SIZE, ACTION_IMG_SIZE);
        actionImage.image = [UIImage imageNamed:@"test_thumb.png"];
        [actionView addSubview:actionImage];
        [actionImage release];
        
        actionLabel = [[UILabel alloc] init];
        actionLabel.backgroundColor = [UIColor clearColor];
        actionLabel.text = @"Eugene Teo invite you to Jam Hsiao World Tour 2012";
        actionLabel.textColor = [UIColor colorWithHexString:TITLE_COLOR];
        actionLabel.font = [UIFont systemFontOfSize:10];        
        actionLabel.numberOfLines = 2;
        actionLabel.frame = CGRectMake(30, 6, SCREEN_WIDTH - 30- 50, 25);
        [actionView addSubview:actionLabel];
        [actionLabel release];
        
        favButton = [[UIButton alloc] init];       
        favButton.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage imageNamed:@"icon_star.png"];
        [favButton setImage:image forState:UIControlStateNormal];
        favButton.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [self addSubview:favButton];
        [favButton release];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = @"Singapore Pastel Art Exhibition: Impression and Expression";
        titleLabel.textColor = [UIColor colorWithHexString:TITLE_COLOR];
        titleLabel.font = [UIFont boldSystemFontOfSize:TITLE_FONT_SIZE];        
        titleLabel.numberOfLines = 0;
        [self addSubview:titleLabel];
        [titleLabel release];
        
        CGRect r;
        
        timeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_time.png"]];
        r = timeImage.frame;
        r.origin.x = SCREEN_WIDTH - INFO_WIDTH + 5;
        r.origin.y = TIME_TOP;
        timeImage.frame = r;
        [self addSubview:timeImage];
        [timeImage release];
        
        timeLabel = [[UILabel alloc] init];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.text = @"48 minutes";
        timeLabel.textColor = [UIColor lightGrayColor];
        timeLabel.font = [UIFont systemFontOfSize:10];
        timeLabel.frame = CGRectMake(r.origin.x + r.size.width + 5, r.origin.y - 2, 100, 12);
        [self addSubview:timeLabel];
        [timeLabel release];
        
        distanceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_pin.png"]];
        r = distanceImage.frame;
        r.origin.x = SCREEN_WIDTH - INFO_WIDTH + 6;
        r.origin.y = DIST_TOP;
        distanceImage.frame = r;
        [self addSubview:distanceImage];
        [distanceImage release];
        
        distanceLabel = [[UILabel alloc] init];
        distanceLabel.backgroundColor = [UIColor clearColor];
        distanceLabel.text = @"0-3 km";
        distanceLabel.textColor = [UIColor lightGrayColor];
        distanceLabel.font = [UIFont systemFontOfSize:10];
        distanceLabel.frame = CGRectMake(r.origin.x + r.size.width + 7, r.origin.y - 2, 100, 12);
        [self addSubview:distanceLabel];
        [distanceLabel release];
        
        divView = [[UIView alloc] init];
        divView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        divView.frame = CGRectMake(MARGIN, 0, SCREEN_WIDTH - MARGIN * 2, DIV_HEIGHT);
        [self addSubview:divView];
        [divView release];
        
        // INFO VIEW
        
        infoView = [[UIView alloc] init];
        infoView.backgroundColor = [UIColor colorWithHexString:INFO_BG_COLOR];
        infoView.frame = CGRectMake(SPACE, 0, SCREEN_WIDTH - SPACE * 2, 0);
        infoView.hidden = TRUE;
        [self addSubview:infoView];
        [infoView release];
        
        whereTitleLabel = [[UILabel alloc] init];
        whereTitleLabel.backgroundColor = [UIColor clearColor];
        whereTitleLabel.text = @"Where: ";
        whereTitleLabel.textColor = [UIColor darkGrayColor];
        whereTitleLabel.font = [UIFont systemFontOfSize:INFO_FONT_SIZE];
        whereTitleLabel.frame = CGRectMake(INFO_TITLE_LEFT, SPACE, INFO_TITLE_WIDTH, INFO_TITLE_HEIGHT);
        [infoView addSubview:whereTitleLabel];
        [whereTitleLabel release];
        
        whereLabel = [[UILabel alloc] init];
        whereLabel.backgroundColor = [UIColor clearColor];        
        whereLabel.textColor = [UIColor darkGrayColor];
        whereLabel.font = [UIFont systemFontOfSize:INFO_FONT_SIZE];
        whereLabel.numberOfLines = 0;
        whereLabel.frame = CGRectMake(INFO_TITLE_LEFT + INFO_TITLE_WIDTH, SPACE, INFO_CONTENT_WIDTH, INFO_TITLE_HEIGHT);
        [infoView addSubview:whereLabel];
        [whereLabel release];
        
        mrtTitleLabel = [[UILabel alloc] init];
        mrtTitleLabel.backgroundColor = [UIColor clearColor];
        mrtTitleLabel.text = @"MRT: ";
        mrtTitleLabel.textColor = [UIColor darkGrayColor];
        mrtTitleLabel.font = [UIFont systemFontOfSize:INFO_FONT_SIZE];
        mrtTitleLabel.frame = CGRectMake(INFO_TITLE_LEFT, MARGIN, INFO_TITLE_WIDTH, INFO_TITLE_HEIGHT);
        [infoView addSubview:mrtTitleLabel];
        [mrtTitleLabel release];
        
        mrtLabel = [[UILabel alloc] init];
        mrtLabel.backgroundColor = [UIColor clearColor];        
        mrtLabel.textColor = [UIColor darkGrayColor];
        mrtLabel.font = [UIFont systemFontOfSize:INFO_FONT_SIZE];
        mrtLabel.numberOfLines = 0;
        mrtLabel.frame = CGRectMake(INFO_TITLE_LEFT + INFO_TITLE_WIDTH, MARGIN, INFO_CONTENT_WIDTH, INFO_TITLE_HEIGHT);
        [infoView addSubview:mrtLabel];
        [mrtLabel release];
        
        whenTitleLabel = [[UILabel alloc] init];
        whenTitleLabel.backgroundColor = [UIColor clearColor];
        whenTitleLabel.text = @"When: ";
        whenTitleLabel.textColor = [UIColor darkGrayColor];
        whenTitleLabel.font = [UIFont systemFontOfSize:INFO_FONT_SIZE];
        whenTitleLabel.frame = CGRectMake(INFO_TITLE_LEFT, MARGIN, INFO_TITLE_WIDTH, INFO_TITLE_HEIGHT);
        [infoView addSubview:whenTitleLabel];
        [whenTitleLabel release];
        
        whenLabel = [[UILabel alloc] init];
        whenLabel.backgroundColor = [UIColor clearColor];        
        whenLabel.textColor = [UIColor darkGrayColor];
        whenLabel.font = [UIFont systemFontOfSize:INFO_FONT_SIZE];
        whenLabel.numberOfLines = 0;
        whenLabel.frame = CGRectMake(INFO_TITLE_LEFT + INFO_TITLE_WIDTH, MARGIN, INFO_CONTENT_WIDTH, INFO_TITLE_HEIGHT);
        [infoView addSubview:whenLabel];
        [whenLabel release];
        
        admissionTitleLabel = [[UILabel alloc] init];
        admissionTitleLabel.backgroundColor = [UIColor clearColor];
        admissionTitleLabel.text = @"Admission: ";
        admissionTitleLabel.textColor = [UIColor darkGrayColor];
        admissionTitleLabel.font = [UIFont systemFontOfSize:INFO_FONT_SIZE];
        admissionTitleLabel.frame = CGRectMake(INFO_TITLE_LEFT, MARGIN, INFO_TITLE_WIDTH, INFO_TITLE_HEIGHT);
        [infoView addSubview:admissionTitleLabel];
        [admissionTitleLabel release];
        
        admissionLabel = [[UILabel alloc] init];
        admissionLabel.backgroundColor = [UIColor clearColor];        
        admissionLabel.textColor = [UIColor darkGrayColor];
        admissionLabel.font = [UIFont systemFontOfSize:INFO_FONT_SIZE];
        admissionLabel.numberOfLines = 0;
        admissionLabel.frame = CGRectMake(INFO_TITLE_LEFT + INFO_TITLE_WIDTH, MARGIN, INFO_CONTENT_WIDTH, INFO_TITLE_HEIGHT);
        [infoView addSubview:admissionLabel];
        [admissionLabel release];
        
        telTitleLabel = [[UILabel alloc] init];
        telTitleLabel.backgroundColor = [UIColor clearColor];
        telTitleLabel.text = @"Tel: ";
        telTitleLabel.textColor = [UIColor darkGrayColor];
        telTitleLabel.font = [UIFont systemFontOfSize:INFO_FONT_SIZE];
        telTitleLabel.frame = CGRectMake(INFO_TITLE_LEFT, MARGIN, INFO_TITLE_WIDTH, INFO_TITLE_HEIGHT);
        [infoView addSubview:telTitleLabel];
        [telTitleLabel release];
        
        telLabel = [[UILabel alloc] init];
        telLabel.backgroundColor = [UIColor clearColor];        
        telLabel.textColor = [UIColor colorWithHexString:TITLE_COLOR];
        telLabel.font = [UIFont systemFontOfSize:INFO_FONT_SIZE];
        telLabel.numberOfLines = 0;
        telLabel.frame = CGRectMake(INFO_TITLE_LEFT + INFO_TITLE_WIDTH, MARGIN, INFO_CONTENT_WIDTH, INFO_TITLE_HEIGHT);
        [infoView addSubview:telLabel];
        [telLabel release];
        
        emailTitleLabel = [[UILabel alloc] init];
        emailTitleLabel.backgroundColor = [UIColor clearColor];
        emailTitleLabel.text = @"E-mail: ";
        emailTitleLabel.textColor = [UIColor darkGrayColor];
        emailTitleLabel.font = [UIFont systemFontOfSize:INFO_FONT_SIZE];
        emailTitleLabel.frame = CGRectMake(INFO_TITLE_LEFT, MARGIN, INFO_TITLE_WIDTH, INFO_TITLE_HEIGHT);
        [infoView addSubview:emailTitleLabel];
        [emailTitleLabel release];
        
        emailLabel = [[UILabel alloc] init];
        emailLabel.backgroundColor = [UIColor clearColor];        
        emailLabel.textColor = [UIColor colorWithHexString:TITLE_COLOR];
        emailLabel.font = [UIFont systemFontOfSize:INFO_FONT_SIZE];
        emailLabel.numberOfLines = 0;
        emailLabel.frame = CGRectMake(INFO_TITLE_LEFT + INFO_TITLE_WIDTH, MARGIN, INFO_CONTENT_WIDTH, INFO_TITLE_HEIGHT);
        [infoView addSubview:emailLabel];
        [emailLabel release];
        
        locMap = [[MKMapView alloc] init];
        locMap.frame = CGRectMake(SPACE, SPACE, INFO_TITLE_LEFT - MARGIN * 2, MAP_HEIGHT);
        locMap.layer.borderColor = [UIColor lightGrayColor].CGColor;
        locMap.layer.borderWidth = 1;
        locMap.delegate = self;
        [infoView addSubview:locMap];
        [locMap release];
        
        mapButton = [[UIButton alloc] init];
        mapButton.frame = locMap.frame;
        [infoView addSubview:mapButton];
        [mapButton release];
        
        todoButton = [[UIButton alloc] init];
        UIImage *img = [UIImage imageNamed:@"button_info.png"];
        [todoButton setBackgroundImage:img forState:UIControlStateNormal];
        [todoButton setTitle:@"+MY CALENDAR" forState:UIControlStateNormal];
        [todoButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        todoButton.titleLabel.font = [UIFont boldSystemFontOfSize:9];
        todoButton.frame = CGRectMake(10, SPACE + MAP_HEIGHT + SPACE, img.size.width, img.size.height);
        [infoView addSubview:todoButton];
        [todoButton release];
        
        brochureButton = [[UIButton alloc] init];
        [brochureButton setBackgroundImage:img forState:UIControlStateNormal];
        [brochureButton setTitle:@"BROCHURE" forState:UIControlStateNormal];
        [brochureButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        brochureButton.titleLabel.font = [UIFont boldSystemFontOfSize:9];
        brochureButton.frame = CGRectMake(10 + 93, SPACE + MAP_HEIGHT + SPACE, img.size.width, img.size.height);
        [infoView addSubview:brochureButton];
        [brochureButton release];
        
        videoButton = [[UIButton alloc] init];
        [videoButton setBackgroundImage:img forState:UIControlStateNormal];
        [videoButton setTitle:@"VIDEO" forState:UIControlStateNormal];
        [videoButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        videoButton.titleLabel.font = [UIFont boldSystemFontOfSize:9];
        videoButton.frame = CGRectMake(10 + 186, SPACE + MAP_HEIGHT + SPACE, img.size.width, img.size.height);
        [infoView addSubview:videoButton];
        [videoButton release];

        //DESC VIEW
        
        descView = [[UIView alloc] init];
        descView.backgroundColor = [UIColor clearColor];
        descView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
        descView.hidden = TRUE;
        [self addSubview:descView];
        [descView release];
        
        UIView *dv = [[UIView alloc] init];
        dv.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        dv.frame = CGRectMake(MARGIN, 0, SCREEN_WIDTH - MARGIN * 2, DIV_HEIGHT);
        [descView addSubview:dv];
        [dv release];
        
        CGFloat w = SCREEN_WIDTH / 3;
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"TOTAL GOING";
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:8];
        label.frame = CGRectMake(0, 0, w, 15);
        label.textAlignment = UITextAlignmentCenter;
        [descView addSubview:label];
        [label release];
        
        label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"FRIENDS GOING";
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:8];
        label.frame = CGRectMake(w, 0, w, 15);
        label.textAlignment = UITextAlignmentCenter;
        [descView addSubview:label];
        [label release];
        
        label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"INVITES";
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:8];
        label.frame = CGRectMake(w * 2, 0, w, 15);
        label.textAlignment = UITextAlignmentCenter;
        [descView addSubview:label];
        [label release];
        
        dv = [[UIView alloc] init];
        dv.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        dv.frame = CGRectMake(w, SPACE, 1, STAT_HEIGHT - SPACE * 2);
        [descView addSubview:dv];
        [dv release];
        
        dv = [[UIView alloc] init];
        dv.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        dv.frame = CGRectMake(w * 2, SPACE, 1, STAT_HEIGHT - SPACE * 2);
        [descView addSubview:dv];
        [dv release];
        
        statTotalLabel = [[UILabel alloc] init];
        statTotalLabel.backgroundColor = [UIColor clearColor];
        statTotalLabel.textColor = [UIColor blackColor];
        statTotalLabel.font = [UIFont boldSystemFontOfSize:20];
        statTotalLabel.frame = CGRectMake(0, 17, w, 20);
        statTotalLabel.textAlignment = UITextAlignmentCenter;
        [descView addSubview:statTotalLabel];
        [statTotalLabel release];
        
        statButton1 = [[UIButton alloc] init];
        statButton1.frame = statTotalLabel.frame;
        statButton1.tag = 1;
        [descView addSubview:statButton1];
        [statButton1 release];
        
        statHereLabel = [[UILabel alloc] init];
        statHereLabel.backgroundColor = [UIColor clearColor];
        statHereLabel.textColor = [UIColor blackColor];
        statHereLabel.font = [UIFont boldSystemFontOfSize:20];
        statHereLabel.frame = CGRectMake(w, 17, w, 20);
        statHereLabel.textAlignment = UITextAlignmentCenter;
        [descView addSubview:statHereLabel];
        [statHereLabel release];
        
        statButton2 = [[UIButton alloc] init];
        statButton2.frame = statHereLabel.frame;
        statButton2.tag = 2;
        [descView addSubview:statButton2];
        [statButton2 release];
        
        statMaybeLabel = [[UILabel alloc] init];
        statMaybeLabel.backgroundColor = [UIColor clearColor];
        statMaybeLabel.textColor = [UIColor blackColor];
        statMaybeLabel.font = [UIFont boldSystemFontOfSize:20];
        statMaybeLabel.frame = CGRectMake(w * 2, 17, w, 20);
        statMaybeLabel.textAlignment = UITextAlignmentCenter;
        [descView addSubview:statMaybeLabel];
        [statMaybeLabel release];
        
        statButton3 = [[UIButton alloc] init];
        statButton3.frame = statMaybeLabel.frame;
        statButton3.tag = 3;
        [descView addSubview:statButton3];
        [statButton3 release];
        
        descAuthorLabel = [[UILabel alloc] init];
        descAuthorLabel.backgroundColor = [UIColor clearColor];
        descAuthorLabel.textColor = [UIColor darkGrayColor];
        descAuthorLabel.font = [UIFont boldSystemFontOfSize:15];
        descAuthorLabel.frame = CGRectMake(MARGIN, STAT_HEIGHT + SPACE, SCREEN_WIDTH - MARGIN * 2, DESC_AUTHOR_HEIGHT);
        descAuthorLabel.numberOfLines = 1;
        descAuthorLabel.text = @"Adeline Chia";
        [descView addSubview:descAuthorLabel];
        [descAuthorLabel release];
        
        descLabel = [[UILabel alloc] init];
        descLabel.backgroundColor = [UIColor clearColor];
        descLabel.textColor = [UIColor darkGrayColor];
        descLabel.font = [UIFont systemFontOfSize:DESC_FONT_SIZE];
        descLabel.frame = CGRectMake(MARGIN + DESC_TAB + SPACE, STAT_HEIGHT + SPACE + DESC_AUTHOR_HEIGHT + SPACE, SCREEN_WIDTH - MARGIN * 2 - DESC_TAB - SPACE, 0);
        descLabel.numberOfLines = 0;
        [descView addSubview:descLabel];
        [descLabel release];
        
        dv = [[UIView alloc] init];
        dv.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        dv.frame = CGRectMake(MARGIN, STAT_HEIGHT - DIV_HEIGHT, SCREEN_WIDTH - MARGIN * 2, DIV_HEIGHT);
        [descView addSubview:dv];
        [dv release];
        
        goingLabel = [[UILabel alloc] init];
        goingLabel.backgroundColor = [UIColor clearColor];
        goingLabel.text = @"14 friends is going";
        goingLabel.textColor = [UIColor lightGrayColor];
        goingLabel.font = [UIFont systemFontOfSize:10];
        goingLabel.frame = CGRectMake(MARGIN, 0, SCREEN_WIDTH - MARGIN * 2, GOING_HEIGHT);
        [self addSubview:goingLabel];
        [goingLabel release];
        
        favView = [[UIView alloc] init];
        favView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ACTION_HEIGHT);
        favView.hidden = TRUE;        
        [self addSubview:favView];
        [favView release];
        
        
        
        triPath = [UIBezierPath bezierPath];
        [triPath moveToPoint:CGPointMake(0, 0)];
        [triPath addLineToPoint:CGPointMake(17 - 7, 0)];        
        [triPath addLineToPoint:CGPointMake(17, -7)];
        [triPath addLineToPoint:CGPointMake(17 + 7, 0)];
        [triPath addLineToPoint:CGPointMake(SCREEN_WIDTH, 0)];
        [triPath addLineToPoint:CGPointMake(SCREEN_WIDTH, FAV_HEIGHT)];
        [triPath addLineToPoint:CGPointMake(0, FAV_HEIGHT)];                                
        [triPath addLineToPoint:CGPointMake(0, 0)];
        
                
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [shapeLayer setFrame:actionView.bounds];
        [shapeLayer setPath:triPath.CGPath];
        [shapeLayer setFillColor:[UIColor colorWithHexString:FAV_BG_COLOR].CGColor];
        //[shapeLayer setLineWidth:1];
        //[shapeLayer setStrokeColor:[UIColor lightGrayColor].CGColor];
        [favView.layer addSublayer:shapeLayer];
        
        triPath = [UIBezierPath bezierPath];
        [triPath moveToPoint:CGPointMake(0, 0)];
        [triPath addLineToPoint:CGPointMake(17 - 7, 0)];        
        [triPath addLineToPoint:CGPointMake(17, -7)];
        [triPath addLineToPoint:CGPointMake(17 + 7, 0)];
        [triPath addLineToPoint:CGPointMake(SCREEN_WIDTH, 0)];
        
        shapeLayer = [CAShapeLayer layer];
        [shapeLayer setFrame:actionView.bounds];
        [shapeLayer setPath:triPath.CGPath];
        [shapeLayer setFillColor:[UIColor clearColor].CGColor];
        [shapeLayer setLineWidth:1];
        [shapeLayer setStrokeColor:[UIColor lightGrayColor].CGColor];
        [favView.layer addSublayer:shapeLayer];
        
        favLabel = [[UILabel alloc] init];
        favLabel.backgroundColor = [UIColor clearColor];
        favLabel.text = @"Eugene Teo favorite this";
        favLabel.textColor = [UIColor colorWithHexString:@"#82c4dc"];
        favLabel.font = [UIFont systemFontOfSize:10];        
        favLabel.numberOfLines = 1;
        favLabel.frame = CGRectMake(10, 3, SCREEN_WIDTH - 20, 25);
        [favView addSubview:favLabel];
        [favLabel release];
        
        commentViews = [[NSMutableArray alloc] init];
        
        ribbonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ribbon_popular.png"]];
        r = ribbonImage.frame;
        r.origin.x = SCREEN_WIDTH - r.size.width + 2;
        r.origin.y = -2;
        ribbonImage.frame = r;
        ribbonImage.clipsToBounds = FALSE;
        [self addSubview:ribbonImage];
        [ribbonImage release];
    }
    return self;
}

- (void)dealloc {
    [commentViews release];
    [super dealloc];
}

- (void)updateMask:(CGFloat)height {
    CGRect r = CGRectMake(0, 0, SCREEN_WIDTH, height);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:r
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:CGSizeMake(5.0f, 5.0f)];        
    maskLayer.frame = r;
    maskLayer.path = maskPath.CGPath;
}

- (void)layoutSubviews {    
    [super layoutSubviews];    
    CGRect r;
    CGSize sz;
    CGSize szMax;    
    CGFloat top = 0;    
    
    if (!actionView.hidden) {
        top += ACTION_HEIGHT;
    }
    
    r = headerImage.frame;
    r.origin.y = top;
    headerImage.frame = r;
    if (headerImage.image) {
        top += HEADER_IMG_HEIGHT;
    }
    
    r = timeImage.frame;
    r.origin.y = TIME_TOP + top;
    timeImage.frame = r;
    r = timeLabel.frame;
    r.origin.y = timeImage.frame.origin.y - 2;
    timeLabel.frame = r;
    
    r = distanceImage.frame;
    r.origin.y = DIST_TOP + top;
    distanceImage.frame = r;
    r = distanceLabel.frame;
    r.origin.y = distanceImage.frame.origin.y - 2;
    distanceLabel.frame = r;
    
    top += MARGIN;    
    r = favButton.frame;
    r.origin.x = MARGIN;
    r.origin.y = top + 3;
    favButton.frame = r;    

    szMax = CGSizeMake(TITLE_WIDTH + SPACE * 2, MAX_HEIGHT);
    sz = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:szMax];
    r = titleLabel.frame;
    r.origin.x = MARGIN + FAV_WIDTH + SPACE;
    r.origin.y = top;
    r.size = sz;
    titleLabel.frame = r;
    top = r.origin.y + r.size.height + SPACE;
    
    r = divView.frame;
    r.origin.y = top;
    divView.frame = r;
    top = r.origin.y + r.size.height + SPACE;
    
    if (!infoView.hidden) {
        CGFloat labelsHeight = 0;
        szMax = CGSizeMake(whereLabel.frame.size.width, MAX_HEIGHT);
        sz = [whereLabel.text sizeWithFont:whereLabel.font constrainedToSize:szMax];
        r = whereLabel.frame;
        r.size.height = sz.height;
        whereLabel.frame = r;
        labelsHeight += r.size.height;
        
        szMax = CGSizeMake(mrtLabel.frame.size.width, MAX_HEIGHT);
        sz = [mrtLabel.text sizeWithFont:mrtLabel.font constrainedToSize:szMax];
        r = mrtLabel.frame;
        r.origin.y = SPACE + labelsHeight;
        r.size.height = sz.height;
        mrtLabel.frame = r;
        labelsHeight += r.size.height;
        
        r = mrtTitleLabel.frame;
        r.origin.y = mrtLabel.frame.origin.y;
        mrtTitleLabel.frame = r;
        
        szMax = CGSizeMake(whenLabel.frame.size.width, MAX_HEIGHT);
        sz = [whenLabel.text sizeWithFont:whenLabel.font constrainedToSize:szMax];
        r = whenLabel.frame;
        r.origin.y = SPACE + labelsHeight;
        r.size.height = sz.height;
        whenLabel.frame = r;
        labelsHeight += r.size.height;
        
        r = whenTitleLabel.frame;
        r.origin.y = whenLabel.frame.origin.y;
        whenTitleLabel.frame = r;
        
        szMax = CGSizeMake(admissionLabel.frame.size.width, MAX_HEIGHT);
        sz = [admissionLabel.text sizeWithFont:admissionLabel.font constrainedToSize:szMax];
        r = admissionLabel.frame;
        r.origin.y = SPACE + labelsHeight;
        r.size.height = sz.height;
        admissionLabel.frame = r;
        labelsHeight += r.size.height;
        
        r = admissionTitleLabel.frame;
        r.origin.y = admissionLabel.frame.origin.y;
        admissionTitleLabel.frame = r;
        
        szMax = CGSizeMake(telLabel.frame.size.width, MAX_HEIGHT);
        sz = [telLabel.text sizeWithFont:telLabel.font constrainedToSize:szMax];
        r = telLabel.frame;
        r.origin.y = SPACE + labelsHeight;
        r.size.height = sz.height;
        telLabel.frame = r;
        labelsHeight += r.size.height;
        
        r = telTitleLabel.frame;
        r.origin.y = telLabel.frame.origin.y;
        telTitleLabel.frame = r;
        
        szMax = CGSizeMake(emailLabel.frame.size.width, MAX_HEIGHT);
        sz = [emailLabel.text sizeWithFont:emailLabel.font constrainedToSize:szMax];
        r = emailLabel.frame;
        r.origin.y = SPACE + labelsHeight;
        r.size.height = sz.height;
        emailLabel.frame = r;
        labelsHeight += r.size.height;
        
        r = emailTitleLabel.frame;
        r.origin.y = emailLabel.frame.origin.y;
        emailTitleLabel.frame = r;
        
        
        CGFloat buttonsTop = labelsHeight + 10;
        r = todoButton.frame;
        r.origin.y = buttonsTop;
        todoButton.frame = r;
        
        r = brochureButton.frame;
        r.origin.y = buttonsTop;
        brochureButton.frame = r;
        
        r = videoButton.frame;
        r.origin.y = buttonsTop;
        videoButton.frame = r;
        
        r = infoView.frame;
        r.origin.y = top;
        r.size.height = SPACE * 2 + labelsHeight + INFO_BUTTONS_HEIGHT;
        infoView.frame = r;
        top = r.origin.y + r.size.height + SPACE;
                        
        szMax = CGSizeMake(descLabel.frame.size.width, MAX_HEIGHT);
        sz = [descLabel.text sizeWithFont:descLabel.font constrainedToSize:szMax];
        r = descLabel.frame;
        r.size.height = sz.height;
        descLabel.frame = r;
        
        r = descView.frame;
        r.origin.y = top;
        r.size.height = STAT_HEIGHT + SPACE + DESC_AUTHOR_HEIGHT + SPACE + descLabel.frame.size.height;
        descView.frame = r;
        top = r.origin.y + r.size.height + SPACE;
    }
    
    r = goingLabel.frame;
    r.origin.y = top;
    goingLabel.frame = r;
    top = r.origin.y + r.size.height + SPACE;
    
    r = favView.frame;
    r.origin.y = top + FAV_SPACE;
    favView.frame = r;    
    if (!favView.hidden) {
        top += FAV_HEIGHT;        
    }
    
    for (int i = 0; i < commentsCount; ++i) {
        EventCommentView *ecv = [commentViews objectAtIndex:i];
        r = ecv.frame;
        r.origin.y = top;
        ecv.frame = r;
        top = r.origin.y + r.size.height;
    }        
    
    [self updateMask:top];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfo:(EventCellInfo *)info {
    headerImage.image = info.image;
    titleLabel.text = info.title;
    actionView.hidden = (info.actionSubject.length && info.actionVerb.length && info.actionObject.length) ? FALSE : TRUE;
    if (!actionView.hidden) {
        actionLabel.text = [NSString stringWithFormat:@"%@ %@ %@", info.actionSubject, info.actionVerb, info.actionObject];
    }
    
    ribbonImage.hidden = !info.popular;
    
    if (info.expanded) {
        infoView.hidden = FALSE;    
        descView.hidden = FALSE;
        whereLabel.text = info.where;
        mrtLabel.text = info.mrt;
        whenLabel.text = info.when;
        admissionLabel.text = info.admission;
        telLabel.text = info.tel;
        emailLabel.text = info.email;
        
        CLLocationCoordinate2D zoomLocation;
        zoomLocation.latitude = info.lat; //1.288725;
        zoomLocation.longitude= info.lon; //103.842087;        
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
        MKCoordinateRegion adjustedRegion = [locMap regionThatFits:viewRegion];                
        [locMap setRegion:adjustedRegion animated:YES];    
        
        [locMap removeAnnotations:locMap.annotations];
        MyLocation *loc = [[MyLocation alloc] init];
        loc.coordinate = zoomLocation;
        [locMap addAnnotation:loc];
        [loc release];             
        
        statTotalLabel.text = info.total;
        statHereLabel.text = info.here;
        statMaybeLabel.text = info.maybe;
        descLabel.text = info.desc;
    } else {
        infoView.hidden = TRUE;
        descView.hidden = TRUE;
    }
    
    favView.hidden = info.favSubject.length ? FALSE : TRUE;
    if (!favView.hidden) {
        favLabel.text = [NSString stringWithFormat:@"%@ favorite this", info.favSubject];
    }
    commentsCount = info.comments.count;
    if (commentsCount) {
        int idx = 0;
        for (EventCellComment *comment in info.comments) {
            EventCommentView *ecv = nil;
            if (idx < commentViews.count) {
                ecv = [commentViews objectAtIndex:idx];                
            } else {
                ecv = [[EventCommentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
                [commentViews addObject:ecv];
                [self addSubview:ecv];
                [ecv release];
            }
            ecv.hidden = FALSE;
            [ecv setThumbImage:comment.thumbImage];
            [ecv setName:comment.name comment:comment.comment];
            [ecv updateSize];
            ++idx;
        }
    }
    
    for (int i = commentsCount; i < commentViews.count; ++i) {
        EventCommentView *ecv = [commentViews objectAtIndex:i];
        ecv.hidden = TRUE;
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {    
    static NSString *identifier = @"MyLocation";   
    if ([annotation isKindOfClass:[MyLocation class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = NO;
        annotationView.image=[UIImage imageNamed:@"pin.png"];//here we use a nice image instead of the default pins
        
        return annotationView;
    }    
    return nil;    
}

@end
