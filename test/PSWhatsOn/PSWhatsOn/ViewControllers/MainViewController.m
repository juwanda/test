//
//  MainViewController.m
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController
@synthesize catView, catTable, catBackButton, friendsView, friendsTable, friendsBackButton;

- (void)dealloc {
    [catItems release];
    [friendsItems release];
    [popViewCont release];
    [feedViewCont release];
    [catView release];
    [catTable release];
    [catBackButton release];
    [friendsView release];
    [friendsTable release];
    [friendsBackButton release];
    [super dealloc];    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    catItems = [[NSMutableArray alloc] init];
    friendsItems = [[NSMutableArray alloc] init];
    [self.view addSubview:catView];
    [self.view addSubview:friendsView];
    CGRect r = friendsView.frame;
    r.origin.x = 40;
    friendsView.frame = r;
    catView.hidden = TRUE;
    catBackButton.hidden = TRUE;
    friendsView.hidden = TRUE;
    friendsBackButton.hidden = TRUE;
    popViewCont = [[PopViewController alloc] init];
    popViewCont.view.hidden = TRUE;
    popViewCont.delegate = self;
    [self.view addSubview:popViewCont.view];    
    
    [self openEvents:EVENTTYPE_LIFE];
    
    //[catItems addObject:[UIImage imageNamed:@"cat_bar_fav.png"]];    
    CatBarCellInfo *cbci = [[CatBarCellInfo alloc] init];
    cbci.title = @"FAVOURITES";
    [catItems addObject:cbci];
    [cbci release];
    
    
    CatCellInfo *cci = [[CatCellInfo alloc] init];
    cci.img = [UIImage imageNamed:@"cat_icon_new.png"];
    cci.title = @"News Feed";
    cci.bgType = CATCELL_BG_DEFAULT;
    cci.count = 17;
    [catItems addObject:cci];
    [cci release];
    
    cci = [[CatCellInfo alloc] init];
    cci.img = [UIImage imageNamed:@"cat_icon_events.png"];
    cci.title = @"Events";
    cci.bgType = CATCELL_BG_DEFAULT;
    cci.count = 2;
    [catItems addObject:cci];
    [cci release];
    
    cci = [[CatCellInfo alloc] init];
    cci.img = [UIImage imageNamed:@"cat_icon_pin.png"];
    cci.title = @"Nearby";
    cci.bgType = CATCELL_BG_DEFAULT;
    cci.count = 2;
    [catItems addObject:cci];
    [cci release];
    
    cci = [[CatCellInfo alloc] init];
    cci.img = [UIImage imageNamed:@"cat_icon_pin.png"];
    cci.title = @"Club Seen";
    cci.bgType = CATCELL_BG_DEFAULT;
    cci.count = 2;
    [catItems addObject:cci];
    [cci release];
    
    cci = [[CatCellInfo alloc] init];
    cci.bgType = CATCELL_BG_SEEALL;
    cci.count = CATCELL_COUNT_NONE;
    [catItems addObject:cci];
    [cci release];
    
    //[catItems addObject:[UIImage imageNamed:@"cat_bar_whats.png"]];
    cbci = [[CatBarCellInfo alloc] init];
    cbci.title = @"CATEGORIES";
    [catItems addObject:cbci];
    [cbci release];        
    
    cci = [[CatCellInfo alloc] init];
    cci.img = [UIImage imageNamed:@"cat_icon_photo.png"];
    cci.title = @"Life! Recommend";
    cci.bgType = CATCELL_BG_DEFAULT;
    cci.count = 5;
    [catItems addObject:cci];
    [cci release];
    
    cci = [[CatCellInfo alloc] init];
    cci.img = [UIImage imageNamed:@"cat_icon_photo.png"];
    cci.title = @"IT SHOW 2012";
    cci.bgType = CATCELL_BG_DEFAULT;
    cci.count = 1;
    [catItems addObject:cci];
    [cci release];
    
    //[catItems addObject:[UIImage imageNamed:@"cat_bar_empty.png"]];
    cbci = [[CatBarCellInfo alloc] init];
    [catItems addObject:cbci];
    [cbci release];
    
    cci = [[CatCellInfo alloc] init];
    cci.img = [UIImage imageNamed:@"cat_icon_help.png"];
    cci.title = @"Help Center";
    cci.bgType = CATCELL_BG_DEFAULT;
    cci.count = CATCELL_COUNT_NONE;
    [catItems addObject:cci];
    [cci release];
    
    cci = [[CatCellInfo alloc] init];
    cci.img = [UIImage imageNamed:@"cat_icon_settings.png"];
    cci.title = @"Settings";
    cci.bgType = CATCELL_BG_DEFAULT;
    cci.count = CATCELL_COUNT_NONE;
    [catItems addObject:cci];
    [cci release];
    
    //FRIENDS
    FriendCellInfo *fci = [[FriendCellInfo alloc] init];
    fci.img = [UIImage imageNamed:@"test_thumb.png"];
    fci.title = @"Nigel Nicholas Oei";
    [friendsItems addObject:fci];
    [fci release];
    
    fci = [[FriendCellInfo alloc] init];
    fci.img = [UIImage imageNamed:@"test_thumb.png"];
    fci.title = @"Eugene Teo";
    [friendsItems addObject:fci];
    [fci release];
    
    fci = [[FriendCellInfo alloc] init];
    fci.img = [UIImage imageNamed:@"test_thumb.png"];
    fci.title = @"Adrian Jiun";
    [friendsItems addObject:fci];
    [fci release];
    
    fci = [[FriendCellInfo alloc] init];
    fci.img = [UIImage imageNamed:@"test_thumb.png"];
    fci.title = @"Nadyne Lim";
    [friendsItems addObject:fci];
    [fci release];
    
    [friendsItems addObject:[UIImage imageNamed:@"add_cell_all.png"]];
}

- (void)openEvents:(int)type {
    EventsViewController *v = [[EventsViewController alloc] init];
    v.mainViewController = self;        
    [self.view addSubview:v.view];
    [v setType:type];
    [v.catButton addTarget:self action:@selector(showCatView) forControlEvents:UIControlEventTouchUpInside];
    [v.friendsButton addTarget:self action:@selector(showFriendsView) forControlEvents:UIControlEventTouchUpInside];    
    [self setFeedViewCont:v];
}

- (void)openBrochure {
    BrochureViewController *v = [[BrochureViewController alloc] init];
    v.mainViewController = self;
    [self.view addSubview:v.view];
    [v.catButton addTarget:self action:@selector(showCatView) forControlEvents:UIControlEventTouchUpInside];
    [v.friendsButton addTarget:self action:@selector(showFriendsView) forControlEvents:UIControlEventTouchUpInside];    
    [self setFeedViewCont:v];    
}

- (void)setFeedViewCont:(UIViewController *)v {
    if (feedViewCont) {
        CGRect r = feedViewCont.view.frame;
        [feedViewCont.view removeFromSuperview];
        [feedViewCont release];
        v.view.frame = r;
    }    
    if (!catView.hidden) {
        [self.view bringSubviewToFront:catBackButton];
    }
    if (!friendsView.hidden) {
        [self.view bringSubviewToFront:friendsBackButton];
    }
    feedViewCont = v;
}

- (void)showCatView {
    catBackButton.hidden = FALSE;
    catView.hidden = FALSE;
    [self.view bringSubviewToFront:catBackButton];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect r = feedViewCont.view.frame;
    r.origin.x = catView.frame.size.width;
    feedViewCont.view.frame = r;
    [UIView commitAnimations];
}

- (void)hideCatView {
    catBackButton.hidden = TRUE;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(onHideCatDidStop)];
    [UIView setAnimationDuration:0.3];
    CGRect r = feedViewCont.view.frame;
    r.origin.x = 0;
    feedViewCont.view.frame = r;
    [UIView commitAnimations];
}

- (void)onHideCatDidStop {
    catView.hidden = TRUE;
}

- (IBAction)onCatTouch:(id)sender {
    [self showCatView];
}

- (IBAction)onCatBackTouch:(id)sender {
    [self hideCatView];
}

- (void)onPopViewFavCommentTouch {
    [self showCommentsView];
}

- (void)showCommentsView {
    CommentsViewController *v = [[CommentsViewController alloc] init];
    [self.navigationController pushViewController:v animated:TRUE];
    [v release];
}

- (void)showFriendsView {
    friendsBackButton.hidden = FALSE;
    friendsView.hidden = FALSE;
    [self.view bringSubviewToFront:friendsBackButton];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect r = feedViewCont.view.frame;
    r.origin.x = -catView.frame.size.width;
    feedViewCont.view.frame = r;
    [UIView commitAnimations];
}

- (void)hideFriendsView {
    friendsBackButton.hidden = TRUE;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(onHideFriendsDidStop)];
    [UIView setAnimationDuration:0.3];
    CGRect r = feedViewCont.view.frame;
    r.origin.x = 0;
    feedViewCont.view.frame = r;
    [UIView commitAnimations];
}

- (void)onHideFriendsDidStop {
    friendsView.hidden = TRUE;
}

- (IBAction)onFriendsTouch:(id)sender {
    [self showFriendsView];
}

- (IBAction)onFriendsBackTouch:(id)sender {
    [self hideFriendsView];
}

- (void)showFavPopFromRect:(CGRect)rect {
    [self.view bringSubviewToFront:popViewCont.view];
    [popViewCont showFavPopFromRect:rect];
}

- (void)showFriendPopFromRect:(CGRect)rect {
    [self.view bringSubviewToFront:popViewCont.view];
    [popViewCont showFriendPopFromRect:rect];
}

- (void)showMapWithLoc:(double)lat lon:(double)lon {
    MapViewController *v = [[MapViewController alloc] init];
    v.lat = lat;
    v.lon = lon;
    [self.navigationController pushViewController:v animated:TRUE];
    [v release];
}

- (void)showVideoWithAddress:(NSString *)address {
    NSURL *url = [NSURL URLWithString:address];
    MPMoviePlayerViewController *v = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self presentMoviePlayerViewControllerAnimated:v];
    [v release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {    
    CGFloat height = 0;     
    if (tableView == catTable) {
        id obj = [catItems objectAtIndex:indexPath.row];
        if ([obj isKindOfClass:[CatBarCellInfo class]]) {
            height = [CatBarCell height];
        } else if ([obj isKindOfClass:[CatCellInfo class]]) {
            height = [CatCell height];
        }
    } else if (tableView == friendsTable) {
        id obj = [friendsItems objectAtIndex:indexPath.row];
        if ([obj isKindOfClass:[FriendCellInfo class]]) {
            height = [FriendCell height];
        } else if ([obj isKindOfClass:[UIImage class]]) {
            height = 45;
        }
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CGFloat ret = 0;
    if (tableView == catTable) {
        ret = catItems.count;
    } else if (tableView == friendsTable) {
        ret = friendsItems.count;
    }
    return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *ret = nil;
    if (tableView == catTable) {
        id obj = [catItems objectAtIndex:indexPath.row];
        if ([obj isKindOfClass:[CatBarCellInfo class]]) {
            CatBarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Bar"];
            if (cell == nil) {
                cell = [[CatBarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Bar"];
                [cell autorelease];
            }
            [cell setInfo:obj];
            ret = cell;
        } else if ([obj isKindOfClass:[CatCellInfo class]]) {
            CatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            if (cell == nil) {
                cell = [[CatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
                [cell autorelease];
            }
            CatCellInfo *info = (CatCellInfo *)obj;
            [cell setInfo:info];
            ret = cell;
        }
    } else if (tableView == friendsTable) {
        id obj = [friendsItems objectAtIndex:indexPath.row];
        if ([obj isKindOfClass:[FriendCellInfo class]]) {
            FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Friend"];
            if (cell == nil) {
                cell = [[FriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Friend"];
                [cell autorelease];
            }
            FriendCellInfo *info = (FriendCellInfo *)obj;
            [cell setInfo:info];
            ret = cell;        
        } else if ([obj isKindOfClass:[UIImage class]]) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SeeAll"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SeeAll"];
                [cell autorelease];
                cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add_cell_all.png"]];
            }
            ret = cell;
        }
    }
    return ret;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    if (tableView == catTable) {
        BOOL open = FALSE;
        if (indexPath.row == 2) {
            open = TRUE;
            [self openEvents:EVENTTYPE_EVENTS];
        }if (indexPath.row == 6) {
            open = TRUE;
            [self openEvents:EVENTTYPE_LIFE];
        } else if (indexPath.row == 7) {
            open = TRUE;
            [self openBrochure];
        }
        if (open) {
            [self hideCatView];
        }
    }
}


@end
