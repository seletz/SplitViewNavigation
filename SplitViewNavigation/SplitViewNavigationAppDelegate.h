//
//  SplitViewNavigationAppDelegate.h
//  SplitViewNavigation
//
//  Created by Stefan Eletzhofer on 17.03.11.
//  Copyright 2011 nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface SplitViewNavigationAppDelegate : NSObject <UIApplicationDelegate> {

    UIWindow              * _window;
    RootViewController    * _rootViewController;
    UISplitViewController * _splitViewController;

}

@property (nonatomic, retain) IBOutlet UIWindow              * window;
@property (nonatomic, retain) IBOutlet UISplitViewController * splitViewController;
@property (nonatomic, retain) IBOutlet RootViewController    * rootViewController;

@end

// vim: set sw=4 ts=4 expandtab:
