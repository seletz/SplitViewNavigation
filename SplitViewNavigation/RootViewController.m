//
//  RootViewController.m
//  SplitViewNavigation
//
//  Created by Stefan Eletzhofer on 17.03.11.
//  Copyright 2011 nexiles GmbH. All rights reserved.
//

#import "RootViewController.h"

#import "DetailViewController.h"
#import "OtherDetailViewController.h"

@interface RootViewController ()

-(void)drillDown:(NSInteger)newNavigationLevel;
-(void)drilldownNotification:(NSNotification *)note;

@end

@implementation RootViewController

@synthesize detailViewController;
@synthesize navigationItems        = _navigationItems;
@synthesize selectedNavigationItem = _selectedNavigationItem;
@synthesize navigationLevel        = _navigationLevel;


- (void)viewDidLoad
{
    NSLog(@"%s", __func__);
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);

    NSMutableArray *a = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];

    for (int i=0; i<10; i++) {
        [a insertObject:[NSString stringWithFormat:@"Item %d.%d", self.navigationLevel, i]
                atIndex:i];
    }
    self.navigationItems = a;
    self.title = [NSString stringWithFormat:@"Level %d", self.navigationLevel];
}


- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s", __func__);
    [super viewWillAppear:animated];

    // We need to update the detail view controller of our parent split view controller
    // here iff it's not set correct.
    if (self.detailViewController != [self.splitViewController.viewControllers objectAtIndex:1]) {
        NSArray *viewControllers = [[NSArray alloc] initWithObjects:self.navigationController, self.detailViewController, nil];
        self.splitViewController.viewControllers = viewControllers;
        [viewControllers release];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%s", __func__);
    [super viewDidAppear:animated];

    [[NSNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(drilldownNotification:)
               name:@"drilldown"
             object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"%s", __func__);
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"%s", __func__);
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.navigationItems.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell.
    cell.textLabel.text = [self.navigationItems objectAtIndex:indexPath.row];
    if (indexPath.row < 5) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    return cell;
}

-(void)drilldownNotification:(NSNotification *)note
{
    NSLog(@"%s", __func__);
    // here, we'd probly use the *userInfo* dictionary to find out exactly
    // where to drill down to.
    [self drillDown:self.navigationLevel + 1];
}

-(void)drillDown:(NSInteger)newNavigationLevel
{
    NSLog(@"dvc     : %@", self.detailViewController);
    NSLog(@"sv vc   : %@", self.splitViewController.viewControllers);
    // We create a new root view controller and a matching detail view controller,
    // then we push the root view controlle onto the navigation controller.
    //
    // Unfortunately, we need also to update the split view contoller's viewController
    // array to get the new detail view shown.
    RootViewController *newRootVC = [[RootViewController alloc] init];

    UIViewController<UISplitViewControllerDelegate, CommonDetailView> *newDetailVC = nil;
    if (newNavigationLevel % 2 == 1) {
        newDetailVC = [[DetailViewController alloc] init];
    } else {
        newDetailVC = [[OtherDetailViewController alloc] init];
    }

    // new root controller.  
    newRootVC.detailViewController = newDetailVC;
    newRootVC.navigationLevel = newNavigationLevel;

    // configure split view controller.  We have a new detail view to be shown, thus we need
    // to reconfigure the split view controller's *viewControllers* array.  We want the 2nd
    // entry of this array to point to our new detail view controller.
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:self.navigationController, newDetailVC, nil];
    self.splitViewController.viewControllers = viewControllers;
    self.splitViewController.delegate = newDetailVC;

    // push the new root view controller to the navigation controller's view stack.
    [self.navigationController pushViewController:newRootVC animated:YES];

    [newRootVC release];
    [newDetailVC release];
    [viewControllers release];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedNavigationItem = [self.navigationItems objectAtIndex:indexPath.row];
    NSLog(@"selected: %@", self.selectedNavigationItem);


    if (indexPath.row < 5) {
        // the user selected one of the top five cells.  He wants to drill down
        // one level.
        [self drillDown:self.navigationLevel + 1];
    } else {
        // user selected an item w/o drill-down option.  Just update the detail view.
        self.detailViewController.title = self.selectedNavigationItem;
        [self.detailViewController configure:self.selectedNavigationItem];
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"<RootViewController Level %d>", self.navigationLevel];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    NSLog(@"%s", __func__);
    self.navigationItems = nil;
    self.detailViewController = nil;
    self.selectedNavigationItem = nil;
}

- (void)dealloc
{
    NSLog(@"%s: self.navigationLevel=%d", __func__, self.navigationLevel);
    NSLog(@"%s: self.selectedNavigationItem=%@", __func__, self.selectedNavigationItem);

    self.navigationItems = nil;
    self.detailViewController = nil;
    self.selectedNavigationItem = nil;
    [super dealloc];
}

@end
// vim: set sw=4 ts=4 expandtab:
