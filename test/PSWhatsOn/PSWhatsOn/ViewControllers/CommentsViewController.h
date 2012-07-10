//
//  CommentsViewController.h
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentCell.h"

@interface CommentsViewController : UIViewController {
@private
    NSMutableArray *items;
}
@property (nonatomic, retain) IBOutlet UITableView *itemsTable;
@property (nonatomic, retain) IBOutlet UIButton *dismissButton;
@property (nonatomic, retain) IBOutlet UIView *inputView;
@property (nonatomic, retain) IBOutlet UITextField *inputField;
@end
