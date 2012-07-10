//
//  BrochureViewController.h
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrochureCell.h"

@class MainViewController;

@interface BrochureItem : NSObject
@property (nonatomic, retain) NSString *title;
@property (nonatomic, readonly) NSMutableArray *items;
@end

@interface BrochureViewController : UIViewController {
@private
    NSMutableArray *items;
}
@property (nonatomic, assign) MainViewController *mainViewController;
@property (nonatomic, retain) IBOutlet UIButton *catButton;
@property (nonatomic, retain) IBOutlet UIButton *friendsButton;
@property (nonatomic, retain) IBOutlet UISearchBar *itemsSearch;
@property (nonatomic, retain) IBOutlet UITableView *itemsTable;
@end
