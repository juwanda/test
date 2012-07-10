//
//  EventCell.h
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>

@interface MyLocation : NSObject<MKAnnotation>;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end

@interface EventCellComment : NSObject
@property (nonatomic, retain) UIImage *thumbImage;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *comment;
@end

@interface EventCellInfo : NSObject
@property (nonatomic, assign) BOOL expanded;
@property (nonatomic, assign) BOOL popular;
@property (nonatomic, retain) NSString *actionSubject;
@property (nonatomic, retain) NSString *actionVerb;
@property (nonatomic, retain) NSString *actionObject;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lon;
@property (nonatomic, assign) NSString *videoPath;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *where;
@property (nonatomic, retain) NSString *mrt;
@property (nonatomic, retain) NSString *when;
@property (nonatomic, retain) NSString *admission;
@property (nonatomic, retain) NSString *tel;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *total;
@property (nonatomic, retain) NSString *here;
@property (nonatomic, retain) NSString *maybe;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *favSubject;
@property (nonatomic, readonly) NSMutableArray *comments;
@end

@interface EventCell : UITableViewCell<MKMapViewDelegate> {
@private
    CAShapeLayer *maskLayer;
    UIImageView *ribbonImage;
    UIView *actionView;
    UIImageView *actionImage;
    UILabel *actionLabel;
    UIImageView *headerImage;
    UIButton *favButton;
    UILabel *titleLabel;
    UIImageView *timeImage;
    UILabel *timeLabel;
    UIImageView *distanceImage;
    UILabel *distanceLabel;
    UIView *divView;
    UIView *infoView;
    UILabel *whereTitleLabel;
    UILabel *whereLabel;
    UILabel *mrtTitleLabel;
    UILabel *mrtLabel;
    UILabel *whenTitleLabel;
    UILabel *whenLabel;    
    UILabel *admissionTitleLabel;
    UILabel *admissionLabel;
    UILabel *telTitleLabel;
    UILabel *telLabel;
    UILabel *emailTitleLabel;
    UILabel *emailLabel;
    MKMapView *locMap;
    UIButton *todoButton;
    UIButton *brochureButton;
    UIButton *videoButton;
    UIView *descView;
    UILabel *statTotalLabel;
    UILabel *statHereLabel;
    UILabel *statMaybeLabel;
    UILabel *descAuthorLabel;
    UILabel *descLabel;
    UILabel *goingLabel;    
    UIView *favView;
    UILabel *favLabel;
    NSMutableArray *commentViews;
    int commentsCount;
}
@property (nonatomic, readonly) UIButton *todoButton;
@property (nonatomic, readonly) UIButton *brochureButton;
@property (nonatomic, readonly) UIButton *videoButton;
@property (nonatomic, readonly) UIButton *favButton;
@property (nonatomic, readonly) UIButton *statButton1;
@property (nonatomic, readonly) UIButton *statButton2;
@property (nonatomic, readonly) UIButton *statButton3;
@property (nonatomic, readonly) UIButton *mapButton;
+(CGFloat)heightForInfo:(EventCellInfo *)info;
-(void)setInfo:(EventCellInfo *)info;
@end
