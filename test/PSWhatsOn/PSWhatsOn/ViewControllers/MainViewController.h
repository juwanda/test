//
//  MainViewController.h
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "EventCell.h"
#import "CatBarCell.h"
#import "CatCell.h"
#import "FriendCell.h"
#import "PopViewController.h"
#import "CommentsViewController.h"
#import "EventsViewController.h"
#import "BrochureViewController.h"
#import "MapViewController.h"

@interface MainViewController : UIViewController<PopViewDelegate, UITableViewDelegate, UITableViewDataSource> {
@private
    NSMutableArray *catItems;
    NSMutableArray *friendsItems;
    PopViewController *popViewCont;
    UIViewController *feedViewCont;    
}
@property (nonatomic, retain) IBOutlet UIView *catView;
@property (nonatomic, retain) IBOutlet UITableView *catTable;
@property (nonatomic, retain) IBOutlet UIButton *catBackButton;
@property (nonatomic, retain) IBOutlet UIView *friendsView;
@property (nonatomic, retain) IBOutlet UITableView *friendsTable;
@property (nonatomic, retain) IBOutlet UIButton *friendsBackButton;
-(void)showFavPopFromRect:(CGRect)rect;
-(void)showFriendPopFromRect:(CGRect)rect;
-(void)showMapWithLoc:(double)lat lon:(double)lon;
-(void)showVideoWithAddress:(NSString *)address;
@end
