//
//  OtherDetailViewController.h
//  SplitViewNavigation
//
//  Created by Stefan Eletzhofer on 17.03.11.
//  Copyright 2011 nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RootViewController.h"

@interface OtherDetailViewController : UIViewController <CommonDetailView, UISplitViewControllerDelegate> {
    
}

-(void)configure:(NSString *)item;

@end
