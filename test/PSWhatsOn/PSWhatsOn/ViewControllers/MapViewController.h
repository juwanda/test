//
//  MapViewController.h
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController
@property (nonatomic, retain) IBOutlet MKMapView *locMap;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lon;
@end
