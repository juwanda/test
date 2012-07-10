//
//  CommentsViewController.m
//  Copyright 2012 alva@metric-design.com. All rights reserved.
//

#import "CommentsViewController.h"

@implementation CommentsViewController
@synthesize itemsTable, dismissButton, inputView, inputField;

- (void)dealloc {
    [items release];
    [itemsTable release];
    [dismissButton release];
    [inputView release];
    [inputField release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    items = [[NSMutableArray alloc] init];
    
    //DEBUG
    CommentCellInfo *cci;
    
    cci = [[CommentCellInfo alloc] init];
    [items addObject:cci];
    cci.thumbImage = [UIImage imageNamed:@"test_thumb.png"];
    cci.name = @"joelmpc";
    cci.comment = @"Ha ha nice shot!";
    cci.time = @"21 HOURS AGO";
    [cci release];
    
    cci = [[CommentCellInfo alloc] init];
    [items addObject:cci];
    cci.thumbImage = [UIImage imageNamed:@"test_thumb.png"];
    cci.name = @"3uma";
    cci.comment = @"Very nice !";
    cci.time = @"21 HOURS AGO";
    [cci release];
    
    
    cci = [[CommentCellInfo alloc] init];
    [items addObject:cci];
    cci.thumbImage = [UIImage imageNamed:@"test_thumb.png"];
    cci.name = @"Test";
    cci.comment = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    cci.time = @"21 HOURS AGO";
    [cci release];
}

- (void)viewWillAppear:(BOOL)animated {
    [self registerForKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {    
    [self unregisterForKeyboardNotifications];
}

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];    
}

- (void)unregisterForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGFloat h =  UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? kbSize.width : kbSize.height;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, h, 0.0);
    itemsTable.contentInset = contentInsets;
    itemsTable.scrollIndicatorInsets = contentInsets;
    dismissButton.hidden = FALSE;    
    
    CGRect r;
    r = inputView.frame;
    r.origin.y -= h;
    inputView.frame = r;
    
    [self.view bringSubviewToFront:inputView];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    itemsTable.contentInset = contentInsets;
    itemsTable.scrollIndicatorInsets = contentInsets;
    dismissButton.hidden = TRUE;
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGFloat h =  UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? kbSize.width : kbSize.height;
    
    CGRect r;
    r = inputView.frame;
    r.origin.y += h;
    inputView.frame = r;
}

- (IBAction)onDismissTouch:(id)sender {
    [inputField resignFirstResponder];
}

- (IBAction)onBackTouch:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)onDoneEditing:(id)sender {
    [inputField resignFirstResponder];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {    
    CommentCellInfo *cci = [items objectAtIndex:indexPath.row];
    return [CommentCell heightForInfo:cci];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Comment"];
    if (cell == nil) {
        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Comment"];
        [cell autorelease];
    }
    CommentCellInfo *cci = [items objectAtIndex:indexPath.row];
    [cell setInfo:cci];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
}

@end
