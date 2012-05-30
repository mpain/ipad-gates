//
//  GTSMasterViewController.h
//  Gates
//
//  Created by Sergey Samoylov on 5/30/12.
//  Copyright (c) 2012 IT Territory. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTSDetailViewController;

#import <CoreData/CoreData.h>

@interface GTSMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) GTSDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
