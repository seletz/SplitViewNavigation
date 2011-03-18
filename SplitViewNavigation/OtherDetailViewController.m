//
//  OtherDetailViewController.m
//  SplitViewNavigation
//
//  Created by Stefan Eletzhofer on 17.03.11.
//  Copyright 2011 nexiles GmbH. All rights reserved.
//

#import "OtherDetailViewController.h"


@implementation OtherDetailViewController

@synthesize toolbar=_toolbar;

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

- (void)dealloc
{
    NSLog(@"%s", __func__);
    self.toolbar = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSLog(@"%s", __func__);
    [super viewDidLoad];
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

@end
// vim: set sw=4 ts=4 expandtab:
