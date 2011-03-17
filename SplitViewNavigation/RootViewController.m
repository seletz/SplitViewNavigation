//
//  RootViewController.m
//  SplitViewNavigation
//
//  Created by Stefan Eletzhofer on 17.03.11.
//  Copyright 2011 nexiles GmbH. All rights reserved.
//

#import "RootViewController.h"

#import "DetailViewController.h"

@implementation RootViewController

@synthesize detailViewController;
		
@synthesize navigationItems = _navigationItems;
@synthesize selectedNavigationItem = _selectedNavigationItem;

@synthesize navigationLevel = _navigationLevel;

- (void)viewDidLoad
{
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
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedNavigationItem = [self.navigationItems objectAtIndex:indexPath.row];
    self.detailViewController.title = self.selectedNavigationItem;
    self.detailViewController.detailDescriptionLabel.text = self.selectedNavigationItem;
    
    if (indexPath.row < 5) {
        RootViewController *vc = [[[RootViewController alloc] init] autorelease];
        vc.detailViewController = self.detailViewController;
        vc.navigationLevel = self.navigationLevel + 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
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
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    [detailViewController release];
    self.navigationItems = nil;
    [super dealloc];
}

@end
