//
//  OtherDetailViewController.m
//  SplitViewNavigation
//
//  Created by Stefan Eletzhofer on 17.03.11.
//  Copyright 2011 nexiles GmbH. All rights reserved.
//

#import "OtherDetailViewController.h"

@interface OtherDetailViewController ()
    @property (nonatomic, retain) UIPopoverController *popoverController;
@end


@implementation OtherDetailViewController

@synthesize toolbar           = _toolbar;
@synthesize popoverController;
@synthesize drilldownButton;

-(void)configure:(NSString *)item
{
    NSLog(@"%s: %@", __func__, item);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"%s", __func__);
    self = [super initWithNibName:@"OtherDetailViewController" bundle:nibBundleOrNil];
    if (self) {
        //
    }
    return self;
}

#pragma mark - actions

- (void)drilldownPressed:(id)sender
{
    NSLog(@"%s", __func__);
    // the user pressed the drilldown button.
    //
    // We want to cause a drilldown to the next level here. We thus
    // fire a notification to indicate that.  The RootViewController
    // will act.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"drilldown" object:self];
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


#pragma mark - View lifecycle

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    }
}

- (void)viewDidLoad
{
    NSLog(@"%s", __func__);
    [super viewDidLoad];
    self.popoverController = nil;
}

- (void)viewDidUnload
{
    NSLog(@"%s", __func__);
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - memory handling

- (void)dealloc
{
    NSLog(@"%s", __func__);
    self.toolbar = nil;
    self.popoverController = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
// vim: set sw=4 ts=4 expandtab:
