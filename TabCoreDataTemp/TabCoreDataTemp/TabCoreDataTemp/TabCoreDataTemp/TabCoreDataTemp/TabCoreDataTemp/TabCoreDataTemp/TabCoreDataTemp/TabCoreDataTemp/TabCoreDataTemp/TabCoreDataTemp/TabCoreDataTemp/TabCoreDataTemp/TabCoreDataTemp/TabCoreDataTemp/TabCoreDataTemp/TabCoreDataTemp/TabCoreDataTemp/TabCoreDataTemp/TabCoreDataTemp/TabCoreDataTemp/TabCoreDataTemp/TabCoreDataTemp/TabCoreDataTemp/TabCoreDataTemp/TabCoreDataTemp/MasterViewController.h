//
//  MasterViewController.h
//  TabCoreDataTemp
//
//  Created by 真有 津坂 on 12/03/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
//#import "Event.h"
//#import "Record.h"

@class DetailViewController;
//#import "DetailViewController.h"


@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end


