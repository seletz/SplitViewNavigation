//
//  RootViewController.h
//  SplitViewNavigation
//
//  Created by Stefan Eletzhofer on 17.03.11.
//  Copyright 2011 nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface RootViewController : UITableViewController {
    NSArray * _navigationItems;
    
    NSString * _selectedNavigationItem;
    
    NSInteger _navigationLevel;
}

		
@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;

@property (nonatomic, retain) NSArray *navigationItems;
@property (nonatomic, retain) NSString *selectedNavigationItem;
@property (nonatomic, assign) NSInteger navigationLevel;


@end
