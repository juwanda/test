//
//  EventsViewController.m
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import "EventsViewController.h"
#import "MainViewController.h"

@implementation EventsViewController
@synthesize mainViewController, titleImage, itemsTable, catButton, friendsButton;

- (void)dealloc {
    [titleImage release];
    [itemsTable release];
    [items release];
    [catButton release];
    [friendsButton release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    items = [[NSMutableArray alloc] init];
    
    [items addObject:@"Space"];    
    EventCellInfo *eci = [[EventCellInfo alloc] init];
    eci.expanded = TRUE;
    eci.popular = TRUE;
    eci.image = [UIImage imageNamed:@"test_image.png"];
    eci.title = @"Jam Hsiao World Tour 2012";
    eci.actionSubject = @"Eugene Teo";
    eci.actionVerb = @"invite you to";
    eci.actionObject = eci.title;
    eci.lat = 1.288725;
    eci.lon = 103.842087;        
    eci.videoPath = @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
    eci.where = @"Recipes, The Treasury, 01-03, 100 High Street";
    eci.mrt = @"City Hall/Clarke Quay";
    eci.when = @"Tue, 7 - 9 pm";
    eci.admission = @"$68 and free flow wines with an extra $25";
    eci.tel = @"6338-2796";
    eci.email = @"recipes@shatec.sg";
    eci.total = @"16";
    eci.here = @"2";
    eci.maybe = @"7";
    eci.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    eci.favSubject = @"Eugene Teo";
    
    EventCellComment *ecc = [[EventCellComment alloc] init];
    ecc.thumbImage = [UIImage imageNamed:@"test_thumb.png"];
    ecc.name = @"Eugene Teo";
    ecc.comment = @"This show rocks!!";    
    [eci.comments addObject:ecc];
    [ecc release];
    
    ecc = [[EventCellComment alloc] init];
    ecc.thumbImage = [UIImage imageNamed:@"test_thumb.png"];
    ecc.name = @"Eugene Teo";    
    ecc.comment = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    [eci.comments addObject:ecc];
    [ecc release];
    
    [items addObject:eci];
    [eci release];
    
    [items addObject:@"Space"]; 
    eci = [[EventCellInfo alloc] init];
    eci.title = @"Test Event";
    [items addObject:eci];
    [eci release];
    
    [items addObject:@"Space"]; 
    eci = [[EventCellInfo alloc] init];
    eci.title = @"Test Event 2";
    eci.favSubject = @"Michelle Liu";
    [items addObject:eci];
    [eci release];
    
    [items addObject:@"Space"]; 
    eci = [[EventCellInfo alloc] init];
    eci.image = [UIImage imageNamed:@"test_image.png"];
    eci.title = @"Hello World";
    [items addObject:eci];
    [eci release];
    
    [items addObject:@"Space"]; 
    eci = [[EventCellInfo alloc] init];
    eci.image = [UIImage imageNamed:@"test_image.png"];
    eci.title = @"Singapore Pastel Art Exhibition: Impression and Expression";
    [items addObject:eci];
    [eci release];
}

- (void)setType:(int)type {
    NSString *name;
    switch (type) {
        case EVENTTYPE_NEWSFEED:
            name = @"text_events.png";
            break;
            
        case EVENTTYPE_EVENTS:
            name = @"text_events.png";
            break;
            
        case EVENTTYPE_LIFE:
            name = @"text_liferec.png";
            break;
            
        default:
            break;
    }
    
    UIImage *img = [UIImage imageNamed:name];    
    titleImage.image = img;
    titleImage.frame = CGRectMake((self.view.frame.size.width - img.size.width) * 0.5, (44 - img.size.height) * 0.5, img.size.width, img.size.height);
}

- (void)onFavButtonTouch:(UIButton *)btn {
    NSIndexPath *indexPath = [itemsTable indexPathForCell:(UITableViewCell *)(btn.superview)];
    if (indexPath) {
        CGRect r = [itemsTable rectForRowAtIndexPath:indexPath];
        r = CGRectMake(r.origin.x + btn.frame.origin.x + itemsTable.frame.origin.x, r.origin.y - itemsTable.contentOffset.y + itemsTable.frame.origin.y + btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height);
        [mainViewController showFavPopFromRect:r];
    }
}

- (void)onStatButtonTouch:(UIButton *)btn {
    NSIndexPath *indexPath = [itemsTable indexPathForCell:(UITableViewCell *)(btn.superview.superview)];
    if (indexPath) {
        CGRect r = [itemsTable rectForRowAtIndexPath:indexPath];
        CGRect pr = btn.superview.frame;
        r = CGRectMake(r.origin.x + pr.origin.x + btn.frame.origin.x + itemsTable.frame.origin.x, r.origin.y + pr.origin.y - itemsTable.contentOffset.y + itemsTable.frame.origin.y + btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height);
        [mainViewController showFriendPopFromRect:r];
    }
}

- (void)onMapButtonTouch:(UIButton *)btn {
    NSIndexPath *indexPath = [itemsTable indexPathForCell:(UITableViewCell *)(btn.superview.superview)];
    if (indexPath) {
        EventCellInfo *eci = [items objectAtIndex:indexPath.row];
        [mainViewController showMapWithLoc:eci.lat lon:eci.lon];
    }
}

- (void)onVideoButtonTouch:(UIButton *)btn {
    NSIndexPath *indexPath = [itemsTable indexPathForCell:(UITableViewCell *)(btn.superview.superview)];
    if (indexPath) {
        EventCellInfo *eci = [items objectAtIndex:indexPath.row];
        [mainViewController showVideoWithAddress:eci.videoPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {    
    CGFloat height = 0;         
    
    id obj = [items objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[EventCellInfo class]]) {
        EventCellInfo *eci = (EventCellInfo *)obj;
        height = [EventCell heightForInfo:eci];
    } else {
        height = 10;
    }   
    
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *ret = nil;
    id obj = [items objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[EventCellInfo class]]) {
        EventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Event"];
        if (cell == nil) {
            cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Event"];
            [cell autorelease];
            [cell.videoButton addTarget:self action:@selector(onVideoButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
            [cell.favButton addTarget:self action:@selector(onFavButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
            [cell.statButton1 addTarget:self action:@selector(onStatButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
            [cell.statButton2 addTarget:self action:@selector(onStatButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
            [cell.statButton3 addTarget:self action:@selector(onStatButtonTouch:) forControlEvents:UIControlEventTouchUpInside];            
            [cell.mapButton addTarget:self action:@selector(onMapButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
        }
        EventCellInfo *eci = (EventCellInfo *)obj;
        [cell setInfo:eci];
        ret = cell;        
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Space"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Space"];
            [cell autorelease];
        }
        ret = cell;
    }
    ret.selectionStyle = UITableViewCellSelectionStyleNone;
    return ret;    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
}

@end
