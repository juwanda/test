//
//  TestViewController.h
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "API_Test.h"

@interface TestViewItem : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *imagePath;
@end

@interface TestViewController : UIViewController<API_Delegate, UITableViewDataSource> {
@private
    NSMutableArray *items;
}
@property (nonatomic, retain) IBOutlet UIView *loadingView;
@property (nonatomic, retain) IBOutlet UITableView *itemsTable;
@end
