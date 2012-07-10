//
//  TestViewController.m
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import "TestViewController.h"
#import "UIImageView+WebCache.h"

@implementation TestViewItem
@synthesize name, imagePath;

- (void)dealloc {
    [name release];
    [imagePath release];
    [super dealloc];
}

@end

@implementation TestViewController
@synthesize loadingView, itemsTable;

- (void)dealloc {
    [items release];
    [loadingView release];
    [itemsTable release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:loadingView];
    loadingView.hidden = TRUE;
    items = [[NSMutableArray alloc] init];
    [self update];
}

- (void)update {
    loadingView.hidden = FALSE;
    API_Test *call = [[API_Test alloc] init];
    call.delegate = self;
    [call update];
}

- (void)onAPICallFinishedUpdate:(API_Call *)call {
    loadingView.hidden = TRUE;
    API_Test *test = (API_Test *)call;
    [items removeAllObjects];
    for (API_TestItem *ati in test.outItems) {
        TestViewItem *item = [[TestViewItem alloc] init];
        item.name = ati.name;
        item.imagePath = ati.imagePath;
        [items addObject:item];
        [item release];
    }
    [itemsTable reloadData];
    [call release];
}

- (IBAction)onRefreshTouch:(id)sender {
    [self update];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
        
    }
    TestViewItem *item = [items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    
    NSString *path = item.imagePath;
    if (path.length == 0) {
        path = @"https://twimg0-a.akamaihd.net/profile_images/1671175603/2ac29_surprised-cat1_normal.jpg";
    }
    [cell.imageView setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    return cell;
}

@end
