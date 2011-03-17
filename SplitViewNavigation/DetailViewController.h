//
//  DetailViewController.h
//  SplitViewNavigation
//
//  Created by Stefan Eletzhofer on 17.03.11.
//  Copyright 2011 nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RootViewController.h"

@interface DetailViewController : UIViewController <CommonDetailView, UIPopoverControllerDelegate, UISplitViewControllerDelegate> {

}


@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) NSString *detailItem;
@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;

-(void)configure:(NSString *)item;

@end
