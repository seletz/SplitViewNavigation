//
//  DetailViewController.m
//  SplitViewNavigation
//
//  Created by Stefan Eletzhofer on 17.03.11.
//  Copyright 2011 nexiles GmbH. All rights reserved.
//

#import "DetailViewController.h"

#import "RootViewController.h"

@interface DetailViewController ()
    @property (nonatomic, retain) UIPopoverController *popoverController;
    - (void)configureView;
@end

@implementation DetailViewController

@synthesize toolbar                = _toolbar;
@synthesize detailItem             = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize popoverController;

#pragma mark - Managing the detail item

-(void)configure:(NSString *)item
{
    self.detailItem = item;
}

/*
   When setting the detail item, update the view and dismiss the popover controller if it's showing.
   */
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release];
        _detailItem = [newDetailItem retain];

        // Update the view.
        [self configureView];
    }

    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    self.detailDescriptionLabel.text = [self.detailItem description];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self configureView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark - Split view support

- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController: (UIPopoverController *)pc
{
    NSLog(@"%s", __func__);
    barButtonItem.title = @"Events";
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [self.toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = pc;
}

// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    NSLog(@"%s", __func__);
    if (self.toolbar.items.count >0) {
        NSMutableArray *items = [[self.toolbar items] mutableCopy];
        [items removeObjectAtIndex:0];
        [self.toolbar setItems:items animated:YES];
        [items release];
    }
    self.popoverController = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    self.popoverController = nil;
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

}

- (void)dealloc
{
    NSLog(@"%s: detailDescriptionLabel.text=%@", __func__, self.detailDescriptionLabel.text);
    self.toolbar = nil;
    self.detailItem = nil;
    self.detailDescriptionLabel = nil;
    [super dealloc];
}

@end
// vim: set sw=4 ts=4 expandtab:
