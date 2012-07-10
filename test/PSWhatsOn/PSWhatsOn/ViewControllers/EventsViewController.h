//
//  EventsViewController.h
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventCell.h"

#define EVENTTYPE_NEWSFEED 0
#define EVENTTYPE_EVENTS 1
#define EVENTTYPE_LIFE 2

@class MainViewController;
@interface EventsViewController : UIViewController {
@private
    NSMutableArray *items;        
}
@property (nonatomic, assign) MainViewController *mainViewController;           
@property (nonatomic, retain) IBOutlet UIImageView *titleImage;
@property (nonatomic, retain) IBOutlet UITableView *itemsTable;
@property (nonatomic, retain) IBOutlet UIButton *catButton;
@property (nonatomic, retain) IBOutlet UIButton *friendsButton;
-(void)setType:(int)type;
@end
