//
//  OtherDetailViewController.h
//  SplitViewNavigation
//
//  Created by Stefan Eletzhofer on 17.03.11.
//  Copyright 2011 nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RootViewController.h"

@interface OtherDetailViewController : UIViewController <CommonDetailView, UIPopoverControllerDelegate, UISplitViewControllerDelegate> {
}

@property (nonatomic,retain) IBOutlet UIToolbar *toolbar;

-(void)configure:(NSString *)item;

@end
// vim: set sw=4 ts=4 expandtab:
