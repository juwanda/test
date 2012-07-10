//
//  MapViewController.m
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import "MapViewController.h"

@interface MapLocation : NSObject<MKAnnotation>;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end

@implementation MapLocation
@synthesize coordinate;
@end

@implementation MapViewController
@synthesize locMap, lat, lon;

static const CGFloat METERS_PER_MILE = 1000; //1689.344;

- (void)dealloc {
    [locMap release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = lat;
    zoomLocation.longitude= lon;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5 * METERS_PER_MILE, 0.5 * METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [locMap regionThatFits:viewRegion];                
    [locMap setRegion:adjustedRegion animated:YES];    
    
    [locMap removeAnnotations:locMap.annotations];
    
    MapLocation *loc = [[MapLocation alloc] init];
    loc.coordinate = zoomLocation;
    [locMap addAnnotation:loc];
    [loc release];             
}

- (IBAction)onBackTouch:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {    
    static NSString *identifier = @"MyLocation";   
    if ([annotation isKindOfClass:[MapLocation class]]) {        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            [annotationView autorelease];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = NO;
        annotationView.image = [UIImage imageNamed:@"pin.png"];//here we use a nice image instead of the default pins
        
        return annotationView;
    }    
    return nil;    
}

@end
