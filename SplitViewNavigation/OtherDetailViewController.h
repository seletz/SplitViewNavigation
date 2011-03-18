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

@property (nonatomic,retain) IBOutlet UIToolbar * toolbar;
@property (nonatomic,retain) IBOutlet UIButton  * drilldownButton;

-(void)configure:(NSString *)item;

- (IBAction)drilldownPressed:(id)sender;

@end
// vim: set sw=4 ts=4 expandtab:
