//
//  BrochureViewController.m
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import "BrochureViewController.h"
#import "MainViewController.h"

@implementation BrochureItem
@synthesize title, items;

- (id)init {
    if ((self = [super init])) {
        items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [title release];
    [items release];
    [super dealloc];
}

@end

@implementation BrochureViewController
@synthesize mainViewController, catButton, friendsButton, itemsSearch, itemsTable;

- (void)dealloc {
    [items release];
    [catButton release];
    [friendsButton release];
    [itemsSearch release];
    [itemsTable release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    items = [[NSMutableArray alloc] init];
        
    BrochureItem *bi = [[BrochureItem alloc] init];
    bi.title = @"A";
    [items addObject:bi];
    [bi release];
    BrochureCellComment *ecc;
    BrochureCellInfo *bci = [[BrochureCellInfo alloc] init];
    bci.popular = TRUE;
    bci.title = @"Dell XPS 14' Core i7 8GB\n256 SSD\nFree Microsoft Office";
    bci.price = @"$1,299";
    [bi.items addObject:bci];
    [bci release];    
    
    bci = [[BrochureCellInfo alloc] init];
    bci.title = @"Asus Eee Pad Slider";
    bci.favSubject = @"Isaac";
    [bi.items addObject:bci];
    [bci release];
    
    [bi.items addObject:@"Space"];
    
    ecc = [[BrochureCellComment alloc] init];
    ecc.thumb = [UIImage imageNamed:@"test_thumb.png"];
    ecc.name = @"Eugene Teo";    
    ecc.comment = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    [bci.comments addObject:ecc];
    [ecc release];
    
    bi = [[BrochureItem alloc] init];
    bi.title = @"B";
    [items addObject:bi];
    [bi release];
    bci = [[BrochureCellInfo alloc] init];
    bci.title = @"Test brochure";
    [bi.items addObject:bci];
    [bci release]; 
    
    [bi.items addObject:@"Space"];
}



- (IBAction)onDismissTouch:(id)sender {
    [itemsSearch resignFirstResponder];
}

- (void)onFavButtonTouch:(UIButton *)btn {
    NSIndexPath *indexPath = [itemsTable indexPathForCell:(UITableViewCell *)(btn.superview.superview)];
    if (indexPath) {
        CGRect r = [itemsTable rectForRowAtIndexPath:indexPath];
        r = CGRectMake(r.origin.x + btn.frame.origin.x + itemsTable.frame.origin.x + btn.superview.frame.origin.x, r.origin.y - itemsTable.contentOffset.y + itemsTable.frame.origin.y + btn.frame.origin.y + btn.superview.frame.origin.y, btn.frame.size.width, btn.frame.size.height);
        [mainViewController showFavPopFromRect:r];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { 
    return items.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {	
	BrochureItem *bi = [items objectAtIndex:section];
    return bi.title;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {	    
    NSMutableArray *arr = [NSMutableArray array];
    for (BrochureItem *bi in items) {
        [arr addObject:bi.title];
    }
	return arr;
}

/*
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {    
    CGFloat height = 0;         
    
    BrochureItem *bi = [items objectAtIndex:indexPath.section];    
    id obj = [bi.items objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[BrochureCellInfo class]]) {
        BrochureCellInfo *eci = (BrochureCellInfo *)obj;
        height = [BrochureCell heightForInfo:eci];
    } else {
        height = 10;
    }   
    
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BrochureItem *bi = [items objectAtIndex:section];    
    return bi.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *ret = nil;
    BrochureItem *bi = [items objectAtIndex:indexPath.section];    
    id obj = [bi.items objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[BrochureCellInfo class]]) {
        BrochureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Event"];
        if (cell == nil) {
            cell = [[BrochureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Event"];
            [cell autorelease];
            [cell.favButton addTarget:self action:@selector(onFavButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
        }
        BrochureCellInfo *eci = (BrochureCellInfo *)obj;
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
